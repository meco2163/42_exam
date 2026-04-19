#!/bin/bash
# ============================================================================
#  filter tester
#  Tests the filter program (replaces occurrences of a string with asterisks)
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
SOL_DIR="$SCRIPT_DIR/../solution"

cleanup() {
    rm -rf "$TEST_DIR"
}
trap cleanup EXIT

print_header() {
    echo -e "${CYAN}==========================================${RESET}"
    echo -e "${CYAN}       filter tester                      ${RESET}"
    echo -e "${CYAN}==========================================${RESET}"
    echo ""
}

run_test() {
    local test_name="$1"
    local input="$2"
    local arg="$3"
    local expected="$4"
    TOTAL=$((TOTAL + 1))

    local actual
    actual=$(echo "$input" | timeout 5 "$TEST_DIR/filter" "$arg" 2>/dev/null)
    local exit_code=$?

    if [ $exit_code -eq 124 ]; then
        echo -e "  ${RED}[FAIL]${RESET} $test_name (timeout)"
        FAIL=$((FAIL + 1))
        return
    fi

    if [ "$expected" = "$actual" ]; then
        echo -e "  ${GREEN}[PASS]${RESET} $test_name"
        PASS=$((PASS + 1))
    else
        echo -e "  ${RED}[FAIL]${RESET} $test_name"
        echo -e "    Input:    '$input' | filter '$arg'"
        echo -e "    Expected: '$expected'"
        echo -e "    Got:      '$actual'"
        FAIL=$((FAIL + 1))
    fi
}

run_exit_test() {
    local test_name="$1"
    shift
    local expected_exit="$1"
    shift
    TOTAL=$((TOTAL + 1))

    echo "" | timeout 5 "$TEST_DIR/filter" "$@" >/dev/null 2>&1
    local actual_exit=$?

    if [ $actual_exit -eq "$expected_exit" ]; then
        echo -e "  ${GREEN}[PASS]${RESET} $test_name (exit=$actual_exit)"
        PASS=$((PASS + 1))
    else
        echo -e "  ${RED}[FAIL]${RESET} $test_name (expected exit=$expected_exit, got exit=$actual_exit)"
        FAIL=$((FAIL + 1))
    fi
}

# ============================================================================
#  MAIN
# ============================================================================
print_header

# Compile
echo -e "${YELLOW}>> Compiling filter...${RESET}"
gcc -Wall -Wextra -Werror "$SOL_DIR/filter.c" -o "$TEST_DIR/filter" 2>"$TEST_DIR/compile_err.txt"
if [ $? -ne 0 ]; then
    echo -e "  ${RED}[FAIL]${RESET} Compilation failed"
    cat "$TEST_DIR/compile_err.txt"
    exit 1
fi
echo -e "  ${GREEN}[OK]${RESET} Compilation successful"
echo ""

# ---- Subject examples ----
echo -e "${YELLOW}>> Subject examples${RESET}"
run_test "Subject test 1: abc in abcdefaaaabcdeabcabcdabc" \
    "abcdefaaaabcdeabcabcdabc" "abc" "***defaaa***de******d***"

run_test "Subject test 2: ababc in ababcabababc" \
    "ababcabababc" "ababc" "*****ab*****"

# ---- Basic tests ----
echo -e "\n${YELLOW}>> Basic tests${RESET}"
run_test "Simple replacement" "hello world" "world" "hello *****"
run_test "No match" "hello world" "xyz" "hello world"
run_test "Full match" "abc" "abc" "***"
run_test "Single char replacement" "abcabc" "a" "*bc*bc"
run_test "Replacement at start" "abcdef" "abc" "***def"
run_test "Replacement at end" "defabc" "abc" "def***"

# ---- Edge cases ----
echo -e "\n${YELLOW}>> Edge cases${RESET}"
run_test "Overlapping pattern" "aaa" "aa" "**a"
run_test "Empty input" "" "abc" ""
run_test "Single character input and match" "a" "a" "*"
run_test "Longer pattern than input" "ab" "abcdef" "ab"
run_test "Repeated pattern" "abcabcabc" "abc" "*********"

# ---- Error handling ----
echo -e "\n${YELLOW}>> Error handling (exit codes)${RESET}"
run_exit_test "No arguments" 1
run_exit_test "Empty argument" 1 ""
run_exit_test "Multiple arguments" 1 "abc" "def"

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
