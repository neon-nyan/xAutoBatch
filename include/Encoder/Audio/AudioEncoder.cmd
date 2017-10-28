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

:StartJumpAudioCodecDestination
    goto %AudioCodecSelect%

:ProcessAudioCodec
    :ProcessAACAudioCodec
        if exist "%mediaoutputname%.wav" (
            del "%mediaoutputname%.wav"
        )

        echo [INFO]     Sedang memproses...
        echo            %mediainput% -^> %mediaoutputname%.m4a
        echo            --------------------------------------------------
        echo            mode: %audio-codec%
        echo.

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
                )

            echo [WARNING]  Bitrate belum dimasukkan atau parameter belum ditentukan.
            echo            Proses akan dilakukan dengan bitrate default !audio-bitrate!kbp/s.
        )

        :DoAACMethodForEachPass
        if /I "%audio-pass%" == "2pass" (
            "%file.exec.avs.pipe.audio%" "%mediainputaudio%" "%mediaoutputname%.wav" && "%file.exec.encoder.audio.aac%" -br !audio-bitrate!000 -2pass -!aac-codec! -ignorelength -if "%mediaoutputname%.wav" -of "%mediaoutputname%.m4a" || set progpath=%file.exec.encoder.audio.aac% && goto :__error

            del "%mediaoutputname%.wav"
        ) else if /I "%audio-pass%" == "1pass" (
            "%file.exec.avs.pipe.audio%" "%mediainputaudio%" - | "%file.exec.encoder.audio.aac%" -br !audio-bitrate!000 -!aac-codec! -ignorelength -if - -of "%mediaoutputname%.m4a" || set progpath=%file.exec.encoder.audio.aac% && goto :__error
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

            "%file.exec.avs.pipe.audio%" "%mediainputaudio%" "%mediaoutputname%.wav" && "%file.exec.encoder.audio.aac%" -br !audio-bitrate!000 -2pass -!aac-codec! -ignorelength -if "%mediaoutputname%.wav" -of "%mediaoutputname%.m4a" || set progpath=%file.exec.encoder.audio.aac% && goto :__error

            del "%mediaoutputname%.wav"
        )

        goto :__end

    :ProcessOpusAudioCodec
        echo [INFO]     Sedang memproses...
        echo            %mediainput% -^> %mediaoutputname%.opus
        echo.

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

        "%file.exec.avs.pipe.audio%" "%mediainputaudio%" - | "%file.exec.encoder.audio.opus%" --bitrate !audio-bitrate! --vbr !passparam! - "%mediaoutputname%.opus" || set progpath=%file.exec.encoder.audio.opus% && goto :__error

        goto :__end

    :ProcessVorbisAudioCodec
        echo [INFO]     Sedang memproses...
        echo            %mediainput% -^> %mediaoutputname%.ogg
        echo.

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

        "%file.exec.avs.pipe.audio%" "%mediainputaudio%" - | "%file.exec.encoder.audio.vorbis%" -ignore_length -q10 -b!audio-bitrate! !passparam! - "%mediaoutputname%.ogg" || set progpath=%file.exec.encoder.audio.vorbis% && goto :__error

        goto :__end

    :ProcessFlacAudioCodec
        echo [INFO]     Sedang memproses...
        echo            %mediainput% -^> %mediaoutputname%.flac
        echo.

        if "%audio-pass%" == "" (
            set passparam=-l 6 -b 4096 -r 4
        ) else (
            if /I "%audio-pass%" == "1pass" (
                set passparam=-l 6 -b 4096 -r 4
            ) else if /I "%audio-pass%" == "2pass" (
                set passparam=-l 12 -b 4096 -m -r 6 -A tukey^(0.5^) -A partial_tukey^(2^) -A punchout_tukey^(3^)
            )
        )

        "%file.exec.avs.pipe.audio%" "%mediainputaudio%" - | "%file.exec.encoder.audio.flac%" -s -f !passparam! -o "%mediaoutputname%.flac" - || set progpath=%file.exec.encoder.audio.flac% && goto :__error

        goto :__end

:__error
    echo [ERROR]    Terjadi kesalahan dalam proses encoding.
    echo            Code            : !errorlevel!
    echo            Program Path    : !progpath!

:__end