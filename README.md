# CDMS (Codex Machine Sync)

**CDMS** is a lightweight, safe synchronization tool for OpenAI Codex CLI (`~/.codex`) across multiple machines (e.g., MacBook ↔ Mac Mini).

It is a fork of [ccms](https://github.com/miwidot/ccms), specialized for the Codex environment with optimized safety rules.

## 🚀 Features

- **Brain Sync**: Synchronizes your Codex sessions, context, and settings.
- **Safety First**: Automatically excludes sensitive files (`auth.json`) and crash-prone SQLite temporary files (`.db-wal`, `.db-shm`).
- **Bidirectional**: Supports both `push` (upload) and `pull` (download).
- **Auto-Backup**: Automatically creates a local backup before pulling to prevent data loss.
- **Integrity Check**: Verifies file integrity using SHA256 checksums.
- **Path Mapping**: Optionally normalizes machine-specific absolute paths in
  Codex session/config files during sync, using a user-defined pathmap.

## 📦 Installation

### Option 1: Using the Install Script (Recommended)

Run the following commands in your terminal:

```bash
# 1. Clone the repository
git clone https://github.com/uhjinshin/cdms.git
cd cdms

# 2. Run the installer
chmod +x install.sh
./install.sh
```

### Option 2: Manual Installation

If you prefer to install manually:

```bash
chmod +x cdms
sudo cp cdms /usr/local/bin/
```

## ⚙️ Configuration

Before using CDMS, you need to configure your remote server (e.g., your Mac Mini).

```bash
cdms config
```

You will be asked for:
1.  **Remote Host**: Your SSH alias or IP address (e.g., `mac-mini` or `192.168.0.x`).
2.  **Remote Path**: Press **Enter** to use the default (`.codex`).
3.  **Rsync Options**: Press **Enter** to use defaults (`-avz --delete`).

## 🛠 Usage

### Basic Commands

| Command | Description |
|---------|-------------|
| `cdms push` | Upload local changes to the remote machine |
| `cdms pull` | Download remote changes to the local machine |
| `cdms status` | Show differences between local and remote |
| `cdms verify` | Verify file integrity |
| `cdms backup` | Create a manual backup of `~/.codex` |

### Typical Workflow (Laptop ↔ Desktop)

1.  **Start working (on Laptop):**
    ```bash
    cdms pull
    ```
2.  **Finish working:**
    ```bash
    cdms push
    ```
3.  **Switch to Desktop:**
    ```bash
    cdms pull
    ```

## ⚠️ Important Safety Notes

### 1. Close Codex Before Syncing
To prevent SQLite database corruption, **always close the Codex terminal/process before running `push` or `pull`.**

### 2. Auth Tokens are NOT Synced
For security reasons, `auth.json` is excluded by default. You must log in to Codex on each machine individually.

### 3. Excluded Files
The following files are excluded to ensure stability:
- `.DS_Store`
- `*.log`, `*.lock`, `*.sock`
- `tmp/` directory
- `*.db-wal`, `*.db-shm` (SQLite temporary files)

### 4. Optional Path Mapping

Codex session files can contain absolute working directories. If one machine
stores projects under a physical path that does not exist on another machine
for example because `~/Desktop` is a symlink to an external volume, add explicit
prefix mappings in:

```text
~/.cdms/pathmap
```

Format:

```text
from_prefix=to_prefix
```

Example:

```text
/Volumes/UJ_Solidigm/Desktop=$HOME/Desktop
/Volumes/UJ_Solidigm/Projects=$HOME/Projects
```

Path mappings are applied only to temporary staging copies during `push` and
`pull`. CDMS does not rewrite your original `~/.codex` files in place before
syncing. This keeps the feature scoped and avoids hard-coding any particular
repository name.

## 📂 File Structure

CDMS stores its configuration and backups in `~/.cdms/`:

```text
~/.cdms/
├── config              # Server connection settings
├── exclude             # Rsync exclude patterns
├── pathmap             # Optional absolute path normalization rules
├── backups/            # Auto-generated backups (keeps last 5)
├── sync.lock           # Prevents concurrent operations
└── checksums           # File integrity data
```

## License

This project is licensed under the MIT License.
Based on [ccms](https://github.com/miwidot/ccms) by miwidot.
