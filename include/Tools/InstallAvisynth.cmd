:: Hak Cipta ©2017 oleh neon-nyan / codeneon [codeneon123@gmail.com]
:: Di bawah Hak Cipta MIT License [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:CheckIfAdmin
    call %b%\ConfirmIfAdmin

:EnterDialog1
    cls
    echo %tpdnt1%
    echo                             !!!!!Peringatan!!!!!
    echo %tpdnt1%
    echo Sebelum anda memasang engine Avisynth+ MT x64 ini, pastikan komputer dan semua
    echo filter anda adalah filter yang diperuntukkan untuk Avisynth x64. Jangan lupa
    echo untuk menjalankan program ini sebagai Administrator.
    echo.

    if /i "%isAdminBlock%" == "true" (
        set adminStat=Tidak di izinkan.
    ) else (
        set adminStat=Di izinkan.
    )

    echo Status Admin: %adminStat%
    echo.

    if /i "%isAdminBlock%" == "true" (
        echo Proses Pemasangan tidak bisa dilanjutkan. Anda harus menjalankan pemasangan ini sebagai administrator.
        echo.
        pause | echo Tekan apa saja untuk keluar...
        goto :__end
        
    ) else (
        echo Pemasangan ini akan meng"overwrite" versi Avisynth sebelumnya dan pastikan anda
        echo tidak ragu untuk memasangnya.
        echo.
        pause | echo Tekan apa saja untuk mulai memasang...
    )

:StartSimpleInstall
    cls
    title=Memasang Avisynth+ Utama...
    "tools\engine\AviSynth+r1858.exe" /VERYSILENT /NORESTARTAPPLICATIONS
    cls
    title=Memasang Avisynth+ MT...
    copy /Y "tools\engine\SysWOW64\avisynth.dll" "%systemroot%\SysWOW64\avisynth.dll"
    copy /Y "tools\engine\SysWOW64\devil.dll" "%systemroot%\SysWOW64\devil.dll"
    copy /Y "tools\engine\x64\AviSynth.dll" "%systemroot%\system32\AviSynth.dll"
    copy /Y "tools\engine\x64\DevIL.dll" "%systemroot%\system32\DevIL.dll"

:EnterDialog2
    cls
    title=Pemasangan Selesai!!!
    echo %tpdnt1%
    echo Pemasangan Selesai!!!
    echo %tpdnt1%
    echo Pemasangan telah selesai dilakukan.
    echo.
    pause | echo Tekan apa saja untuk keluar...

:__end