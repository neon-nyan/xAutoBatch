:: Hak Cipta ©2017
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:CheckEncoderBitDepth
    if /i not "%profile%" == "" (
        if /i "%profile%" == "high10" (
            set EncoderPath=%Encoder10Path%
            set PipeInputDepth=16
        ) else if /i "%profile%" == "high" (
            set EncoderPath=%Encoder8Path%
            set PipeInputDepth=8
        ) else (
            echo [WARNING]  Jenis profile Bit Depth "%profile%" tidak tersedia.
            echo                value: [high,high10]
            echo            Bit depth akan di atur secara default ke "high10".

            set EncoderPath=%Encoder10Path%
            set PipeInputDepth=16
        )
    ) else (
        echo [WARNING]  Profile bit depth belum dimasukkan sama sekali.
        echo                value: [high,high10]
        echo            Bit depth akan di atur secara default ke "high10".

        set EncoderPath=%Encoder10Path%
        set PipeInputDepth=16
    )

:SETPreviewerTitleRes
    if not "%resH%" == "" set PreviewerH=!resH!p

:__jumper
    if "%jump%" == "" (
        msg * Sertakan label terlebih dahulu!
        msg * Dan gunakan Classes ini dengan program Encodernya.
        msg * ^(/^^_^^^)/ Makasih! \^(^^_^^\^) ^<-----------^> Oleh: codeneon
        exit
    ) else (
        goto %jump%
    )

:AvisynthOnlyDecoder
    echo.
    setlocal EnableDelayedExpansion
REM "%AvisynthPipePath%" -dll="%AvisynthLibrary%" video -y4mp=0:0 -y4mbits=16 "%mediainput%" | "%EncoderPath%" --demuxer y4m --muxer mkv -o - !parameters! !tabout! --stylish - | "%PipeTeePath%" -i "%mediaoutput%" | "%PreviewerPath%" -autoexit -x 240 -y 135 -window_title "!resH!p Preview Window" -showmode 0 -v quiet -
    "%AvisynthPipePath[0]%" "%mediainput%" -csp AUTO -depth %PipeInputDepth% -o - | "%EncoderPath%" --demuxer y4m --muxer mkv -o - !parameters! !tabout! --stylish - | "%PipeTeePath%" -i "%mediaoutput%" | "%PreviewerPath%" -autoexit -x 240 -y 135 -window_title "%PreviewerH%Preview Window" -showmode 0 -v quiet -
    goto :__end

:__end
    endlocal
    set jump=