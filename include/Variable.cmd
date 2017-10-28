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

REM Variable prefix direktori
    set dir=%~dp0
        set dir.tools=%dir%\..\tools
            set dir.tools.exec=%dir.tools%\_exec
                set dir.tools.exec.avisynthPlugin=%dir.tools.exec%\_avsplugins
                    set dir.tools.exec.avisynthPlugin.docs=%dir.tools.exec.avisynthPlugin%\_docs
                    set dir.tools.exec.avisynthPlugin.scripts=%dir.tools.exec.avisynthPlugin%\_scripts
                set dir.tools.exec.msys=%dir.tools.exec%\_msys
                    set dir.tools.exec.msys.bin=%dir.tools.exec.msys%\bin
        set dir.Temp=%temp%\%progname%_Temp
            set dir.Temp.script=%dir.Temp%\_Script
                set dir.Temp.script.autoload=%dir.Temp.script%\_autoload
                set dir.Temp.script.input=%dir.Temp.script%\_input
            set dir.Temp.data=%dir.Temp%\_Data
            set dir.Temp.update=%dir.Temp%\_Update

REM Variable Prefix nama file temporari.
    :data.cache
        set data.cache.scripttemp=%dir.scriptTemp.autoload%\ScriptTemp.avsi
        set data.cache.zone=%dir.Temp.data%\lastZoneAddress.data
        set data.cache.trim=%dir.Temp.data%\lastTrimAddress.data
        set data.cache.stack.table=%dir.Temp.data%\lastStackTable.data
        set data.cache.stack.trim=%dir.Temp.data%\lastStackTrim.data
        set data.cache.specdata=%dir.Temp.data%\SpecData.data
        :data.cache.time
            set data.cache.time.hour=%dir.Temp.data%\lastHour.data
            set data.cache.time.min=%dir.Temp.data%\lastMin.data
            set data.cache.time.sec=%dir.Temp.data%\lastSec.data
            set data.cache.time.msec=%dir.Temp.data%\lastMSec.data
        :data.cache.date
            set data.cache.date.stack1=%dir.Temp.data%\lastStack1.data
            set data.cache.date.stack2=%dir.Temp.data%\lastStack2.data
            set data.cache.date.stack3=%dir.Temp.data%\lastStack3.data
        set data.script.calculate=%dir.Temp.data%\calc.vbs

REM Variable Prefix path file.
    :file
        :file.script.improver
            set file.script.improver.includer=%dir.tools.exec.avisynthPlugin.scripts%\Video Improver v20170908_0_PlugImporter.avsi
            set file.script.improver.1pass=%dir.tools.exec.avisynthPlugin.scripts%\Video Improver v20170908_0_1Pass.avsi
            set file.script.improver.2pass=%dir.tools.exec.avisynthPlugin.scripts%\Video Improver v20170908_0_2Pass.avsi
        :file.exec
            :file.exec.encoder.video
                set file.exec.encoder.video.x264.8bit=%dir.tools.exec%\x264_8.exe
                set file.exec.encoder.video.x264.10bit=%dir.tools.exec%\x264_10.exe
            :file.exec.encoder.audio
                set file.exec.encoder.audio.opus=%dir.tools.exec%\opusenc.exe
                set file.exec.encoder.audio.aac=%dir.tools.exec%\neroAacEnc.exe
                set file.exec.encoder.audio.vorbis=%dir.tools.exec%\oggenc.exe
                set file.exec.encoder.audio.flac=%dir.tools.exec%\flac.exe
            set file.exec.muxer=%dir.tools.exec%\mkvmerge.exe
            set file.exec.msys.tee=%dir.tools.exec.msys.bin%\tee.exe
            set file.exec.msys.wget=%dir.tools.exec.msys.bin%\wget.exe
            set file.exec.msys.unzip=%dir.tools.exec.msys.bin%\unzip.exe
            set file.exec.avs.preview=%dir.tools.exec.avisynthPlugin%\ffplay.exe
            set file.exec.avs.pipe.video=%dir.tools.exec%\avs2yuv.exe
            set file.exec.avs.pipe.audio=%dir.tools.exec%\wavi.exe
            set file.exec.info=clinfo.exe

REM Variable Prefix untuk properti yang lain.
    set props.encode.video.mode=AvisynthOnlyDecoder
    set props.style.header.style1=-------------------------------------------------------------------------------
    set props.style.header.style2=+-----------------------------------------------------------------------------+
    set props.style.header.style3=###############################################################################