@echo off
setlocal enabledelayedexpansion


echo n:�V�K�쐬
echo e:�ҏW
echo d:�폜
echo o:�t�H���_���J��

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
