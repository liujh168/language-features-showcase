rem 主题 08：类型系统 —— C++ 一键编译运行（人工使用）
@echo off
call "%~dp0build.bat"
if errorlevel 1 exit /b 1
"%~dp0main.exe"
