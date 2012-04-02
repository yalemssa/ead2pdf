@echo off
REM Batch script to transform a directory full of EAD files
REM 

setlocal EnableDelayedExpansion
set err=0
pushd d:\ead2pdf\scripts

set logfile=D:\EAD2PDF\logs\%date:~-4%_%date:~4,2%_%date:~7,2%.txt
@type nul >> %logfile% & copy %logfile% +,, > nul
echo Writing logs to %logfile%.

echo. >> %logfile%
echo ------------------------------- >> %logfile%
echo %date% %time% >> %logfile%

for %%x in (d:\EAD2PDF\in\*.xml) do (
  echo Transforming %%~dpnx.xml to D:\EAD2PDF\out\%%~nx.pdf ... >> %logfile% 
  call fop-saxon -c fop.xconf -xml %%~dpnx.xml -xsl yul.ead2002.pdf.xsl -pdf d:\EAD2PDF\out\%%~nx.pdf >> %logfile% 2>&1 
  set err=!errorlevel!
  if !errorlevel! EQU 0 (
    echo Transformation of %%~dpnx.xml succeeded. Moving file to D:\EAD2PDF\%%~nx.xml >> %logfile%
    echo. >> %logfile%
    move %%~dpnx.xml d:\EAD2PDF\out
    ) else (
    echo Error: Transformation of %%~dpnx.xml failed. Exiting. >> %logfile%
    echo. >> %logfile%
    exit /b %err%
    )
  )
popd
exit /b %err%