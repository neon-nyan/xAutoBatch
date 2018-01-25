:: Hak Cipta ©2018
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

REM set PreviewerPath=C:\Program Files (x86)\K-Lite Codec Pack\MPC-HC64\mpc-hc64.exe
set PreviewerParam=-x 240 -y 135 -window_title "!resH!p Preview Window" -showmode 0 -v quiet

:home
    cls
    
    :GETName
    cls
    echo Nama File^?: %alert%
    echo %tpdnt1%
    set /p mediainput=^> 
    echo.
    set alert=
    if "%mediainput%" == "" (
        set alert=Nggak Boleh Kosong, coeg!!! -_-
        goto :GETName
    )

    :GETOffset
    cls
    echo Dimulai dari detik ke^?: %alert%
    echo %tpdnt1%
    set /p offset=^> 
    echo.
    set alert=
    if "%offset%" == "" (
        set alert=Nggak Boleh Kosong, coeg!!! -_-
        goto :GETOffset
    )

    :GETParam
    cls
    echo Isi Parameternya: %alert%
    echo %tpdnt1%
    set /p parameters=^> 
    echo.
    set alert=
    if "%parameters%" == "" (
        set alert=Nggak Boleh Kosong, coeg!!! -_-
        goto :GETParam
    )

    :GETCrf
    cls
    echo Isi CRFnya: %alert%
    echo %tpdnt1%
    set /p crf=^> 
    echo.
    set alert=
    if "%crf%" == "" (
        set alert=Nggak Boleh Kosong, coeg!!! -_-
        goto :GETCrf
    )

    set parameters=%parameters% --crf %crf%

    "%DecoderPath%" -i "input\%mediainput%" -f yuv4mpegpipe -strict -1 -loglevel quiet -pix_fmt yuv420p10 -ss %offset% -t 1 -filter:v scale=1280:-1:lanczos -sn -an - | "%EncoderPath%" --demuxer y4m --muxer mkv -o - %parameters% - | "%PreviewerPath%" %PreviewerParam% -

    goto home