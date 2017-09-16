
:GETTableData
    set i=0
    setlocal enabledelayedexpansion

    :StartCollectTableData
        for /f "tokens=1,2,3 delims=;" %%a in ('type %input%') do (
            if /i not "%%a" == "StartFrame" (
                set data=!data!/%%a,%%b,%%c
            )
        )
        echo 0,0,crf=26!data!>%temp%\StackTable.data
        endlocal

:__end