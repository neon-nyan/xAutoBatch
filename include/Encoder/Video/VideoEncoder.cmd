:: Hak Cipta ©2017 oleh neon-nyan / codeneon [codeneon123@gmail.com]
:: Di bawah Hak Cipta MIT License [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:CheckEncoderBitDepth
    if /i not "%profile%" == "" (
        if /i "%profile%" == "high10" (
            set EncoderPath=%Encoder10Path%
        ) else if /i "%profile%" == "high" (
            set EncoderPath=%Encoder8Path%
        ) else (
            echo.
            echo Jenis profile Bit Depth "%profile%" tidak tersedia.
            echo Bit depth akan di atur secara default ke "high10".
            echo.

            set EncoderPath=%Encoder10Path%
        )
    ) else (
        echo.
        echo Profile bit depth belum dimasukkan sama sekali.
        echo Bit depth akan di atur secara default ke "high10".
        echo.

        set EncoderPath=%Encoder10Path%
    )

:__jumper
(
    if "%jump%" == "" (
        msg * Sertakan label terlebih dahulu!
        msg * Dan gunakan Classes ini dengan program Encodernya.
        msg * ^(/^^_^^^)/ Makasih! \^(^^_^^\^) ^<-----------^> Oleh: codeneon
        exit
    ) else (
        goto %jump%
    )
)

:AvisynthOnlyDecoder
(
    "%EncoderPath%" --muxer mkv -o - !parameters! "%mediainput%" | "%PipeTeePath%" -i "%mediaoutput%" | "%PreviewerPath%" -autoexit -x 240 -y 135 -window_title "!resH!p Preview Window" -showmode 0 -v quiet -
    goto :__end
)

:FFmpegDecoder
(
    "%DecoderPath%" -i "%mediainput%" -f yuv4mpegpipe -strict -1 -loglevel !debStat! -pix_fmt yuv420p10 -sn -an - | "%EncoderPath%" --demuxer y4m --muxer mkv -o - !parameters! - | "%PipeTeePath%" -i "%mediaoutput%" | "%PreviewerPath%" -autoexit -x 240 -y 135 -window_title "!resH!p Preview Window" -showmode 0 -v quiet -
    goto :__end
)

:FFmpegDecoderNoExit
(
    "%DecoderPath%" -i "%mediainput%" -f yuv4mpegpipe -strict -1 -loglevel !debStat! -pix_fmt yuv420p10 -sn -an - | "%EncoderPath%" --demuxer y4m --muxer mkv -o - !parameters! - | "%PipeTeePath%" -i "%mediaoutput%" | "%PreviewerPath%" -x !resW! -y !resH! -window_title "!resH!p Preview Window" -showmode 0 -v quiet -
    goto :__end
)

:__end
    set jump=