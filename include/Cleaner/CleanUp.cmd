:: Hak Cipta ©2017
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:CleanLastTempFile
    if /i exist "%scripttempname%" (
        del "%scripttempname%"
    )

    if /i exist "input\*.avs" (
        del input\*.avs
    )

    goto :__end

:__end