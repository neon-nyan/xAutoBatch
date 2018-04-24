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

:CleanLastTempFile
    if exist "%scripttempname%" (
        del "%scripttempname%"
    )

    if /i exist "input\*.avs" (
        del "input\*.avs"
    )

    if /i exist "%temp%\*.data" (
        del "%temp%\*.data"
    )

    goto :__end

:CleanLastQueryCache
    if /i exist "%scripttempname%" del "%scripttempname%"
    if /i exist "%zoneaddfile%" del "%zoneaddfile%"
    if /i exist "%trimaddfile%" del "%trimaddfile%"
    if /i exist "%tabledata%" del "%tabledata%"
    if /i exist "%trimdata%" del "%trimdata%"

    goto :__end
    

:__end