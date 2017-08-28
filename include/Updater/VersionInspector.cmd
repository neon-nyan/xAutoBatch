:: Hak Cipta ©2017
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:GETNewVersionData
    echo Memeriksa Update...
    "%wgetPath%" --no-check-certificate -q -O "%temp%\UPDATE_CHECK" https://raw.githubusercontent.com/neon-nyan/xAutoBatch/master/UPDATE_CHECK

    REM Bila errorlevel == 1, maka munculkan pesan error.
    if "%errorlevel%" GEQ "1" (
        cls
        title=Update - ERROR
        echo %debugStat%Terjadi kesalahan dalam proses pembaruan...
        timeout /t 3 /nobreak | echo Jaringan terganggu. Silahkan periksa kembali koneksi Internet anda. :3
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

REM De-eliminasi data RAW yang ada dalam file Chunk untuk update.
REM dengan struktur data RAW:
REM     [codename]_v[ver_xxx].r[rev_x]
REM contoh:
REM     Kuvukiland_v696.r9
:GETUpdateNewVersion
    setlocal enabledelayedexpansion
    REM De-eliminasi data menjadi dua bagian, contoh:
    REM     1: Kuvukiland
    REM     2: v696.r9
    for /f "tokens=1,2 delims=_" %%a in ('echo %NewVerUpdate%') do (
        REM Tetapkan data variable newcodename dengan bagian ke-1.
        set newcodename=%%a
        REM De-eliminasi data variable ke-2 menjadi dua bagian:
        REM     1: 696
        REM     2: 9
        for /f "tokens=1 delims=v" %%a in ('echo %%b') do (
            for /f "tokens=1,2 delims=.r" %%a in ('echo %%a') do (
                REM Tetapkan data variable newver "696", newrev "9", dan newallver "newver+newrev=6969"
                set newver=%%a
                set newrev=%%b
                set newallver=%%a%%b
            )
        )
    )

:CheckCurVer
    REM Tetapkan data variable oldver dengan versi internal.
    REM Bila newallver tidak lebih dari oldver, maka akhiri sesi.
    REM Bila newallver lebih dari oldver, maka lanjutkan sesi.
    REM Bila newallver sama dengan oldver, maka nyatakan bahwa versi yang digunakan sama atau terbaru.
    set oldver=%ver%%rev%&&if not "!newallver!" GTR "!oldver!" (
        goto :__end
    ) else if "!newallver!" == "!oldver!" (
        title=Update - Dibatalkan
        cls
        echo Versi yang anda gunakan adalah yang terbaru.
        echo.
        timeout /t 3 /nobreak | echo Versi saat ini: !newver!
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

REM Fetch data update dari server GitHub dengan tag dan lakukan penerapan terhadap program.
:DoUpdate
    cls
    if /i not exist "%downtempdir%" md "%downtempdir%"
    title=Mendapatkan update...
    %wgetPath% --no-check-certificate -L -q https://github.com/neon-nyan/xAutoBatch/releases/download/v!newver!.r!newrev!/xAutoBatch-!newver!.r!newrev!.zip -O "%downtempdir%\%progname%-!newver!.r!newrev!.zip" | echo Mendapatkan paket...
    if "%errorlevel%" GEQ "1" (
        echo Terjadi kesalah dalam pengambilan data paket pembaruan.
        timeout /t 3 /nobreak | echo.
        echo Program Error  : wget
        echo Program Path   : %wgetPath%
        echo Time           : %date% - %time%
        goto :__end
    )

    %unzipPath% -qq -o -d "%downtempdir%" "%downtempdir%\xAutoBatch-!newver!.r!newrev!.zip" | echo Decompress paket...
    if "%errorlevel%" GEQ "1" (
        echo Terjadi kesalah dalam proses pen-dekompresan.
        timeout /t 3 /nobreak | echo.
        echo Program Error  : unzip
        echo Program Path   : %unzipPath%
        echo Time           : %date% - %time%
        goto :__end
    )

    xcopy /E /H /R /Y "%downtempdir%\xAutoBatch-!newver!.r!newrev!" "." | echo Terapkan paket...
    
    :StatUpdateDone
        cls
        title=Update selesai...
        timeout /t 2 /nobreak | echo Update selesai

        msg * Program telah keluar. Mohon jalankan kembali untuk melanjutkan.

        REM Buka release note 
        start https://github.com/neon-nyan/xAutoBatch/releases/tag/v!newver!.r!newrev!

:__end
    endlocal