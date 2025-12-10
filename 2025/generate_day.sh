#!/bin/bash

# Script to generate Advent of Code day files
# Usage: ./generate_day.sh <day_number>

if [ $# -eq 0 ]; then
    echo "Usage: $0 <day_number>"
    echo "Example: $0 8"
    exit 1
fi

DAY=$1

# Validate day number
if ! [[ "$DAY" =~ ^[0-9]+$ ]] || [ "$DAY" -lt 1 ] || [ "$DAY" -gt 25 ]; then
    echo "Error: Day must be a number between 1 and 25"
    exit 1
fi

# Get the script directory (where the script is located)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Paths
INPUT_FILE="${SCRIPT_DIR}/Inputs/day${DAY}_input.txt"
DAY_FILE="${SCRIPT_DIR}/Days/day${DAY}.rb"
MAIN_FILE="${SCRIPT_DIR}/main.rb"

echo "Generating files for Day ${DAY}..."

# Create input file if it doesn't exist
if [ ! -f "$INPUT_FILE" ]; then
    touch "$INPUT_FILE"
    echo "Created: $INPUT_FILE"
else
    echo "Already exists: $INPUT_FILE"
fi

# Create day Ruby file if it doesn't exist
if [ ! -f "$DAY_FILE" ]; then
    cat > "$DAY_FILE" << EOF
require_relative 'day'
class Day${DAY} < Day
  DAY = ${DAY}

  def self.solve_part1
    input = get_raw_input(DAY)
    # TODO: Implement part 1 solution
    0
  end

  def self.solve_part2
    input = get_raw_input(DAY)
    # TODO: Implement part 2 solution
    0
  end
end
EOF
    echo "Created: $DAY_FILE"
else
    echo "Already exists: $DAY_FILE"
fi

# Update main.rb to include the new day
REQUIRE_LINE="require_relative 'Days/Day${DAY}'"
PUTS_BLOCK="puts(\"Day ${DAY}:\")\nputs(\" - #{Day${DAY}.solve_part1}\")\nputs(\" - #{Day${DAY}.solve_part2}\")\n"

# Check if require statement already exists
if ! grep -q "$REQUIRE_LINE" "$MAIN_FILE"; then
    # Find the last require_relative line number and add the new one after it
    LAST_REQUIRE_LINE=$(grep -n "^require_relative 'Days/Day[0-9]*'" "$MAIN_FILE" | tail -1 | cut -d: -f1)
    if [ -n "$LAST_REQUIRE_LINE" ]; then
        sed -i '' "${LAST_REQUIRE_LINE}a\\
$REQUIRE_LINE
" "$MAIN_FILE"
    else
        # If no existing require lines, add at the beginning
        sed -i '' "1i\\
$REQUIRE_LINE
" "$MAIN_FILE"
    fi
    echo "Added require statement to main.rb"
else
    echo "Require statement already exists in main.rb"
fi

# Check if puts block already exists
if ! grep -q "Day ${DAY}:" "$MAIN_FILE"; then
    # Add the puts block at the end of the file
    echo -e "\n$PUTS_BLOCK" >> "$MAIN_FILE"
    echo "Added puts statements to main.rb"
else
    echo "Puts statements already exist in main.rb"
fi

echo "Day ${DAY} files generated successfully!"
