:: Hak Cipta ©2017
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:__jumper
    if "%jump%" == "" (
        msg * Sertakan label terlebih dahulu!
        msg * Dan gunakan Classes ini dengan program Encodernya.
        msg * ^(/^^_^^^)/ Makasih! \^(^^_^^\^) ^<-----------^> Oleh: codeneon
        exit
    ) else (
        goto %jump%
    )


:StartCheckAudioCodecName
    if /i "%audio-codec%" == "he-aac" (
        goto :ProcessHEAACAudioCodec
    )

    if /i "%audio-codec%" == "he-aacv2" (
        goto :ProcessHEAACv2AudioCodec
    )

    if /i "%audio-codec%" == "vorbis" (
        goto :ProcessVorbisAudioCodec
    )

    if /i "%audio-codec%" == "flac" (
        goto :ProcessFlacAudioCodec
    )

    if /i "%audio-codec%" == "opus" (
        goto :ProcessOpusAudioCodec
    )



    goto :__end


:ProcessAudioCodec
    :ProcessHEAACAudioCodec
        if /i exist "%mediaoutputname%.wav" (
            del "%mediaoutputname%.wav"
        )

        if "%audio-bitrate%" == "" (
            set audio-bitrate=76

            echo Bitrate belum dimasukkan atau parameter belum ditentukan.
            echo Proses akan dilakukan dengan bitrate default !audio-bitrate!kbp/s.
            echo.
        )

        if "%audio-pass%" == "" (
            set audio-pass=1pass

            set passparam=-%audio-pass%

            echo Pass/phase-pass belum dimasukkan atau parameter belum ditentukan.
            echo Proses akan dilakukan dalam x-1pass.
            echo.
        ) else (
            if /i "%audio-pass%" == "1pass" (
                set passparam=
            ) else if /i "%audio-pass%" == "2pass" (
                set passparam=-%audio-pass%
            ) else (
                set passparam=-2pass

                echo Value Pass/phase-pass tidak diketahui.
                echo Proses akan dilakukan kedalam x!passparam! secara default.
                echo.
            )
        )

        "%DecoderPath%" -loglevel %debStat% -i "%mediainput%" -ar %audio-resample% -c:a pcm_f32le -f wav "%mediaoutputname%.wav"
        "%AACEncPath%" -br !audio-bitrate!000 !passparam! -he -ignorelength -if "%mediaoutputname%.wav" -of "%mediaoutputname%.m4a"

        del "%mediaoutputname%.wav"

        goto :__end


    :ProcessHEAACv2AudioCodec
        if /i exist "%mediaoutputname%.wav" (
            del "%mediaoutputname%.wav"
        )

        if "%audio-bitrate%" == "" (
            set audio-bitrate=48

            echo Bitrate belum dimasukkan atau parameter belum ditentukan.
            echo Proses akan dilakukan dengan bitrate default !audio-bitrate!kbp/s.
            echo.
        )

        if "%audio-pass%" == "" (
            set audio-pass=1pass

            set passparam=-%audio-pass%

            echo Pass/phase-pass belum dimasukkan atau parameter belum ditentukan.
            echo Proses akan dilakukan dalam x-1pass.
            echo.
        ) else (
            if /i "%audio-pass%" == "1pass" (
                set passparam=
            ) else if /i "%audio-pass%" == "2pass" (
                set passparam=-%audio-pass%
            ) else (
                set passparam=-2pass

                echo Value Pass/phase-pass tidak diketahui.
                echo Proses akan dilakukan kedalam x!passparam! secara default.
                echo.
            )
        )

        "%DecoderPath%" -loglevel %debStat% -i "%mediainput%" -ar %audio-resample% -c:a pcm_f32le -f wav "%mediaoutputname%.wav"
        "%AACEncPath%" -br !audio-bitrate!000 !passparam! -hev2 -ignorelength -if "%mediaoutputname%.wav" -of "%mediaoutputname%.m4a"
        
        del "%mediaoutputname%.wav"

        goto :__end

    :ProcessOpusAudioCodec
        if "%audio-bitrate%" == "" (
            set audio-bitrate=72

            echo Bitrate belum dimasukkan atau parameter belum ditentukan.
            echo Proses akan dilakukan dengan bitrate default !audio-bitrate!kbp/s.
            echo.
        )

        if "%audio-pass%" == "" (
            set audio-pass=1pass

            set passparam=--comp 6 --framesize 40

            echo Pass/phase-pass belum dimasukkan atau parameter belum ditentukan.
            echo Proses akan dilakukan dalam x-1pass.
            echo.
        ) else (
            if /i "%audio-pass%" == "1pass" (
                set passparam=--comp 6 --framesize 40
            ) else if /i "%audio-pass%" == "2pass" (
                set passparam=--comp 10 --framesize 20
            ) else (
                set passparam=--comp 10 --framesize 20

                echo Value Pass/phase-pass tidak diketahui.
                echo Proses akan dilakukan kedalam x!passparam! secara default.
                echo.
            )
        )

        "%DecoderPath%" -loglevel %debStat% -i "%mediainput%" -ar %audio-resample% -c:a pcm_f32le -f wav - | "%OpusEncPath%" --bitrate !audio-bitrate! --vbr !passparam! - "%mediaoutputname%.opus"

        goto :__end

    :ProcessVorbisAudioCodec
        if "%audio-bitrate%" == "" (
            set audio-bitrate=80

            echo Bitrate belum dimasukkan atau parameter belum ditentukan.
            echo Proses akan dilakukan dengan bitrate default !audio-bitrate!kbp/s.
            echo.
        )

        if "%audio-bitrate%" GTR "500" (
            set audio-bitrate=500

            echo.
            echo    [Warning]: Bitrate untuk codec Vorbis di luar batas maksimum!.
            echo.
        )

        if "%audio-pass%" == "" (
            set audio-pass=1pass

            set passparam=

            echo Pass/phase-pass belum dimasukkan atau parameter belum ditentukan.
            echo Proses akan dilakukan dalam x-1pass.
            echo.
        ) else (
            if /i "%audio-pass%" == "1pass" (
                set passparam=
            ) else if /i "%audio-pass%" == "2pass" (
                set /a vorbmaxbitrate=!audio-bitrate! * 2
                if "!vorbmaxbitrate!" GTR "1000" (
                    set vorbmaxbitrate=1000
                )
                set passparam=-lb=1 -ub=!vorbmaxbitrate!
            ) else (
                set passparam=

                echo Value Pass/phase-pass tidak diketahui.
                echo Proses akan dilakukan kedalam x-1pass secara default.
                echo.
            )
        )

        "%DecoderPath%" -loglevel %debStat% -i "%mediainput%" -ar %audio-resample% -c:a pcm_s16le -f wav - | "%VorbEncPath%" -ignore_length -q10 -b!audio-bitrate! !passparam! - "%mediaoutputname%.ogg"

        goto :__end

    :ProcessFlacAudioCodec
        echo Sedang memproses...
        echo    %mediainput% -> %mediaoutputname%.flac
        "%DecoderPath%" -loglevel %debStat% -i "%mediainput%" -ar %audio-resample% -c:a flac -f flac "%mediaoutputname%.flac"

        goto :__end

:__end