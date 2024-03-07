<#
.SYNOPSIS
Analyzes .NET applications for replatforming and migration opportunities for Azure.
The script allows you to analyze .NET applications source code to identify replatforming and migration opportunities for Azure. It supports different sources such as Solution, Folder, and IISServer, and various target platforms including AppService.Linux, AppService.Windows, AppServiceContainer.Linux, AppServiceContainer.Windows, ACA, AKS.Linux, AKS.Windows, and Any.
For IISServer as the source, you can specify multiple IISSiteName values separated by commas.

.DESCRIPTION
This script automates the analysis of an application for migration to Azure using the appcat analyze command. 
It allows you to specify various parameters such as the application path, target platform, report path, serializer, and source type.

.PARAMETER ApplicationPath
Specifies the path to the application to be analyzed. Default value is "C:\workspace\source\ang-net\BooksApi\BooksApi.sln".

.PARAMETER Target
Specifies the target platform for the migration. Default value is "Any".
Possible values are: AppService.Linux, AppService.Windows, AppServiceContainer.Linux, AppServiceContainer.Windows, ACA, AKS.Linux, AKS.Windows, Any.

.PARAMETER ReportPath
Specifies the path where the assessment report will be saved. Default value is "C:\appcat".

.PARAMETER Serializer
Specifies the format for the report. Default value is "html".

.PARAMETER Source
Specifies the source type which the tool should analyze. Default value is "IISServer".
Possible values are: Solution, Folder, IISServer.

.PARAMETER IISSiteName
Specifies the name(s) of the IIS site(s) to be analyzed. This parameter is required when Source is IISServer.
You can provide multiple site names by separating them with commas.
Comma-separated list of IISSiteName values when the Source is IISServer.

.PARAMETER IncludeChildFolders
Switch parameter to specify whether to include analysis of child folders when the Source is a folder.

.OUTPUTS
The script runs the appcat analyze command and saves the assessment report to the specified report path.

.EXAMPLE
.\Get-AppCatResult.ps1

Runs the script with default parameters.

.EXAMPLE
.\Get-AppCatResult.ps1 -ApplicationPath "C:\path\to\application" -Target "AppService.Windows" -ReportPath "C:\output\folder" -Serializer "html" -Source "Folder"

Runs the script with custom parameters.

.\Get-AppCatResult.ps1 -Source "Folder" -Target "AppService.Linux" -ApplicationPath "C:\MyApp" -ReportPath "C:\Reports" -Serializer "html"

 Analyzes the .NET application located at "C:\MyApp" folder for replatforming opportunities targeting AppService.Linux platform. The analysis report will be saved in HTML format at "C:\Reports".

.EXAMPLE
  .\Get-AppCatResult.ps1 -Source "IISServer" -Target "AppService.Windows" -IISSiteName "Site1,Site2" -ReportPath "C:\Reports"

  Analyzes the specified IIS sites (Site1 and Site2) for replatforming opportunities targeting AppService.Windows platform. The analysis report will be saved in the default format at "C:\Reports".
#>

# Define named argument parameters
param (
    [Parameter()]
    [string]$Path = "C:\workspace\source\ang-net\BooksApi\BooksApi.sln",
    [Parameter()]
    [string]$Target = "Any", # AppService.Linux, AppService.Windows, AppServiceContainer.Linux,AppServiceContainer.Windows, ACA, AKS.Linux,  AKS.Windows, Any
    [Parameter()]
    [string]$ReportPath = "C:\appcat\",
    [Parameter()]
    [string]$Serializer = "html",
    [Parameter()]
    [string]$Source = "IISServer", # Solution, Folder, IISServer
    [Parameter()]
    [string[]]$IISSiteName = @(), # Required when Source is IISServer
    [Parameter()]
    [switch]$IncludeChildFolders = $false
)
$BaseReportPath = $ReportPath 

# Conditionally add --code flag if Source is Solution
$CodeFlag = if ($Source -eq "Solution") { "--code" } else { "" }

# Conditionally add --binaries flag if Source is Folder or IISServer
$BinariesFlag = if ($Source -eq "Folder" -or $Source -eq "IISServer") { "--binaries" } else { "" }

# Function to run the appcat analyze command 
function RunAppCat($PlaceHolder) {

    $appcatCommand = "appcat analyze  --source $Source --target $Target  --serializer $Serializer --non-interactive $CodeFlag $BinariesFlag"
    
    if ( $PlaceHolder -ne "") {
        $appcatCommand += "  $($PlaceHolder.FullName)"       
    }

    if ($Source -eq "Folder") {
        $rp = Split-Path $($PlaceHolder.FullName) -Leaf           
        # Create a new report folder for each child folder        
        $ReportPath = Join-Path -Path (Join-Path -Path $BaseReportPath -ChildPath $Source) -ChildPath $rp   

    }
    elseif ($Source -eq "Solution") {        
        $rp = Split-Path $Path -Parent | Split-Path -Leaf       
        # Create a new report folder for each child folder
        $ReportPath = Join-Path -Path (Join-Path -Path $BaseReportPath -ChildPath $Source) -ChildPath $rp   

    } elseif ($Source -eq "IISServer" ) {
        
        $ReportPath = Join-Path -Path $BaseReportPath -ChildPath $Source
    }

    Write-Host  $($PlaceHolder.FullName)  
    Write-Host $ReportPath
    
    # Check if the report path exists and delete it if it does
    if (Test-Path -Path $ReportPath) {
        Remove-Item -Path $ReportPath -Recurse -Force
    }
    # Check if IISSiteNames is provided
    if ($Source -eq "IISServer" -and $IISSiteNames -ne "") {
        $appcatCommand += " --IISSiteName $($IISSiteName -join ',')"
    }
    
    $appcatCommand += "  --report $ReportPath"
    
    Invoke-Expression $appcatCommand
}



# Check if the source is IISServer and IISSiteNames is provided
if ($Source -eq "IISServer" ) {
    RunAppCat 
}
elseif ($Source -eq "Solution") {
    $SolutionFile = Get-Item -Path $Path -Filter *.sln 
    RunAppCat $SolutionFile    
}
elseif ($Source -eq "Folder") {
    # Check if the flag to include child folders is set and $Source is "Folder"
    if ($IncludeChildFolders -and $Source -eq "Folder") {
        # Get a list of child folders one level down from the root folder
        $ChildFolders = Get-ChildItem -Path $Path -Directory

        # Iterate through each child folder and run the script for each one
        foreach ($Folder in $ChildFolders) {
            RunAppCat $Folder
        }
    }
    else {
        # Run the appcat analyze command for the root folder only
        RunAppCat (Get-Item -Path $Path)
    }  
}

# Display author/developer information
Write-Host "Author: Ravinder Singh Rana"
Write-Host "Email: v-ravrana@microsoft.com"
Write-Host "Version: 1.0"
Write-Host "Date: 06-March-2024"