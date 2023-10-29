

    
	#Eliminar archivo temporal que se envio por correo
	Remove-Item C:\temp\Datos.csv
	#Eliminar archivo que se envio por correo
	Remove-Item C:\temp\Datos_vps1.csv

	# Datos que van en la cabezera
     $1v="Date and time:"
     $2v="Computer Name:"
     $3v="CPU usage (%):"
     $4v="Total Memory:(MB)"
     $5v="Memory Use:(MB)"
     $6v="Free memory:(MB)"
     $7v="Percentage Memory Use:(%)"
     $8v="Free Space Disk C: (GB)"
    # >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    # Exportar en CSV 
     "$1v; $2v; $3v;$4v; $5v; $6v;$7v;$8v" | out-file -filepath C:\temp\Datos.csv -append -width 200