@echo off
rem variable scope
setlocal

rem session �ļ������λ��: �û�Ŀ¼��
set SESSION_FILE=%HOMEDRIVE%%HOMEPATH%\vim-session.vim
rem vim ��������λ��
set VIM_PROGRAM=%PROGRAMFILES%/Vim/vim73/gvim.exe


if "%1" == "" ( rem �޲��� -> �� session ����
    if exist "%SESSION_FILE%" (
        START "" "%VIM_PROGRAM%" -S "%SESSION_FILE%"
    ) else START "" "%VIM_PROGRAM%"
) else ( rem �в���
    set noSessionFile=true
    set args=

    rem �������
    :LoopStart
        if "%1"=="" (
            goto LoopEnd
        ) else (
            if "%1" == "-s" (
                set noSessionFile=false
            ) else (
                set args=%args% %1
            )
            shift
            goto LoopStart
        )

    :LoopEnd
    if "%noSessionFile%"=="true" (
        rem "�� -ns -> ���� session ����"
        START "" "%VIM_PROGRAM%" %args%
    ) else (
        rem "�� -s -> �� session ����"
        START "" "%VIM_PROGRAM%" %args% -S "%SESSION_FILE%"
    )
)
endlocal

exit


rem ʹ��˵��:
rem = vim ���Ӳ���ʹ���ϴ� session ����
rem = vim �Ӳ���
rem     = �������� -s, ���ϲ������ϴ� session ����
rem     = �������� -s, ���� session ����
rem
rem
rem vim -n (����vim, �������ļ�)
