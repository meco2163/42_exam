#!/bin/bash
# ============================================================================
#  rip tester
#  Tests the rip program (remove minimum parentheses to balance)
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
    echo -e "${CYAN}       rip tester                         ${RESET}"
    echo -e "${CYAN}==========================================${RESET}"
    echo ""
}

# Check if a string has balanced parentheses (spaces are ignored)
is_balanced() {
    local s="$1"
    local count=0
    local i
    for ((i = 0; i < ${#s}; i++)); do
        local c="${s:$i:1}"
        if [ "$c" = "(" ]; then
            count=$((count + 1))
        elif [ "$c" = ")" ]; then
            count=$((count - 1))
            if [ $count -lt 0 ]; then
                return 1
            fi
        fi
    done
    [ $count -eq 0 ]
}

# Compare outputs (order doesn't matter)
run_test() {
    local test_name="$1"
    local input="$2"
    local expected="$3"
    TOTAL=$((TOTAL + 1))

    local actual
    actual=$(timeout 10 "$TEST_DIR/rip" "$input" 2>/dev/null)
    local exit_code=$?

    if [ $exit_code -eq 124 ]; then
        echo -e "  ${RED}[FAIL]${RESET} $test_name (timeout)"
        FAIL=$((FAIL + 1))
        return
    fi

    local expected_sorted
    local actual_sorted
    expected_sorted=$(echo "$expected" | sort)
    actual_sorted=$(echo "$actual" | sort)

    if [ "$expected_sorted" = "$actual_sorted" ]; then
        echo -e "  ${GREEN}[PASS]${RESET} $test_name"
        PASS=$((PASS + 1))
    else
        echo -e "  ${RED}[FAIL]${RESET} $test_name"
        echo -e "    Input:    '$input'"
        echo -e "    Expected (sorted):"
        echo "$expected_sorted" | head -5 | sed 's/^/      /'
        echo -e "    Got (sorted):"
        echo "$actual_sorted" | head -5 | sed 's/^/      /'
        FAIL=$((FAIL + 1))
    fi
}

# Check that all output lines are balanced
run_balance_test() {
    local test_name="$1"
    local input="$2"
    TOTAL=$((TOTAL + 1))

    local output
    output=$(timeout 10 "$TEST_DIR/rip" "$input" 2>/dev/null)

    if [ -z "$output" ]; then
        echo -e "  ${GREEN}[PASS]${RESET} $test_name (no output)"
        PASS=$((PASS + 1))
        return
    fi

    local all_balanced=1
    while IFS= read -r line; do
        if ! is_balanced "$line"; then
            echo -e "  ${RED}[FAIL]${RESET} $test_name (unbalanced output: '$line')"
            all_balanced=0
            break
        fi
    done <<< "$output"

    if [ $all_balanced -eq 1 ]; then
        echo -e "  ${GREEN}[PASS]${RESET} $test_name (all outputs balanced)"
        PASS=$((PASS + 1))
    else
        FAIL=$((FAIL + 1))
    fi
}

# Check no duplicate lines
run_no_dup_test() {
    local test_name="$1"
    local input="$2"
    TOTAL=$((TOTAL + 1))

    local output
    output=$(timeout 10 "$TEST_DIR/rip" "$input" 2>/dev/null)

    if [ -z "$output" ]; then
        echo -e "  ${GREEN}[PASS]${RESET} $test_name (no output)"
        PASS=$((PASS + 1))
        return
    fi

    local total_lines
    local unique_lines
    total_lines=$(echo "$output" | wc -l)
    unique_lines=$(echo "$output" | sort -u | wc -l)

    if [ "$total_lines" -eq "$unique_lines" ]; then
        echo -e "  ${GREEN}[PASS]${RESET} $test_name ($total_lines unique)"
        PASS=$((PASS + 1))
    else
        echo -e "  ${RED}[FAIL]${RESET} $test_name (total=$total_lines, unique=$unique_lines)"
        FAIL=$((FAIL + 1))
    fi
}

# Check same length as original (spaces replace parens)
run_length_test() {
    local test_name="$1"
    local input="$2"
    local input_len=${#input}
    TOTAL=$((TOTAL + 1))

    local output
    output=$(timeout 10 "$TEST_DIR/rip" "$input" 2>/dev/null)

    if [ -z "$output" ]; then
        echo -e "  ${GREEN}[PASS]${RESET} $test_name (no output)"
        PASS=$((PASS + 1))
        return
    fi

    local all_correct=1
    while IFS= read -r line; do
        if [ ${#line} -ne "$input_len" ]; then
            echo -e "  ${RED}[FAIL]${RESET} $test_name (line length ${#line} != input length $input_len: '$line')"
            all_correct=0
            break
        fi
    done <<< "$output"

    if [ $all_correct -eq 1 ]; then
        echo -e "  ${GREEN}[PASS]${RESET} $test_name (all lines same length as input)"
        PASS=$((PASS + 1))
    else
        FAIL=$((FAIL + 1))
    fi
}

# ============================================================================
#  MAIN
# ============================================================================
print_header

# Compile
echo -e "${YELLOW}>> Compiling rip...${RESET}"
gcc -Wall -Wextra -Werror "$SOL_DIR/rip.c" -o "$TEST_DIR/rip" 2>"$TEST_DIR/compile_err.txt"
if [ $? -ne 0 ]; then
    echo -e "  ${RED}[FAIL]${RESET} Compilation failed"
    cat "$TEST_DIR/compile_err.txt"
    exit 1
fi
echo -e "  ${GREEN}[OK]${RESET} Compilation successful"

# ---- Subject examples ----
echo -e "\n${YELLOW}>> Subject examples${RESET}"

EXPECTED_1=$(printf " ()\n( )")
run_test "rip '(()'" "((" "$EXPECTED_1"

EXPECTED_2="((()()())())"
run_test "rip '((()()())())'" "((()()())())" "$EXPECTED_2"

EXPECTED_3=$(printf "()() ()\n()( )()\n( ())()")
run_test "rip '()())()'" "()())()" "$EXPECTED_3"

EXPECTED_4=$(printf "(()  ) \n( )( ) \n( ) () \n ()( ) ")
run_test "rip '(()(()(' " "(()(()(" "$EXPECTED_4"

# ---- Balance validity tests ----
echo -e "\n${YELLOW}>> Balance validity tests${RESET}"
run_balance_test "Balance check '(()'" "(("
run_balance_test "Balance check '()())()'" "()())()"
run_balance_test "Balance check '(()(()(' " "(()(()("
run_balance_test "Balance check '((()()())())'" "((()()())())"

# ---- Length preservation tests ----
echo -e "\n${YELLOW}>> Length preservation tests${RESET}"
run_length_test "Length check '(()'" "(("
run_length_test "Length check '()())()'" "()())()"
run_length_test "Length check '(()(()(' " "(()(()("

# ---- No duplicates tests ----
echo -e "\n${YELLOW}>> No duplicates tests${RESET}"
run_no_dup_test "No dups '(()'" "(("
run_no_dup_test "No dups '()())()'" "()())()"
run_no_dup_test "No dups '(()(()(' " "(()(()("

# ---- Additional tests ----
echo -e "\n${YELLOW}>> Additional tests${RESET}"

# Already balanced
EXPECTED_BALANCED="()()"
run_test "Already balanced '()()'" "()()" "$EXPECTED_BALANCED"

# Single paren
EXPECTED_SINGLE=" "
run_test "Single '('" "(" "$EXPECTED_SINGLE"

EXPECTED_SINGLE2=" "
run_test "Single ')'" ")" "$EXPECTED_SINGLE2"

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
