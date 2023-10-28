#Envio al correo
    $User = "correossl@tsolperu.com"
    $Password = ConvertTo-SecureString  -String "NeclzyZx" -AsPlainText -Force 
    $cred=New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $Password
# Este script muestra el uso de cpu, ram, disco
    $date=Get-Date
    $computer = gc env:computername
    # Vamos a crear un método WMI reutilizable para las estadísticas de la CPU
    $ProcessorStats = Get-WmiObject win32_processor -computer $computer
    $ComputerCpu = $ProcessorStats.LoadPercentage 
    # Vamos a crear un método WMI reutilizable para estadísticas de memoria
    $OperatingSystem = Get-WmiObject win32_OperatingSystem -computer $computer
    # Vamos a agarrar la memoria libre
    $FreeMemory = $OperatingSystem.FreePhysicalMemory
    $FreeMemoryinMb = [math]::truncate($FreeMemory/1024)
    # Vamos a agarrar la memoria total
    $TotalMemory = $OperatingSystem.TotalVisibleMemorySize
    $TotalMemoryinMb = [math]::truncate($TotalMemory/1024)
    # Hagamos algunos cálculos para la conversión de MB
    $MemoryUsed =[math]::truncate(($TotalMemory - $FreeMemory)/1024) 
    # Tomemos el porcentaje de memoria total
    $PercentageMemoryUsed =($MemoryUsed*100000)/$TotalMemory
    $PercentageMemoryUsedRound = [math]::Round($PercentageMemoryUsed, 2)
    # Disco libre
    $disk = Get-WmiObject Win32_LogicalDisk -ComputerName $computer -Filter "DeviceID='C:'" |Select-Object Size,FreeSpace
    $Disk_Free=[math]::round($disk.FreeSpace /1Gb, 2)
    clear
    # Mostrar datos
    # >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    # Write-Host "Date and time:" $date
    # Write-Host "Computer Name:" $computer
    # Write-Host "CPU usage:" $ComputerCpu "%"
    # Write-Host "Total Memory:" $TotalMemoryinMb "MB"  
    # Write-Host "Memory Use:" $MemoryUsed "MB"
    # Write-Host "Free memory:" $FreeMemoryinMb "MB" 
    # Write-Host "Percentage Memory Use:" $PercentageMemoryUsedRound "%" 
    # Write-Host "Free Space Disk C:" $Disk_Free "GB"
    Write-Host "Se envió el reporte"
    # >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    # Datos que van en la cabezera
    # $1v="Date and time:"
    # $2v="Computer Name:"
    # $3v="CPU usage (%):"
    # $4v="Total Memory:(MB)"
    # $5v="Memory Use:(MB)"
    # $6v="Free memory:(MB)"
    # $7v="Percentage Memory Use:(%)"
    # $8v="Free Space Disk C: (GB)"
    # >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    # Exportar en txt
    # "$1v, $2v, $3v,$4v, $5v, $6v,$7v,$8v" | out-file -filepath C:\temp\Datos.txt -append -width 200
    # "$date; $computer; $ComputerCpu;$TotalMemoryinMb; $MemoryUsed; $FreeMemoryinMb;$PercentageMemoryUsedRound;$Disk_Free" | out-file -filepath C:\temp\Datos.txt -append -width 200
    # Exportar en CSV
    # "$1v; $2v; $3v;$4v; $5v; $6v;$7v;$8v" | out-file -filepath C:\temp\Datos.csv -append -width 200
    "$date; $computer; $ComputerCpu;$TotalMemoryinMb; $MemoryUsed; $FreeMemoryinMb;$PercentageMemoryUsedRound;$Disk_Free" | out-file -filepath C:\temp\Datos.csv -append -width 200
    # >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    # Delimitar excel
    Import-Csv C:\temp\Datos.csv  -Delimiter ";" | Export-Csv   C:\temp\Datos_vps1.csv -NoTypeInformation | Format-Table 
    #Envio de reporte al correo
    #Send-MailMessage -Body "Reporte monitoreo de performance del VPS 1" -From "operations@tsolperu.com" -To "monitoreosiges@tsolperu.com" -Subject "Reporte monitoreo de performance del VPS 1" -SmtpServer "mail.tsolperu.com" -Port '587' -Credential $cred -attachment "C:\temp\Datos_vps1.csv"
    # Read-Host "Press any key to continue............"