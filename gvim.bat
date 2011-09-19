@echo off
rem variable scope
setlocal

rem session 文件保存的位置: 用户目录下
set SESSION_FILE=%HOMEDRIVE%%HOMEPATH%\vim-session.vim
rem vim 程序所在位置
set VIM_PROGRAM=%PROGRAMFILES%/Vim/vim73/gvim.exe


if "%1" == "" ( rem 无参数 -> 带 session 启动
    if exist "%SESSION_FILE%" (
        START "" "%VIM_PROGRAM%" -S "%SESSION_FILE%"
    ) else START "" "%VIM_PROGRAM%"
) else ( rem 有参数
    set noSessionFile=true
    set args=

    rem 处理参数
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
        rem "无 -ns -> 不带 session 启动"
        START "" "%VIM_PROGRAM%" %args%
    ) else (
        rem "有 -s -> 带 session 启动"
        START "" "%VIM_PROGRAM%" %args% -S "%SESSION_FILE%"
    )
)
endlocal

exit


rem 使用说明:
rem = vim 不加参数使用上次 session 启动
rem = vim 加参数
rem     = 参数中有 -s, 带上参数以上次 session 启动
rem     = 参数中无 -s, 不加 session 启动
rem
rem
rem vim -n (启动vim, 创建新文件)
