# 一键编译运行全部主题的全部 demo，并逐字节校验输出。
# 用法: powershell -ExecutionPolicy Bypass -File scripts\run-all.ps1
# 可选: -RequireAll 要求所有工具链可用，存在 SKIP 时也返回失败。
param([switch]$RequireAll)

$ErrorActionPreference = "Stop"
$root = Split-Path $PSScriptRoot

function Test-Command([string]$name) {
    return $null -ne (Get-Command $name -ErrorAction SilentlyContinue)
}

function Test-MSVC {
    if (Test-Command "cl") { return $true }
    if ($env:VCINSTALLDIR -and (Test-Path (Join-Path $env:VCINSTALLDIR "Auxiliary\Build\vcvars64.bat"))) { return $true }
    if ($env:VSINSTALLDIR -and (Test-Path (Join-Path $env:VSINSTALLDIR "VC\Auxiliary\Build\vcvars64.bat"))) { return $true }

    $programFilesX86 = [Environment]::GetFolderPath("ProgramFilesX86")
    if (-not $programFilesX86) { return $false }
    $vswhere = Join-Path $programFilesX86 "Microsoft Visual Studio\Installer\vswhere.exe"
    if (-not (Test-Path $vswhere)) { return $false }
    $installation = & $vswhere -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath 2>$null
    return $LASTEXITCODE -eq 0 -and $installation -and (Test-Path (Join-Path $installation "VC\Auxiliary\Build\vcvars64.bat"))
}

$javaHome = $null
$configPath = Join-Path $root "toolchains.local.json"
if (Test-Path $configPath) {
    try {
        $localConfig = Get-Content -Raw -Encoding UTF8 $configPath | ConvertFrom-Json
        if ($localConfig.javaHome) { $javaHome = $localConfig.javaHome }
    } catch {
        Write-Warning "无法读取 toolchains.local.json：$($_.Exception.Message)"
    }
}
if ($env:JAVA_HOME) { $javaHome = $env:JAVA_HOME }

$javaExe = "java"
$javacExe = "javac"
if ($javaHome) {
    $javaCandidate = Join-Path $javaHome "bin\java.exe"
    $javacCandidate = Join-Path $javaHome "bin\javac.exe"
    if (Test-Path $javaCandidate) { $javaExe = $javaCandidate }
    if (Test-Path $javacCandidate) { $javacExe = $javacCandidate }
    if ((Test-Path $javaCandidate) -and (Test-Path $javacCandidate)) { $env:JAVA_HOME = $javaHome }
}

$goExe = "go"
if ($localConfig.goHome) {
    $goHome = Join-Path $root $localConfig.goHome
    $goCandidate = Join-Path $goHome "bin\go.exe"
    if (Test-Path $goCandidate) {
        $goExe = $goCandidate
        $env:GOROOT = $goHome
        $env:GOPATH = Join-Path $root ".toolchains\gopath"
        $env:GOCACHE = Join-Path $root ".toolchains\go-build"
        $env:GOTMPDIR = Join-Path $root ".toolchains\go-tmp"
        New-Item -ItemType Directory -Path $env:GOTMPDIR -Force | Out-Null
    }
}

$cargoExe = "cargo"
if ($localConfig.cargoHome) {
    $cargoHome = Join-Path $root $localConfig.cargoHome
    $cargoCandidate = Join-Path $cargoHome "bin\cargo.exe"
    if (Test-Path $cargoCandidate) {
        $cargoExe = $cargoCandidate
        $env:CARGO_HOME = $cargoHome
    }
}
if ($localConfig.rustupHome) { $env:RUSTUP_HOME = Join-Path $root $localConfig.rustupHome }

$tools = @{
    Python = Test-Command "python"
    TypeScript = (Test-Command "node") -and (Test-Command "npx") -and (Test-Path (Join-Path $root "node_modules\.bin\tsx.cmd"))
    Go = Test-Command $goExe
    Rust = Test-Command $cargoExe
    "C++" = Test-MSVC
    Java = (Test-Command $javaExe) -and (Test-Command $javacExe)
}
$toolHints = @{
    Python = "安装 Python 3.10+ 并加入 PATH"
    TypeScript = "先在项目根目录运行 npm install"
    Go = "安装 Go 1.21+ 并加入 PATH"
    Rust = "安装 Rust/cargo 并加入 PATH；首次构建需准备离线 crate 缓存"
    "C++" = "安装 VS Build Tools，或从 Developer Command Prompt 运行"
    Java = "安装 JDK 21，设置 JAVA_HOME 或将 java/javac 加入 PATH"
}

