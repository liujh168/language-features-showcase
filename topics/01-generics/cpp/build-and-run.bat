rem 主题 01：泛型 —— C++ 一键编译运行（人工使用）
@echo off
call "%~dp0build.bat"
if errorlevel 1 exit /b 1
"%~dp0main.exe"
