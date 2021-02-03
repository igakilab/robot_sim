
- ↓のdocker-compose.ymlならいけるが，現状のDockerfileをbuildしたものだとコンテナは起動するがRestartingのままで完全に起動するところまで到達しない
- また，novncのオプション resize=scale が機能していない気がする
```yml
version: '3'
services:
  ros-desktop:
    image: tiryoh/ros-desktop-vnc:melodic
    ports:
      - "8080:80"
    environment:
      - shm-size="512m"
```
