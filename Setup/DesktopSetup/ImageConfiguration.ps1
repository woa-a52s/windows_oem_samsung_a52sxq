#-------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation.  All rights reserved.
#-------------------------------------------------------------------------------
$Global:ErrorActionPreference = 'Stop'
$logPath = "$PSScriptRoot\ImageConfigurationOOBE.log"

function ImageConfig {
    trap {
        $_
        Write-Host 'Stack Trace'
        Write-Host $_.ScriptStackTrace
    }

    Write-Host "> Prune extra Office languages to save space"
    & "${env:CommonProgramFiles}\Microsoft Shared\ClickToRun\OfficeClickToRun.exe" scenario=CULTUREREFRESH RemoveNonClientCultures=True displaylevel=False
	
    # Disable Windows Update Services
    #Write-Host "> Disabling Windows Update services..."
    #Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue
    #Set-Service -Name wuauserv -StartupType Disabled

    #Stop-Service -Name WaaSMedicSvc -Force -ErrorAction SilentlyContinue
    #Set-Service -Name WaaSMedicSvc -StartupType Disabled

    #Write-Host "> Disabling Windows Update registry settings..."
    #New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null
    #Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoUpdate" -Type DWord -Value 1

    #Clean up
    #Remove-Item -LiteralPath $MyInvocation.MyCommand.Path -Force -ErrorAction Ignore

    #No Reboot
    [Environment]::Exit(0)
}
Start-Transcript -Path $logPath
try {
    ImageConfig
}
catch {
    [Environment]::Exit(1)
}
finally {
    Stop-Transcript
}
