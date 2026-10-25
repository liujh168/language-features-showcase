@echo off
rem 自动发现 MSVC 环境：优先复用当前环境，其次使用 vswhere。
where cl >nul 2>&1
if not errorlevel 1 exit /b 0

if defined VCINSTALLDIR if exist "%VCINSTALLDIR%\Auxiliary\Build\vcvars64.bat" (
    call "%VCINSTALLDIR%\Auxiliary\Build\vcvars64.bat" >nul
    if errorlevel 1 exit /b 1
    exit /b 0
)

if defined VSINSTALLDIR if exist "%VSINSTALLDIR%\VC\Auxiliary\Build\vcvars64.bat" (
    call "%VSINSTALLDIR%\VC\Auxiliary\Build\vcvars64.bat" >nul
    if errorlevel 1 exit /b 1
    exit /b 0
)

set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
if not exist "%VSWHERE%" set "VSWHERE=%SystemDrive%\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe"
if exist "%VSWHERE%" (
    for /f "usebackq tokens=*" %%I in (`"%VSWHERE%" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath`) do (
        if exist "%%I\VC\Auxiliary\Build\vcvars64.bat" (
            call "%%I\VC\Auxiliary\Build\vcvars64.bat" >nul
            if errorlevel 1 exit /b 1
            exit /b 0
        )
    )
)

echo MSVC build tools not found. Open a Developer Command Prompt or install Visual Studio Build Tools. 1>&2
exit /b 1
