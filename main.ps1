Add-Type -AssemblyName System.Windows.Forms

$objForm = [System.Windows.Forms.Form]
$objLbl = [System.Windows.Forms.Label]
$objBtn = [System.Windows.Forms.Button]
$objTxtBox = [System.Windows.Forms.TextBox]

$Form = New-Object $objForm
$Form.ClientSize = '300,300'
$Form.Text = 'VDApp'
$Form.BackColor = "#ffffff"
$Form.StartPosition = 'CenterScreen'
$Form.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon("F:\ps\voltage_divider\favicon.ico")  # Replace with the path to your icon file
$Form.MaximizeBox = $false

#VOLTAGE LABEL
$lblVout = New-Object $objLbl
$lblVout.Text = "Vout:"
$lblVout.AutoSize = $true
$lblVout.Location = New-Object System.Drawing.Point(120,20)

$lblVin = New-Object $objLbl
$lblVin.Text = "Vin"
$lblVin.AutoSize = $true
$lblVin.Location = New-Object System.Drawing.Point(120,40)

#RESISTANCE LABEL
$lblR1 = New-Object $objLbl
$lblR1.Text = "R1"
$lblR1.AutoSize = $true
$lblR1.Location = New-Object System.Drawing.Point(120,60)

$lblR2 = New-Object $objLbl
$lblR2.Text = "R2"
$lblR2.AutoSize = $true
$lblR2.Location = New-Object System.Drawing.Point(120,80)


#OUTPUT LABEL
$lblOut = New-Object $objLbl
$lblOut.Text = ''
$lblOut.AutoSize = $false
$lblOut.Location = New-Object System.Drawing.Point(120,100)

#TEXTBOXES
$bxVout = New-Object $objTxtBox
$bxVout.Location = New-Object System.Drawing.Point(150,20)
$bxVout.Size = New-Object System.Drawing.Size(50,1)

$bxVin = New-Object $objTxtBox
$bxVin.Location = New-Object System.Drawing.Point(150,40)
$bxVin.Size = New-Object System.Drawing.Size(50,1)

$bxR1 = New-Object $objTxtBox
$bxR1.Location = New-Object System.Drawing.Point(150,60)
$bxR1.Size = New-Object System.Drawing.Size(50,1)

$bxR2 = New-Object $objTxtBox
$bxR2.Location = New-Object System.Drawing.Point(150,80)
$bxR2.Size = New-Object System.Drawing.Size(50,1)

#BUTTONS
$btnCalc = New-Object $objBtn
$btnCalc.Location = New-Object System.Drawing.Point(100,200)
$btnCalc.Width = 50
$btnCalc.Text ='CALC'

$btnClear = New-Object $objBtn
$btnClear.Location = New-Object System.Drawing.Point(150,200)

$btnClear.Text = 'CLEAR'

function txtCalc{
    $varVout = $bxVout.Text -as [double]
    $varVin = $bxVin.Text -as [double]
    $varR1 = $bxR1.Text -as [double]
    $varR2 = $bxR2.Text -as [double]

    #CASE VOUT
    if($bxVout.Text -eq '' -and 
    [System.Double]::TryParse($varVin, [ref]$null) -and
    [System.Double]::TryParse($varR1, [ref]$null) -and
    [System.Double]::TryParse($varR2, [ref]$null) ){
    
    $varTemp = $varR1 + $varR2
    $varTemp = $varR2 / $varTemp
    $varTemp = $varVin * $varTemp
    $varTemp = [math]::Round($varTemp,2)
    $lblOut.text = 'Vout = ' + $varTemp +'V'
    }
    #CASE VIN
    elseif($bxVin.Text -eq '' -and 
    [System.Double]::TryParse($varVout, [ref]$null) -and
    [System.Double]::TryParse($varR1, [ref]$null) -and
    [System.Double]::TryParse($varR2, [ref]$null) ){
    
    $varTemp = $varR1 + $varR2
    $varTemp = $varR2 / $varTemp
    $varTemp = $varVout / $varTemp
    $varTemp = [math]::Round($varTemp,2)
    $lblOut.text = 'Vout = ' + $varTemp +'V'
    }
    #CASE R1
    elseif($bxR1.Text -eq '' -and 
    [System.Double]::TryParse($varVout, [ref]$null) -and
    [System.Double]::TryParse($varVin, [ref]$null) -and
    [System.Double]::TryParse($varR2, [ref]$null) ){
    
    $varTemp = $varR1 + $varR2
    $varTemp = $varR2 / $varTemp
    $varTemp = $varVout / $varTemp
    $varTemp = [math]::Round($varTemp,2)
    $lblOut.text = 'Vout = ' + $varTemp +'V'
    }
    #CASE R2
    elseif($bxVin.Text -eq '' -and 
    [System.Double]::TryParse($varVout, [ref]$null) -and
    [System.Double]::TryParse($varR1, [ref]$null) -and
    [System.Double]::TryParse($varVin, [ref]$null) ){
    
    $varTemp = $varR1 + $varR2
    $varTemp = $varR2 / $varTemp
    $varTemp = $varVout / $varTemp
    $varTemp = [math]::Round($varTemp,2)
    $lblOut.text = 'Vout = ' + $varTemp +'V'
    }
    elseif(
    -not [System.Double]::TryParse($varVout, [ref]$null) -or
    -not [System.Double]::TryParse($varVout, [ref]$null) -or
    -not [System.Double]::TryParse($varR1, [ref]$null) -or
    -not [System.Double]::TryParse($varVin, [ref]$null)){
    $lblOut.Text = 'Please enter a valid number.'
    }
    else{
    $lblOut.Text = 'Please leave 1 parameter blank'
    }
}

function txtClear{
$bxVout.Text = ''
$bxVin.Text = ''
$bxR1.Text = ''
$bxR2.Text = ''
$lblOut.Text = ''
}


$btnCalc.Add_Click({txtCalc})
$btnClear.Add_Click({txtClear})

$Form.Controls.AddRange(@(
$lblVout,
$lblVin,
$lblR1,
$lblR2,
$lblOut,
$bxVout,
$bxVin,
$bxR1,
$bxR2,
$btnCalc,
$btnClear
))

$Form.TopMost = $true
$Form.ShowDialog()

$Form.Dispose()