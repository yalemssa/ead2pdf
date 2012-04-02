@echo off
REM Batch script to transform a directory full of EAD files
REM 

setlocal EnableDelayedExpansion
set err=0
pushd c:\Program Files\facc-xslfo

for %%x in (d:\EAD2PDF\in\*.xml) do (
  echo Transforming %%~dpnx.xml to D:\EAD2PDF\out\%%~nx.pdf ...
  call fop-saxon -c fop.xconf -xml %%~dpnx.xml -xsl yul.ead2002.pdf.xsl -pdf d:\EAD2PDF\out\%%~nx.pdf
  set err=!errorlevel!
  if !errorlevel! EQU 0 (
    echo Transformation of %%~dpnx.xml succeeded. Deleting file.
    echo.
    del %%~dpnx.xml
    ) else (
    echo Error: Transformation of %%~dpnx.xml failed. Exiting.
    echo.
    exit /b %err%
    )
  )
popd
exit /b %err%