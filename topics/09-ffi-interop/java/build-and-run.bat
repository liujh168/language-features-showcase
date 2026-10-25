rem 主题 09：FFI —— Java/JNI 一键构建运行
@echo off
call "%~dp0build.bat"
if errorlevel 1 exit /b 1
set "JAVA=java"
if defined JAVA_HOME if exist "%JAVA_HOME%\bin\java.exe" set "JAVA=%JAVA_HOME%\bin\java.exe"
"%JAVA%" "-Djava.library.path=%~dp0." -cp "%~dp0." Main
