■事前準備
Quake 3 Areneの、baseq3ディレクトリを、本ファイルのあるフォルダにコピーする。(どこでもよいのだが、決めないと後の説明がしにくい。)

■Visual Studioで開く

ソリューションファイル:
code/quake3.sln

スタートアッププロジェクト:
quake3

quake3プロジェクト->プロパティ->構成プロパティ->デバッグ->作業ディレクトリ:	プログラム実行開始時のカレントディレクトリ
$(SolutionDir)..\..	(baseq3ディレクトリのあるディレクトリ)

quake3プロジェクト->プロパティ->構成プロパティ->デバッグ->コマンド引数:
+set sv_pure 0 +set vm_game 0 +set vm_cgame 0 +set vm_ui 0