Write-Host "工具链预检：" -ForegroundColor Yellow
foreach ($name in @("Python", "TypeScript", "Go", "Rust", "C++", "Java")) {
    if ($tools[$name]) {
        Write-Host "  [OK] $name" -ForegroundColor Green
    } else {
        Write-Host "  [MISSING] $name — $($toolHints[$name])" -ForegroundColor DarkYellow
    }
}

function New-Result([string]$topic, [string]$name, [string]$status, [string]$detail = "") {
    return [pscustomobject]@{ Topic = $topic; Name = $name; Status = $status; Detail = $detail }
}

function Show-File([string]$label, [string]$path) {
    if ((Test-Path $path) -and (Get-Item $path).Length -gt 0) {
        Write-Host "--- $label ---"
        Get-Content $path | ForEach-Object { Write-Host $_ }
    }
}

function Check-Output([string]$topic, [string]$name, [string]$cwd, [string]$expected, [scriptblock]$build, [scriptblock]$run) {
    Write-Host "`n=== $name ===" -ForegroundColor Cyan
    $tempDir = Join-Path $root (".run-all-" + [Guid]::NewGuid().ToString("N"))
    New-Item -ItemType Directory -Path $tempDir | Out-Null
    $buildOut = Join-Path $tempDir "build.out"
    $buildErr = Join-Path $tempDir "build.err"
    $runOut = Join-Path $tempDir "run.out"
    $runErr = Join-Path $tempDir "run.err"
    $previousPreference = $ErrorActionPreference
    Push-Location $cwd
    try {
        $ErrorActionPreference = "Stop"
        if ($build -ne $null) {
            & $build > $buildOut 2> $buildErr
            if ($LASTEXITCODE -ne 0) {
                Write-Host "BUILD FAIL (exit $LASTEXITCODE)" -ForegroundColor Red
                Show-File "build stdout" $buildOut
                Show-File "build stderr" $buildErr
                return New-Result $topic $name "FAIL" "build exit $LASTEXITCODE"
            }
        }
        & $run > $runOut 2> $runErr
        if ($LASTEXITCODE -ne 0) {
            Write-Host "RUN FAIL (exit $LASTEXITCODE)" -ForegroundColor Red
            Show-File "run stdout" $runOut
            Show-File "run stderr" $runErr
            return New-Result $topic $name "FAIL" "run exit $LASTEXITCODE"
        }
        $out = if (Test-Path $runOut) { (Get-Content -Raw $runOut).Trim() } else { "" }
        if ($out -eq $expected.Trim()) {
            Write-Host "PASS" -ForegroundColor Green
            return New-Result $topic $name "PASS"
        }
        Write-Host "FAIL`n--- actual ---" -ForegroundColor Red
        Write-Host $out
        Write-Host "--- expected ---"
        Write-Host $expected
        Show-File "run stderr" $runErr
        return New-Result $topic $name "FAIL" "output mismatch"
    } catch {
        Write-Host "FAIL — $($_.Exception.Message)" -ForegroundColor Red
        Show-File "build stderr" $buildErr
        Show-File "run stderr" $runErr
        return New-Result $topic $name "FAIL" $_.Exception.Message
    } finally {
        $ErrorActionPreference = $previousPreference
        Pop-Location
        Remove-Item $tempDir -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# 标准六语言 demo 集（主题 09 的 Java 走 JNI 特殊构建，单独传入）
function Default-Demos([hashtable]$javaOverride) {
    $jBuild = { & $javacExe -encoding UTF-8 Main.java }
    $jRun = { & $javaExe Main }
    $jRequires = @("Java")
    if ($javaOverride) {
        $jBuild = $javaOverride.build
        $jRun = $javaOverride.run
        $jRequires = $javaOverride.requires
    }
    return @(
        @{ name = "Python";     dir = "python";     requires = @("Python");     build = $null; run = { python main.py } },
        @{ name = "TypeScript"; dir = "typescript"; requires = @("TypeScript"); build = $null; run = { npx --no-install tsx main.ts } },
        @{ name = "Go";         dir = "go";         requires = @("Go");         build = $null; run = { & $goExe run main.go } },
        @{ name = "Rust";       dir = "rust";       requires = @("Rust");       build = { & $cargoExe build --offline --quiet }; run = { & $cargoExe run --offline --quiet } },
        @{ name = "C++";        dir = "cpp";        requires = @("C++");        build = { cmd /c build.bat }; run = { & ".\main.exe" } },
        @{ name = "Java";       dir = "java";       requires = $jRequires;      build = $jBuild; run = $jRun }
    )
}

function Invoke-Topic([string]$topicName, [string]$expected, [array]$demos) {
    Write-Host "`n##### 主题 $topicName #####" -ForegroundColor Yellow
    $topicDir = Join-Path $root (Join-Path "topics" $topicName)
    $results = @()
    foreach ($d in $demos) {
        $cwd = Join-Path $topicDir $d.dir
        if (-not (Test-Path $cwd)) {
            Write-Host "`n=== $($d.name) ===" -ForegroundColor Cyan
            Write-Host "FAIL — 缺少目录 $cwd" -ForegroundColor Red
            $results += New-Result $topicName $d.name "FAIL" "missing directory"
            continue
        }
        $missing = @($d.requires | Where-Object { -not $tools[$_] })
        if ($missing.Count -gt 0) {
            $detail = ($missing | ForEach-Object { "$_：$($toolHints[$_])" }) -join "；"
            Write-Host "`n=== $($d.name) ===" -ForegroundColor Cyan
            Write-Host "SKIP — $detail" -ForegroundColor DarkYellow
            $results += New-Result $topicName $d.name "SKIP" $detail
            continue
        }
        $results += Check-Output $topicName $d.name $cwd $expected $d.build $d.run
    }
    return $results
}

$results = @()

$results += Invoke-Topic "01-generics" @"
int box: 42
str box: hello
first of [10, 20, 30] = 10
doubled 21 -> 42
"@ (Default-Demos $null)

$results += Invoke-Topic "02-concurrency" @"
start 4 workers
result from worker 1: 10
result from worker 2: 20
result from worker 3: 30
result from worker 4: 40
all done
"@ (Default-Demos $null)

$results += Invoke-Topic "03-pattern-matching" @"
classify(0) = zero
classify(1) = one
classify(-3) = negative
classify(42) = even
classify(7) = odd
"@ (Default-Demos $null)

$results += Invoke-Topic "04-error-handling" @"
parse "42" -> 42
parse "abc" -> error: invalid digit
10 / 2 = 5
10 / 0 -> error: division by zero
"@ (Default-Demos $null)

$results += Invoke-Topic "05-ownership-memory" @"
acquire resource #1
use resource #1
release resource #1
done
"@ (Default-Demos $null)

$results += Invoke-Topic "06-iterators" @"
evens doubled: 20 40 60 80 100
first 3: 20 40 60
sum = 300
"@ (Default-Demos $null)

$results += Invoke-Topic "07-macros-metaprogramming" @"
square(7) = 49
cube(3) = 27
"@ (Default-Demos $null)

$results += Invoke-Topic "08-type-system" @"
dog says: woof
cat says: meow
"@ (Default-Demos $null)

# 主题 09：Java 走 JNI（javac -h + cl 编 DLL），TS 留空（见 typescript/README.md）
$ffiJava = @{
    build = { cmd /c build.bat }
    run = { & $javaExe "-Djava.library.path=." -cp . Main }
    requires = @("Java", "C++")
}
$results += Invoke-Topic "09-ffi-interop" @"
strlen("hello") = 5
strlen("modern languages") = 16
"@ @( (Default-Demos $ffiJava) | Where-Object { $_.name -ne "TypeScript" } )

$results += Invoke-Topic "10-resource-management" @"
allocate buffer A
allocate buffer B
use A + B
return A to pool
return B to pool
all buffers back in pool
"@ (Default-Demos $null)

$results += Invoke-Topic "11-modules-encapsulation" @"
utils.greet() = hello from utils
area(3, 4) = 12
makeUser("ada") = User(name=ada)
"@ (Default-Demos $null)

$results += Invoke-Topic "12-async-advanced" @"
start 3 tasks
task fast finished
task medium finished
task slow finished
all settled
"@ (Default-Demos $null)

$pass = @($results | Where-Object { $_.Status -eq "PASS" }).Count
$fail = @($results | Where-Object { $_.Status -eq "FAIL" }).Count
$skip = @($results | Where-Object { $_.Status -eq "SKIP" }).Count
$total = $results.Count
Write-Host "`n===== $pass passed, $fail failed, $skip skipped, $total total ====="
if ($total -ne 71) {
    Write-Host "RESULT ERROR：预期登记 71 项，实际统计 $total 项。" -ForegroundColor Red
    exit 1
}
if ($fail -gt 0 -or ($RequireAll -and $skip -gt 0)) { exit 1 } else { exit 0 }
