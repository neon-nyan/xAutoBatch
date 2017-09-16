@echo off
cls

set input=SampleData.csv

call Reader

set /p data=<%temp%\StackTable.data
echo %data%

del %temp%\StackTable.data