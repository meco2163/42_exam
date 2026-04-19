#!/bin/bash
# ============================================================================
#  powerset tester
#  Tests the powerset program (subsets whose sum equals target)
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
    echo -e "${CYAN}       powerset tester                    ${RESET}"
    echo -e "${CYAN}==========================================${RESET}"
    echo ""
}

# Compare output: sort both expected and actual, then diff
run_test() {
    local test_name="$1"
    local expected="$2"
    shift 2
    TOTAL=$((TOTAL + 1))

    local actual
    actual=$(timeout 10 "$TEST_DIR/powerset" "$@" 2>/dev/null)
    local exit_code=$?

    if [ $exit_code -eq 124 ]; then
        echo -e "  ${RED}[FAIL]${RESET} $test_name (timeout)"
        FAIL=$((FAIL + 1))
        return
    fi

    # Sort both for comparison (order of lines is not important)
    local expected_sorted
    local actual_sorted
    expected_sorted=$(echo "$expected" | sort)
    actual_sorted=$(echo "$actual" | sort)

    if [ "$expected_sorted" = "$actual_sorted" ]; then
        echo -e "  ${GREEN}[PASS]${RESET} $test_name"
        PASS=$((PASS + 1))
    else
        echo -e "  ${RED}[FAIL]${RESET} $test_name"
        echo -e "    Expected (sorted): $(echo "$expected_sorted" | head -5)"
        echo -e "    Got (sorted):      $(echo "$actual_sorted" | head -5)"
        FAIL=$((FAIL + 1))
    fi
}

run_count_test() {
    local test_name="$1"
    local expected_count="$2"
    shift 2
    TOTAL=$((TOTAL + 1))

    local actual_count
    actual_count=$(timeout 10 "$TEST_DIR/powerset" "$@" 2>/dev/null | wc -l)

    if [ "$actual_count" -eq "$expected_count" ]; then
        echo -e "  ${GREEN}[PASS]${RESET} $test_name (count=$actual_count)"
        PASS=$((PASS + 1))
    else
        echo -e "  ${RED}[FAIL]${RESET} $test_name (expected $expected_count lines, got $actual_count)"
        FAIL=$((FAIL + 1))
    fi
}

# ============================================================================
#  MAIN
# ============================================================================
print_header

# Compile
echo -e "${YELLOW}>> Compiling powerset...${RESET}"
gcc -Wall -Wextra -Werror "$SOL_DIR/powerset.c" -o "$TEST_DIR/powerset" 2>"$TEST_DIR/compile_err.txt"
if [ $? -ne 0 ]; then
    echo -e "  ${RED}[FAIL]${RESET} Compilation failed"
    cat "$TEST_DIR/compile_err.txt"
    exit 1
fi
echo -e "  ${GREEN}[OK]${RESET} Compilation successful"

# ---- Subject examples ----
echo -e "\n${YELLOW}>> Subject examples${RESET}"

EXPECTED_1=$(printf "3\n0 3\n1 2\n1 0 2")
run_test "powerset 3 1 0 2 4 5 3" "$EXPECTED_1" 3 1 0 2 4 5 3

EXPECTED_2=$(printf "8 4\n1 11\n1 4 7\n1 8 3\n2 3 7\n5 7\n5 4 3\n5 2 1 4")
run_test "powerset 12 5 2 1 8 4 3 7 11" "$EXPECTED_2" 12 5 2 1 8 4 3 7 11

EXPECTED_3=$(printf "\n1 -1")
run_test "powerset 0 1 -1" "$EXPECTED_3" 0 1 -1

# ---- Additional tests ----
echo -e "\n${YELLOW}>> Additional tests${RESET}"

EXPECTED_4=$(printf "5\n1 4\n2 3")
run_test "powerset 5 1 2 3 4 5" "$EXPECTED_4" 5 1 2 3 4 5

# Single element match
EXPECTED_5="10"
run_test "powerset 10 10" "$EXPECTED_5" 10 10

# No solution
TOTAL=$((TOTAL + 1))
actual=$(timeout 10 "$TEST_DIR/powerset" 100 1 2 3 2>/dev/null)
if [ -z "$actual" ]; then
    echo -e "  ${GREEN}[PASS]${RESET} No solution case (empty output)"
    PASS=$((PASS + 1))
else
    echo -e "  ${RED}[FAIL]${RESET} No solution case (expected empty, got output)"
    FAIL=$((FAIL + 1))
fi

# ---- Error handling ----
echo -e "\n${YELLOW}>> Error handling${RESET}"
TOTAL=$((TOTAL + 1))
"$TEST_DIR/powerset" >/dev/null 2>&1
if [ $? -eq 1 ]; then
    echo -e "  ${GREEN}[PASS]${RESET} No arguments returns 1"
    PASS=$((PASS + 1))
else
    echo -e "  ${RED}[FAIL]${RESET} No arguments should return 1"
    FAIL=$((FAIL + 1))
fi

TOTAL=$((TOTAL + 1))
"$TEST_DIR/powerset" 5 >/dev/null 2>&1
if [ $? -eq 1 ]; then
    echo -e "  ${GREEN}[PASS]${RESET} Only target (no set) returns 1"
    PASS=$((PASS + 1))
else
    echo -e "  ${RED}[FAIL]${RESET} Only target should return 1"
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
