# Get-AppCatResult PowerShell Script

## Overview

The Get-AppCatResult PowerShell script (`Get-AppCatResult.ps1`) is a tool for analyzing .NET applications and assessing their readiness for deployment to various target environments. It leverages the `appcat` command-line tool to perform the analysis.

## Script Details

### Parameters

The script accepts the following named parameters:

- **ApplicationPath**: The path to the .NET application to be analyzed. Default value: `C:\workspace\source\ang-net\BooksApi\BooksApi.sln`.
- **Target**: The target environment for deployment. Possible values include `Any`, `AppService.Linux`, `AppService.Windows`, `AppServiceContainer.Linux`, `AppServiceContainer.Windows`, `ACA`, `AKS.Linux`, `AKS.Windows`. Default value: `Any`.
- **ReportPath**: The path to store the assessment results. Default value: `C:\appcat`.
- **Serializer**: The format for the assessment report. Default value: `html`.
- **Source**: The source of the application to be analyzed. Possible values include `Solution`, `Folder`, `IISServer`. Default value: `IISServer`.
- **IISSiteName**: (Optional) The name of the IIS site(s) to analyze. This parameter accepts multiple site names separated by commas.

### Dependencies

Ensure the following dependencies are installed and configured:

1. **PowerShell**: Version 5.1 or later.
2. **.NET Framework or .NET Core SDK**: Required for analyzing .NET applications.
3. **appcat**: Ensure the `appcat` command-line tool is available in the system's PATH or provide the full path to the executable in the script.
4. **Optional Dependencies**: Any additional dependencies required by the script or the `appcat` tool.

## Usage Examples

1. Analyze a .NET application using default parameters:
    ```powershell
    .\Get-AppCatResult.ps1
    ```

2. Analyze a specific application with custom parameters:
    ```powershell
    .\Get-AppCatResult.ps1 -ApplicationPath "C:\path\to\application" -Source Solution -Target AppService.Windows
    ```

## Author

- **Author:** Ravinder Singh Rana
- **Email:** v-ravrana@microsoft.com

If you have any questions or suggestions, feel free to contact me at [v-ravrana@microsoft.com](mailto:v-ravrana@microsoft.com).

# --------------------------------------------------
## Usage Examples

1. For Source as Solution:
 ```powershell
.\Get-AppCatResult.ps1 -Source "Solution" -ApplicationPath "C:\path\to\your\project.sln" -Target "AppService.Linux"
.\Get-AppCatResult.ps1 -Source "Solution" -ApplicationPath "C:\path\to\your\project.sln" -Target "AppService.Windows"
.\Get-AppCatResult.ps1 -Source "Solution" -ApplicationPath "C:\path\to\your\project.sln" -Target "AppServiceContainer.Linux"
.\Get-AppCatResult.ps1 -Source "Solution" -ApplicationPath "C:\path\to\your\project.sln" -Target "AppServiceContainer.Windows"
.\Get-AppCatResult.ps1 -Source "Solution" -ApplicationPath "C:\path\to\your\project.sln" -Target "ACA"
.\Get-AppCatResult.ps1 -Source "Solution" -ApplicationPath "C:\path\to\your\project.sln" -Target "AKS.Linux"
.\Get-AppCatResult.ps1 -Source "Solution" -ApplicationPath "C:\path\to\your\project.sln" -Target "AKS.Windows"
.\Get-AppCatResult.ps1 -Source "Solution" -ApplicationPath "C:\path\to\your\project.sln" -Target "Any"
 ```

2. For Source as Folder:
```powershell
.\Get-AppCatResult.ps1 -Source "Folder" -ApplicationPath "C:\path\to\your\folder" -Target "AppService.Linux"
.\Get-AppCatResult.ps1 -Source "Folder" -ApplicationPath "C:\path\to\your\folder" -Target "AppService.Windows"
.\Get-AppCatResult.ps1 -Source "Folder" -ApplicationPath "C:\path\to\your\folder" -Target "AppServiceContainer.Linux"
.\Get-AppCatResult.ps1 -Source "Folder" -ApplicationPath "C:\path\to\your\folder" -Target "AppServiceContainer.Windows"
.\Get-AppCatResult.ps1 -Source "Folder" -ApplicationPath "C:\path\to\your\folder" -Target "ACA"
.\Get-AppCatResult.ps1 -Source "Folder" -ApplicationPath "C:\path\to\your\folder" -Target "AKS.Linux"
.\Get-AppCatResult.ps1 -Source "Folder" -ApplicationPath "C:\path\to\your\folder" -Target "AKS.Windows"
.\Get-AppCatResult.ps1 -Source "Folder" -ApplicationPath "C:\path\to\your\folder" -Target "Any"
```

3. For Source as IISServer:
```powershell
.\Get-AppCatResult.ps1 -Source "IISServer" -IISSiteName "Site1" -Target "AppService.Linux"
.\Get-AppCatResult.ps1 -Source "IISServer" -IISSiteName "Site1" -Target "AppService.Windows"
.\Get-AppCatResult.ps1 -Source "IISServer" -IISSiteName "Site1" -Target "AppServiceContainer.Linux"
.\Get-AppCatResult.ps1 -Source "IISServer" -IISSiteName "Site1" -Target "AppServiceContainer.Windows"
.\Get-AppCatResult.ps1 -Source "IISServer" -IISSiteName "Site1" -Target "ACA"
.\Get-AppCatResult.ps1 -Source "IISServer" -IISSiteName "Site1" -Target "AKS.Linux"
.\Get-AppCatResult.ps1 -Source "IISServer" -IISSiteName "Site1" -Target "AKS.Windows"
.\Get-AppCatResult.ps1 -Source "IISServer" -IISSiteName "Site1" -Target "Any"
```

4. For Source as IISServer with multiple IISSiteName values:
```powershell
.\Get-AppCatResult.ps1 -Source "IISServer" -IISSiteName "Site1,Site2" -Target "AppService.Linux"
.\Get-AppCatResult.ps1 -Source "IISServer" -IISSiteName "Site1,Site2" -Target "AppService.Windows"
.\Get-AppCatResult.ps1 -Source "IISServer" -IISSiteName "Site1,Site2" -Target "AppServiceContainer.Linux"
.\Get-AppCatResult.ps1 -Source "IISServer" -IISSiteName "Site1,Site2" -Target "AppServiceContainer.Windows"
.\Get-AppCatResult.ps1 -Source "IISServer" -IISSiteName "Site1,Site2" -Target "ACA"
.\Get-AppCatResult.ps1 -Source "IISServer" -IISSiteName "Site1,Site2" -Target "AKS.Linux"
.\Get-AppCatResult.ps1 -Source "IISServer" -IISSiteName "Site1,Site2" -Target "AKS.Windows"
.\Get-AppCatResult.ps1 -Source "IISServer" -IISSiteName "Site1,Site2" -Target "Any"
```