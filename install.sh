#!/usr/bin/env bash

# CDMS (Codex Machine Sync) Installation Script

set -euo pipefail

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# Default installation directory
# 맥/리눅스 표준인 사용자 로컬 bin 폴더 사용
DEFAULT_INSTALL_DIR="$HOME/.local/bin"

print_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[✓]${NC} $1"; }
print_error() { echo -e "${RED}[✗]${NC} $1" >&2; }

# Main installation process
main() {
    print_info "CDMS (Codex Machine Sync) Installer"
    echo
    
    # Check if rsync exists
    if ! command -v rsync &> /dev/null; then
        print_error "rsync is required but not installed."
        echo "Please install rsync first (e.g., brew install rsync)"
        exit 1
    fi
    
    # Check if cdms file exists
    if [[ ! -f "cdms" ]]; then
        print_error "'cdms' script not found in current directory."
        exit 1
    fi
    
    # Get installation directory
    read -p "Install location [$DEFAULT_INSTALL_DIR]: " INSTALL_DIR
    INSTALL_DIR="${INSTALL_DIR:-$DEFAULT_INSTALL_DIR}"

    # Create directory if needed
    if [[ ! -d "$INSTALL_DIR" ]]; then
        mkdir -p "$INSTALL_DIR" || {
            print_error "Failed to create installation directory"
            exit 1
        }
    fi

    # Copy script
    print_info "Installing cdms to $INSTALL_DIR..."
    cp cdms "$INSTALL_DIR/" || {
        print_error "Failed to copy script"
        exit 1
    }

    # Make executable
    chmod +x "$INSTALL_DIR/cdms"

    print_success "Installed successfully!"

    # Path check
    if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
        echo
        print_info "NOTE: $INSTALL_DIR is not in your PATH."
        echo "Add this to your ~/.zshrc or ~/.bashrc:"
        echo "  export PATH=\"\$PATH:$INSTALL_DIR\""
    fi
    
    echo
    echo "Usage:"
    echo "  cdms config   # Setup connection"
    echo "  cdms push     # Upload Codex data"
    echo "  cdms pull     # Download Codex data"
}

main
