:: Hak Cipta ©2018
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:ProcessMedia
    set i=0

    for /r %%d in (input\*.spf) do (
        setlocal EnableDelayedExpansion
        set /a i=!i!+1

        :GETCurrentJobName
            cls
            title=%debugStat%File ke !i! - Mempersiapkan Job Query...
            echo [INFO]     Memulai Job Query untuk %%~nd...
            echo            Pada waktu: %time% ^| %date%
            echo %tpdnt1%

        :ProcessMediaGETVar
            set input=%%d
            set mediainput=%%~dpnd.avs
            set mediainputname=%%~dpnd
            set mediainputaudio=%%~dpnd.audio.avs
            set mediaoutput=output\%%~nd.mkv
            set mediaoutputname=output\%%~nd
            set mediaoutputnamebase=%%~nd

        :GETPresetData
            :CheckZoneDataAvailibility
                echo !mediainputname!.csv>"%zoneaddfile%"
                echo !mediainputname!.trm>"%trimaddfile%"
                call %b%\Encoder\LoadQuery
                del "%zoneaddfile%"
            
            :GETSourceAddress
            set mediainputsource=%%~dpnd!inputext!
        
        :ProcessMediaStart
            :ShowCurrentParameter
                %argDebug% %tpdnt2%
                %argDebug% ^| Parameter saat ini yang digunakan pada Job.                                 ^|
                %argDebug% %tpdnt2%
                %argDebug%      !parameters! !tabout!
                %argDebug%.

            :CreateAvisynthFile
                call %b%\Avisynth\MergeAutoscripts
                call %b%\Avisynth\BuildAvsFile

            :WAIT_CLEAR
                echo ---- Selesai! ----
                timeout /t 2 /nobreak > nul
                cls

            :StartVideoProcess
                if "%Mergeonly%" == "true" (
                    REM EOF
                ) else if not "%Encaudioonly%" == "true" (
                    :GETCurrentJobNameWithDetails
                        if "!resW!!resH!" == "" (
                            title=%debugStat%File ke !i! - Memproses %%~nd
                            echo [INFO]     Memulai Job...
                            echo %tpdnt1%
                        ) else (
                            title=%debugStat%File ke !i! - Memproses %%~nd ^| !resW!x!resH!p
                            echo [INFO]     Memulai Job dengan Resolusi Output: !resW!x!resH!p...
                            echo %tpdnt1%
                        )

                        if /i "%VideoEncodeMode%" == "FFmpegDecoderNoExit" (
                            set debStat=!debStat! %frame%
                            %debugStat% echo !debstat!
                        ) else set debStat=!debStat!

                        set jump=:%VideoEncodeMode% && call %b%\Encoder\Video\VideoEncoder
                )

            :StartAudioProcess
                set jump=:GETAudioCodecName && call %b%\Encoder\Audio\CheckAudioCodec
                
                if "%Mergeonly%" == "true" (
                    REM EOF
                ) else if not "%Encvideoonly%" == "true" (
                    if /i "%acodec%" == "unknown" (
                        set jump=:ERRORCodecNotAvailable && call %b%\Encoder\Audio\CheckAudioCodec
                    )

                    title=%debugStat%File ke !i! - Memproses %%~nd ^| Codec Audio: !audio-codec! - !audio-bitrate!kbp/s:!audio-resample!Hz [!audio-pass!]
                    set jump=:StartCheckAudioCodecName && call %b%\Encoder\Audio\AudioEncoder
                )

            :StartMergeProcess
                if not "%Mergeonly%" == "true" (
                    if "%Encvideoonly%" == "true" (
                        REM EOF
                    ) else if "%Encaudioonly%" == "true" (
                        REM EOF
                    ) else (
                        title=%debugStat%File ke !i! - Menyatukan %%~nd...
                        call %b%\Encoder\Mixer\MergeAll
                    )
                ) else (
                    title=%debugStat%File ke !i! - Menyatukan %%~nd...
                    call %b%\Encoder\Mixer\MergeAll
                )

            :DoCleanUp
                call %b%\Cleaner\CleanUp

        :__endMedia
            set input=
            set mediainput=
            set mediaoutput=
            set mediaoutputname=
            set mediaoutputnamebase=

        endlocal
    )

    if /i exist "%scripttempname%" del "%scripttempname%"
    if /i exist "%zoneaddfile%" del "%zoneaddfile%"
    if /i exist "%trimaddfile%" del "%trimaddfile%"
    if /i exist "%tabledata%" del "%tabledata%"
    if /i exist "%trimdata%" del "%trimdata%"