function New-TsEntry {
    param (
        [string] $Path = $Script:Config.TimesheetDirectory
    )

    if (!(Test-Path -Path $Path)) {
        $null = New-Item -Path $Path -ItemType Directory
    }

    $Response = New-TsInputForm

    if ($Response -eq '' -or $Response -eq $null) {
        $Response = '** Canceled **'
    }

    $Record = [PSCustomObject] @{
		Time = Get-Date
        User = $env:USERNAME
		Activity = $Response
	}

    $Record | Export-Csv -Path "$Path\$($env:USERNAME).csv" -Append -NoTypeInformation -Force
}
