:: Hak Cipta ©2017 oleh neon-nyan / codeneon [codeneon123@gmail.com]
:: Di bawah Hak Cipta MIT License [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

REM Informasi dasar/assembly record tentang program
    set progname=xAutoBatch
    set majver=1
    set minver=6
    set revver=6
    set codename=Upstream'sNeon
    set progver=v%majver%.%minver%.%revver% ["%codename%"]

REM Variable Prefix untuk Avisynth Merger.
    set asdir=..\tools\decoder\ffmpeg\
    set scripttempname=%temp%\x264AutoScriptTemp.avsi
	set zoneaddfile=%temp%\ZoneAddress.data
	set trimaddfile=%temp%\TrimAddress.data
	set tabledata=%temp%\StackTable.data
	set trimdata=%temp%\StackTrim.data
	set improverInc=tools\avsplugin\script\Video improver v20170710_0 Plug-in Importer.avsi
	set improver1pass=tools\avsplugin\script\Video improver v20170710_0 1pass.avsi
	set improver2pass=tools\avsplugin\script\Video improver v20170710_0 2pass.avsi
    set VideoEncodeMode=AvisynthOnlyDecoder

REM Variable Prefix untuk Program Encoder/Decoder Dasar.
    set DecoderPath=tools\decoder\ffmpeg\ffmpeg
    set EncoderPath=tools\encoder\x264\10bit\x264
    set Encoder10Path=tools\encoder\x264\10bit\x264
    set Encoder8Path=tools\encoder\x264\8bit\x264
    set PipeTeePath=tools\msys\bin\tee
    set PreviewerPath=tools\decoder\ffmpeg\ffplay
    set MergerPath=tools\muxer\mkvmerge\mkvmerge

REM Variable Prefix untuk Program Encoder Audio.
    REM Codec Opus
        set OpusEncPath=tools\encoder\opus\opusenc

    REM Codec AAC
        set AACEncPath=tools\encoder\neroaac\neroAacEnc

    REM Codec Vorbis
        set VorbEncPath=tools\encoder\vorbis\venc64

    REM Codec FLAC
        set FLACEncPath=tools\encoder\flac\neroAacEnc