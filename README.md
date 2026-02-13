# CDMS - Codex Machine Sync

**CDMS** is a lightweight tool to synchronize your OpenAI Codex CLI environment (`~/.codex`) across multiple machines (e.g., MacBook ↔ Mac Mini).

It is a fork of [ccms](https://github.com/miwidot/ccms) adapted for Codex.

## Features

- 🧠 **Syncs Codex Brain**: Keeps sessions, settings, and context in sync.
- 🛡️ **Safety First**: Automatically excludes sensitive `auth.json` and crash-prone SQLite temp files (`.db-wal`).
- 🔄 **Bidirectional**: Push to server / Pull from server.
- 📦 **Backups**: Auto-backups local state before pulling.

## Installation

```bash
# Clone this repository
git clone [https://github.com/YOUR_USERNAME/cdms.git](https://github.com/YOUR_USERNAME/cdms.git)
cd cdms

# Run installer
chmod +x install.sh
./install.sh
```

Quick Start
Configure:

Bash
cdms config
Remote Host: Your SSH alias (e.g., mac-mini)

Remote Path: Press Enter (defaults to .codex)

Sync:

Bash
cdms push   # Upload from current machine
cdms pull   # Download to current machine
Safety Note
Close Codex before syncing to ensure database integrity.

Auth Tokens: auth.json is excluded by default for security. You must log in on each machine once.


---

### 📝 5단계: 라이선스 (`LICENSE`)

오픈소스 매너를 지키기 위해 원작자(miwidot)의 MIT 라이선스[cite: 80]를 유지하되, 님의 이름도 추가할 수 있습니다.

`nano LICENSE` 입력 후 붙여넣기:

```text
MIT License

Copyright (c) 2025 Uh-Jin Shin
Copyright (c) 2025 miwidot (Original CCMS)

Permission is hereby granted, free of charge, to any person obtaining a copy...
(이하 MIT 라이선스 전문은 인터넷에서 복사하거나 ccms의 것 그대로 사용)
```
