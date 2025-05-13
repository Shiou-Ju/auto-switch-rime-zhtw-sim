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

# 嘗試模擬按下 Ctrl+Option+` 快捷鍵以觸發重新部署
echo "嘗試重新部署..."
osascript -e 'tell application "System Events" to key code 50 using {control down, option down}'

echo "設定已更新！如果切換不生效，請手動重新部署"

