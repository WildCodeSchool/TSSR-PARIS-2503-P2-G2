######################################################################
# Auteur : Chahine MARZOUK 
# Version : 2.1
# Description : Script de gestion de logiciels via WinRM (PowerShell)
######################################################################

# Configuration de la cible
$hote = "172.16.20.20"

# Demande des informations d'identification
$cred = Get-Credential -Message "Entrez les identifiants pour la machine distante $hote"

function Show-Menu {
    Clear-Host
    Write-Host "=== Gestion des logiciels sur la machine distante ($hote) ==="
    Write-Host "1) Installer un logiciel (via winget ou fichier MSI)"
    Write-Host "2) Désinstaller un logiciel"
    Write-Host "3) Exécuter un script PowerShell distant"
    Write-Host "4) Quitter"
}

do {
    Show-Menu
    $choix = Read-Host "Choisissez une option (1-4)"

    switch ($choix) {
        "1" {
            $logiciel = Read-Host "Nom du logiciel à installer (winget ID ou chemin MSI)"
            try {
                Invoke-Command -ComputerName $hote -Credential $cred -ScriptBlock {
                    param($pkg)
                    Write-Host "Tentative d'installation de $pkg..."
                    if ($pkg.EndsWith(".msi")) {
                        Start-Process "msiexec.exe" -ArgumentList "/i `"$pkg`" /quiet /norestart" -Wait
                    } else {
                        winget install --accept-source-agreements --accept-package-agreements $pkg
                    }
                } -ArgumentList $logiciel
            } catch {
                Write-Host "Erreur lors de l'installation : $_" -ForegroundColor Red
            }
        }

        "2" {
            $logiciel = Read-Host "Nom du logiciel à désinstaller (nom affiché ou ID)"
            try {
                Invoke-Command -ComputerName $hote -Credential $cred -ScriptBlock {
                    param($pkg)
                    Write-Host "Tentative de désinstallation de $pkg..."
                    winget uninstall --accept-source-agreements $pkg
                } -ArgumentList $logiciel
            } catch {
                Write-Host "Erreur lors de la désinstallation : $_" -ForegroundColor Red
            }
        }

        "3" {
            $chemin_script = Read-Host "Chemin absolu du script PowerShell sur la machine distante (ex: C:\Scripts\test.ps1)"
            try {
                Invoke-Command -ComputerName $hote -Credential $cred -ScriptBlock {
                    param($scriptPath)
                    if (Test-Path $scriptPath) {
                        Write-Host "Exécution de $scriptPath..."
                        & $scriptPath
                    } else {
                        Write-Host "Fichier introuvable : $scriptPath"
                    }
                } -ArgumentList $chemin_script
            } catch {
                Write-Host "Erreur d'exécution du script : $_" -ForegroundColor Red
            }
        }

        "4" {
            Write-Host "Fin du script."
            break
        }

        default {
            Write-Host "Option invalide. Veuillez choisir un nombre entre 1 et 4." -ForegroundColor Yellow
        }
    }

    if ($choix -ne "4") {
        Pause
    }
} while ($choix -ne "4")
