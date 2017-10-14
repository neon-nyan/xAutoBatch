:: Hak Cipta ©2017
:: @neon-nyan / codeneon
:: [codeneon123@gmail.com]
:: 
:: Di bawah Hak Cipta MIT License
:: [https://github.com/neon-nyan/xAutoBatch/raw/master/LICENSE]

:CheckDirectoryExistency
    if /i not exist "%dir.Temp%" md "%dir.Temp%"
        if /i not exist "%dir.Temp.script%" md "%dir.Temp.script%"
            if /i not exist "%dir.Temp.script.autoload%"  md "%dir.Temp.script.autoload%"
            if /i not exist "%dir.Temp.script.input%"     md "%dir.Temp.script.input%"
        if /i not exist "%dir.Temp.data%"   md "%dir.Temp.data%"
        if /i not exist "%dir.Temp.update%" md "%dir.Temp.update%"