@echo off
set package_id="ReSharper.ReMoji"

set config=%1
if "%config%" == "" (
   set config=Release
)
 
set version=10.0.0
if not "%PackageVersion%" == "" (
   set version=%PackageVersion%
)

set nuget=
if "%nuget%" == "" (
        set nuget=src\.nuget\nuget.exe
)

%nuget% restore src\ReSharper.ReMoji.sln
"%ProgramFiles(x86)%\MSBuild\14.0\Bin\msbuild" src\ReSharper.ReMoji.sln /t:Rebuild /p:Configuration="%config%" /m /v:M /fl /flp:LogFile=msbuild.log;Verbosity=Minimal /nr:false

%nuget% pack "src\ReSharper.ReMoji.nuspec" -NoPackageAnalysis -Version %version% -Properties "Configuration=%config%;ReSharperDep=Wave;ReSharperVer=[4.0];SDK=10.0;PackageId=%package_id%" -Verbosity detailed