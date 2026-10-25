Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$script:clicks = 0
$script:last = [DateTime]::MinValue
$forms = @()

$onClick = {
    $now = [DateTime]::Now
    if (($now - $script:last).TotalSeconds -gt 1.5) { $script:clicks = 0 }
    $script:last = $now
    $script:clicks++
    if ($script:clicks -ge 3) { [System.Windows.Forms.Application]::Exit() }
}

foreach ($screen in [System.Windows.Forms.Screen]::AllScreens) {
    $f = New-Object System.Windows.Forms.Form
    $f.FormBorderStyle = 'None'
    $f.BackColor = [System.Drawing.Color]::Black
    $f.StartPosition = 'Manual'
    $f.Bounds = $screen.Bounds
    $f.TopMost = $true
    $f.ShowInTaskbar = $false
    $f.Cursor = New-Object System.Windows.Forms.Cursor((New-Object System.Drawing.Bitmap(1,1)).GetHicon())
    $f.Add_MouseDown($onClick)
    $f.Show()
    $forms += $f
}

[System.Windows.Forms.Application]::Run()
