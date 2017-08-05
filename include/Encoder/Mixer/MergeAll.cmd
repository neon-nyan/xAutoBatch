:: Hak Cipta ©2017
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:VerifyAudioCodecNameExtension
    if /i "%audio-codec%" == "he-aac" (
        set acodecext=m4a
    ) else if /i "%audio-codec%" == "he-aacv2" (
        set acodecext=m4a
    ) else if /i "%audio-codec%" == "vorbis" (
        set acodecext=ogg
    ) else if /i "%audio-codec%" == "flac" (
        set acodecext=flac
    ) else if /i "%audio-codec%" == "opus" (
        set acodecext=opus
    ) else (
        set acodecext=opus
    )

:WriteFinalOutput && (
        echo Penyatuan untuk: hasil\%mediaoutputnamebase%.mkv
        "%MergerPath%" --ui-language en --output "hasil\%mediaoutputnamebase%.mkv" --quiet --default-track 0:yes "%mediaoutput%" --default-track 0:yes "%mediaoutputname%.%acodecext%" --track-order 0:0,1:0
)