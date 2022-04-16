@echo off

IF "%FARPROFILE%"=="" (
    echo Variable %%FARPROFILE%% is not set
    exit 1
)

xcopy ".\macros" "%FARPROFILE%\Macros\internal" /-y