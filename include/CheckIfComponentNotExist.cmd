:: Hak Cipta ©2017
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:CheckComponent
    if /i not exist "%DecoderPath%" (
        msg * File: %DecoderPath% tidak ditemukan.
    )

    if /i not exist "%Encoder10Path%" (
        msg * File: %Encoder10Path% tidak ditemukan.
    )

    if /i not exist "%Encoder8Path%" (
        msg * File: %Encoder8Path% tidak ditemukan.
    )

    if /i not exist "%PipeTeePath%" (
        msg * File: %PipeTeePath% tidak ditemukan.
    )

    if /i not exist "%PreviewerPath%" (
        msg * File: %PreviewerPath% tidak ditemukan.
    )

    if /i not exist "%MergerPath%" (
        msg * File: %MergerPath% tidak ditemukan.
    )

    if /i not exist "%OpusEncPath%" (
        msg * File: %OpusEncPath% tidak ditemukan.
    )

    if /i not exist "%AACEncPath%" (
        msg * File: %AACEncPath% tidak ditemukan.
    )

    if /i not exist "%VorbEncPath%" (
        msg * File: %VorbEncPath% tidak ditemukan.
    )

:__end