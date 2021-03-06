:: Hak Cipta ©2018
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

REM Bila ada parameter yang tertimpa atau conflict dengan parameter yang lain,
REM Cukup tambahkan hashtag [#] kedalam set param=[nama parameter]
REM 
REM Contoh:
REM     set param=me#
REM 
REM dan tuliskan juga parameter pada file preset .spf dengan format [nama parameter]#![value]
REM 
REM Contoh:
REM     me#!24
REM 
REM Perubahan ini sudah diterapkan pada file preset versi v1.0 atau di atasnya.

echo [INFO]     Membaca Parameter...

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

    :SETParam_slices
        set param=slices
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
        set param=me#
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_merange
        set param=merange
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

    :SETParam_subme
        set param=subme
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

REM :SETParam_b-bias
REM     set param=b-bias
REM     set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
REM     set jump=:CheckValueInParameters && call %b%\IO\PresetReader\CheckParamAvailibility

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
        
        :CheckCPUThreads
            if /i "%threads%" == "auto" (
                set jump=:CPUThreadsCount && call %b%\IO\SpecLoader
            ) else if "%threads%" == "" (
                set jump=:CPUThreadsCount && call %b%\IO\SpecLoader
            )

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

REM Baca File Preset untuk Parameter Decoder

    :SETParam_resW
        set resW=
        set param=resW
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set resW=%output%

    :SETParam_resH
        set resH=
        set param=resH
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set resH=%output%

    :SETParam_resMethod
        set resF=
        set param=resMethod
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set resF=%output%
        
        :GET_resMethodForEncoder
            if "%resF%" == "" (
                echo    [Warning]: Resizer tidak terdefinisi.
                echo        Akan diatur secara default ke -^> Spline36Resize
                set resF=Spline36Resize
            ) else if /i "%resF%" == "BilinearResize" (
                REM EOF
            ) else if /i "%resF%" == "BicubicResize" (
                REM EOF
            ) else if /i "%resF%" == "PointResize" (
                REM EOF
            ) else if /i "%resF%" == "SincResize" (
                REM EOF
            ) else if /i "%resF%" == "GaussResize" (
                REM EOF
            ) else if /i "%resF%" == "Spline16Resize" (
                REM EOF
            ) else if /i "%resF%" == "Spline36Resize" (
                REM EOF
            ) else if /i "%resF%" == "Spline64Resize" (
                REM EOF
            ) else if /i "%resF%" == "LanczosResize" (
                REM EOF
            ) else if /i "%resF%" == "Lanczos4Resize" (
                REM EOF
            ) else if /i "%resF%" == "BlackmanResize" (
                REM EOF
            ) else (
                echo [WARNING]  Resizer %resF% tidak dikenal.
                echo            Akan diatur secara default ke -^> Spline36Resize
                set resF=Spline36Resize
            )

REM Baca File Preset untuk Parameter Deinterlacer

    :SETParam_interlace
        set param=interlace
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set interlace=%output%
    
    :SETParam_fieldbase
        set param=fieldbase
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set fieldbase=%output%

        :SETDefault_fieldbase
            if "%fieldbase%" == "" (
                %argDebug% %debugStat%  Value field first base untuk de-interlacer tidak disetel. Atur default -^> TFF.
                set fieldbase=TFF
            )
    
    :SETParam_teledebug
        set param=teledebug
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set teledebug=%output%

        :SETDefault_teledebug
            if "%teledebug%" == "" (
                set teledebug=false
            )
    
    :SETParam_teleguide
        set param=teleguide
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set teleguide=%output%

        :SETDefault_teleguide
            if "%teleguide%" == "" (
                %argDebug% %debugStat% Value telecine guide kosong. Atur default -^> 0.
                set teleguide=0
            ) else if "%teleguide%" GTR "3" (
                %argDebug% %debugStat% Nilai maksimum value untuk telecine guide adalah: 0-3. Atur default -^> 0.
                set teleguide=0
            )
    
    :SETParam_televtresh
        set param=televtresh
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set televtresh=%output%

        :SETDefault_televtresh
            set televtreshtemp=
            if "%televtresh%" == "" (
                %argDebug% %debugStat% Value dari telecine vtresh kosong. Atur default -^> 72.
                set televtresh=72
            ) else (
                echo %televtresh% | find "." > nul
                if "%errorlevel%" == "1" (
                    for /f "tokens=1,2 delims=." %%a in ('echo %televtresh%') do (
                        echo %%a>%data.cache.telecine%
                    )
                    set /p televtreshtemp=<%data.cache.telecine%
                    del %data.cache.telecine%
                ) else (
                    set televtreshtemp=%televtresh%
                )

                :CheckMaxValue_televtresh
                    if "%televtreshtemp%" GTR "255" (
                        %argDebug% %debugStat% Value maksimum dari telecine vtresh adalah: 0.0-255. Atur default -^> 72.
                        set televtresh=72
                    )
            )
    
    :SETParam_teleblend
        set param=teleblend
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set teleblend=%output%

        :SETDefault_teleblend
            if "%teleblend%" == "" (
                %argDebug% %debugStat% Value telecine interpolate blend kosong. Atur default -^> true.
                set teleblend=true
            )

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

REM :SETParam_vdrecovery
REM     set param=vdrecovery
REM     set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
REM     set vdrecovery=%output%

REM Baca beberapa option untuk encoder.
REM :SETParam_InputType
REM     set param=ext
REM     set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
REM     set inputext=%output%
    
    :SETParam_input-source
        set param=input-source
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set input-source=%output%

    :SETParam_input-zone
        set param=input-zone
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set input-zone=%output%

        type "%input-zone%"

    :SETParam_input-trim
        set param=input-trim
        set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
        set input-trim=%output%
        
        :Write_input-props
            echo %input-zone%>"%data.cache.zone%"
            echo %input-trim%>"%data.cache.trim%"

    :SETParams_Decoders
        REM Check parameter video source.
        :SETParam_vsource
            set param=vsource
            set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
            set vsource=%output%

            :SETDefault_VideoDecodeSource
                if "%vsource%" == "" (
                    %argDebug% %debugStat% Plugin video source tidak di definisikan. Atur default -^> 1 [FFVideoSource].
                    set vsource=1
                ) else if "%vsource%" GTR "2" (
                    %argDebug% %debugStat% Plugin Source tidak diketahui.
                    %argDebug%      1 == FFVideoSource
                    %argDebug%      2 == LWLibavVideoSource
                    %argDebug%      Atur default -^> 1 [FFVideoSource].
                    set vsource=1
                )

        REM Check parameter audio source.
        :SETParam_asource
            set param=asource
            set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader
            set asource=%output%

            :SETDefault_AudioDecodeSource
                if "%asource%" == "" (
                    echo [WARNING]  Plugin audio source tidak di definisikan.
                    echo            Atur default -^> 2 [LWLibavAudioSource].
                    set asource=2
                ) else if "%asource%" GTR "2" (
                    echo [WARNING]  Plugin Source tidak diketahui.
                    echo                  1 == FFAudioSource [Experimental]
                    echo                  2 == LWLibavAudioSource
                    echo                  Atur default -^> 2 [LWLibavAudioSource].
                    set asource=2
                )

REM Baca data pembagian pengubahan CRF pada setiap frame dalam bentuk table. [Zones]

    :GETZoneDataStackName
        set /p zonadd=<"%data.cache.zone%"

        if /i not exist "%zonadd%" (
            echo [INFO]     Zone data untuk file "%zonadd%" belum dibuat atau tidak ada.
            echo            Maka media akan diproses tanpa melakukan Zone Processing.
            echo            Tolong letakkan file .szf didalam input dengan
            echo            nama yang sama dengan media video atau "Buat Baru".
        ) else (
            echo Membaca Zone Data Stack...

            :SETQuery_zonesChange
                set jump=:TableReader && call %b%\IO\PresetReader\LegacyReader
        )

REM Baca data Trim pada file .trm

    :GETTrimDataStackName
        set /p trimadd=<"%data.cache.trim%"

        if /i exist "%trimadd%" (
            echo [INFO]     Media akan diproses dengan Trimming. Pastikan bila satuan frame
            echo            sudah benar dan tidak ada frame yang tertinggal maupun terpotong.

            :SETQuery_TrimData
                set jump=:TrimReader && call %b%\IO\PresetReader\LegacyReader
        )

:__end
    set zonaddtemp=
    set output=