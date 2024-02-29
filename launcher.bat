@echo off
setlocal enabledelayedexpansion
call variable.bat

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

echo n:�V�K�쐬
echo e:�ҏW
echo d:�폜
echo o:�t�H���_���J��




set /p "choice=�t�@�C���̔ԍ����R�}���h����͂��Ă������� (��G���^�[�ŏI��): "

if "%choice%"=="" (
    echo ��G���^�[�����͂��ꂽ���߁A�o�b�`�t�@�C�����I�����܂��B
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

echo �����Ȕԍ������͂���܂����B
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
set /p choice=�ԍ�����͂��Ă�������:
start /b "" gvim "!file[%choice%]!"
endlocal

exit

:DELETE

setlocal enabledelayedexpansion

REM �J�����g�f�B���N�g���ɂ���g���q��txt�̃t�@�C���ꗗ��\������
set /a count=1
for %%F in (*.txt) do (
    echo !count!. %%F
    set /a count+=1
)

REM �ԍ���I�����ăt�@�C����I�����A�S�~���Ɉړ�����
set /p choice=�ړ�����t�@�C���̔ԍ�����͂��Ă�������: 
set /a fileCount=1
for %%F in (*.txt) do (
    if !fileCount! equ %choice% (
        echo �t�@�C�� "%%F" ��Downloads�Ɉړ����܂�...
        move "%%F" C:\Users\bpc_m\Downloads\
        echo �t�@�C���̈ړ����������܂����B
        exit /b
    )
    set /a fileCount+=1
)

echo �����Ȕԍ������͂���܂����B�v���O�������I�����܂��B


exit

:OPEN

start /b C:\portable_soft\launcher

exit




:ProcessFile
::echo �I�����ꂽ�t�@�C��: %selectedFileName%
::echo �t�@�C���̓��e:
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
::set /p "lineChoice=�\�����ꂽ�s�̔ԍ�����͂��Ă������� (a: �S�Ă̍s�����s, ��G���^�[�ŏI��): "

::if "%lineChoice%"=="" (
::    echo ��G���^�[�����͂��ꂽ���߁A�o�b�`�t�@�C�����I�����܂��B
::    exit /b
::)

::if "%lineChoice%"=="a" (
    echo �S�Ă̍s�̓��e�����s���܂�:

    set /a lineNumber=%lineNumber%-1

    
    for /l %%N in (1, 1, %lineNumber%) do (
        set "lineContent=start /b "" !line[%%N]!"
        echo ���s��: !lineContent!
        call !lineContent!
    )

    echo �S�Ă̍s�̎��s���������܂����B
    goto :EOF
::)

::set /a "selectedLine=lineChoice"

::if !selectedLine! gtr !lineNumber! (
::    echo �����Ȕԍ������͂���܂����B
::    goto :EOF
::)
::
::set "selectedLineContent=start /b !line[%selectedLine%]!"
::echo �I�����ꂽ�s�̓��e: !selectedLineContent!
::
::echo ���s��: !selectedLineContent!
::call !selectedLineContent!

goto :EOF

:EOF

exit /0
