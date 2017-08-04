:: Hak Cipta ©2017 oleh neon-nyan / codeneon [codeneon123@gmail.com]
:: Di bawah Hak Cipta MIT License [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:__jumper
(
    if "%jump%" == "" (
        msg * Sertakan label terlebih dahulu!
        msg * Dan gunakan Classes ini dengan program Encodernya.
        msg * ^(/^^_^^^)/ Makasih! \^(^^_^^\^) ^<-----------^> Oleh: codeneon
        exit
    ) else (
        goto %jump%
    )
)


:ValueReader
(
    set output=

    for /f "tokens=2 delims=!" %%a in ('type "%input%" ^| find "%param%"') do (
        set output=%%a
        
        for /f "tokens=1 delims=." %%a in ('echo %param%') do (
            if not "%param%" == "%%a." (
                REM EOF
            ) else (
                set param=%%a
            )
        )

        for /f "tokens=1 delims=#" %%a in ('echo %param%') do (
            if not "%param%" == "%%a#" (
                REM EOF
            ) else (
                set param=%%a
            )
        )

        for /f "tokens=1 delims=@" %%a in ('echo %param%') do (
            if not "%param%" == "%%a@" (
                REM EOF
            ) else (
                set param=%%a
            )
        )

        for /f "tokens=1 delims=\" %%a in ('echo %param%') do (
            if not "%param%" == "%%a\" (
                REM EOF
            ) else (
                set param=%%a
            )
        )

        for /f "tokens=1 delims=/" %%a in ('echo %param%') do (
            if not "%param%" == "%%a/" (
                REM EOF
            ) else (
                set param=%%a
            )
        )
    )

    :end
        goto :__end
)

:ValueReader_ForLoops
(
    for /r %%d in ("input\*.spf") do (
        set output=
        for /f "tokens=2 delims=!" %%a in ('type "%%d" ^| find "%param%"') do (
            set output=%%a

            for /f "tokens=1 delims=#" %%a in ('echo %param%') do (
                if not "%param%" == "%%a#" (
                    REM EOF
                ) else (
                    set param=%%a
                )
            )

            for /f "tokens=1 delims=@" %%a in ('echo %param%') do (
                if not "%param%" == "%%a@" (
                    REM EOF
                ) else (
                    set param=%%a
                )
            )

            for /f "tokens=1 delims=\" %%a in ('echo %param%') do (
                if not "%param%" == "%%a\" (
                    REM EOF
                ) else (
                    set param=%%a
                )
            )

            for /f "tokens=1 delims=/" %%a in ('echo %param%') do (
                if not "%param%" == "%%a/" (
                    REM EOF
                ) else (
                    set param=%%a
                )
            )
        )
    )

    :end
        goto :__end
)

:TableReader
    REM Proses Pembacaan Baris pada table akan dimulai dari urutan
    REM paling atas ke bawah.
    :countInputLegacyStacks
    (
        set i=1

        for /f "tokens=1,2,3,4 delims=^|" %%a in ('type "%zonadd%"') do (
            setlocal EnableDelayedExpansion | REM EOF
            set eliminate=%%a,%%b,%%c,%%d
            for /f "tokens=1,2,3,4 delims=, " %%a in ('echo !eliminate!') do (
                REM Ambil data stack dari table menjadi value.
                set tabout=!tabout!%%b,%%c,%%d/

                REM Output akan muncul bila parameter +debug berlaku.
                %argDebug% [DEBUG] !tabout!
            )
        )

        REM Output akan muncul bila parameter +debug berlaku.
        %argDebug% [DEBUG] !tabout!

        REM Jadikan value menjadi bagian dari parameter.
        REM Ditambahkan value "0,0,crf=20" untuk mencegah terjadinya bug.
        set tabout=--zones !tabout!0,0,crf=%defaultCRF%
    )

    :WriteOutTableStacks
        set writeout=%tabout%
        echo %writeout% > "%tabledata%"
        endlocal
        set output=

    :end
        goto :__end

:TableReader_ForLoops
    for /r %%d in ("input\*.szf") do (
        REM Proses Pembacaan Baris pada table akan dimulai dari urutan
        REM paling atas ke bawah.
        :countInputLegacyStacks
            set i=2
            for /f "tokens=1,2,3,4 delims=^|" %%a in ('type "%%d" ^| find "%i%. "') do (
                setlocal EnableDelayedExpansion | REM EOF
                set eliminate=%%a,%%b,%%c,%%d
                for /f "tokens=1,2,3,4 delims=, " %%a in ('echo !eliminate!') do (
                    set tabout=!tabout! --zones %%b,%%c,%%d
                )
            )

        :WriteOutTableStacks
            set writeout=!tabout!
            echo !writeout! > "%tabledata%"
            endlocal
            set output=
    )

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