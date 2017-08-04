:: Hak Cipta ©2017 oleh neon-nyan / codeneon [codeneon123@gmail.com]
:: Di bawah Hak Cipta MIT License [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

@echo off

set b=include
set stdin=%~1%~2%~3%~4%~5%~6%~7%~8%~9

:setvars
    call %b%\Variable

:CheckCPUArch
    call %b%\Encoder\ArchitectureCheck

:CheckFolderExistency
    if /i not exist "input" md input
    if /i not exist "output" md output
    if /i not exist "hasil" md hasil

REM Setel encode boolean bila parameter +audio-only dan +video-only tidak digunakan
set Encaudioonly=false
set Encvideoonly=false
set Mergeonly=false

:ParamReads
    :DebugStatsConfirm
        if /i "%stdin%" == "+debug" (
            if "%debugStat%" == "[DEBUG] " (
                set isDebug=^R^E^M
                set debugStat=
                echo Debug: Mati
                echo %isDebug%
            ) else (
                set isDebug=e^c^h^o
                set debugStat=[DEBUG] 
                echo Debug: Hidup
                echo %isDebug% %debugStat%
            )
            goto :__end
        ) else (
            set isDebug=^R^E^M
        )

    :ToolsConfirm
        :InstallAvisynthMTConfirm
            if /i "%stdin%" == "+install-avisynth" (
                title=%debugStat%Pasang Avisynth+ MT
                cls
                call %b%\Tools\installAvisynth
                goto :__end
            )

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
        if /i "%stdin%" == "+audio-only" (
            set Encaudioonly=true
        ) else (
            set Encaudioonly=false
        )

        if /i "%stdin%" == "+video-only" (
            set Encvideoonly=true
        ) else (
            set Encvideoonly=false
        )

        if /i "%stdin%" == "+merge-only" (
            set Mergeonly=true
        ) else (
            set Mergeonly=false
        )

:ProcessStart
    :ShowIntro
        cls
        title=%debugStat%Selamat Datang di %progname% %progver%, %username%

    :CleanUpLastTempFile
        call %b%\Cleaner\CleanUp

    :checkAVSandEncode
        call %b%\Avisynth\CheckAvisynth
        call %b%\Encoder\ReorderQuery

:__end
