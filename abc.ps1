#.\abc.ps1 -ComputerName1 ALDSBXDBPOPS01.chicago.local -ComputerName2 ALDSBXDBPOPS01.chicago.local
param(

    [string]$ComputerName1,
    [string]$ComputerName2

)
#ALDSBXDBPOPS01.chicago.local
$ProdServer = Get-WmiObject Win32_logicaldisk -ComputerName $ComputerName1 -filter "DeviceID='J:'"
$Conversion_TotalSizePRD = [int]($ProdServer.Size / 1GB)
$Conversion_FreeSizePRD = [int]($ProdServer.FreeSpace / 1GB)
$Conversion_UsedSizePRD = $Conversion_TotalSizePRD - $Conversion_FreeSizePRD
write-Host("The Used Disk space of Prod server is $Conversion_UsedSizePRD" + "GB")
write-Host("The Free Disk space of Prod server is $Conversion_FreeSizePRD" + "GB")
write-Host("The Total Disk space of Prod server is $Conversion_TotalSizePRD" + "GB")


$RefreshingServer = Get-WmiObject Win32_logicaldisk -ComputerName $ComputerName2 -filter "DeviceID='F:'"
$Conversion_TotalSizeRS = [int]($RefreshingServer.Size / 1GB)
$Conversion_FreeSizeRS = [int]($RefreshingServer.FreeSpace / 1GB)
$Conversion_UsedSizeRS = $Conversion_TotalSizeRS - $Conversion_FreeSizeRS
write-Host("The Used Disk space of refreshing server is $Conversion_UsedSizeRS" + "GB")
write-Host("The Free Disk space of refreshing server is $Conversion_FreeSizeRS" + "GB")
write-Host("The Total Disk space of refreshing server is $Conversion_TotalSizeRS" + "GB")


if ($Conversion_UsedSizePRD -le $Conversion_FreeSizeRS ) {
    write-host("We can proceed with the refresh")

}
else {
    write-host("please raise a ticket to increase the disk volume")
}