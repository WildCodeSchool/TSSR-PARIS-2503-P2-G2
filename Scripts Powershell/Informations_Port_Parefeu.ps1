######################################################################
# Auteur : Chahine MARZOUK
# Version : 2.0 (WinRM)
# Description : Script d'informations sur les ports ouverts et le pare-feu via PowerShell/WinRM
######################################################################

# Forcer l'encodage UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Cible distante
$cible = Read-Host "Nom ou IP de la machine distante"

# Authentification
$utilisateur = Read-Host "Nom d'utilisateur (ex: MACHINE\Administrateur)"
$mdp = Read-Host "Mot de passe" -AsSecureString
$creds = New-Object System.Management.Automation.PSCredential($utilisateur, $mdp)

# Vérifier la connexion
try {
    Invoke-Command -ComputerName $cible -Credential $creds -ScriptBlock { hostname } -ErrorAction Stop | Out-Null
} catch {
    Write-Host "Erreur : impossible de se connecter à $cible avec l'utilisateur $utilisateur."
    exit 1
}

# Fonction menu
function Show-Menu {
    Clear-Host
    Write-Host "===== Informations Pare-feu & Ports sur ($cible) ====="
    Write-Host "1) Liste des ports ouverts (TCP/UDP)"
    Write-Host "2) Statut du pare-feu Windows"
    Write-Host "3) Quitter"
}

do {
    Show-Menu
    $choix = Read-Host "Choisissez une option (1-3)"

    switch ($choix) {
        "1" {
            Invoke-Command -ComputerName $cible -Credential $creds -ScriptBlock {
                Write-Output ">>> Ports TCP ouverts :"
                Get-NetTCPConnection | Select-Object LocalAddress, LocalPort, State, OwningProcess

                Write-Output ""
                Write-Output ">>> Ports UDP ouverts :"
                Get-NetUDPEndpoint | Select-Object LocalAddress, LocalPort, OwningProcess
            }
        }

        "2" {
            Invoke-Command -ComputerName $cible -Credential $creds -ScriptBlock {
                Write-Output ">>> Statut du pare-feu par profil :"
                Get-NetFirewallProfile | Select-Object Name, Enabled, DefaultInboundAction, DefaultOutboundAction
            }
        }

        "3" {
            Write-Host "Fin du script."
            break
        }

        default {
            Write-Host "Option invalide. Veuillez choisir un nombre entre 1 et 3."
        }
    }

    if ($choix -ne "3") {
        Write-Host ""
        Read-Host "Appuyez sur Entrée pour revenir au menu..."
    }
} while ($choix -ne "3")
