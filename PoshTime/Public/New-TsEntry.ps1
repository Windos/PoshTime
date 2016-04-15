function New-TsEntry
{
    param
    (
        [string] $Path = '\\redacted\share$\timesheets\'
    )

    if (!(Test-Path -Path $Path))
    {
        $null = New-Item -Path $Path -ItemType Directory
    }

    $Response = New-TsInputForm
    
    if ($Response -eq '' -or $Response -eq $null)
    {
        $Response = 'No Response - AFK?'
    }

    $Record = [pscustomobject] @{
		Time = Get-Date
        User = $env:USERNAME
		Activity = $Response
	}
    

    $Record | Export-Csv -Path "$Path\$($env:USERNAME).csv" -Append -NoTypeInformation -Force
}
