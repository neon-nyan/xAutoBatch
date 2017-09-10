:: Hak Cipta ©2017
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:CheckAvisynthAvailibility
    if /i not exist "%systemroot%\system32\avisynth.dll" (
        echo [WARNING]  Avisynth tidak terpasang.
        echo            Peogram akan menggunakan AviSynth bawaan.
    ) else (
        if /i not exist "%systemroot%\SysWOW64\avisynth.dll" (
            echo [WARNING]  AviSynth x64 tidak terpasang.

            if /i exist "%systemroot%\system32\avisynth.dll" (
                echo            Namun Avisynth x86 terpasang di komputer anda.
            )
            echo            Peogram akan menggunakan AviSynth bawaan.
        ) else (
            echo [INFO]     Avisynth x86/x64 terpasang di komputer anda.
        )
    )

    goto :__end

:__end
    timeout /t 3 /nobreak | echo.