echo off
SET filterfile=%~1
SET where=%~2
SET copydir=%~3
SET ThisScriptsDirectory=%~dp0
IF EXIST %ThisScriptsDirectory%search_out.txt DEL /F %ThisScriptsDirectory%search_out.txt

for /F "tokens=1" %%i in (%filterfile%) do call :process_search %%i
goto thenextstep
:process_search
if "%1" NEQ "" (
    if "%1" NEQ "%filterfile%" (
        echo "%1"
        dir /b /a-D /s "%where%\*%1*" >>%ThisScriptsDirectory%search_out.txt
    )
)
goto :EOF
:thenextstep
for /F "tokens=1" %%i in (%ThisScriptsDirectory%search_out.txt) do call :process_copy %%i
goto end
:process_copy
if "%1" NEQ "" (
    if "%1" NEQ "%filterfile%" (
        xcopy /Q /y "%1" %copydir%
    )
)
goto :EOF
:end
goto :EOF
