#!/bin/bash
# ============================================================================
#  broken_gnl tester
#  Tests get_next_line by compiling with a main and checking line-by-line output
# ============================================================================

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m"
RESET="\033[0m"

PASS=0
FAIL=0
TOTAL=0

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEST_DIR=$(mktemp -d)

cleanup() {
    rm -rf "$TEST_DIR"
}
trap cleanup EXIT

print_header() {
    echo -e "${CYAN}==========================================${RESET}"
    echo -e "${CYAN}       broken_gnl tester                  ${RESET}"
    echo -e "${CYAN}==========================================${RESET}"
    echo ""
}

run_test() {
    local test_name="$1"
    local input_file="$2"
    local buffer_size="$3"
    TOTAL=$((TOTAL + 1))

    # Expected: read all lines with cat
    local expected
    expected=$(cat "$input_file")

    # Actual: read with get_next_line via test main
    local actual
    actual=$(timeout 5 "$TEST_DIR/gnl_test" "$input_file" 2>/dev/null)
    local exit_code=$?

    if [ $exit_code -eq 124 ]; then
        echo -e "  ${RED}[FAIL]${RESET} $test_name (timeout)"
        FAIL=$((FAIL + 1))
        return
    fi

    if [ "$expected" = "$actual" ]; then
        echo -e "  ${GREEN}[PASS]${RESET} $test_name (BUFFER_SIZE=$buffer_size)"
        PASS=$((PASS + 1))
    else
        echo -e "  ${RED}[FAIL]${RESET} $test_name (BUFFER_SIZE=$buffer_size)"
        echo -e "    Expected: $(echo "$expected" | head -3)"
        echo -e "    Got:      $(echo "$actual" | head -3)"
        FAIL=$((FAIL + 1))
    fi
}

# ---- Create test main ----
create_main() {
    cat > "$TEST_DIR/main_test.c" << 'MAIN_EOF'
#include "get_next_line.h"
#include <stdio.h>
#include <fcntl.h>

int main(int argc, char **argv)
{
    if (argc != 2)
        return 1;
    int fd = open(argv[1], O_RDONLY);
    if (fd < 0)
        return 1;
    char *line;
    while ((line = get_next_line(fd)) != NULL)
    {
        printf("%s", line);
        free(line);
    }
    close(fd);
    return 0;
}
MAIN_EOF
}

# ---- Create test files ----
create_test_files() {
    # Simple single line
    printf "Hello World\n" > "$TEST_DIR/single_line.txt"

    # Multiple lines
    printf "Line 1\nLine 2\nLine 3\n" > "$TEST_DIR/multi_line.txt"

    # Line without trailing newline (EOF)
    printf "No newline at end" > "$TEST_DIR/no_newline.txt"

    # Empty file
    > "$TEST_DIR/empty.txt"

    # Long line
    python3 -c "print('A' * 10000)" > "$TEST_DIR/long_line.txt" 2>/dev/null || \
    perl -e "print 'A' x 10000; print \"\n\";" > "$TEST_DIR/long_line.txt"

    # Multiple empty lines
    printf "\n\n\n" > "$TEST_DIR/empty_lines.txt"

    # Mixed content
    printf "Hello\n\nWorld\n\n42\n" > "$TEST_DIR/mixed.txt"

    # Single character lines
    printf "a\nb\nc\n" > "$TEST_DIR/single_chars.txt"

    # Single newline
    printf "\n" > "$TEST_DIR/single_newline.txt"
}

# ---- Compile and test with a given buffer size ----
compile_and_test() {
    local buffer_size="$1"
    local sol_dir="$2"
    local sol_name="$3"

    echo -e "\n${YELLOW}>> Testing $sol_name with BUFFER_SIZE=$buffer_size${RESET}"

    # Copy solution files
    cp "$sol_dir"/get_next_line.c "$TEST_DIR/"
    cp "$sol_dir"/get_next_line.h "$TEST_DIR/"
    create_main

    # Compile
    gcc -Wall -Wextra -Werror -D BUFFER_SIZE="$buffer_size" \
        "$TEST_DIR/main_test.c" "$TEST_DIR/get_next_line.c" \
        -o "$TEST_DIR/gnl_test" 2>"$TEST_DIR/compile_err.txt"

    if [ $? -ne 0 ]; then
        echo -e "  ${RED}[FAIL]${RESET} Compilation failed (BUFFER_SIZE=$buffer_size)"
        cat "$TEST_DIR/compile_err.txt"
        FAIL=$((FAIL + 1))
        TOTAL=$((TOTAL + 1))
        return
    fi

    run_test "Single line" "$TEST_DIR/single_line.txt" "$buffer_size"
    run_test "Multiple lines" "$TEST_DIR/multi_line.txt" "$buffer_size"
    run_test "No trailing newline (EOF)" "$TEST_DIR/no_newline.txt" "$buffer_size"
    run_test "Empty file" "$TEST_DIR/empty.txt" "$buffer_size"
    run_test "Long line (10000 chars)" "$TEST_DIR/long_line.txt" "$buffer_size"
    run_test "Multiple empty lines" "$TEST_DIR/empty_lines.txt" "$buffer_size"
    run_test "Mixed content" "$TEST_DIR/mixed.txt" "$buffer_size"
    run_test "Single character lines" "$TEST_DIR/single_chars.txt" "$buffer_size"
    run_test "Single newline" "$TEST_DIR/single_newline.txt" "$buffer_size"
}

# ============================================================================
#  MAIN
# ============================================================================
print_header
create_test_files

# Find solution directories
SOL_DIR_1="$SCRIPT_DIR/../solution/sol_1"
SOL_DIR_2="$SCRIPT_DIR/../solution/sol_2"

for sol_dir in "$SOL_DIR_1" "$SOL_DIR_2"; do
    if [ -d "$sol_dir" ]; then
        sol_name=$(basename "$sol_dir")
        for bs in 1 42 1024 9999; do
            compile_and_test "$bs" "$sol_dir" "$sol_name"
        done
    fi
done

# ---- Summary ----
echo ""
echo -e "${CYAN}==========================================${RESET}"
echo -e "  Total: $TOTAL  |  ${GREEN}Pass: $PASS${RESET}  |  ${RED}Fail: $FAIL${RESET}"
echo -e "${CYAN}==========================================${RESET}"

if [ $FAIL -eq 0 ]; then
    echo -e "\n${GREEN}✅ All tests PASSED!${RESET}\n"
    exit 0
else
    echo -e "\n${RED}❌ Some tests FAILED.${RESET}\n"
    exit 1
fi
