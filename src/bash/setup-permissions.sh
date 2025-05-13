#!/bin/zsh

# 簡單的權限設定腳本
# 功能：給予所有腳本執行權限

# 在 zsh 中獲取當前腳本的絕對路徑
SCRIPT_PATH="$0"
if [[ $SCRIPT_PATH != /* ]]; then
  SCRIPT_PATH="$PWD/$SCRIPT_PATH"
fi
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

echo "設定執行權限..."
echo "腳本目錄: $SCRIPT_DIR"
echo "專案根目錄: $PROJECT_ROOT"

# 為所有 .sh 文件設定執行權限
find "$PROJECT_ROOT" -name "*.sh" -exec chmod +x {} \;

echo "✓ 已設定所有腳本的執行權限"
echo "您現在可以直接執行 src/bash/rime-switch.sh 來切換 Rime 輸入法的繁簡體設定"


