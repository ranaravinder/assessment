<#
.SYNOPSIS
This PowerShell script is designed to run the Azure App Configuration Analysis Tool (APPCAT) on either a single input directory or on multiple subfolders within a specified root directory. It provides flexibility in customizing various parameters such as the path to the APPCAT executable, input directory, output directory, target platform, packages to analyze, and whether to include subfolders for analysis.

.PARAMETER AppcatPath
The path to the APPCAT executable.

.PARAMETER InputPath
The path to the input directory or root directory containing subfolders to analyze.

.PARAMETER OutputPath
The path to the output directory where the analysis reports will be saved.

.PARAMETER Target
The target platform for the analysis (e.g., Any, AppService.Linux, AppService.Windows, etc.).

.PARAMETER Packages
An array of packages to analyze.

.PARAMETER SourceMode
A switch indicating whether to analyze source code (optional).

.PARAMETER IncludeChildFolders
A switch indicating whether to include subfolders for analysis (optional).

.NOTES
The script provides two main functions: RunAppCat and AnalyzeSubfolders. RunAppCat constructs and executes the APPCAT command for a single input directory or file, while AnalyzeSubfolders recursively analyzes subfolders within the specified root directory, generating separate analysis reports for each subfolder.

.EXAMPLE
.\RunAppcat.ps1 -AppcatPath "C:\appcat\appcat.exe" -InputPath "C:\my_project" -OutputPath "C:\analysis_reports" -Packages "org.example" -IncludeChildFolders
#>
# Define named argument parameters
param (
    [Parameter(Mandatory = $true)]
    [string]$AppcatPath,
    [Parameter(Mandatory = $true)]
    [string]$InputPath,
    [Parameter(Mandatory = $true)]
    [string]$OutputPath,    
    [Parameter()]
    [string]$Target = "Any", # AppService.Linux, AppService.Windows, AppServiceContainer.Linux,AppServiceContainer.Windows, ACA, AKS.Linux,  AKS.Windows, Any
    [string[]]$Packages,
    [switch]$SourceMode = $false,
    [switch]$IncludeChildFolders = $false
)
Write-Host $InputPath
Write-Host $OutputPath
# Function to construct and run the appcat command
function RunAppCat {
    param (
        [string]$Path,
        [string]$ReportOutputPath
    )
    $appcatCommand = "$AppcatPath --input $Path --output $ReportOutputPath --target $Target --packages $($Packages -join ' ')"
    if ($SourceMode) {
        $appcatCommand += " --sourceMode"
    }
    Invoke-Expression $appcatCommand
}

# Function to analyze subfolders of the input directory
function AnalyzeSubfolders {
    param (      
        [string]$ParentOutputPath,
        [string]$InputDirectory
    )    
    
    $subfolders = Get-ChildItem -Path $InputDirectory -Directory
    foreach ($subfolder in $subfolders) {
        $subfolderOutputPath = Join-Path -Path $ParentOutputPath -ChildPath $subfolder.Name
        if (!(Test-Path -Path $subfolderOutputPath)) {
            New-Item -ItemType Directory -Path $subfolderOutputPath | Out-Null
        }
        RunAppCat -Path $subfolder.FullName -ReportOutputPath $subfolderOutputPath
    }
}

# Analyze the input directory
if ($IncludeChildFolders) {
    AnalyzeSubfolders -ParentOutputPath $OutputPath -InputDirectory $InputPath
}
else {
    RunAppCat -Path $InputPath -ReportOutputPath $OutputPath
}