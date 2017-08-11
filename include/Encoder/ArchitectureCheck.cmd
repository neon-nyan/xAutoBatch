:: Hak Cipta ©2017
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:CheckCPUArchitecture
(
    if "%processor_architecture%" == "x86" (
        msg * Maaf, Arsitektur x86/32-bit tidak didukung oleh program ini.
        goto __terminate
    ) else (
        goto :__end
    )
)

:__terminate
    exit

:__end