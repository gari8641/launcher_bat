@echo off
setlocal enabledelayedexpansion

set "folder=%CD%"
set "counter=1"

echo �t�@�C���ꗗ:
echo -----------------------------

for %%F in ("%folder%\*.txt") do (
    set "filename=%%~nxF"
    echo !counter!. !filename!
    set /a "counter+=1"
)

echo -----------------------------
set /p "choice=�t�@�C���̔ԍ�����͂��Ă������� (��G���^�[�ŏI��): "

if "%choice%"=="" (
    echo ��G���^�[�����͂��ꂽ���߁A�o�b�`�t�@�C�����I�����܂��B
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

echo �����Ȕԍ������͂���܂����B
goto :EOF

:ProcessFile
echo �I�����ꂽ�t�@�C��: %selectedFileName%
echo �t�@�C���̓��e:
echo -----------------------------

set "lineNumber=1"

for /f "usebackq delims=" %%L in ("%folder%\%selectedFileName%") do (
    echo !lineNumber!. %%L
    set "line[!lineNumber!]=%%L"
    set /a "lineNumber+=1"
)

echo -----------------------------
set /p "lineChoice=�\�����ꂽ�s�̔ԍ�����͂��Ă������� (a: �S�Ă̍s�����s, ��G���^�[�ŏI��): "

if "%lineChoice%"=="" (
    echo ��G���^�[�����͂��ꂽ���߁A�o�b�`�t�@�C�����I�����܂��B
    exit /b
)

if "%lineChoice%"=="a" (
    echo �S�Ă̍s�̓��e�����s���܂�:
    
    for /l %%N in (1, 1, %lineNumber%) do (
        set "lineContent=!line[%%N]!"
        echo ���s��: !lineContent!
        call !lineContent!
    )

    echo �S�Ă̍s�̎��s���������܂����B
    goto :EOF
)

set /a "selectedLine=lineChoice"

if !selectedLine! gtr !lineNumber! (
    echo �����Ȕԍ������͂���܂����B
    goto :EOF
)

set "selectedLineContent=!line[%selectedLine%]!"
echo �I�����ꂽ�s�̓��e: !selectedLineContent!

echo ���s��: !selectedLineContent!
call !selectedLineContent!

goto :EOF

