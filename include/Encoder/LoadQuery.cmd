:: Hak Cipta ©2017
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

REM Semua Prefix value dari parameter dapat dipisah atau dibedakan dengan simbol:
REM     ^ # @ \ /
REM bila ada parameter yang mempunyai nama yang sama dengan syntax yang dimaksud
REM agar tidak terjadi conflict pada masing-masing parameter.
REM
REM contoh:
REM    me -> bfra"me"s
REM    me -> sub"me"
REM    me -> "me"range
REM
REM Maka tulis parameter dengan nama:
REM    me^^
REM    bframes.
REM    subme#
REM    merange@
REM
REM Tulis parameter diatas pada query seperti: "set param=[namaparameter]"
REM dan tulis parameter beserta value dalam file preset .spf seperti:
REM "[namaparameter]![value/string/interger/boolean]"
REM
REM contoh:
REM    Pada Query:
REM        set param=subme^^
REM        set param=me@
REM
REM    Pada file Preset .spf
REM        subme^^!9
REM        me@!umh
REM 
REM Berikut ini adalah 2 parameter yang harus ada dalam file preset:
REM    open-gop
REM    weightb
REM    8x8dct // Dibaca dan diatur secara default oleh encoder.
REM dikarenakan masalah bug pada saat overwrite untuk parameter non value
REM "Parameter yang tidak mempunyai value" yang menyebabkan data variable
REM tidak disetel ulang/di-reset.

echo Membaca Parameter...

REM Baca File Preset
:SETParams
    :SETParam_profile
        set param=profile
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set profile=%output%
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_scenecut
        set param=scenecut
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_aq-mode
        set param=aq-mode
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_aq-strength
        set param=aq-strength
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_qcomp
        set param=qcomp
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_chroma-qp-offset
        set param=chroma-qp-offset
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_frame-packing
        set param=frame-packing
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_pulldown
        set param=pulldown
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_open-gop
        set param=open-gop
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:NoCheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_keyint
        set param=keyint
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_partitions
        set param=partitions
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_direct
        set param=direct
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_weightp
        set param=weightp
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_me
        set param=me^^
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_merange
        set param=merange^^
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_subme
        set param=subme@
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_psy-rd
        set param=psy-rd
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_trellis
        set param=trellis
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_cqm
        set param=cqm
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_b-adapt
        set param=b-adapt
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_b-pyramid
        set param=b-pyramid
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_weightb
        set param=weightb
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:NoCheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_stats
        set param=stats
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_qpstep
        set param=qpstep
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_crf
        set param=crf
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility
        set defaultCRF=%output%

    :SETParam_bframes
        set param=bframes
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_ref
        set param=ref
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_qpmin
        set param=qpmin
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_qpmax
        set param=qpmax
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_vbv-bufsize
        set param=vbv-bufsize
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_vbv-maxrate
        set param=vbv-maxrate
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_deblock
        set param=deblock
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_videoformat
        set param=videoformat
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_colorprim
        set param=colorprim
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_transfer
        set param=transfer
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_colormatrix
        set param=colormatrix
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_log-level
        set param=log-level
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_threads
        set param=threads
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility
        set threads=%output%

    :SETParam_decoder-log-level
        set param=decoder-log-level
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set debStat=%output%


REM Parameter Mod

    :SETParam_aq2-strength
        set param=aq2-strength
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_aq2-sensitivity
        set param=aq2-sensitivity
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_aq3-mode
        set param=aq3-mode
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_aq3-strength
        set param=aq3-strength
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_aq3-sensitivity
        set param=aq3-sensitivity
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

REM Parameter Codec Audio

    :SETParam_audio-codec
        set param=audio-codec
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set audio-codec=%output%

    :SETParam_audio-bitrate
        set param=audio-bitrate
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set audio-bitrate=%output%

    :SETParam_audio-pass
        set param=audio-pass
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set audio-pass=%output%

    :SETParam_audio-resample
        set param=audio-resample
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set audio-resample=%output%

        REM Check bila value dari audio-resample == null/kosong
        :Check_audio-resample_def
            if "%audio-resample%" == "" set audio-resample=44100

REM Baca File Preset untuk Parameter Decoder

    :SETParam_resW
        set param=resW
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set resW=%output%

    :SETParam_resH
        set param=resH
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set resH=%output%

    :SETParam_resMethod
        set param=resMethod
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set resF=%output%

REM Baca File Preset untuk Parameter Deinterlacer

    :SETParam_interlace
        set param=interlace
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set interlace=%output%

REM Baca File Preset untuk Parameter Framerate Changer

    :SETParam_assumefps
        set param=assumefps
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set assumefps=%output%

    :SETParam_syncaudioassume
        set param=syncaudioassume
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set syncaudioassume=%output%

    :SETParam_changefps
        set param=changefps
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set changefps=%output%

    :SETParam_linearchange
        set param=linearchange
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set linearchange=%output%

REM Baca File Preset untuk Parameter fitur Audio Sync pada file source

    :SETParam_audiosync
        set param=audiosync
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set audiosync=%output%

REM Baca File Preset untuk Parameter apakah source menggunakan autoscript atau tidak

    :SETParam_filter
        set param=filter
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set filter=%output%

    :SETParam_vidimpv
        set param=vidimpv
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set vidimpv=%output%

    :SETParam_vdfilterpass
        set param=vdfilterpass
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set vdfilterpass=%output%

REM Baca data pembagian pengubahan CRF pada setiap frame dalam bentuk table. [Zones]

    :GETZoneDataStackName
        set /p zonadd= < "%zoneaddfile%"

        if /i not exist "%zonadd%" (
            echo.
            echo Zone data untuk file "%zonadd%" belum dibuat atau tidak ada. Maka media akan diproses tanpa melakukan Zone Processing.
            echo.
            echo Tolong letakkan file .szf didalam input dengan nama yang sama dengan media video atau "Buat Baru".
            echo.
        ) else (
            echo Membaca Zone Data Stack...

            :SETQuery_zonesChange
                set jump=:TableReader && call %b%\IO\PresetReader\LegacyReader

            :SETParam_all
                set /p tab= < "%tabledata%"
                del "%tabledata%"
                set parameters=%parameters% %tab%
        )

REM Baca beberapa option untuk encoder.
    :SETParam_InputType
        set param=ext
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set inputext=%output%

REM Baca data Trim pada file .trm
    
    :GETTrimDataStackName
        set /p trimadd= < "%trimaddfile%"

        if /i exist "%trimadd%" (
            echo Membaca Data Trimming...
            echo.
            echo Media akan diproses dengan Trimming. Pastikan bila satuan frame sudah benar dan tidak ada frame yang tertinggal maupun terpotong.
            echo.

            :SETQuery_TrimData
                set jump=:TrimReader && call %b%\IO\PresetReader\LegacyReader
        )

echo Selesai! && echo.

:__end
    set zonaddtemp=
    set output=