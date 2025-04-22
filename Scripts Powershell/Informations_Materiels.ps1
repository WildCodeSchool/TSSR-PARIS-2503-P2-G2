
######################################################################
# Auteur : Marzouk 
# Version : 2.0 (WinRM)
# Description : Script d'informations systeme via PowerShell/WinRM
######################################################################

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$client = Read-Host "Nom ou IP de la machine distante"
$creds = Get-Credential -Message "Entrez les identifiants pour la machine distante $client"

function Show-Menu {
    Clear-Host
    Write-Host "=== Informations Systeme sur ($client) ==="
    Write-Host "1) Type de CPU, nombre de coeurs"
    Write-Host "2) Memoire RAM totale"
    Write-Host "3) Utilisation de la RAM"
    Write-Host "4) Utilisation du disque"
    Write-Host "5) Utilisation du processeur"
    Write-Host "6) Quitter"
}

do {
    Show-Menu
    $choix = Read-Host "Choisissez une option (1-6)"

    switch ($choix) {
        "1" {
            Invoke-Command -ComputerName $client -Credential $creds -ScriptBlock {
                Get-CimInstance Win32_Processor | Select-Object Name, NumberOfCores, NumberOfLogicalProcessors
            }
        }

        "2" {
            Invoke-Command -ComputerName $client -Credential $creds -ScriptBlock {
                $mem = Get-CimInstance Win32_ComputerSystem
                Write-Output ("Memoire RAM Totale : {0} Go" -f [math]::Round($mem.TotalPhysicalMemory / 1GB, 2))
            }
        }

        "3" {
            Invoke-Command -ComputerName $client -Credential $creds -ScriptBlock {
                Get-CimInstance Win32_OperatingSystem | ForEach-Object {
                    Write-Output ("RAM utilisee : {0} Go" -f [math]::Round(($_.TotalVisibleMemorySize - $_.FreePhysicalMemory)/1MB, 2))
                    Write-Output ("RAM disponible : {0} Go" -f [math]::Round($_.FreePhysicalMemory/1MB, 2))
                }
            }
        }

        "4" {
            Invoke-Command -ComputerName $client -Credential $creds -ScriptBlock {
                Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" |
                Select-Object DeviceID, 
                              @{Name='Espace total (Go)';Expression={[math]::Round($_.Size/1GB,2)}},
                              @{Name='Espace libre (Go)';Expression={[math]::Round($_.FreeSpace/1GB,2)}}
            }
        }

        "5" {
            Invoke-Command -ComputerName $client -Credential $creds -ScriptBlock {
                $cpuLoad = Get-CimInstance Win32_Processor | Select-Object -ExpandProperty LoadPercentage
                Write-Output ("Utilisation CPU : $cpuLoad %")
            }
        }

        "6" {
            Write-Host "Fin du script."
            break
        }

        default {
            Write-Host "Option invalide. Veuillez choisir un nombre entre 1 et 6."
        }
    }

    if ($choix -ne "6") {
        Write-Host ""
        Read-Host "Appuyez sur Entree pour revenir au menu..."
    }
} while ($choix -ne "6")
