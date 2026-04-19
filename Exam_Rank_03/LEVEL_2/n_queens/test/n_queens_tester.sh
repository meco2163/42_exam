#!/bin/bash
# ============================================================================
#  n_queens tester
#  Tests the n_queens program by verifying solution count and validity
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
    echo -e "${CYAN}       n_queens tester                    ${RESET}"
    echo -e "${CYAN}==========================================${RESET}"
    echo ""
}

# Validate that a solution is correct for n-queens
validate_solution() {
    local n="$1"
    local line="$2"
    local -a queens
    read -ra queens <<< "$line"

    # Check correct number of queens
    if [ ${#queens[@]} -ne "$n" ]; then
        return 1
    fi

    # Check each queen position is valid (0 to n-1)
    for q in "${queens[@]}"; do
        if [ "$q" -lt 0 ] || [ "$q" -ge "$n" ]; then
            return 1
        fi
    done

    # Check no two queens on same row or diagonal
    for ((i = 0; i < n; i++)); do
        for ((j = i + 1; j < n; j++)); do
            # Same row
            if [ "${queens[$i]}" -eq "${queens[$j]}" ]; then
                return 1
            fi
            # Same diagonal
            local row_diff=$(( ${queens[$j]} - ${queens[$i]} ))
            local col_diff=$(( j - i ))
            if [ "${row_diff#-}" -eq "$col_diff" ]; then
                return 1
            fi
        done
    done
    return 0
}

run_count_test() {
    local n="$1"
    local expected_count="$2"
    TOTAL=$((TOTAL + 1))

    local output
    output=$(timeout 10 "$TEST_DIR/n_queens" "$n" 2>/dev/null)
    local exit_code=$?

    if [ $exit_code -eq 124 ]; then
        echo -e "  ${RED}[FAIL]${RESET} n=$n (timeout)"
        FAIL=$((FAIL + 1))
        return
    fi

    # Count lines (excluding empty)
    local actual_count
    if [ -z "$output" ]; then
        actual_count=0
    else
        actual_count=$(echo "$output" | grep -c '^')
    fi

    if [ "$actual_count" -eq "$expected_count" ]; then
        echo -e "  ${GREEN}[PASS]${RESET} n=$n  solutions=$actual_count (expected $expected_count)"
        PASS=$((PASS + 1))
    else
        echo -e "  ${RED}[FAIL]${RESET} n=$n  solutions=$actual_count (expected $expected_count)"
        FAIL=$((FAIL + 1))
    fi
}

run_validity_test() {
    local n="$1"
    TOTAL=$((TOTAL + 1))

    local output
    output=$(timeout 10 "$TEST_DIR/n_queens" "$n" 2>/dev/null)

    if [ -z "$output" ]; then
        echo -e "  ${GREEN}[PASS]${RESET} n=$n validity (no solutions, nothing to validate)"
        PASS=$((PASS + 1))
        return
    fi

    local all_valid=1
    while IFS= read -r line; do
        if ! validate_solution "$n" "$line"; then
            echo -e "  ${RED}[FAIL]${RESET} n=$n validity (invalid solution: $line)"
            all_valid=0
            break
        fi
    done <<< "$output"

    if [ $all_valid -eq 1 ]; then
        echo -e "  ${GREEN}[PASS]${RESET} n=$n validity (all solutions valid)"
        PASS=$((PASS + 1))
    else
        FAIL=$((FAIL + 1))
    fi
}

run_no_duplicates_test() {
    local n="$1"
    TOTAL=$((TOTAL + 1))

    local output
    output=$(timeout 10 "$TEST_DIR/n_queens" "$n" 2>/dev/null)

    if [ -z "$output" ]; then
        echo -e "  ${GREEN}[PASS]${RESET} n=$n no duplicates (no solutions)"
        PASS=$((PASS + 1))
        return
    fi

    local total_lines
    local unique_lines
    total_lines=$(echo "$output" | wc -l)
    unique_lines=$(echo "$output" | sort -u | wc -l)

    if [ "$total_lines" -eq "$unique_lines" ]; then
        echo -e "  ${GREEN}[PASS]${RESET} n=$n no duplicates ($total_lines unique)"
        PASS=$((PASS + 1))
    else
        echo -e "  ${RED}[FAIL]${RESET} n=$n has duplicates (total=$total_lines, unique=$unique_lines)"
        FAIL=$((FAIL + 1))
    fi
}

# ============================================================================
#  MAIN
# ============================================================================
print_header

# Compile
echo -e "${YELLOW}>> Compiling n_queens...${RESET}"
gcc -Wall -Wextra -Werror "$SOL_DIR/n_queens.c" -o "$TEST_DIR/n_queens" 2>"$TEST_DIR/compile_err.txt"
if [ $? -ne 0 ]; then
    echo -e "  ${RED}[FAIL]${RESET} Compilation failed"
    cat "$TEST_DIR/compile_err.txt"
    exit 1
fi
echo -e "  ${GREEN}[OK]${RESET} Compilation successful"

# Known solution counts: n=1:1, n=2:0, n=3:0, n=4:2, n=5:10, n=6:4, n=7:40, n=8:92
echo -e "\n${YELLOW}>> Solution count tests${RESET}"
run_count_test 1 1
run_count_test 2 0
run_count_test 3 0
run_count_test 4 2
run_count_test 5 10
run_count_test 6 4
run_count_test 7 40
run_count_test 8 92

echo -e "\n${YELLOW}>> Solution validity tests${RESET}"
run_validity_test 4
run_validity_test 5
run_validity_test 6
run_validity_test 8

echo -e "\n${YELLOW}>> Duplicate check tests${RESET}"
run_no_duplicates_test 4
run_no_duplicates_test 5
run_no_duplicates_test 8

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
