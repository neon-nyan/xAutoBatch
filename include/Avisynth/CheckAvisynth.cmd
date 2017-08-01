:: Hak Cipta ©2017 oleh neon-nyan / codeneon [codeneon123@gmail.com]
:: Di bawah Hak Cipta MIT License [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:CheckAvisynthAvailibility
(
    if /i not exist "%systemroot%\system32\avisynth.dll" (
        echo Avisynth tidak terpasang.
    ) else (
        if /i not exist "%systemroot%\SysWOW64\avisynth.dll" (
            echo Avisynth x64 tidak terpasang.
            
            if /i exist "%systemroot%\system32\avisynth.dll" (
                echo Namun Avisynth x86 terpasang di komputer anda.
            )
        ) else (
            echo Avisynth x86/x64 terpasang di komputer anda.
        )
    )
    goto :__end
)

:__end
    timeout /t 3 /nobreak | echo.