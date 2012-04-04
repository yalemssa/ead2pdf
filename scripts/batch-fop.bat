@echo off
REM Batch script to transform a directory full of EAD files
REM 

setlocal EnableDelayedExpansion
set err=0
pushd %~dp0

set logfile=..\logs\%date:~-4%_%date:~4,2%_%date:~7,2%.txt
@type nul >> %logfile% & copy %logfile% +,, > nul
echo Writing logs to %logfile%.

echo. >> %logfile%
echo ------------------------------- >> %logfile%
echo %date% %time% >> %logfile%

for %%x in (..\in\*.xml) do (
  echo Transforming in\%%~dpnx.xml to out\%%~nx.pdf ... >> %logfile% 
  call fop-saxon -c fop.xconf -xml %%~dpnx.xml -xsl xslt\yul.ead2002.pdf.xsl -pdf ..\out\%%~nx.pdf >> %logfile% 2>&1 
  set err=!errorlevel!
  if !errorlevel! EQU 0 (
    echo Transformation of in\%%~dpnx.xml succeeded. Moving file to out\%%~nx.xml >> %logfile%
    move %%~dpnx.xml ..\out >> %logfile%
    echo. >> %logfile%
    ) else (
    echo Error: Transformation of in\%%~dpnx.xml failed. Exiting. >> %logfile%
    echo. >> %logfile%
    exit /b %err%
    )
  )
popd
exit /b %err%