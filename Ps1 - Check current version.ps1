$software = 'Notepad++'


Function CheckCurrentVersion ($software){
    $Version = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion  | where {$_.DisplayName -match $software})
    Write-Host "Version of Notepad: " $Version.DisplayVersion

}

Function CheckLatestVersion{
    $npp = Invoke-WebRequest -UseBasicParsing 'https://api.github.com/repos/notepad-plus-plus/notepad-plus-plus/releases/latest' | ConvertFrom-Json
    $GetLatestVersion = $npp.tag_name
    Write-Host $GetLatestVersion
    $DownloadURL = $npp.assets[4].browser_download_url 
    Write-Host $DownloadURL
    $nppinstallfile = $npp.assets[4].name
    Invoke-WebRequest -UseBasicParsing $DownloadURL -OutFile $nppinstallfile
    Write-Host "Silently Installing $($npp.name)... Please wait..."
    Start-Process -FilePath $nppinstallfile -Args "/S" -Verb RunAs -Wait
}
    
Function CheckIfInstalled{
    param (
        [parameter(Mandatory=$true)]$software_to_check
        )

    Write-Output "Checking if $software_to_check is installed"

    $MatchString = [Regex]::Escape($software_to_check)

    $InstalledPackage = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -match $MatchString }) -ne $null

    If(-Not $InstalledPackage) 
    {
    	Write-Host "'$software' NOT is installed.";

    } 
    else 
    {
    	Write-Host "'$software' is installed."
        CheckCurrentVersion $MatchString
        CheckLatestVersion
    }
}
 
CheckIfInstalled $software 

