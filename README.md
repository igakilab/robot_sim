# robot_sim
iPBL用の様々なスクリプト類を書きなぐっていくリポジトリ
- noetic-baseをベース都市，必要なライブラリは導入しておく
- init_workspaceしておく
- install_sigverseしておく
- IDEはWeb（Theia）を導入しておく（ただし，WindowsネイティブvscodeでのRemote Developmentでの開発にも対応する？）
  - VSCodeプラグインは
https://github.com/KMiyawaki/setup_robot_programming/blob/master/install_vscode_extensions_from_file.sh
- noVNCを一応導入する．クリップボード共有と画面リサイズへの対応が必須．これらが難しい場合は通常のVNCで対応する？
  - Docker内でVNCが必要な処理について確認が必要．今のところrViz
- 永続化対応が必要．ホームを永続化するか(ちょっと面倒．ホーム作成後一度別のところに退避して，ホームをマウントしてから書き戻す等の処理が必要なので．．) /workspaceのような特定のディレクトリをマウントするか（楽です）検討が必要．
- （オプション）国ごとにタイムゾーン指定。->タイムゾーンはホームを丸ごと永続化して，ホームの.bashrcなどの設定のみで対応できるなら．．無理なら国ごとにコンテナが必要
  - この方法でいけそう↓
  - https://qiita.com/rururu_kenken/items/972314402d588e073d40
- （オプション）日本人は日本語化できるようにする。コンテナへ開始後インストールスクリプト実行でも可。->開始後の実行だと再起動時に消えるので，基本的には日本語化は対応しないほうが望ましいかも．
- （オプション）受講用のROSパッケージをあらかじめ作成しておく。テンプレートをgitからクローン。そこには各種シミュレータのROS側ブリッジを起動させるlaunchを仕込むと楽->一度は後からcatkin_create_pkgさせても良いかもしれないが，そこを学習させる価値があるかどうか要検討（学生が独力で今後できるようにするために等の理由があるのであればやったほうがいいかも）
コンテナの修正が入った時は(a)Docker hubでtagを更新して公開し，学生に配布(コンテナを停止->docker-compose.ymlを修正してもらう or git pull，その後docker-compose up -d実行）あるいは(b)Dockerfileを再配布（git pull)してdocker-compose buildしてもらうかのどちらかで対応する．
