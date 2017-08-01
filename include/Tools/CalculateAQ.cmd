:: Hak Cipta ©2017 oleh neon-nyan / codeneon [codeneon123@gmail.com]
:: Di bawah Hak Cipta MIT License [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

@echo off
cls
set b=include

:setvars
    call %b%\Variable

:DoCalculate
    set param=psy-rd
    for /r %%a in ("input\*.spf") do (
        set input=%%a

        setlocal enabledelayedexpansion && call %b%\IO\Calculator\AQModCalculator

        title=%debStat%AQ2 Str: !n1! - AQ2 Sens: !n2! - AQ3 Str: !n3! - AQ3 Sens: !ns!

        cls
        echo -------------------------------------------------------------------------------
        echo                                 Hasil Statistika
        echo -------------------------------------------------------------------------------
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