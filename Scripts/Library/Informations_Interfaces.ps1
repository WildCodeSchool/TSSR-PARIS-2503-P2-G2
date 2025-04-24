####################################################################################
# Auteur : Pauline 
# Version : 1.0 
# Description : Script information interface.ps1 (avec WinRM)
# État : à tester
####################################################################################

# --- Adresse IP de la machine distante ---
$ip = Read-Host "Entrez l'adresse IP de la machine distante"

# --- Demander les identifiants d'authentification ---
$cred = Get-Credential

# --- Boucle de menu principal ---
$choix = ""

while ($choix -ne "retour") {
    Write-Host "`n========= MENU PRINCIPAL ========="
    Write-Host "1 → Liste des interfaces réseau"
    Write-Host "2 → Liste des adresses IP avec nom des interfaces"
    Write-Host "3 → Liste des adresses MAC avec nom des interfaces"
    Write-Host "retour → Quitter le menu"
    Write-Host "=================================="

    $choix = Read-Host "Votre choix"

    switch ($choix) {
        "1" {
            Write-Host "`n Interfaces réseau sur $ip"
            Invoke-Command -ComputerName $ip -Credential $cred -ScriptBlock {
                Get-NetAdapter | Select-Object Name, InterfaceDescription, Status | Format-Table -AutoSize
            }
        }

        "2" {
            Write-Host "`n Adresses IP avec le nom des interfaces sur $ip"
            Invoke-Command -ComputerName $ip -Credential $cred -ScriptBlock {
                Get-NetIPAddress | Select-Object InterfaceAlias, IPAddress, AddressFamily | Format-Table -AutoSize
            }
        }

        "3" {
            Write-Host "`n Adresses MAC avec le nom des interfaces sur $ip"
            Invoke-Command -ComputerName $ip -Credential $cred -ScriptBlock {
                Get-NetAdapter | Select-Object Name, MacAddress, Status | Format-Table -AutoSize
            }
        }

        "retour" {
            Write-Host "Retour au menu précédent."
        }

        default {
            Write-Host " Choix invalide. Merci de recommencer." -ForegroundColor Yellow
        }
    }
}
