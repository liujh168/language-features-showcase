rem 主题 06：迭代器与流 —— C++ 编译脚本（只编译不运行；本主题需 C++20）
@echo off
call "%~dp0..\..\..\scripts\setup-msvc.bat"
if errorlevel 1 exit /b 1
cl /nologo /std:c++20 /EHsc /utf-8 "%~dp0main.cpp" /Fo:"%~dp0main.obj" /Fe:"%~dp0main.exe"
