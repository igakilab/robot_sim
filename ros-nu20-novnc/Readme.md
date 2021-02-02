- ros:melodicからsigverseまでセットアップしたDockerfileを利用している
- ros-nu20コンテナ
  - roscoreを実行するコンテナ
- rvizコンテナ
  - rvizを実行するコンテナ．中身はros-nu20と同じ
- guiコンテナ
  - rvizを実行した画面をnovncに流して表示するコンテナ

### 実行方法
```sh
$ cd ros-nu20-novnc
$ docker-compose up -d
```

### 終了方法
```sh
$ cd ros-nu20-novnc
$ docker-compose down
```

### アクセス方法
- `docker-compose up -d` をホストで実行した後，http://localhost:8080/vnc.html?resize=scale&autoconnect=true にブラウザでアクセスする
- rvizコンテナ（rvizコマンド実行するだけ）で実行されているrvizの画面が表示される

### ToDo
- `install_sigverse.sh` の `catkin_make`コマンドだけDockerfile内で実行できなかった（Not foundになる）ので，ログイン後手動で実行する必要あり．
  - ↓を追加したらいけたヽ(^o^)丿
```sh
TARGET_ROS="noetic"
echo "**Making workspace. Target ros-${TARGET_ROS}**"
ROS_SETUP="/opt/ros/${TARGET_ROS}/setup.bash"
source ${ROS_SETUP}
```
- ノードを追加したかったらどうすればよいか
  - ros-nu20に下記のコマンドでアクセスしてノードを実装してコマンド実行したらrvizの画面に反映されるかどうか
  - `docker exec -it ros-nu20 bash`
- roscoreを再起動したい場合は docker-compose down かrestartするしかない？
- workディレクトリにスクリプト置いておいて，それを参照して自動的にノードのコマンドを実行するみたいな運用にできないかどうか
- SIGVerseと連携できるかどうか
  - いまいちやり方が分かってない
- vscodeとの連携
  - Windows側にvscodeをインストールして，Remote Developmentで接続して実装する方法を試してみたい．他にはjupyterやブラウザベースのvscode風のツールを導入して実装できるようにしている既存事例もあり．
  - https://qiita.com/yosuke@github/items/328dbd778047499828f2#%E3%81%AF%E3%81%98%E3%82%81%E3%81%AB
  - eclipse theiaのほうが筋がよさそう（ブラウザでvscode風のIDEで開発できる）

### 参考文献
- https://github.com/gramaziokohler/ros_docker/blob/master/README.md
  - 基本ここのを流用．
  - これが理解できたら開発環境もなんとかなるかも．
    - https://github.com/gramaziokohler/ros_docker/blob/master/examples/moveit-dev/docker-compose.yml