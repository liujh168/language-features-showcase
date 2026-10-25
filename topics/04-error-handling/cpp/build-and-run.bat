rem 主题 04：错误处理 —— C++ 一键编译运行（人工使用）
@echo off
call "%~dp0build.bat"
if errorlevel 1 exit /b 1
"%~dp0main.exe"
