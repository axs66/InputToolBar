# MyInputToolBar

Demo Theos tweak that injects a toolbar above WeChat input box.

## 编译与安装
1. 把本项目拷贝到你的 Theos 工作目录（例如 `~/projects/MyInputToolBar`）。
2. 编辑 `control` 中的 maintainer / description 等信息。
3. 在本地机器上使用 `make package` 构建，或直接 `make`。
4. 将 `.deb` 上传到越狱设备并 `dpkg -i`，或在 Theos 中配置 DEVICE_IP 并 `make package install`。
   - 若使用 rootless scheme（默认），可能需要用 `make package install` 并配合 rootless 工具。
5. 重启微信或 respring（通常重启微信）。

## 调试
- 使用 `cycript` / `frida` 或者 `po`/`lldb` 查看运行时层级。
- 若工具栏未出现，尝试把 `Tweak.xm` 中的候选类名数组扩展为你微信版本中的真实类名（可通过查看 view hierarchy 确认）。

## 扩展建议
- 将工具栏独立成资源 bundle（便于替换图片）。
- 增加素材 `UICollectionView`，支持 GIF/PNG/MP4 缩略图并点击发送。
- 使用微信内部发送接口可实现“直接发送”，但会依赖内部类签名（需要逆向）。
