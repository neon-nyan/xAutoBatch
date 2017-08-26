:: Hak Cipta ©2017
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

REM Informasi dasar/assembly record tentang program
    set progname=xAutoBatch
    set ver=123
    set rev=0
    set codename=nope!
    set progver=v%ver%.r%rev% ["%codename%"]

REM Variable Prefix untuk Avisynth Merger.
    REM asdir   : Direktori untuk plugin source.
    REM avsplug : Direktori untuk plugin umum.
    set asdir=..\tools\decoder\ffmpeg\
    set avsplug=..\tools\avsplugin\
    set AvisynthLibrary=tools\decoder\avs2pipe\AviSynth.dll
    set downtempdir=include\Updater\DownTemp

REM Variable Prefix untuk cache data.
    set scripttempname=%temp%\%progname%ScriptTemp.avsi
    set zoneaddfile=%temp%\ZoneAddress.data
    set trimaddfile=%temp%\TrimAddress.data
    set tabledata=%temp%\StackTable.data
    set trimdata=%temp%\StackTrim.data

REM Variable Prefix untuk letak autoscript Video Improver.
    set improverInc=tools\avsplugin\script\Video improver v20170710_0 Plug-in Importer.avsi
    set improver1pass=tools\avsplugin\script\Video improver v20170710_0 1pass.avsi
    set improver2pass=tools\avsplugin\script\Video improver v20170710_0 2pass.avsi'

REM Variable Prefix untuk mode encode pada video.
    set VideoEncodeMode=AvisynthOnlyDecoder

REM Variable Prefix untuk Program yang dibutuhkan.
    set DecoderPath=tools\decoder\ffmpeg\ffmpeg.exe
    set EncoderPath=tools\encoder\x264\10bit\x264.exe
    set Encoder10Path=tools\encoder\x264\10bit\x264.exe
    set Encoder8Path=tools\encoder\x264\8bit\x264.exe
    set PipeTeePath=tools\msys\bin\tee.exe
    set PreviewerPath=tools\decoder\ffmpeg\ffplay.exe
    set AvisynthPipePath=tools\decoder\avs2pipe\avs2pipemod.exe
    set MergerPath=tools\muxer\mkvmerge\mkvmerge.exe
    set wgetPath=tools\msys\bin\wget.exe
    set unzipPath=tools\msys\bin\unzip.exe

REM Variable Prefix untuk Program Encoder Audio.
    REM Codec Opus
        set OpusEncPath=tools\encoder\opus\opusenc.exe

    REM Codec AAC
        set AACEncPath=tools\encoder\neroaac\neroAacEnc.exe

    REM Codec Vorbis
        set VorbEncPath=tools\encoder\vorbis\venc64.exe

    REM Codec Flac
        set FlacEncPath=tools\encoder\flac\flac.exe

REM Tentukan template untuk text
    set tpdnt1=-------------------------------------------------------------------------------
    set tpdnt2=+-----------------------------------------------------------------------------+
    set tpdnt3=###############################################################################