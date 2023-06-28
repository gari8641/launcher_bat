@echo off
setlocal enabledelayedexpansion


echo n:新規作成
echo e:編集
echo d:削除
echo o:フォルダを開く

set /p ACTION=choise:
if "%ACTION%"=="" goto EDIT
if "%ACTION%"=="n" goto NEW
if "%ACTION%"=="e" goto EDIT
if "%ACTION%"=="d" goto DELETE
if "%ACTION%"=="o" goto OPEN


:NEW


set DATE_PREFIX=%date:~2,2%-%date:~5,2%-%date:~8,2%

set /p FILE_NAME=file_name:

start /b "" gvim %DATE_PREFIX%_%FILE_NAME%.txt

exit

:EDIT
set count=0
for %%f in (*.txt) do (
set /a count+=1
set file[!count!]=%%f
echo !count!. %%f
)
set /p choice=番号を入力してください:
start /b "" gvim "!file[%choice%]!"
endlocal

exit

:DELETE

setlocal enabledelayedexpansion

REM カレントディレクトリにある拡張子がtxtのファイル一覧を表示する
set /a count=1
for %%F in (*.txt) do (
    echo !count!. %%F
    set /a count+=1
)

REM 番号を選択してファイルを選択し、ゴミ箱に移動する
set /p choice=移動するファイルの番号を入力してください: 
set /a fileCount=1
for %%F in (*.txt) do (
    if !fileCount! equ %choice% (
        echo ファイル "%%F" をDownloadsに移動します...
        move "%%F" C:\Users\bpc_m\Downloads\
        echo ファイルの移動が完了しました。
        exit /b
    )
    set /a fileCount+=1
)

echo 無効な番号が入力されました。プログラムを終了します。


exit

:OPEN

start /b C:\portable_soft\launcher

exit
