rem 主题 09：FFI —— Java/JNI 构建脚本：javac 生成头文件 + cl 编译 DLL
@echo off
set "JAVAC=javac"
if defined JAVA_HOME if exist "%JAVA_HOME%\bin\javac.exe" (
    set "JDK_HOME=%JAVA_HOME%"
    set "JAVAC=%JAVA_HOME%\bin\javac.exe"
)
if not defined JDK_HOME (
    for /f "delims=" %%J in ('where javac 2^>nul') do if not defined JDK_HOME set "JDK_HOME=%%~dpJ.."
)
if not defined JDK_HOME (
    echo JDK not found. Set JAVA_HOME or add javac to PATH. 1>&2
    exit /b 1
)
"%JAVAC%" -encoding UTF-8 -h "%~dp0." "%~dp0Main.java"
if errorlevel 1 exit /b 1
call "%~dp0..\..\..\scripts\setup-msvc.bat"
if errorlevel 1 exit /b 1
cl /nologo /utf-8 /LD "%~dp0strlen_jni.c" /I "%JDK_HOME%\include" /I "%JDK_HOME%\include\win32" /Fe:"%~dp0main.dll"
