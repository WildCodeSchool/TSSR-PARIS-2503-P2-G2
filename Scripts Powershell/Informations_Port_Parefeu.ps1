# Auteur : Chahine MARZOUK
# Version : 1.0
# Description : Script Informations Port Pare-feu via WinRM

# Récupérer l'IP ou le nom d'hôte distant
$cible = Read-Host "Adresse IP ou nom de la machine distante"

# Récupérer les identifiants pour WinRM
$remote_user = Read-Host "Nom d'utilisateur (ex: MACHINE\Administrateur)"
$securePassword = Read-Host "Mot de passe" -AsSecureString
$creds = New-Object System.Management.Automation.PSCredential($remote_user, $securePassword)

# Tester la connexion avec une commande basique
try {
    Invoke-Command -ComputerName $cible -Credential $creds -ScriptBlock { hostname } -ErrorAction Stop | Out-Null
} catch {
    Write-Host "Erreur : impossible de se connecter à $cible avec l'utilisateur $remote_user."
    exit 1
}

# Boucle de menu
while ($true) {
    Write-Host ""
    Write-Host "===== Menu Informations Pare-feu ====="
    Write-Host "1) Liste des ports ouverts (TCP/UDP)"
    Write-Host "2) Statut du pare-feu Windows"
    Write-Host "3) Quitter"
    $choix = Read-Host "Choisissez une option (1-3)"

    switch ($choix) {
        "1" {
            Write-Host "----- 🔍 Liste des ports ouverts (TCP/UDP) -----"
            Invoke-Command -ComputerName $cible -Credential $creds -ScriptBlock {
                Get-NetTCPConnection | Select-Object LocalAddress, LocalPort, State, OwningProcess
                Get-NetUDPEndpoint | Select-Object LocalAddress, LocalPort, OwningProcess
            }
        }
        "2" {
            Write-Host "----- 🔐 Statut du pare-feu Windows -----"
            Invoke-Command -ComputerName $cible -Credential $creds -ScriptBlock {
                Get-NetFirewallProfile | Select-Object Name, Enabled, DefaultInboundAction, DefaultOutboundAction
            }
        }
        "3" {
            Write-Host "Fin du script."
            break
        }
        Default {
            Write-Host "Option invalide. Veuillez choisir un nombre entre 1 et 3."
        }
    }

    Write-Host ""
    Read-Host "Appuyez sur Entrée pour revenir au menu..."
    Clear-Host
}
