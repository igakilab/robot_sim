### 概要
- noeticvncコンテナ一つで，ros-noetic, novncを導入している
- このコンテナはDocker Desktopなどでローカルに展開されることを前提としています．グローバルな仮想サーバなどでの動作は前提としていません（セキュリティ的にも）

### 実行方法
```sh
$ cd noeticvnc
$ docker-compose up -d
```

### 終了方法
```sh
$ cd noeticvnc
$ docker-compose down
```

### アクセス方法
- `docker-compose up -d` をホストで実行した後，http://localhost:8000 にブラウザでアクセスする
  - ubuntuのデスクトップにアクセスできるので，そのままLXTerminalを起動して必要な処理を呼び出す
  - `docker-compose up` だけでもいいかも（バックグラウンド動作にならない）
- localhost:5900 を対象に通常のVNCクライアントでもアクセスできる
  - RealVNCで動作検証済み．コピペ等も問題なくできるっぽい
  - https://www.realvnc.com/en/connect/download/viewer/
- `docker exec -it noeticvnc bash` でubuntuユーザでbashでログインできる
- `docker-compose up` 実行後，vscodeのRemote Containersプラグインを利用して/home/ubuntu にアクセス可能．

### ToDo
- sigverseとの連携がうまくいくか未確認
- novncのデフォルト設定をLocalScalingにしたい

### Done
- DesktopにLXTerminalのショートカット貼り付け
- vscodeとの連携
  - Windows側にvscodeをインストールして，Remote Developmentで接続して実装する方法を試す
  - vscodeからymlを指定してコンテナにアクセスする方法だと，コンテナ内のファイルへのアクセスに失敗した．`docker-compose up` でコンテナを起動してからそれを選択する方法だといけた
    - こちらでいけることは確認できた．vscodeのターミナルがrootにログインしてしまうのもubuntuをデフォルトにすることで対応済み
- ~localhost:2000でsshdがListenしているので，sshクライアントでubuntu:ubuntuにアクセスできる．~
  - Remote Containersではssh不要なのでsshdもインストールしないことにした
- `docker exec -it --user ubuntu noeticvnc bash` でubuntuユーザでbashでログインできる
  - デフォルトをubuntuユーザになるように変更したので，--userは不要になった
- ~eclipse Theiaの導入~(重くなりすぎるのでひとまず導入しない方向で）
  -   - https://qiita.com/yosuke@github/items/328dbd778047499828f2#%E3%81%AF%E3%81%98%E3%82%81%E3%81%AB
- コピペがnovncのClip BoardUIを介さないとだめっぽいのが何とかならないか．．->コピペ等したい場合はVNCクライアントで5900にアクセスすればいける
- 起動後にnovncの設定で Scaling Modeを `Local Scaling` に変更するとブラウザサイズに合わせて画面サイズが変更される
  - ubuntuの解像度はdocker-compose.ymlで変更可能
- ~/catkin_ws を永続化し，初期化するように修正してみた
  - ボリュームの中身を一度全部消したい場合は `docker-compose down --rmi local --volumes --remove-orphans` このあたりでvolume削除すればOK
- `install_sigverse.sh` の `catkin_make`コマンドだけDockerfile内で実行できなかった（Not foundになる）ので，ログイン後手動で実行する必要あり．
  - ↓を追加したらいけたヽ(^o^)丿
```sh
TARGET_ROS="noetic"
echo "**Making workspace. Target ros-${TARGET_ROS}**"
ROS_SETUP="/opt/ros/${TARGET_ROS}/setup.bash"
source ${ROS_SETUP}
```


This software includes the work that is distributed in the Apache License 2.0.

このソフトウェアは、 Apache 2.0ライセンスで配布されている製作物が含まれています。
