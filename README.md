# auto-switch-rime-zhtw-sim

## Rime 繁簡體輸入法快速切換工具
MacOS zsh 工具，在 Rime 輸入法的輸入方案之間切換。

目前只支援本地的兩種輸入法，可依自己需求重新設計。



## 特點

- 自動部署：自動部署新配置，無需手動點擊
- 無縫整合：自動添加到您的 zsh 環境中


## 需求

- macOS 操作系統(我用 12.6)
- Rime 輸入法（鼠鬚管）
- zsh shell
- [im-select](https://github.com/daipeihust/im-select) 工具 (用於輸入法切換)

## 安裝

1. git clone this repo

2. 運行:

```bash
./src/bash/setup-permissions.sh
```

- 為所有 script 設定執行權限
- 將 `rimet` 函數添加到您的 `~/.zshrc` 文件中
- 顯示如何立即啟用該函數的說明

3. 啟用 `rimet` 命令:

```bash
source ~/.zshrc
```

## 使用方法
切換輸入法:

```bash
rimet
```

每次執行 `rimet` 命令，腳本將:
1. 檢測當前輸入方案並切換到另一個
2. 更新時間戳觸發 Rime 檢測變更
3. 切換到 Rime 輸入法
4. 自動部署新設定

如果自動部署未成功，您可以手動部署。

## 工作原理
此工具通過修改 Rime 的 `default.custom.yaml` 配置文件來切換輸入方案。它會:

1. 使用 `grep` 和 `sed` 命令來搜索和修改配置
2. 使用 `find` 命令更新配置文件的時間戳
3. 使用 `im-select` 工具切換到 Rime 輸入法
4. 使用 AppleScript 嘗試觸發重新部署

## 自定義
如果您使用的不是洋蔥注音，您可以編輯 `src/bash/rime-switch.sh` 文件，將:
- `bopomo_onion` 替換為您的第一輸入方案名稱
- `bopomo_onion_sim` 替換為您的第二輸入方案名稱

## 疑難解答

如果遇到權限錯誤:
```
System Events發生錯誤：不允許「osascript」傳送按鍵。
```

請在系統偏好設定 > 安全性與隱私 > 隱私 > 輔助功能中授予終端機權限。


## 許可證

[MIT](LICENSE)

## 貢獻
歡迎提交任何建議！

