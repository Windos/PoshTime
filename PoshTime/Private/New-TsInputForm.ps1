function New-TsInputForm
{
    param
    (
        [string] $Title = 'TimeSheet',
        [string] $Message = 'What are you working on?',
        [string] $Default = ''
    )

    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 

    $TsForm = New-Object System.Windows.Forms.Form
    $TsForm.Text = "$Title"
    $TsForm.Size = New-Object System.Drawing.Size(290,150)
    $TsForm.Location = [System.Drawing.Point]::new(([System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Width - $TsForm.Size.Width) / 2, ([System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Height - $TsForm.Size.Height) / 2) #[System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Location
    $TsForm.StartPosition = "Manual"
    $TsForm.AutoSize = $False
    $TsForm.MinimizeBox = $False
    $TsForm.MaximizeBox = $False
    $TsForm.SizeGripStyle = "Hide"
    $TsForm.WindowState = "Normal"
    $TsForm.FormBorderStyle ="Fixed3D"
         
    $OKButton = New-Object System.Windows.Forms.Button
    $OKButton.Location = New-Object System.Drawing.Size(115,80)
    $OKButton.Size = New-Object System.Drawing.Size(75,23)
    $OKButton.Text = "OK"
    $OKButton.TabIndex = 1
    $OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $OKButton.Add_Click({$TsForm.Close()})
    $TsForm.Controls.Add($OKButton)
    $TsForm.AcceptButton = $OKButton
    
    $CancelButton = New-Object System.Windows.Forms.Button
    $CancelButton.Location = New-Object System.Drawing.Size(195,80)
    $CancelButton.Size = New-Object System.Drawing.Size(75,23)
    $CancelButton.Text = "Cancel"
    $CancelButton.TabIndex = 2
    $CancelButton.Add_Click({$TsForm.Close()})
    $TsForm.Controls.Add($CancelButton)
    $TsForm.CancelButton = $CancelButton
    
    $MessageLabel = New-Object System.Windows.Forms.Label
    $MessageLabel.Location = New-Object System.Drawing.Size(10,20)
    $MessageLabel.Size = New-Object System.Drawing.Size(280,20)
    $MessageLabel.Text = "$Message"
    $TsForm.Controls.Add($MessageLabel) 
    
    $ResponseTextBox = New-Object System.Windows.Forms.TextBox
    $ResponseTextBox.Location = New-Object System.Drawing.Size(10,40)
    $ResponseTextBox.Size = New-Object System.Drawing.Size(260,20)
    $ResponseTextBox.Text = "$Default"
    $ResponseTextBox.TabIndex = 0
    $ResponseTextBox.Select()
    $TsForm.Controls.Add($ResponseTextBox) 
    
    $TsForm.Topmost = $True
    $TsForm.ShowIcon = $False
    
    $TsForm.Add_Shown({$TsForm.Activate()})
    $TsForm.Add_GotFocus({$ResponseTextBox.Select()})

    [void] $TsForm.ShowDialog()

    return $ResponseTextBox.Text
}
