# Auteur : Chahine MARZOUK
# Version : 1.0
# Description : Script Informations Système en PowerShell via WinRM

# Nom de l'ordinateur distant (nom NetBIOS ou IP)
$client = Read-Host "Nom ou IP de la machine distante"

# Nom d'utilisateur au format Domaine\NomUtilisateur ou NomMachine\NomUtilisateur
$remote_user = Read-Host "Nom d'utilisateur (ex: MACHINE\Administrateur)"
$securePassword = Read-Host "Mot de passe" -AsSecureString
$creds = New-Object System.Management.Automation.PSCredential($remote_user, $securePassword)

# Boucle menu
while ($true) {
    Write-Host ""
    Write-Host "=== Informations Système ==="
    Write-Host "1) Type de CPU, nombre de cœurs, etc."
    Write-Host "2) Mémoire RAM totale"
    Write-Host "3) Utilisation de la RAM"
    Write-Host "4) Utilisation du disque"
    Write-Host "5) Utilisation du processeur"
    Write-Host "6) Quitter"
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
                "Mémoire RAM Totale : {0} Go" -f [math]::Round($mem.TotalPhysicalMemory / 1GB, 2)
            }
        }
        "3" {
            Invoke-Command -ComputerName $client -Credential $creds -ScriptBlock {
                Get-CimInstance Win32_OperatingSystem | ForEach-Object {
                    "RAM utilisée : {0} Go" -f [math]::Round(($_.TotalVisibleMemorySize - $_.FreePhysicalMemory)/1MB, 2)
                    "RAM disponible : {0} Go" -f [math]::Round($_.FreePhysicalMemory/1MB, 2)
                }
            }
        }
        "4" {
            Invoke-Command -ComputerName $client -Credential $creds -ScriptBlock {
                Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" | Select-Object DeviceID, @{n='Espace total (Go)';e={[math]::Round($_.Size/1GB,2)}}, @{n='Espace libre (Go)';e={[math]::Round($_.FreeSpace/1GB,2)}}
            }
        }
        "5" {
            Invoke-Command -ComputerName $client -Credential $creds -ScriptBlock {
                $cpuLoad = Get-CimInstance Win32_Processor | Select-Object -ExpandProperty LoadPercentage
                "Utilisation CPU : $cpuLoad %"
            }
        }
        "6" {
            Write-Host "Fin du script."
            break
        }
        Default {
            Write-Host "Option invalide. Veuillez choisir un nombre entre 1 et 6."
        }
    }

    Write-Host ""
    Read-Host "Appuyez sur Entrée pour continuer..."
    Clear-Host
}
