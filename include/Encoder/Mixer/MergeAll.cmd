:: Hak Cipta ©2018
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:WriteFinalOutput
        echo Penyatuan untuk: hasil\%mediaoutputnamebase%.mkv
        "%MergerPath%" --ui-language en --output "hasil\%mediaoutputnamebase%.mkv" --quiet --default-track 0:yes "%mediaoutput%" --default-track 0:yes "%mediaoutputname%.%acodecext%" --track-order 0:0,1:0