:: Hak Cipta ©2017
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:mkavs
    for /r %%a in (input\*%inputext%) do (
        (
            echo %tpdnt3%
            echo # AviSynth+ Script.                                                           #
            echo %tpdnt3%
            echo # ^| Generated by  : %progname% %progver%
            echo # ^| in time       : %date%,%time%
            echo # ^| by            : %username%
            echo # +----------------------------------------------------------------------------
            echo.
            echo SetMemoryMax^(%memorymax%^)
            if "%threads%" == "" set threads=7
            echo global threads = %threads%
            echo.
            echo ro = "%asdir%"
            echo s = "%%a"
            echo.
            echo # input
            echo LoadPlugin^(ro ^+ "ffms2.dll"^)
            echo.

            REM Setel beberapa fungsi yang dibutuhkan untuk pemrosesan dengan Avisynth+ MT.
            echo # setel beberapa hal yang dibutuhkan Avisynth MT.
            echo SetFilterMTMode^("DEFAULT_MT_MODE",2^)

            REM Setel MT Level untuk Video Improver bila == true
            if not "%vidimpv%" == "" (
                if /i "%vidimpv%" == "true" (
                    echo SetFilterMTMode^("GradFun2DBmod",1^)
                    echo SetFilterMTMode^("aWarpSharp2",1^)
                    echo SetFilterMTMode^("Tweak",1^)
                )
            )

            echo SetFilterMTMode^("%resF%",1^)

            echo.

            REM Setel atribut source.
            :GETInputMethod
                setlocal enabledelayedexpansion

                :SETAudioSyncBoolean
                    if /i "%audiosync%" == "true" (
                        set isAudsync=true
                    ) else if /i "%audiosync%" == "false" (
                        set isAudsync=false
                    ) else (
                        set isAudsync=true
                    )

                :SETCacheIfDebug
                    if "%isDebug%" == "true" (
                        set isCache=true
                    ) else (
                        set isCache=false
                    )

                :CheckIfCurrentOnlyEncodeMethod
                    if not "%Encaudioonly%" == "true" (
                        echo.
                        echo SetFilterMTMode^("FFVideoSource",3^)
                        echo global vS = FFVideoSource^( \
                        echo    s, \
                    REM echo    colorspace = "YUY2", \
                        echo    cache = !isCache! \
                        echo ^).\
                        echo ConvertToYV12
                        echo.
                    )

                    if not "%Encvideoonly%" == "true" (
                        echo SetFilterMTMode^("FFAudioSource",3^)
                        echo global aS = FFAudioSource^(\
                        echo    s, \
                        echo    cache = !isCache! \
                        echo ^)
                        echo.
                    )

                    :SETSourceMethod
                        if "%Encaudioonly%" == "true" (
                            echo aS
                            echo.
                            if not "%audio-resample%" == "" echo ResampleAudio^(%audio-resample%^)
                        ) else if "%Encvideoonly%" == "true" (
                            echo vS
                        ) else (
                            echo AudioDub^( \
                            echo    vS, \
                            echo    aS \
                            echo ^)
                            echo.
                            if not "%audio-resample%" == "" echo ResampleAudio^(%audio-resample%^)
                        )

                endlocal

            if not "%Encaudioonly%" == "true" (
                if exist "%trimadd%" ( echo. && type "%trimdata%")

                REM Bila <boolean> interlace == true, maka buat output fungsi.
                REM SeparateFields^(^) == pisahkan 2 frame kedalam masing-masing area.
                REM Bob^(^) == Deinterlacer Bob.
                REM SelectOdd^(^) == pilih frame genap untuk diproses.
                if /i "%interlace%" == "true" (
                    echo # Deinterlace source.
                    echo SeparateFields^(^)
                    echo Bob^(^)
                    echo # SelectEven^(^)
                    echo SelectOdd^(^)
                    echo.
                )

                echo %resF%^( \
                echo    %resW%, \
                echo    %resH% \
                echo ^)

                REM A. Bila %assumefps% tidak kosong, lalu:
                REM      1. Bila %syncaudioassume% tidak kosong, lalu:
                REM          a. Bila %syncaudioassume% aktif, maka gunakan fungsi assumefps == true.
                REM          b. Namun bila %syncaudioassume% nonaktif, maka gunakan fungsi assumefps == false.
                REM          c. Namun bila %syncaudioassume% tidak aktif dan tidak nonaktif, maka gunakan fungsi assumefps == false.
                REM      2. Bila %syncaudioassume% kosong, maka gunakan fungsi assumefps == false.
                REM B. Namun bila %assumefps% kosong, maka jangan printOut apapun kedalam console.
                if not "%assumefps%" == "" (
                    echo.
                    if not "%syncaudioassume%" == "" (
                        if /i "%syncaudioassume%" == "true" (
                            echo AssumeFPS^(%assumefps%, true^)
                        ) else if /i "%syncaudioassume%" == "false" (
                            echo AssumeFPS^(%assumefps%, false^)
                        ) else (
                            echo AssumeFPS^(%assumefps%, false^)
                        )
                    ) else (
                        echo AssumeFPS^(%assumefps%, false^)
                    )
                    echo.
                )

                REM Bila filter terdefinisi dan <boolean> filter == true, maka tulis output dari file skrip temporari.
                if not "%filter%" == "" (
                    if /i "%filter%" == "true" (
                        type %scripttempname%
                    ) else if /i "%filter%" == "false" (
                        echo.
                    ) else (
                        type %scripttempname%
                    )
                )

                REM Tulis Script untuk Video improver bila boolean parameter vidimpv !== true
                if not "%vidimpv%" == "" (
                    if /i "%vidimpv%" == "true" (
                        echo. && type "%improverInc%"
                        if /i "%vdfilterpass%" == "2pass" (
                            echo. && type "%improver2pass%"
                        ) else (
                            echo. && type "%improver1pass%"
                        )
                        echo.
                    )
                )

                REM Untuk sementara, fungsi decimate dinonaktifkan karena stabilitas dari framerate yang tidak konsisten.
                if /i "%interlace%" == "true" echo # tdecimate^(mode = 1, hybrid = 1, vfrDec = 1^)

                REM A. Bila %changefps% tidak kosong, lalu:
                REM      1. Bila %linearchange% tidak kosong, lalu:
                REM          a. Bila %linearchange% aktif, maka gunakan fungsi ChangeFPS == true.
                REM          b. Namun bila %linearchange% nonaktif, maka gunakan fungsi ChangeFPS == false.
                REM          c. Namun bila %linearchange% tidak aktif dan tidak nonaktif, maka gunakan fungsi ChangeFPS == true.
                REM      2. Bila %linearchange% kosong, maka gunakan fungsi ChangeFPS == true.
                REM B. Namun bila %changefps% kosong, maka jangan printOut apapun kedalam console.
                if not "%changefps%" == "" (
                    if not "%linearchange%" == "" (
                        echo.
                        if /i "%linearchange%" == "true" (
                            echo ChangeFPS^(% changefps%, true^)
                        ) else if /i "%linearchange%" == "false" (
                            echo ChangeFPS^(%changefps%, false^)
                        ) else (
                            echo ChangeFPS^(%changefps%, true^)
                        )
                        echo.
                    ) else (
                        echo ChangeFPS^(%changefps%, true^)
                    )
                )
                echo.
            )
            echo Prefetch^(threads^)
        ) > "input\%%~na.%resH%.avs"
    )