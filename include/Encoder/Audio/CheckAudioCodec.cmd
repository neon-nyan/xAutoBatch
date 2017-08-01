:: Hak Cipta ©2017 oleh neon-nyan / codeneon [codeneon123@gmail.com]
:: Di bawah Hak Cipta MIT License [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:__jumper
    if "%jump%" == "" (
        msg * Sertakan label terlebih dahulu!
        msg * Dan gunakan Classes ini dengan program Encodernya.
        msg * ^(/^^_^^^)/ Makasih! \^(^^_^^\^) ^<-----------^> Oleh: codeneon
        exit
    ) else (
        goto %jump%
    )

:GETAudioCodecName
    if /i "%audio-codec%" == "he-aac" (
        set acodec=%audio-codec%
        set acodecext=m4a
        set nextjump=:ProcessHEAACAudioCodec
    ) else if /i "%audio-codec%" == "he-aacv2" (
        set acodec=%audio-codec%
        set acodecext=m4a
        set nextjump=:ProcessHEAACv2AudioCodec
    ) else if /i "%audio-codec%" == "vorbis" (
        set acodec=%audio-codec%
        set acodecext=ogg
        set nextjump=:ProcessVorbisAudioCodec
    ) else if /i "%audio-codec%" == "flac" (
        set acodec=%audio-codec%
        set acodecext=flac
        set nextjump=:ProcessFlacAudioCodec
    ) else if /i "%audio-codec%" == "opus" (
        set acodec=%audio-codec%
        set acodecext=opus
        set nextjump=:ProcessOpusAudioCodec
    ) else (
        set acodec=unknown
    )

    goto :__end

:ERRORCodecNotAvailable
    echo.
    echo Nama Codec: %audio-codec% tidak diketahui.
    echo Codec Audio yang tersedia adalah: he-aac, he-aacv2, vorbis, flac, dan opus.
    echo Silahkan periksa kembali value parameter "audio-codec" pada file preset media.
    echo.

    REM Setel Audio Codec default
    set audio-codec=opus

    goto :__end

:__end
    set jump=
    set nextjump=
    set acodec=