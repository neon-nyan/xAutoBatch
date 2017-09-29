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

:GETAudioCodecName
    if /i "%audio-codec%" == "lc-aac" (
        set acodec=%audio-codec%
        set acodecext=m4a
    ) else if /i "%audio-codec%" == "he-aac" (
        set acodec=%audio-codec%
        set acodecext=m4a
    ) else if /i "%audio-codec%" == "he-aacv2" (
        set acodec=%audio-codec%
        set acodecext=m4a
    ) else if /i "%audio-codec%" == "vorbis" (
        set acodec=%audio-codec%
        set acodecext=ogg
    ) else if /i "%audio-codec%" == "flac" (
        set acodec=%audio-codec%
        set acodecext=flac
    ) else if /i "%audio-codec%" == "opus" (
        set acodec=%audio-codec%
        set acodecext=opus
    ) else (
        set acodec=unknown
    )

    goto :__end

:ERRORCodecNotAvailable
    echo [WARNING]  Nama Codec: %audio-codec% tidak diketahui.
    echo                value: [lc-aac,he-aac,he-aacv2,vorbis,flac,opus]
    echo            Codec akan disetel secara default ke -^> opus.
    echo            Silahkan periksa kembali value parameter "audio-codec" pada file
    echo            preset media.

    REM Setel Audio Codec default
    :SETAudioCodecDefault
        set audio-codec=opus
        set acodecext=opus
        set nextjump=:ProcessOpusAudioCodec

    goto :__end

:__end
    set jump=
    set nextjump=
    set acodec=