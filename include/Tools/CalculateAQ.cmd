:: Hak Cipta ©2018
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:DoCalculate
    set param=psy-rd
    for /r %%a in ("input\*.spf") do (
        set input=%%a

        setlocal enabledelayedexpansion && call %b%\IO\Calculator\AQModCalculator

        title=%debStat%AQ2 Str: !n1! - AQ2 Sens: !n2! - AQ3 Str: !n3! - AQ3 Sens: !ns!

        cls
        echo %props.style.header.style1%
        echo                                 Hasil Statistika
        echo %props.style.header.style1%
        echo %%~na.spf
        echo.
        echo        AQ2 Strength       : !n1!
        echo        AQ2 Sensitivity    : !n2!
        echo        AQ3 Strength       : !n3!
        echo        AQ3 Sensitivity    : !ns!
        echo.

        pause | echo Tekan apa saja untuk menghitung ke file selanjutnya...
    )

cls