:: Hak Cipta ©2017
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:GETNewVersionData
    echo Memeriksa Update...
    "%wgetPath%" --no-check-certificate -q -O "%temp%\UPDATE" https://raw.githubusercontent.com/neon-nyan/xAutoBatch/master/UPDATE

    if "%errorlevel%" GEQ "1" (
        cls
        title=Update - ERROR
        echo %debugStat%Terjadi kesalahan dalam proses pembaruan...
        echo Jaringan terganggu. Silahkan periksa kembali koneksi Internet anda. :3
        goto :__end
    )

    set /p NewVerUpdate=<"%temp%\UPDATE"

REM :GETUpdateNewVersion
REM     setlocal enabledelayedexpansion
REM     for /f "tokens=1,2 delims=_" %%a in ('echo %NewVerUpdate%') do (
REM         set newcodename=%%a
REM         for /f "tokens=1 delims=v" %%a in ('echo %%b') do (
REM             for /f "tokens=1,2,3 delims=." %%a in ('echo %%a') do (
REM                 set newmajver=%%a&&set newminver=%%b&&set newrevver=%%c&&set newver=%%a%%b%%c
REM             )
REM         )
REM     )

:GETUpdateNewVersion
    setlocal enabledelayedexpansion
    for /f "tokens=1,2 delims=_" %%a in ('echo %NewVerUpdate%') do (
        set newcodename=%%a
        set newver=%%b
        for /f "tokens=2 delims=.r" %%a in ('echo !newrev!') do (
            set newrev=%%a
        )
        set newallver=%%a!newrev!
    )
    echo !newallver!
cmd

:CheckCurVer
REM set oldver=%majver%%minver%%revver%&&if not "!newver!" GTR "!oldver!" goto :__end
    set oldver=%ver%%rev%&&if not "!newver!" GTR "!oldver!" (
        goto :__end
    ) else if "!newver!" == "!oldver!" (
        title=Update - Dibatalkan
        cls
        echo Versi yang anda gunakan adalah yang terbaru.
        echo.
        echo Versi saat ini: !newver!
        goto :__end
    )

:ConfirmUpdate
    cls
    title=Versi baru v!newver!.r!newrev! ["!newcodename!"] terdeteksi
    echo %tpdnt1%
    echo Versi baru terdeteksi
    echo %tpdnt1%
    echo.
    echo Versi terbaru v!newver!.r!newrev! ["!newcodename!"] telah terdeteksi.
    echo Versi saat ini v%ver%.r%rev% ["%codename%"]
    set /p UpdateConfirm=Apakah anda ingin memperbaruinya [Y/N]?^> 
    
    if /i "%UpdateConfirm%" == "Y" (
        goto :DoUpdate
    ) else if /i "%UpdateConfirm%" == "Yes" (
        goto :DoUpdate
    ) else (
        goto :__end
    )

:DoUpdate
    cls
    if /i not exist "%downtempdir%" md "%downtempdir%"
    title=Mendapatkan update...
    %wgetPath% --no-check-certificate -L -q https://github.com/neon-nyan/xAutoBatch/releases/download/v!newver!.r!newrev!/xAutoBatch-!newver!.r!newrev!.zip -O "%downtempdir%\%progname%-!newver!.r!newrev!.zip" | echo Mendapatkan paket...
    %unzipPath% -qq -o -d "%downtempdir%" "%downtempdir%\xAutoBatch-!newver!.r!newrev!.zip" | echo Decompress paket...
    xcopy /E /H /R /Y "%downtempdir%\xAutoBatch-!newver!.r!newrev!" "." | echo Terapkan paket...
    
    :StatUpdateDone
        cls
        title=Update selesai...
        timeout /t 2 /nobreak | echo Update selesai

        msg * Program telah keluar. Mohon jalankan kembali untuk melanjutkan.

        start https://github.com/neon-nyan/xAutoBatch/releases/tag/v!newver!.r!newrev!

:__end
    endlocal