rem 主题 12：异步进阶 —— C++ 一键编译运行
@echo off
call "%~dp0build.bat"
if errorlevel 1 exit /b 1
"%~dp0main.exe"
