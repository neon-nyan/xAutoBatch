:: Hak Cipta ©2017
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:CheckEncoderBitDepth
    if /i not "%profile%" == "" (
        if /i "%profile%" == "high10" (
            set encoder.path=%file.exec.encoder.video.x264.10bit%
            set PipeInputDepth=16
        ) else if /i "%profile%" == "high" (
            set encoder.path=%file.exec.encoder.video.x264.8bit%
            set PipeInputDepth=8
        ) else (
            echo [WARNING]  Jenis profile Bit Depth "%profile%" tidak tersedia.
            echo                value: [high,high10]
            echo            Bit depth akan di atur secara default ke "high10".

            set encoder.path=%file.exec.encoder.video.x264.10bit%
            set PipeInputDepth=16
        )
    ) else (
        echo [WARNING]  Profile bit depth belum dimasukkan sama sekali.
        echo                value: [high,high10]
        echo            Bit depth akan di atur secara default ke "high10".

        set encoder.path=%file.exec.encoder.video.x264.10bit%
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
    "%file.exec.avs.pipe.video%" "%mediainput%" -csp AUTO -depth %PipeInputDepth% -o - | "%encoder.path%" --demuxer y4m --muxer mkv -o - !parameters! !tabout! --stylish - | "%file.exec.msys.tee%" -i "%mediaoutput%" | "%file.exec.avs.preview%" -autoexit -x 240 -y 135 -window_title "%PreviewerH% Preview Window" -showmode 0 -v quiet -
    goto :__end

:__end
    endlocal
    set jump=