:: Hak Cipta ©2017
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:CheckCPUArchitecture
    if "%processor_architecture%" == "x86" (
        msg * Maaf, Arsitektur x86/32-bit tidak didukung oleh program ini.
        goto :__terminate
    ) else (
        goto :__end
    )

:SetRAMIfDefaultRoleDetected
    if "%memorymax%" LSS "1280" (
        set memorymax=1024
    ) else if "%memorymax%" LSS "1024" (
        set memorymax=512
    ) else if "%memorymax%" LSS "512" (
        set memorymax=256
    ) else if "%memorymax%" LSS "256" (
        msg * Maaf, Free Space RAM anda tidak mencukupi untuk melakukan encoding.
        msg * Pastikan RAM anda mempunyai Free Space lebih dari 256 MB.
        goto :__terminate
    ) else (
        goto :__end
    )

:__terminate
    exit

:__end