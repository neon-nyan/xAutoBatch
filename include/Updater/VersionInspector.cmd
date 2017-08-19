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
        echo %debugStat%Terjadi kesalahan dalam proses pembaruan...
        goto :__end
    )

    set /p NewVerUpdate=<"%temp%\UPDATE"

:GETUpdateNewVersion
    setlocal enabledelayedexpansion
    for /f "tokens=1,2 delims=_" %%a in ('echo %NewVerUpdate%') do (
        set newcodename=%%a
        for /f "tokens=1 delims=v" %%a in ('echo %%b') do (
            for /f "tokens=1,2,3 delims=." %%a in ('echo %%a') do (
                set newmajver=%%a&&set newminver=%%b&&set newrevver=%%c&&set newver=%%a%%b%%c
            )
        )
    )

:CheckCurVer
    set oldver=%majver%%minver%%revver%&&if not "!newver!" GTR "!oldver!" goto :__end

:ConfirmUpdate
    cls
    title=Versi baru v!newmajver!.!newminver!.!newrevver! ["!newcodename!"] terdeteksi
    echo %tpdnt1%
    echo Versi baru terdeteksi
    echo %tpdnt1%
    echo.
    echo Versi terbaru v!newmajver!.!newminver!.!newrevver! ["!newcodename!"] telah terdeteksi.
    echo Versi saat ini v%majver%.%minver%.%revver% ["%codename%"]
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
    %wgetPath% --no-check-certificate -L -q https://github.com/neon-nyan/xAutoBatch/releases/download/v!newmajver!.!newminver!.!newrevver!/xAutoBatch-!newmajver!.!newminver!.!newrevver!.zip -O "%downtempdir%\%progname%-!newmajver!.!newminver!.!newrevver!.zip" | echo Mendapatkan paket...
    %unzipPath% -qq -o -d "%downtempdir%" "%downtempdir%\xAutoBatch-!newmajver!.!newminver!.!newrevver!.zip" | echo Decompress paket...
    xcopy /E /H /R /Y "%downtempdir%\xAutoBatch-!newmajver!.!newminver!.!newrevver!" "." | echo Terapkan paket...
    
    :StatUpdateDone
        cls
        title=Update selesai...
        timeout /t 2 /nobreak | echo Update selesai

        msg * Program telah keluar. Mohon jalankan kembali untuk melanjutkan.

        start https://github.com/neon-nyan/xAutoBatch/releases/tag/v!newmajver!.!newminver!.!newrevver!

:__end
    endlocal