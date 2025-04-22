####################################################################################
# Autor : Pauline 
# Version : 1.0 
# Description : Script information interface.ps1
# Etat : a tester
####################################################################################

# --- Adresse IP de la machine distante ---
$ip = Read-Host "Entrez l'adresse IP de la machine distante"

# --- Boucle de menu principal ---
$choix = ""

while ($choix -ne "retour") {
    Write-Host "`n========= MENU PRINCIPAL ========="
    Write-Host "Pour voir la liste des interfaces réseau : 1 "
    Write-Host "Pour voir la liste des adresses IP avec le nom des interfaces : 2"
    Write-Host "Pour voir la liste des adresses MAC avec le nom des interfaces : 3"
    Write-Host "Pour revenir au menu precedent : retour"
    Write-Host "=================================="

    $choix = Read-Host "Votre choix"

    switch ($choix) {
        "1" {
            Write-Host "Liste des interfaces réseau sur $ip"
            Invoke-Command -HostName $ip -ScriptBlock {
                ip link show
            }
        }

        "2" {
            Write-Host "Liste des adresses IP avec le nom des interfaces sur $ip"
            Invoke-Command -HostName $ip -ScriptBlock {
                ip addr show
            }
        }

        "3" {
            Write-Host "Liste des adresses MAC avec le nom des interfaces sur $ip"
            Invoke-Command -HostName $ip -ScriptBlock {
                ip link show | grep ether
            }
        }

        "retour" {
            Write-Host "Retour au menu precedent"
        }

        default {
            Write-Host " Choix invalide. Merci de recommencer." -ForegroundColor Yellow
        }
    }
}

