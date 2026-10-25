rem 主题 07：宏与元编程 —— C++ 编译脚本（只编译不运行）
@echo off
call "%~dp0..\..\..\scripts\setup-msvc.bat"
if errorlevel 1 exit /b 1
cl /nologo /std:c++17 /EHsc /utf-8 "%~dp0main.cpp" /Fo:"%~dp0main.obj" /Fe:"%~dp0main.exe"
