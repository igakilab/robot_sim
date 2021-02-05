### 概要
- noeticvncコンテナ一つで，ros-noetic, novncを導入している

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
- `docker-compose up -d` をホストで実行した後，http://localhost:8080 にブラウザでアクセスする
- ubuntuのデスクトップにアクセスできるので，そのままLXTerminalを起動して必要な処理を呼び出す

### ToDo
- sigverseとの連携がうまくいくか未確認
- novncのデフォルト設定をLocalScalingにしたい
- コピペがnovncのClip BoardUIを介さないとだめっぽいのが何とかならないか．．
- eclipse Theiaの導入
- vscodeとの連携
  - Windows側にvscodeをインストールして，Remote Developmentで接続して実装する方法を試してみたい．他にはjupyterやブラウザベースのvscode風のツールを導入して実装できるようにしている既存事例もあり．
  - https://qiita.com/yosuke@github/items/328dbd778047499828f2#%E3%81%AF%E3%81%98%E3%82%81%E3%81%AB

### Done
- 以下のコマンドをstartup.shから排除（時間がかかるため）．起動後に手動で実行する．
```sh
cd /home/ubuntu/setup_robot_programming/sigverse_ros_package && git pull origin master && rsync -av  /home/ubuntu/setup_robot_programming/sigverse_ros_package/ /home/ubuntu/catkin_ws/src/sigverse_ros_package/ && cd /home/ubuntu/catkin_ws/ && catkin_make
```
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
