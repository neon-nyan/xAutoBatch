:: Hak Cipta ©2017
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:ProcessMedia
(
    set i=0

    for /r %%d in (input\*.spf) do (
        setlocal EnableDelayedExpansion
        set /a i=!i!+1

        :GETCurrentJobName
            cls
            title=%debugStat%File ke !i! - Mempersiapkan Job Query...
            echo Memulai Job Query untuk %%~nd...
            echo.

        :ProcessMediaGETVar
            set input=%%d
            set mediainput=%%~dpnd.avs
            set mediaoutput=output\%%~nd.mkv
            set mediaoutputname=output\%%~nd
            set mediaoutputnamebase=%%~nd

        :GETZoneDataStack
            :CheckZoneDataAvailibility
                echo %%~dpnd.szf > "%zoneaddfile%"
                echo %%~dpnd.trm > "%trimaddfile%"
                call %b%\Encoder\LoadQuery
                del "%zoneaddfile%"

        :ProcessMediaStart && (
            :ShowCurrentParameter && (
                echo %tpdnt2%
                echo ^| Parameter saat ini yang digunakan pada Job.                                 ^|
                echo %tpdnt2%
                echo !parameters!
                echo.
            )

            call %b%\Avisynth\MergeAutoscripts
            call %b%\Avisynth\BuildAvsFile

            :StartVideoProcess
                if "%Mergeonly%" == "true" (
                    REM EOF
                ) else if not "%Encaudioonly%" == "true" (
                    :GETCurrentJobNameWithDetails
                        title=%debugStat%File ke !i! - Memproses %%~nd ^| !resW!x!resH!p
                        echo Memulai Job dengan Resolusi Output: !resW!x!resH!p...
                        echo.

                        if /i "%VideoEncodeMode%" == "FFmpegDecoderNoExit" (
                            set debStat=!debStat! %frame%
                            %debugStat% echo !debstat!
                        ) else set debStat=!debStat!

                        set jump=:%VideoEncodeMode% && call %b%\Encoder\Video\VideoEncoder
                )

            :StartAudioProcess
                if "%Mergeonly%" == "true" (
                    REM EOF
                ) else if not "%Encvideoonly%" == "true" (
                    :GETCurrentJobNameForCurrentAudioCodec
                        set jump=:GETAudioCodecName && call %b%\Encoder\Audio\CheckAudioCodec
                        if /i "%acodec%" == "unknown" (
                            set jump=:ERRORCodecNotAvailable && call %b%\Encoder\Audio\CheckAudioCodec
                        ) else (
                            title=%debugStat%File ke !i! - Memproses %%~nd ^| Codec Audio: !audio-codec! - !audio-bitrate!kbp/s:!audio-resample!Hz [!audio-pass!]

                            set jump=:StartCheckAudioCodecName && call %b%\Encoder\Audio\AudioEncoder
                        )
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
        )

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
    del input\*.avs
)