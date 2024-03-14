# Azure App Configuration Analysis Tool (APPCAT) Script

## Overview
This PowerShell script facilitates the usage of the Azure App Configuration Analysis Tool (APPCAT) for analyzing applications and source code for migration to Azure App Service. It offers the flexibility to analyze either a single input directory or multiple subfolders within a specified root directory.

## Requirements
- Windows operating system
- PowerShell
- Azure App Configuration Analysis Tool (APPCAT) executable

## Usage
1. **Download APPCAT:** Download the APPCAT executable from the official source.
2. **Set Up Parameters:** Open the `RunAppcat.ps1` script and set the parameters according to your requirements.
3. **Run the Script:** Execute the script in PowerShell by running `.\RunAppcat.ps1`.

## Parameters
- **AppcatPath:** Path to the APPCAT executable.
- **InputPath:** Path to the input directory or root directory containing subfolders to analyze.
- **OutputPath:** Path to the output directory where analysis reports will be saved.
- **Target:** Target platform for analysis (e.g., Any, AppService.Linux, AppService.Windows, etc.).
- **Packages:** Array of packages to analyze.
- **SourceMode:** Optional switch to indicate whether to analyze source code.
- **IncludeChildFolders:** Optional switch to include subfolders for analysis.

## Functions
- **RunAppCat:** Constructs and executes the APPCAT command for a single input directory or file.
- **AnalyzeSubfolders:** Recursively analyzes subfolders within the specified root directory, generating separate analysis reports for each subfolder.

## Example
```powershell
.\RunAppcat.ps1 -AppcatPath "C:\appcat\appcat.exe" -InputPath "C:\my_project" -OutputPath "C:\analysis_reports" -Packages "org.example" -IncludeChildFolders
