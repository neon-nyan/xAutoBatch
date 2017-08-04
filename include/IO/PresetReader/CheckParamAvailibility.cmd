:: Hak Cipta ©2017 oleh neon-nyan / codeneon [codeneon123@gmail.com]
:: Di bawah Hak Cipta MIT License [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:__jumper
    if "%jump%" == "" (
        msg * Sertakan label terlebih dahulu!
        msg * Dan gunakan Classes ini dengan program Encodernya.
        msg * ^(/^^_^^^)/ Makasih! \^(^^_^^\^) ^<-----------^> Oleh: codeneon
        exit
    ) else (
        goto %jump%
    )

:CheckValueInParameters
    set jumplabel=_resumeCheckValueInParameters

    goto :CheckParamAvailibility
    :_resumeCheckValueInParameters

    REM Setel value default dari parameter profile dengan high10
    REM bila tidak tidak sesuai dengan definisi.
    if "%param%" == "profile" (
        if "%output%" == "high10" (
            REM EOF
        ) else if "%output%" == "high" (
            REM EOF
        ) else set output=high10
    )

    set CheckData=--%param% %output%

    REM Bila parameter tidak mempunyai value, maka parameter tersebut tidak akan di
    REM keluarkan sebagai output. Melainkan akan terhapus dengan parameter lain.
    if /i "%output%" == "" (
        set parameters=%parameters%
    ) else (
        set parameters=%parameters% %CheckData%
    )

    REM Output akan muncul bila parameter +debug berlaku.
    %argDebug% [DEBUG] %CheckData%

    goto :__end

:NoCheckValueInParameters
    set jumplabel=:_resumeNoCheckValueInParameters

    goto :CheckParamAvailibility
    :_resumeNoCheckValueInParameters

    set CheckDataNoValue=--%param%

    set parameters=%parameters% %CheckDataNoValue%

    goto :__end

:CheckParamAvailibility
    :DoCheckParamAvailibility
        if "%output%" == "" (
            if /i "%param%" == "open-gop" (
                REM EOF
            ) else if /i "%param%" == "weightb" (
                REM EOF
            ) else if /i "%param%" == "stats" (
                REM EOF
            ) else echo    [Warning]: Tidak ada value pada parameter %param%
        ) else set outputstat=%output%

        REM Output akan muncul bila parameter +debug berlaku.
        %argDebug% %debugStat% Check Param: --%param% %outputstat%...
        find "%param%" "%input%" | echo > nul
        if "%errorlevel%" == "0" (
            goto :_resume
        ) else (
            set parameters=%parameters%
            goto :_end
        )

    :_resume
        if "%jumplabel%" == "" (
            echo. > nul
        ) else goto %jumplabel%

:__end
    set jumplabel=
    set CheckData=
    set CheckDataNoValue=
    set jump=