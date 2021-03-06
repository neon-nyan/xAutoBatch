:: Hak Cipta ©2018
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

@echo off

:_jump_drive
    %~d0
    cd "%~dp0"

set b=include
set stdin=%~1%~2%~3%~4%~5%~6%~7%~8%~9

:setvars
    call %b%\Variable

:StartUpCheck
    call %b%\IO\CheckDirectory
    call %b%\IO\SystemTimeLoader

cls
echo %dir.tools.exec.avisynthPlugin.scripts%
echo %thour%:%tmin%:%tsec%
cmd

:ParamReads
    :DebugStatsConfirm
        if /i "%stdin%" == "+debug" (
            set isdebug=true

            if "%isDebug%" == "true" (
                set argDebug=^R^E^M
                set debugStat=
                echo Debug: Mati
                set isDebug=false
            ) else (
                set argDebug=e^c^h^o
                set debugStat=[DEBUG] 
                echo Debug: Hidup
                set isDebug=true
            )

            goto :__end
        )

        if "%isDebug%" == "" set argDebug=^R^E^M

    :ToolsConfirm
        :CalculateAQConfirm
            if /i "%stdin%" == "+calcaq" (
                cls
                call %b%\Tools\CalculateAQ
                goto :__end
            )

        :GenerateParametersConfirm
            if /i "%stdin%" == "+genparam" (
                title=%debugStat%Gen. Parameter
                cls
                call %b%\Tools\GenerateParameters
                goto :__end
            )

        :QualityPreviewConfirm
            if /i "%stdin%" == "+preview" (
                title=%debugStat%Quality Preview
                cls
                call %b%\Tools\QualityPreview
                goto :__end
            )

        :Updater
            if /i "%stdin%" == "+update" (
                title=%debugStat%Updater
                cls
                call %b%\Updater\VersionInspector
                goto :__end
            )

    :EggsConfirm
        if /i "%stdin%" == "+me-in-farland" (
            echo %debugstat% %isDebug%
            set o=0 && set i=0
            :GETRandomInterger
                set /a o=%random% * 5 / 800
                set /a i=%o% / 2

                echo [%o%-%i%] Maaf, lagi ngapain? o_o^)^?

            goto :__end
        )

    :SelectCurrentEncodeConfirm
        :EncodeAudioOnlyConfirm
            if /i "%stdin%" == "+audio-only" (
                if "%isAudioOnly%" == "" (
                    set Encaudioonly=true
                    set isAudioOnly=true
                    echo Audio Encode Only: Hidup
                ) else (
                    set Encaudioonly=false
                    set isAudioOnly=
                    echo Audio Encode Only: Mati
                )
                goto :__end
            ) else (
                if /i not "%isAudioOnly%" == "true" (
                    set Encaudioonly=false
                )
            )

        :EncodeVideoOnlyConfirm
            if /i "%stdin%" == "+video-only" (
                if "%isVideoOnly%" == "" (
                    set Encvideoonly=true
                    set isVideoOnly=true
                    echo Video Encode Only: Hidup
                ) else (
                    set Encvideoonly=false
                    set isVideoOnly=
                    echo Video Encode Only: Mati
                )
                goto :__end
            ) else (
                if /i not "%isVideoOnly%" == "true" (
                    set Encvideoonly=false
                )
            )

        :MergeOnlyConfirm
            if /i "%stdin%" == "+merge-only" (
                if "%isMergeOnly%" == "" (
                    set Mergeonly=true
                    set isMergeOnly=true
                    echo Merge Only: Hidup
                ) else (
                    set Mergeonly=false
                    set isMergeOnly=
                    echo Merge Only: Mati
                )
                goto :__end
            ) else (
                if not "%isMergeOnly%" == "true" (
                    set Mergeonly=false
                )
            )
    
    :DebugConfirm
        :DebugLogConfirm
            if "%isDebug%" == "true" (
                REM Hapus semua output pada command window.
                cls

                REM Buat state Debug == false.
                REM Hal ini mencegah untuk terjadinya Infinite Looping.
                set isDebug=false

                REM Buat Direktori untuk Log.
                if /i not exist "include\Logs" md "include\Logs"

                REM Capture Debug Log.
                encode | "tools\msys\bin\tee" -i "include\Logs\Logs-%username%[%tdate3%%tdate2%%tdate1%][%thour%-%tmin%-%tsec%].txt"

                REM Kembalikan state debug == true.
                REM Setelah itu kembali dan akhiri.
                set isDebug=true
                goto :__end
            )

:ProcessStart
    :CheckComponentIfNotExist
        call %b%\CheckIfComponentNotExist

    :CheckSpecs
        cls
        title=Memeriksa Spesifikasi Komputer...

        :CheckRAMSpace
            cls
            set jump=:RAMSpaceCount && call %b%\IO\SpecLoader
            set memorymax=%output%

        call %b%\Encoder\ArchitectureCheck

    :ShowIntro
        cls
        title=%debugStat%Selamat Datang di %progname% %progver%, %username%

    :CleanUpLastTempFile
        set jump=:CleanLastTempFile && call %b%\Cleaner\CleanUp

    :checkAVSandEncode
        call %b%\Avisynth\CheckAvisynth
        call %b%\Encoder\ReorderQuery

:__end