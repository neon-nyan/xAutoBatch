:: Hak Cipta ©2017 oleh neon-nyan / codeneon [codeneon123@gmail.com]
:: Di bawah Hak Cipta MIT License [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:DoSimpleAdminCheck
    echo > lel.lel
    move /Y lel.lel %systemroot% > nul

    if "%errorlevel%" == "1" (
        %argDebug% Tidak di izinkan.
        set isAdminBlock=true
    ) else (
        %argDebug% Di izinkan.
        set isAdminBlock=false
    )

    del lel.lel
    del "%systemroot%\lel.lel"