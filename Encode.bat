:: Hak Cipta ©2017
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

@echo off

set b=include
set stdin=%~1%~2%~3%~4%~5%~6%~7%~8%~9

:setvars
    call %b%\Variable

:CheckComponentExistency
    if /i not exist "input" md input
    if /i not exist "output" md output
    if /i not exist "hasil" md hasil
    if /i not exist "autoscript" md autoscript

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
                echo %debugStat%a1 = %o% ^| a2 = %i%
                if "%i%" LSS "7" (
                    echo %debugStat%Interger Overflow!.
                )

            :ShowMeB*tch
                if "%i%" GEQ "56" (
                    echo Woot Pooot!
                ) else if "%i%" GEQ "64" (
                    echo ^[SUPPER-RARE!!!^] [Censored] said:
                    echo     hooh, malming kesepian
                    echo     pacar diajak jalan ama cowok lain jadinya ya sudah main bot kowakwao
                ) else if "%i%" GEQ "56" (
                    echo kresbayyy said:
                    echo     ngeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeng
                ) else if "%i%" GEQ "48" (
                    echo Tsubame Narumi said:
                    echo     Udah nikah dia
                    echo     sama karakter 2D
                    echo.
                    echo KuroTenshi said:
                    echo     sa ae kang sendal
                ) else if "%i%" GEQ "40" (
                    echo Tsubame Narumi said:
                    echo     Pacar lu 2D aja bangga
                ) else if "%i%" GEQ "32" (
                    echo KuroTenshi said:
                    echo     tapi yah diriku beneran 4thaun lagi nikah kwoakaw
                ) else if "%i%" GEQ "24" (
                    echo neon said:
                    echo     telolet telolet telolet, trrrrttt.....
                ) else if "%i%" GEQ "16" (
                    echo Tsubame Narumi said:
                    echo     Dasar tukang delay
                    echo.
                    echo kresbayyy said:
                    echo     ^< triggered -_-
                ) else if "%i%" GEQ "10" (
                    echo ^[RARE!!!^] I'm just said:
                    echo     You Got This!: http://tinyurl.com/hmmm-cute
                )

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

:ProcessStart
    :CheckComponentIfNotExist
        call %b%\CheckIfComponentNotExist

    :CheckSpecs
        cls
        title=Memeriksa Spesifikasi Komputer...

        for /f "tokens=4 delims=: " %%a in ('systeminfo ^| find "Available Physical Memory"') do (
            for /f "tokens=1,2 delims=." %%a in ('echo %%a') do (
                echo %%a%%b>%temp%\spec.data
            )
        )
        set /p memorymax=<%temp%\spec.data
        del %temp%\spec.data

        call %b%\Encoder\ArchitectureCheck

    :ShowIntro
        cls
        title=%debugStat%Selamat Datang di %progname% %progver%, %username%

    :CleanUpLastTempFile
        call %b%\Cleaner\CleanUp

    :checkAVSandEncode
        call %b%\Avisynth\CheckAvisynth
        call %b%\Encoder\ReorderQuery

:__end