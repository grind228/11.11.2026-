#!/bin/bash

set -e

REPO_NAME="homework-tracker-ivanov"
mkdir -p "$REPO_NAME"
cd "$REPO_NAME"

git init -b main

cat << 'EOF' > deadlines.md
| Предмет | Задание | Срок |
| :--- | :--- | :--- |
| Математика | Решить задачи по интегралам | 15.11.2026 |
| Физика | Лабораторная работа №3 | 18.11.2026 |
| Информатика | Настроить Git-репозиторий | 20.11.2026 |
EOF

git add deadlines.md
git commit -m "feat: create deadlines.md with 3 tasks"

cat << 'EOF' > CHANGELOG.md
# Changelog

## [0.1.0] - 2026-11-11
### Added
- Таблица дедлайнов в `deadlines.md` (3 задачи).
EOF

git add CHANGELOG.md
git commit -m "docs: add CHANGELOG.md for v0.1.0"
git tag -a v0.1.0 -m "Release v0.1.0"

cat << 'EOF' > deadlines.md
| Предмет | Задание | Срок |
| :--- | :--- | :--- |
| Математика | Решить задачи по интегралам | 16.11.2026 |
| Физика | Лабораторная работа №3 | 18.11.2026 |
| Информатика | Настроить Git-репозиторий | 20.11.2026 |
EOF

git add deadlines.md
git commit -m "fix: update deadline for Math"

FIX_COMMIT_HASH=$(git rev-parse --short HEAD)

cat << 'EOF' > deadlines.md
| Предмет | Задание | Срок |
| :--- | :--- | :--- |
| Математика | Решить задачи по интегралам | 16.11.2026 |
| Физика | Лабораторная работа №3 | 18.11.2026 |
EOF

git add deadlines.md
git commit -m "refactor: remove last row from deadlines"

git checkout HEAD~1 -- deadlines.md
git commit -m "revert: restore last row from previous commit"

cat << 'EOF' > deadlines.md
| Предмет | Задание | Срок | Статус |
| :--- | :--- | :--- | :--- |
| Математика | Решить задачи по интегралам | 16.11.2026 | сдано |
| Физика | Лабораторная работа №3 | 18.11.2026 | не сдано |
| Информатика | Настроить Git-репозиторий | 20.11.2026 | не сдано |
EOF

git add deadlines.md
git commit -m "feat: add Status column to deadlines table"

cat << EOF > CHANGELOG.md
# Changelog

## [0.2.0] - 2026-11-11
### Added
- Добавлен столбец «Статус» (сдано / не сдано) в \`deadlines.md\`.

### Fixed
- Исправлен срок по предмету «Математика» (коммит \`$FIX_COMMIT_HASH\`).
- Восстановлена третья строка таблицы из истории коммитов.
EOF

git add CHANGELOG.md
git commit -m "docs: update CHANGELOG.md for v0.2.0"
git tag -a v0.2.0 -m "Release v0.2.0 (fix commit: $FIX_COMMIT_HASH)"

echo "Готово! Локальный репозиторий создан в папке $REPO_NAME."
echo "Хэш коммита с исправлением срока (через Blame): $FIX_COMMIT_HASH"
