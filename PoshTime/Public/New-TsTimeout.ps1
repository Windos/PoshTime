function New-TsTimeout {
    param (
        [string] $Path = $Script:Config.TimesheetDirectory,
        [int] $Timeout = $Script:Config.Timeout
    )

    $Command = "Import-Module PoshTime; New-TsEntry -Path $Path"

    $Process = Start-Process -FilePath powershell.exe -ArgumentList "-noprofile -Command $Command" -PassThru -NoNewWindow

    try {
        $Process | Wait-Process -Timeout $Timeout -ErrorAction Stop
        Write-Verbose -Message 'Process successfully completed within timeout.'
    } catch {
        Write-Verbose -Message 'Process exceeded timeout, will be killed now.'
        $Process | Stop-Process -Force
        $Record = [PSCustomObject] @{
    		Time = Get-Date
            User = $env:USERNAME
    		Activity = '** TimedOut **'
    	}
        $Record | Export-Csv -Path "$Path\$($env:USERNAME).csv" -Append -NoTypeInformation -Force
    }
}
