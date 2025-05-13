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
RIME_SWITCH_PATH="$SCRIPT_DIR/rime-switch.sh"

echo "設定執行權限..."
echo "腳本目錄: $SCRIPT_DIR"
echo "專案根目錄: $PROJECT_ROOT"

# 為所有 .sh 文件設定執行權限
find "$PROJECT_ROOT" -name "*.sh" -exec chmod +x {} \;

echo "✓ 已設定所有腳本的執行權限"
echo "您現在可以直接執行 src/bash/rime-switch.sh 來切換 Rime 輸入法的繁簡體設定"
echo ""


# 自動添加到 zshrc
ZSHRC_PATH="$HOME/.zshrc"
FUNCTION_NAME="rimet"

echo "正在將 $FUNCTION_NAME 函數添加到 $ZSHRC_PATH..."

# 檢查函數是否已存在
if grep -q "function $FUNCTION_NAME" "$ZSHRC_PATH"; then
  echo "⚠️ $FUNCTION_NAME 函數已存在於 $ZSHRC_PATH"
  echo "現有函數將不會被修改"
else
  # 添加自定義函數到 zshrc
  cat << EOF >> "$ZSHRC_PATH"

# Rime 輸入法繁簡體切換函數 (由 auto-switch-rime-zhtw-sim 添加)
function $FUNCTION_NAME() {
  "$RIME_SWITCH_PATH"
}
EOF

  echo "✅ 已成功添加 $FUNCTION_NAME 函數到 $ZSHRC_PATH"
  echo "請執行以下命令以立即啟用 rimet 命令："
  echo ""
  echo "    source ~/.zshrc"
  echo ""
fi

echo "設定完成！您現在可以使用以下方式切換 Rime 輸入法的繁簡體設定："
echo "1. 直接執行: $RIME_SWITCH_PATH"
echo "2. 使用函數: rimet (需要先 source ~/.zshrc 或重新開啟終端)"

