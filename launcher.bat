@echo off
setlocal enabledelayedexpansion
call variable.bat

set "folder=%CD%"
set "counter=1"

echo ファイル一覧:
echo -----------------------------

for %%F in ("%folder%\*.txt") do (
    set "filename=%%~nxF"
    echo !counter!. !filename!
    set /a "counter+=1"
)

echo -----------------------------

echo n:新規作成
echo e:編集
echo d:削除
echo o:フォルダを開く




set /p "choice=ファイルの番号かコマンドを入力してください (空エンターで終了): "

if "%choice%"=="" (
    echo 空エンターが入力されたため、バッチファイルを終了します。
    exit /b
)

if "%choice%"=="" goto EDIT
if "%choice%"=="n" goto NEW
if "%choice%"=="e" goto EDIT
if "%choice%"=="d" goto DELETE
if "%choice%"=="o" goto OPEN

set /a "selectedFile=choice-1"
set "fileNumber=0"

for %%F in ("%folder%\*.txt") do (
    if !fileNumber! equ %selectedFile% (
        set "selectedFileName=%%~nxF"
        goto :ProcessFile
    )
    set /a "fileNumber+=1"
)

echo 無効な番号が入力されました。
goto :EOF




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




:ProcessFile
::echo 選択されたファイル: %selectedFileName%
::echo ファイルの内容:
::echo -----------------------------
::
set "lineNumber=1"
::
for /f "usebackq delims=" %%L in ("%folder%\%selectedFileName%") do (
    echo !lineNumber!. %%L
    set "line[!lineNumber!]=%%L"
    set /a "lineNumber+=1"
)

::echo -----------------------------
::set /p "lineChoice=表示された行の番号を入力してください (a: 全ての行を実行, 空エンターで終了): "

::if "%lineChoice%"=="" (
::    echo 空エンターが入力されたため、バッチファイルを終了します。
::    exit /b
::)

::if "%lineChoice%"=="a" (
    echo 全ての行の内容を実行します:

    set /a lineNumber=%lineNumber%-1

    
    for /l %%N in (1, 1, %lineNumber%) do (
        set "lineContent=start /b "" !line[%%N]!"
        echo 実行中: !lineContent!
        call !lineContent!
    )

    echo 全ての行の実行が完了しました。
    goto :EOF
::)

::set /a "selectedLine=lineChoice"

::if !selectedLine! gtr !lineNumber! (
::    echo 無効な番号が入力されました。
::    goto :EOF
::)
::
::set "selectedLineContent=start /b !line[%selectedLine%]!"
::echo 選択された行の内容: !selectedLineContent!
::
::echo 実行中: !selectedLineContent!
::call !selectedLineContent!

goto :EOF

:EOF

exit /0
