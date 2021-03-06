:: Hak Cipta ©2018
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:GETFileExistency
    if not exist "input\*.spf" (
        msg * tidak ada satupun file preset .spf didalam folder input.
        goto :__end
    )

:ProcessParams
    for /r %%d in (input\*.spf) do (
        setlocal EnableDelayedExpansion
        set input=%%d

        call %b%\Encoder\LoadQuery

        cls

        echo Parameter pada file preset telah digenerate dalam file input\%%~nd_parameters.txt
        echo !parameters! !tabout! > input\%%~nd_parameters.txt
        echo.
    )

:__end