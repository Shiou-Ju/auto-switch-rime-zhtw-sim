#!/bin/zsh

CONFIG_FILE="$HOME/Library/Rime/default.custom.yaml"

# 檢查目前狀態
if grep -q "^    - schema: bopomo_onion$" "$CONFIG_FILE"; then
    # 目前是繁體，切換到簡體
    sed -i '' 's/^    - schema: bopomo_onion$/    # - schema: bopomo_onion/' "$CONFIG_FILE"
    sed -i '' 's/^    # - schema: bopomo_onion_sim$/    - schema: bopomo_onion_sim/' "$CONFIG_FILE"
    echo "已切換到簡體輸入"
else
    # 目前是簡體，切換到繁體
    sed -i '' 's/^    # - schema: bopomo_onion$/    - schema: bopomo_onion/' "$CONFIG_FILE"
    sed -i '' 's/^    - schema: bopomo_onion_sim$/    # - schema: bopomo_onion_sim/' "$CONFIG_FILE"
    echo "已切換到繁體輸入"
fi

# 更新時間戳觸發 Rime 檢測變更
find "$HOME/Library/Rime" -type f -name "*.yaml" -exec touch {} \;


# 保存當前輸入法，確保執行完後可以切換回來
CURRENT_IM=$(im-select)
echo "當前輸入法: $CURRENT_IM"

# 切換到 Rime 輸入法
echo "切換到 Rime 輸入法..."
im-select im.rime.inputmethod.Squirrel.Rime

# 嘗試模擬按下 Control+Option+反引號 快捷鍵以觸發重新部署
echo "嘗試重新部署..."
# 使用單引號括起來的字符串，避免反引號被解釋
# osascript -e 'tell application "System Events" to key code 50 using {control down, option down}'

# 嘗試模擬按下 Control+Option+反引號 快捷鍵以觸發重新部署
# shell 腳本中內聯 AppleScript 代碼。可能有 zsh 對反引號的處理問題。
# 將 AppleScript 代碼保存到臨時文件以避免反引號問題
cat > /tmp/rime_deploy.scpt << 'EOF'
try
  tell application "System Events"
    key code 50 using {control down, option down}
  end tell
  "成功 AppleScript deploy script"
on error errMsg
  errMsg
end try
EOF

# 執行 AppleScript 文件而不是內聯代碼
osascript /tmp/rime_deploy.scpt 2>/dev/null
rm /tmp/rime_deploy.scpt  # 清理臨時文件

# 給 Rime 一些時間處理部署
sleep 3

# 有可能出現可能部署需要較久，且或许不需要切換回去
# 切換回原來的輸入法
# echo "切換回原來的輸入法..."
# im-select "$CURRENT_IM"

echo "設定已更新並已嘗試自動部署！如果切換仍未生效，請手動點擊輸入法圖標並選擇「重新部署」"

