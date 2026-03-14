@echo off
set "KKFILEVIEW_BIN_FOLDER=%cd%"
cd "%KKFILEVIEW_BIN_FOLDER%"
echo Using KKFILEVIEW_BIN_FOLDER %KKFILEVIEW_BIN_FOLDER%
echo Starting kkFileView...
echo Please check log file in ../log/kkFileView.log for more information
java -Dfile.encoding=UTF-8 -Dspring.config.location=..\config\application.properties -jar kkFileView-4.4.0-RELEASE.jar -> ..\log\kkFileView.log
