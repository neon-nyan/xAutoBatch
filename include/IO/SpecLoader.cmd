:: Hak Cipta ©2018
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:__jumper
    if "%jump%" == "" (
        msg * Sertakan label terlebih dahulu!
        msg * Dan gunakan Classes ini dengan program Encodernya.
        msg * ^(/^^_^^^)/ Makasih! \^(^^_^^\^) ^<-----------^> Oleh: codeneon
        exit
    ) else (
        goto %jump%
    )

:CPUThreadsCount
    for /f "tokens=1,2,3 delims= " %%a in ('%SpecInfoPath% --raw ^| find "CL_DEVICE_MAX_COMPUTE_UNITS"') do (
        echo %%c>"%pcspecdata%"
    )
    set /p threads=<"%pcspecdata%"

    goto :__end

:RAMSpaceCount
    for /f "tokens=4 delims=: " %%a in ('systeminfo ^| find "Available Physical Memory"') do (
        setlocal enabledelayedexpansion
        echo %%a | find "," > nul
        if "!errorlevel!" == "1" (
            for /f "tokens=1,2 delims=." %%a in ('echo %%a') do (
                echo %%a%%b>"%pcspecdata%"
            )
        ) else (
            for /f "tokens=1,2 delims=," %%a in ('echo %%a') do (
                echo %%a%%b>"%pcspecdata%"
            )
        )
        endlocal
    )
    set /p output=<"%pcspecdata%"
    
    goto :__end

:__end
    del "%pcspecdata%"