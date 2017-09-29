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
    if /I "%audio-codec%" == "lc-aac" (
        goto :ProcessAACAudioCodec
    ) else if /I "%audio-codec%" == "he-aac" (
        goto :ProcessAACAudioCodec
    ) else if /I "%audio-codec%" == "he-aacv2" (
        goto :ProcessAACAudioCodec
    ) else if /I "%audio-codec%" == "vorbis" (
        goto :ProcessVorbisAudioCodec
    ) else if /I "%audio-codec%" == "flac" (
        goto :ProcessFlacAudioCodec
    ) else if /I "%audio-codec%" == "opus" (
        goto :ProcessOpusAudioCodec
    ) else (
        goto :__end
    )

:ProcessAudioCodec
    :ProcessAACAudioCodec
        if exist "%mediaoutputname%.wav" (
            del "%mediaoutputname%.wav"
        )

        :SETAACCodecParam
            if /I "%audio-codec%" == "lc-aac" (
                set aac-codec=lc
            ) else if /I "%audio-codec%" == "he-aac" (
                set aac-codec=he
            ) else if /I "%audio-codec%" == "he-aacv2" (
                set aac-codec=hev2
            )

        if "%audio-bitrate%" == "" (
            :SETAACDefaultBitrate
                if /I "%audio-codec%" == "lc-aac" (
                    set audio-bitrate=116
                ) else if "%audio-codec%" == "he-aac" (
                    set audio-bitrate=76
                ) else if "%audio-codec%" == "he-aacv2" (
                    set audio-bitrate=48
                ) else (
                    set audio-bitrate=76
                )

            echo [WARNING]  Bitrate belum dimasukkan atau parameter belum ditentukan.
            echo            Proses akan dilakukan dengan bitrate default !audio-bitrate!kbp/s.
        )

        :DoAACMethodForEachPass
        if /I "%audio-pass%" == "2pass" (
            "%AvisynthPipePath[1]%" "%mediainputaudio%" "%mediaoutputname%.wav" && "%AACEncPath%" -br !audio-bitrate!000 -2pass -!aac-codec! -ignorelength -if "%mediaoutputname%.wav" -of "%mediaoutputname%.m4a"

            del "%mediaoutputname%.wav"
        ) else if /I "%audio-pass%" == "1pass" (
            "%AvisynthPipePath[1]%" "%mediainputaudio%" - && "%AACEncPath%" -br !audio-bitrate!000 -1pass -!aac-codec! -ignorelength -if - -of "%mediaoutputname%.m4a"
        ) else (
            if "%audio-pass%" == "" (
                echo [WARNING]  Pass/phase-pass belum dimasukkan atau parameter belum ditentukan.
                echo                value: [1pass,2pass]
                echo            Proses akan dilakukan dalam x-2pass.
            ) else (
                echo [WARNING]  Value Pass/phase-pass tidak diketahui.
                echo                value: [1pass,2pass]
                echo            Proses akan dilakukan kedalam x-2pass secara default.
            )

            "%AvisynthPipePath[1]%" "%mediainputaudio%" "%mediaoutputname%.wav" && "%AACEncPath%" -br !audio-bitrate!000 -2pass -!aac-codec! -ignorelength -if "%mediaoutputname%.wav" -of "%mediaoutputname%.m4a"

            del "%mediaoutputname%.wav"
        )

        goto :__end

    :ProcessOpusAudioCodec
        if "%audio-bitrate%" == "" (
            set audio-bitrate=72

            echo [WARNING]  Bitrate belum dimasukkan atau parameter belum ditentukan.
            echo            Proses akan dilakukan dengan bitrate default !audio-bitrate!kbp/s.
        )

        if "%audio-pass%" == "" (
            set audio-pass=1pass

            set passparam=--comp 6 --framesize 40

            echo [WARNING]  Pass/phase-pass belum dimasukkan atau parameter belum ditentukan.
            echo                value: [1pass,2pass]
            echo            Proses akan dilakukan dalam x-1pass.
        ) else (
            if /I "%audio-pass%" == "1pass" (
                set passparam=--comp 6 --framesize 40
            ) else if /I "%audio-pass%" == "2pass" (
                set passparam=--comp 10 --framesize 20
            ) else (
                set passparam=--comp 10 --framesize 20

                echo [WARNING]  Value Pass/phase-pass tidak diketahui.
                echo                value: [1pass,2pass]
                echo            Proses akan dilakukan kedalam x-2pass secara default.
            )
        )

        "%AvisynthPipePath[1]%" "%mediainputaudio%" - | "%OpusEncPath%" --bitrate !audio-bitrate! --vbr !passparam! - "%mediaoutputname%.opus"

        goto :__end

    :ProcessVorbisAudioCodec
        if "%audio-bitrate%" == "" (
            set audio-bitrate=80

            echo [WARNING]  Bitrate belum dimasukkan atau parameter belum ditentukan.
            echo            Proses akan dilakukan dengan bitrate default !audio-bitrate!kbp/s.
        )

        if "%audio-pass%" == "" (
            set audio-pass=1pass

            set passparam=

            echo [WARNING]  Pass/phase-pass belum dimasukkan atau parameter belum ditentukan.
            echo                value: [1pass,2pass]
            echo            Proses akan dilakukan dalam x-1pass.
        ) else (
            if /I "%audio-pass%" == "1pass" (
                set passparam=
            ) else if /I "%audio-pass%" == "2pass" (
                set /a vorbmaxbitrate=!audio-bitrate! * 2
                set passparam=-lb=1 -ub=!vorbmaxbitrate!
            ) else (
                set passparam=

                echo [WARNING]  Value Pass/phase-pass tidak diketahui.
                echo                value: [1pass,2pass]
                echo            Proses akan dilakukan kedalam x-1pass secara default.
            )
        )

        "%AvisynthPipePath[1]%" "%mediainputaudio%" - | "%VorbEncPath%" -ignore_length -q10 -b!audio-bitrate! !passparam! - "%mediaoutputname%.ogg"

        goto :__end

    :ProcessFlacAudioCodec
        echo [INFO]     Sedang memproses...
        echo            %mediainput% -^> %mediaoutputname%.flac

        if "%audio-pass%" == "" (
            set passparam=-l 6 -b 4096 -r 4
        ) else (
            if /I "%audio-pass%" == "1pass" (
                set passparam=-l 6 -b 4096 -r 4
            ) else if /I "%audio-pass%" == "2pass" (
                set passparam=-l 12 -b 4096 -m -r 6 -A tukey^(0.5^) -A partial_tukey^(2^) -A punchout_tukey^(3^)
            )
        )

        "%AvisynthPipePath[1]%" "%mediainputaudio%" - | "%FlacEncPath%" -s -f !passparam! -o "%mediaoutputname%.flac" -

        goto :__end

:__end