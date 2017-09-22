:: Hak Cipta ©2017
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:GETSystemTime
    REM Eliminasi variable dari data waktu berdasarkan jam, waktu, detik, dan milidetik,
    REM Lalu tulis output ke file temporari.
    for /f "tokens=1,2,3 delims=:" %%a in ('echo %time%') do (
        echo %%a>"%temp%\hour.data"
        echo %%b>"%temp%\min.data"

        REM Eliminasi antara detik dan milidetik,
        REM Lalu tulis output ke file temporari.
        for /f "tokens=1,2 delims= " %%a in ('echo %%c') do (
            echo %%a>"%temp%\sec.data"
            echo %%b>"%temp%\micsec.data"
        )
    )

    REM Muat data variable dari file temporari
    set /p thour=<"%temp%\hour.data"
    set /p tmin=<"%temp%\min.data"
    set /p tsec=<"%temp%\sec.data"
    set /p tmicsec=<"%temp%\micsec.data"

    REM Hapus file temporari.
    echo y | del "%temp%\hour.data"
    echo y | del "%temp%\min.data"
    echo y | del "%temp%\sec.data"
    echo y | del "%temp%\micsec.data"

:GETSystemDate
    :CheckDateFormat
        REM Check penggunaan format De-eliminator dari tanggal.
        echo %date% | find "/" > nul

        REM Bila format menggunakan "/" untuk De-eliminasi, maka gunakan step1,
        REM Namun bila format tidak menggunakan De-eliminator "/", maka gunakan step2,
        REM Lalu tulis output ke file temporari.
        if not "!errorlevel!" == "1" (
            for /f "tokens=1,2,3 delims=/" %%a in ('echo %date%') do (
                echo %%a>"%temp%\tdate1.data"
                echo %%b>"%temp%\tdate2.data"
                echo %%c>"%temp%\tdate3.data"
            )
        ) else (
            for /f "tokens=1,2,3 delims=-" %%a in ('echo %date%') do (
                echo %%a>"%temp%\tdate1.data"
                echo %%b>"%temp%\tdate2.data"
                echo %%c>"%temp%\tdate3.data"
            )
        )

        REM Muat data variable dari file temporari
        set /p tdate1=<"%temp%\tdate1.data"
        set /p tdate2=<"%temp%\tdate2.data"
        set /p tdate3=<"%temp%\tdate3.data"

        REM Hapus file temporari.
        echo y | del "%temp%\tdate1.data"
        echo y | del "%temp%\tdate2.data"
        echo y | del "%temp%\tdate3.data"