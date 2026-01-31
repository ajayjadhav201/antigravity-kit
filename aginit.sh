#!/bin/bash

# --- Universal Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 1. Determine script location
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0" 2>/dev/null || greadlink -f "$0" 2>/dev/null || echo "$0")")" && pwd)"

# Defaults
SEARCH_INPUT=""
TARGET_DIR="."
DRY_RUN=false

# --- Usage ---
usage() {
    printf "${YELLOW}Usage:${NC} %s [OPTIONS] [TARGET_PATH]\n\n" "$(basename "$0")"
    printf "Options:\n"
    printf "  -t DIR         Search for '.agent' inside this directory\n"
    printf "  -n, --dry-run  Show what would happen\n"
    printf "  -h, --help     Show this help\n\n"
    exit 0
}

# 2. Support --help and --dry-run
for arg in "$@"; do
  [[ "$arg" == "--help" ]] && usage
  [[ "$arg" == "--dry-run" ]] && DRY_RUN=true
done

# 3. Parse Flags
while getopts "t:nh" opt; do
  case $opt in
    t) SEARCH_INPUT="$OPTARG" ;;
    n) DRY_RUN=true ;;
    h) usage ;;
    *) usage ;;
  esac
done
shift $((OPTIND -1))

[ -n "$1" ] && TARGET_DIR="$1"

# 4. Smart Search Logic
if [ -n "$SEARCH_INPUT" ]; then
    # Resolve the absolute path of the input
    if [ -d "$SEARCH_INPUT" ]; then
        ABS_INPUT="$(cd "$SEARCH_INPUT" && pwd)"
    elif [ -d "$SCRIPT_DIR/$SEARCH_INPUT" ]; then
        ABS_INPUT="$(cd "$SCRIPT_DIR/$SEARCH_INPUT" && pwd)"
    else
        printf "${RED}Error:${NC} Path '%s' not found.\n" "$SEARCH_INPUT"
        exit 1
    fi

    # Check if the input itself is the .agent folder
    if [[ "$ABS_INPUT" == */.agent ]] || [[ "$ABS_INPUT" == */.agent/ ]]; then
        FULL_TEMPLATE_PATH="$ABS_INPUT"
    # Otherwise, look for .agent inside the provided directory
    elif [ -d "$ABS_INPUT/.agent" ]; then
        FULL_TEMPLATE_PATH="$ABS_INPUT/.agent"
    else
        printf "${RED}Error:${NC} Could not find a '.agent' folder at or inside '%s'.\n" "$SEARCH_INPUT"
        exit 1
    fi
else
    # Default: Use the script's root directory child
    FULL_TEMPLATE_PATH="$SCRIPT_DIR/.agent"
fi

# 5. Final Validation
if [ ! -d "$FULL_TEMPLATE_PATH" ]; then
    printf "${RED}Error:${NC} '.agent' folder not found inside '%s'.\n" "$SEARCH_BASE"
    exit 1
fi

# 6. Check for Overwrite
if [ -d "$TARGET_DIR/.agent" ] && [ "$DRY_RUN" = false ]; then
    printf "${YELLOW}Warning:${NC} '%s/.agent' already exists. Overwrite? (y/N): " "$TARGET_DIR"
    read -r response
    if [[ ! "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        printf "Operation cancelled.\n"
        exit 0
    fi
fi

# 7. Execution
if [ "$DRY_RUN" = true ]; then
    printf "${YELLOW}[DRY RUN]:${NC} Would copy %s to %s/\n" "$FULL_TEMPLATE_PATH" "$TARGET_DIR"
else
    mkdir -p "$TARGET_DIR" 2>/dev/null
    if cp -Rp "$FULL_TEMPLATE_PATH" "$TARGET_DIR"; then
        printf "${GREEN}Success:${NC} '.agent' created.\n"
    else
        printf "${RED}Error:${NC} Copy failed. Check permissions.\n"
        exit 1
    fi
fi



# different ways of getting soruce dir (correct and incorrect)


# SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# SOURCE="${BASH_SOURCE[0]}"
# while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
#   DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
#   SOURCE="$(readlink "$SOURCE")"
#   [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" 
# done
# SCRIPT_DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

# --- Usage Template ---
# 
# usage() {
#     printf "${YELLOW}Usage:${NC} %s [OPTIONS] [TARGET_PATH]\n\n" "$(basename "$0")"
#     printf "${YELLOW}Options:${NC}\n"
#     printf "  -t DIR         Directory to search for the '.agent' folder.\n"
#     printf "  -n, --dry-run  Show what would be copied without doing it.\n"
#     printf "  -h, --help     Display this help message.\n\n"
#     printf "${YELLOW}Arguments:${NC}\n"
#     printf "  TARGET_PATH    Destination directory (Default: '.')\n\n"
#     exit 0
# }