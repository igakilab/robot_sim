# ROS-VNCコンテナ
- ROSとvncをセットで使えるようにするコンテナ
- Docker Desktop(Windows) on WSL2で動作確認
- 詳細は下記それぞれのフォルダ配下のReadme参照

## noeticvnc
- ROS1-noeticとVNC
- ROS自体は正常に動作しているが，Windowsホストで動作するアプリケーション（SIGVerseとか）とコンテナ内のROSとの通信がうまくいかない

## melodicvnc
- ROS1-melodicとVNC
- ROS及びWindowsホスト-コンテナ内ROS間通信がうまくいくことを確認できた

## 共通の準備
- WSL2を使えるようにする
  - 参照：https://dev.classmethod.jp/articles/linux-beginner-wsl2-windowsterminal-setup/
  - ubuntuなどのLinuxOSをインストールする必要はありませんが，Windows Terminalのインストールはおすすめします
- Docker Desktop for Windowsをインストールする
  - 参照：https://dev.classmethod.jp/articles/docker-desktop-for-windows-on-wsl2/
  - WSL2で動いていることを確認すること
  - Windows起動時に自動起動する設定はどちらでも構いません．普段使わないなら自動起動しないようにするとリソースの節約になります
- (Option)Windows環境にVisual Studio Codeをインストールする
  - 一応Linuxコンテナ内にvscode入れる予定ですが，コンテナ外から使えるほうが色々と楽です．
  - 公式からインストールしても良いですが，複数のvscodeをインストールする場合はPortable Appをおすすめ
  - https://portapps.io/app/vscode-portable/
  - vscode起動後，Remote Containers プラグインを導入しておく
- Unity Hub及びUnityのインストール
  - コンテナが正常に動作するか確認してからでOKです
  - SIGVerseプロジェクトの導入
  - 参照：http://www.sigverse.org/wiki/jp/?Tutorial%20for%20ver.3

### 実行方法
- リポジトリをcloneしたあと，melodicvncあるいはnoeticvncにcdし，docker-compose upを実行してください
```sh
$ cd melodicvnc
$ docker-compose up -d
```
- 動作内容を確認したいのであれば `-d` は不要です（foregroundでコンテナが開始します）

### 終了方法
```sh
$ cd melodicvnc
$ docker-compose down
```
