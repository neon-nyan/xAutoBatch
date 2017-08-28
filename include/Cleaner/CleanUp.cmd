:: Hak Cipta ©2017
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

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

:__end