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
    if /I "%audio-codec%" == "lc-aac" (
        set acodecext=m4a && set AudioCodecSelect=:ProcessAACAudioCodec
    ) else if /I "%audio-codec%" == "he-aac" (
        set acodecext=m4a && set AudioCodecSelect=:ProcessAACAudioCodec
    ) else if /I "%audio-codec%" == "he-aacv2" (
        set acodecext=m4a && set AudioCodecSelect=:ProcessAACAudioCodec
    ) else if /I "%audio-codec%" == "vorbis" (
        set acodecext=ogg && set AudioCodecSelect=:ProcessVorbisAudioCodec
    ) else if /I "%audio-codec%" == "flac" (
        set acodecext=flac && set AudioCodecSelect=:ProcessFlacAudioCodec
    ) else if /I "%audio-codec%" == "opus" (
        set acodecext=opus && set AudioCodecSelect=:ProcessOpusAudioCodec
    ) else (
        echo lc-aac he-aac he-aacv2 opus vorbis flac | find /I "%audio-codec%" > nul || set acodec=unknown
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

    %argDebug% %debugStat%SELECTED_CODEC   : %audio-codec%
    %argDebug% %debugStat%FILE_EXT         : %acodecext%
    %argDebug% %debugStat%JUMP_DESTINATION : %AudioCodecSelect%

    goto :__end

:__end

    set jump=
    set nextjump=
    set acodec=