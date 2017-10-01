:: Hak Cipta ©2017
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:__jumper
    if "%jump%" == "" (
        msg * Sertakan label terlebih dahulu!
        msg * Dan gunakan Classes ini dengan program Encodernya.
        msg * ^(/^^_^^^)/ Makasih! \^(^^_^^\^) ^<-----------^> Oleh: codeneon
        exit
    ) else (
        goto %jump%
    )

:ValueReader
    set output=

    for /f "tokens=2 delims=!" %%a in ('type "%input%" ^| find "%param%!"') do (
        set output=%%a
        for /f "tokens=1 delims=#" %%a in ('echo %param%') do (
            if "%param%" == "%%a#" set param=%%a
        )
    )

    :end
        goto :__end

:TableReader
    :LegacyTableReader
        :countInputLegacyStacks
            :CheckColumnHeader
                :CheckColumn1
                    type "%zonadd%" | find /I "StartFrame" > nul || (
                        echo [ERROR]    Header untuk Kolom "StartFrame" tidak ada.
                        echo            Pemuatan zoning dibatalkan.

                        goto :__end
                    )

                :CheckColumn2
                    type "%zonadd%" | find /I "EndFrame" > nul || (
                        echo [ERROR]    Header untuk Kolom "EndFrame" tidak ada.
                        echo            Pemuatan zoning dibatalkan.

                        goto :__end
                    )

                :CheckColumn3
                    type "%zonadd%" | find /I "Props" > nul || (
                        echo [ERROR]    Header untuk Kolom "Props" tidak ada.
                        echo            Pemuatan zoning dibatalkan.

                        goto :__end
                    )

            for /f "tokens=1,2,3 delims=^;" %%a in ('type "%zonadd%"') do (
                setlocal EnableDelayedExpansion | REM EOF
                if /i not "%%a" == "StartFrame" (
                    if /i not "%%b" == "EndFrame" (
                        if /i not "%%c" == "Props" (
                            set tabout=!tabout!%%a,%%b,%%c/

                            REM Output akan muncul bila parameter +debug berlaku.
                            %argDebug% [DEBUG] !tabout!
                        )
                    )
                )
            )

            set tabout=--zones !tabout!0,0,crf=%defaultCRF%
            endlocal

        :end
            goto :__end

:TrimReader
    REM Proses ini akan membaca framein dan frameout pada file .trm bila tersedia.
    :GETTrimStructure
    (
        for /f "tokens=1,2 delims= " %%a in ('type "%trimadd%"') do (
            echo Trim^(%%a, %%b^)
        )
    ) > "%trimdata%"

    :end
        goto :__end

:__end
    set jump=