@echo off
setlocal enabledelayedexpansion

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
set /p "choice=ファイルの番号を入力してください (空エンターで終了): "

if "%choice%"=="" (
    echo 空エンターが入力されたため、バッチファイルを終了します。
    exit /b
)

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

:ProcessFile
echo 選択されたファイル: %selectedFileName%
echo ファイルの内容:
echo -----------------------------

set "lineNumber=1"

for /f "usebackq delims=" %%L in ("%folder%\%selectedFileName%") do (
    echo !lineNumber!. %%L
    set "line[!lineNumber!]=%%L"
    set /a "lineNumber+=1"
)

echo -----------------------------
set /p "lineChoice=表示された行の番号を入力してください (a: 全ての行を実行, 空エンターで終了): "

if "%lineChoice%"=="" (
    echo 空エンターが入力されたため、バッチファイルを終了します。
    exit /b
)

if "%lineChoice%"=="a" (
    echo 全ての行の内容を実行します:
    
    for /l %%N in (1, 1, %lineNumber%) do (
        set "lineContent=!line[%%N]!"
        echo 実行中: !lineContent!
        call !lineContent!
    )

    echo 全ての行の実行が完了しました。
    goto :EOF
)

set /a "selectedLine=lineChoice"

if !selectedLine! gtr !lineNumber! (
    echo 無効な番号が入力されました。
    goto :EOF
)

set "selectedLineContent=!line[%selectedLine%]!"
echo 選択された行の内容: !selectedLineContent!

echo 実行中: !selectedLineContent!
call !selectedLineContent!

goto :EOF

