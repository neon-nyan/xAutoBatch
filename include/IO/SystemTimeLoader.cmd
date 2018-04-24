:: Hak Cipta ©2018
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:GETSystemTime
    REM Eliminasi variable dari data waktu berdasarkan jam, waktu, detik, dan milidetik,
    REM Lalu tulis output ke file temporari.
    for /f "tokens=1,2,3 delims=:" %%a in ('echo %time%') do (
        echo %%a>"%data.cache.time.hour%"
        echo %%b>"%data.cache.time.min%"

        REM Eliminasi antara detik dan milidetik,
        REM Lalu tulis output ke file temporari.
        for /f "tokens=1,2 delims= " %%a in ('echo %%c') do (
            echo %%a>"%data.cache.time.sec%"
            echo %%b>"%data.cache.time.msec%"
        )
    )

    REM Muat data variable dari file temporari
    set /p thour=<"%data.cache.time.hour%"
    set /p tmin=<"%data.cache.time.min%"
    set /p tsec=<"%data.cache.time.sec%"
    set /p tmicsec=<"%data.cache.time.msec%"

    REM Hapus file temporari.
    echo y | del "%data.cache.time.hour%"
    echo y | del "%data.cache.time.min%"
    echo y | del "%data.cache.time.sec%"
    echo y | del "%data.cache.time.msec%"

:GETSystemDate
    :CheckDateFormat
        REM Check penggunaan format De-eliminator dari tanggal.
        echo %date% | find "/" > nul

        REM Bila format menggunakan "/" untuk De-eliminasi, maka gunakan step1,
        REM Namun bila format tidak menggunakan De-eliminator "/", maka gunakan step2,
        REM Lalu tulis output ke file temporari.
        if not "!errorlevel!" == "1" (
            for /f "tokens=1,2,3 delims=/" %%a in ('echo %date%') do (
                echo %%a>"%data.cache.date.stack1%"
                echo %%b>"%data.cache.date.stack2%"
                echo %%c>"%data.cache.date.stack3%"
            )
        ) else (
            for /f "tokens=1,2,3 delims=-" %%a in ('echo %date%') do (
                echo %%a>"%data.cache.date.stack1%"
                echo %%b>"%data.cache.date.stack2%"
                echo %%c>"%data.cache.date.stack3%"
            )
        )

        REM Muat data variable dari file temporari
        set /p tdate1=<"%data.cache.date.stack1%"
        set /p tdate2=<"%data.cache.date.stack2%"
        set /p tdate3=<"%data.cache.date.stack3%"

        REM Hapus file temporari.
        echo y | del "%data.cache.date.stack1%"
        echo y | del "%data.cache.date.stack2%"
        echo y | del "%data.cache.date.stack3%"