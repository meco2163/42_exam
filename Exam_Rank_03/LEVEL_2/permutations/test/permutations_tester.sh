#!/bin/bash
# ============================================================================
#  permutations tester
#  Tests the permutations program for correct output in alphabetical order
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
    echo -e "${CYAN}       permutations tester                ${RESET}"
    echo -e "${CYAN}==========================================${RESET}"
    echo ""
}

run_test() {
    local test_name="$1"
    local input="$2"
    local expected="$3"
    TOTAL=$((TOTAL + 1))

    local actual
    actual=$(timeout 10 "$TEST_DIR/permutations" "$input" 2>/dev/null)
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
        echo -e "    Expected: $(echo "$expected" | head -3)..."
        echo -e "    Got:      $(echo "$actual" | head -3)..."
        FAIL=$((FAIL + 1))
    fi
}

run_count_test() {
    local test_name="$1"
    local input="$2"
    local expected_count="$3"
    TOTAL=$((TOTAL + 1))

    local actual_count
    actual_count=$(timeout 10 "$TEST_DIR/permutations" "$input" 2>/dev/null | wc -l)

    if [ "$actual_count" -eq "$expected_count" ]; then
        echo -e "  ${GREEN}[PASS]${RESET} $test_name (count=$actual_count)"
        PASS=$((PASS + 1))
    else
        echo -e "  ${RED}[FAIL]${RESET} $test_name (expected $expected_count, got $actual_count)"
        FAIL=$((FAIL + 1))
    fi
}

run_sorted_test() {
    local test_name="$1"
    local input="$2"
    TOTAL=$((TOTAL + 1))

    local output
    output=$(timeout 10 "$TEST_DIR/permutations" "$input" 2>/dev/null)

    local sorted
    sorted=$(echo "$output" | sort)

    if [ "$output" = "$sorted" ]; then
        echo -e "  ${GREEN}[PASS]${RESET} $test_name (alphabetical order)"
        PASS=$((PASS + 1))
    else
        echo -e "  ${RED}[FAIL]${RESET} $test_name (not in alphabetical order)"
        FAIL=$((FAIL + 1))
    fi
}

# ============================================================================
#  MAIN
# ============================================================================
print_header

# Compile
echo -e "${YELLOW}>> Compiling permutations...${RESET}"
gcc -Wall -Wextra -Werror "$SOL_DIR/permutations.c" -o "$TEST_DIR/permutations" 2>"$TEST_DIR/compile_err.txt"
if [ $? -ne 0 ]; then
    echo -e "  ${RED}[FAIL]${RESET} Compilation failed"
    cat "$TEST_DIR/compile_err.txt"
    exit 1
fi
echo -e "  ${GREEN}[OK]${RESET} Compilation successful"

# ---- Subject examples ----
echo -e "\n${YELLOW}>> Subject examples${RESET}"
EXPECTED_A="a"
run_test "permutations 'a'" "a" "$EXPECTED_A"

EXPECTED_AB=$(printf "ab\nba")
run_test "permutations 'ab'" "ab" "$EXPECTED_AB"

EXPECTED_ABC=$(printf "abc\nacb\nbac\nbca\ncab\ncba")
run_test "permutations 'abc'" "abc" "$EXPECTED_ABC"

# ---- Count tests (n! permutations) ----
echo -e "\n${YELLOW}>> Permutation count tests${RESET}"
run_count_test "1 char -> 1 perm" "z" 1
run_count_test "2 chars -> 2 perms" "xy" 2
run_count_test "3 chars -> 6 perms" "abc" 6
run_count_test "4 chars -> 24 perms" "abcd" 24
run_count_test "5 chars -> 120 perms" "abcde" 120

# ---- Alphabetical order tests ----
echo -e "\n${YELLOW}>> Alphabetical order tests${RESET}"
run_sorted_test "3 chars sorted" "abc"
run_sorted_test "4 chars sorted" "abcd"
run_sorted_test "Unsorted input 'cba'" "cba"
run_sorted_test "Unsorted input 'bac'" "bac"

# ---- No duplicates test ----
echo -e "\n${YELLOW}>> No duplicates test${RESET}"
TOTAL=$((TOTAL + 1))
output=$(timeout 10 "$TEST_DIR/permutations" "abcd" 2>/dev/null)
total_lines=$(echo "$output" | wc -l)
unique_lines=$(echo "$output" | sort -u | wc -l)
if [ "$total_lines" -eq "$unique_lines" ]; then
    echo -e "  ${GREEN}[PASS]${RESET} No duplicates in 'abcd' ($total_lines unique)"
    PASS=$((PASS + 1))
else
    echo -e "  ${RED}[FAIL]${RESET} Duplicates found in 'abcd' (total=$total_lines, unique=$unique_lines)"
    FAIL=$((FAIL + 1))
fi

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
