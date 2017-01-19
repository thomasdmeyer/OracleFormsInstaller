@ECHO OFF
REM ----------------------------------------------------------------------------
REM Name: OracleFormsClientStart
REM Date: 03/10/2016
REM Description: This file will automate the invocation of a JAVA
REM              based command line that starts the Oracle Forms
REM              client (a thin client).
REM Installation: This file is installed using the 
REM              OracleFormsInstaller.MSI that was developed
REM              in-house to ease the installation process.
REM ----------------------------------------------------------------------------

REM Turn on command processor extensions and don't clobber variables (SETLOCAL)
SETLOCAL ENABLEEXTENSIONS
SET version=1.0
SET installationDirectoryDoesNotExistError=The installation directory does not exist.
GOTO %PROCESSOR_ARCHITECTURE%
:AMD64
SET ProgFiles86Root=C:\Program Files (x86)
goto initProcess
:X86
SET ProgFiles86Root=C:\Program Files
goto initProcess

:initProcess
SET forms_client_location=%ProgFiles86Root%\MCS\OracleFormsClient
SET forms_client_jar=frmsal.jar
SET forms_server_url="https://mmcsdev.health.utah.gov/forms/frmservlet?config=mmcs -t 30000"
SET current_directory=%~n0

IF NOT EXIST "%forms_client_location%" GOTO noWinDirectory
	cd "%forms_client_location%"
	goto mainProcess
:noWinDirectory
ECHO Error: %installationDirectoryDoesNotExistError%
ECHO %forms_client_location%
goto finished

:mainProcess
REM --- STATUS USER ---
ECHO %current_directory%
ECHO Version: %version%

REM Change our working directory
REM --- Uncomment to use full path
REM ECHO calling java -jar "%forms_client_location%\%forms_client_jar%" -url %forms_server_url%
ECHO calling java -jar %forms_client_jar%" -url %forms_server_url%


REM Initiate call to the [standalone] Oracle Forms Server using a JAVA client
REM --- Uncomment to use full path
REM call java -jar "%forms_client_location%\%forms_client_jar%" -url %forms_server_url%
call java -jar "%current_directory%\%forms_client_jar%" -url %forms_server_url%

:finished
ECHO Finished
