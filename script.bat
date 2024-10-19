 @echo off
setlocal EnableDelayedExpansion

REM Define the output file
set "output_file=result.txt"

REM Create or clear the result.txt file
> "%output_file%" echo.

REM Add a header and tree command output to the result file
echo File structure: >> "%output_file%"
tree "%cd%" >> "%output_file%" 2>NUL
echo. >> "%output_file%"
echo. >> "%output_file%"

REM Function to recursively read files
CALL :read_files "%cd%"
GOTO :EOF

:read_files
set "dir=%~1"

REM Loop through each item in the directory
for %%I in ("%dir%\*") do (
    if exist "%%I" (
        if exist "%%I\" (
            REM If it's a directory, recursively call the function
            CALL :read_files "%%I"
        ) else (
            REM If it's a file, write its path and content to the output file
            echo File path: [%%I] >> "%output_file%"
            type "%%I" >> "%output_file%"
            echo. >> "%output_file%"
            echo. >> "%output_file%"
        )
    )
)
GOTO :EOF

REM After processing
echo Result file created: %output_file%

