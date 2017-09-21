:: Hak Cipta ©2017
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:GETSystemTime
    setlocal enabledelayedexpansion

    for /f "tokens=1,2,3 delims=:" %%a in ('echo %time%') do (
        echo %%a>"%temp%\hour.data"
        echo %%b>"%temp%\min.data"
        for /f "tokens=1,2 delims= " %%a in ('echo %%c') do (
            echo %%a>"%temp%\sec.data"
            echo %%b>"%temp%\micsec.data"
        )
    )

    endlocal

    set /p thour=<"%temp%\hour.data"
    set /p tmin=<"%temp%\min.data"
    set /p tsec=<"%temp%\sec.data"
    set /p tmicsec=<"%temp%\micsec.data"

    echo y | del "%temp%\hour.data"
    echo y | del "%temp%\min.data"
    echo y | del "%temp%\sec.data"
    echo y | del "%temp%\micsec.data"

:GETSysemDate
    setlocal enabledelayedexpansion

    :CheckTime
    echo %date% | find "/" > nul
    if not "!errorlevel!" == "1" (
        for /f "tokens=1,2,3 delims=/" %%a in ('echo %date%') do (
            echo %%a>"%temp%\tdate1.data"
            echo %%b>"%temp%\tdate2.data"
            echo %%c>"%temp%\tdate3.data"
        )
    )

    endlocal

    set /p tdate1=<"%temp%\tdate1.data"
    set /p tdate2=<"%temp%\tdate2.data"
    set /p tdate3=<"%temp%\tdate3.data"

    echo y | del "%temp%\tdate1.data"
    echo y | del "%temp%\tdate2.data"
    echo y | del "%temp%\tdate3.data"