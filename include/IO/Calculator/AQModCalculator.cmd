:: Hak Cipta ©2017
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:WriteSimpleScript
    echo WScript.Echo Eval^(WScript.Arguments^(0^)^) > "%temp%\calc.vbs"

:GETParameterfromPreset
    set jump=:ValueReader && call %b%\IO\PresetReader\LegacyReader

    for /f "tokens=2 delims=!" %%a in ('type "%input%" ^| find "%param%"') do (
        for /f "tokens=1 delims=:" %%a in ('echo %%a') do (
            set psytrellis=%%a

            REM Kalikan %psytrellis% dengan 10
            for /f %%a in ('cscript //nologo %temp%\calc.vbs "!psytrellis!*10"') do (
                for /f "tokens=1,2 delims=," %%a in ('echo %%a') do (
                    if "%%b" == "" (
                        set psytrellis=%%a
                    ) else (
                        set psytrellis=%%a.%%b
                    )
                )
            )

            REM Sekarang hitung AQ2-Str. dengan rumus:
            REM      2 / PSY-TRL = n1
            for /f %%a in ('cscript //nologo %temp%\calc.vbs "2/!psytrellis!"') do (
                for /f "tokens=1,2 delims=," %%a in ('echo %%a') do (
                    if "%%b" == "" (
                        set n1=%%a
                    ) else (
                        for /f "tokens=1 delims=E-" %%a in ('echo %%a.%%b') do (
                            set n1=%%a
                        )
                    )
                )
            )

            REM Sekarang hitung AQ2-Sens. dengan rumus:
            REM      16 x n1 = n2
            REM      [BUGFix] Kalikan 1 untuk hasil yang absolute.
            for /f %%a in ('cscript //nologo %temp%\calc.vbs "^(16*!n1!^)*1"') do (
                for /f "tokens=1,2 delims=," %%a in ('echo %%a') do (
                    if "%%b" == "" (
                        set n2=%%a
                    ) else (
                        for /f "tokens=1 delims=E-" %%a in ('echo %%a.%%b') do (
                            set n2=%%a
                        )
                    )
                )
            )

            REM Sekarang hitung AQ3-Str. dengan rumus:
            REM      [8 / [[0,03 x [n2 / n1]]]] x 0,03 = n3
            for /f %%a in ('cscript //nologo %temp%\calc.vbs "^(8/^(^(0.03*^(!n2!/!n1!^)^)^)^)*0.03"') do (
                for /f "tokens=1,2 delims=," %%a in ('echo %%a') do (
                    if "%%b" == "" (
                        set n3=%%a
                    ) else (
                        for /f "tokens=1 delims=E-" %%a in ('echo %%a.%%b') do (
                            set n3=%%a
                        )
                    )
                )
            )

            REM Sekarang hitung AQ3-Sens. dengan rumus:
            REM      [n2 / n3[2]] / 3 = ns
            REM      [n2 / [n3*n3]] / 3 = ns
            for /f %%a in ('cscript //nologo %temp%\calc.vbs "^(^(!n2!/^(!n3!*!n3!^)^)/3^)"') do (
                for /f "tokens=1,2 delims=," %%a in ('echo %%a') do (
                    if "%%b" == "" (
                        set ns=%%a
                    ) else (
                        for /f "tokens=1 delims=E-" %%a in ('echo %%a.%%b') do (
                            set ns=%%a
                        )
                    )
                )
            )
        )
    )

:__end
    del %temp%\calc.vbs