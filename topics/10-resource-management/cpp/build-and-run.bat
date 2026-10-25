# 主题 10：资源管理 —— C++ 一键编译运行
@echo off
call "%~dp0build.bat"
if errorlevel 1 exit /b 1
"%~dp0main.exe"
