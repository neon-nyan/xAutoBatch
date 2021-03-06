:: Hak Cipta ©2018
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

REM Fungsi ini menyatukan semua script .avsi kedalam satu file, dan akan digunakan
REM pada saat proses encoding berlangsung.
:MergeAutoscripts
(
    if not exist "autoscript\*.avsi" goto :NotAvailable

    for /r %%x in ("autoscript\*.avsi") do (
        echo %tpdnt3%
        echo # Load: %%~nx.avsi
        echo %tpdnt3%
        type "%%x"
        echo. && echo.
    )
) > "%scripttempname%"
goto :__end

:NotAvailable
    echo [INFO]     File Autoscript ".avsi" tidak tersedia didalam folder "autoscript".
    echo            Media akan diproses tanpa Autoscript.
    echo.
    goto :__end

:__end