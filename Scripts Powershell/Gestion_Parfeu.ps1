<#
    Script : Gestion Pare-feu Windows
    Version : 1.0
    Auteur : Sadek S. (Sabiri)
    Description : Active, désactive et affiche les règles personnalisées du pare-feu Windows.
#>

# Liste des ports autorisés
$allowedPorts = @(22, 80, 443, 53)  # SSH, HTTP, HTTPS, DNS

function Enable-Firewall {
    Write-Host "`n[+] Activation du pare-feu avec règles personnalisées..." -ForegroundColor Green

    # Activer le pare-feu pour tous les profils
    Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True

    # Supprimer les anciennes règles créées par le script
    Get-NetFirewallRule -DisplayName "CustomRule_*" -ErrorAction SilentlyContinue | Remove-NetFirewallRule

    # Autoriser les connexions sur les ports définis
    foreach ($port in $allowedPorts) {
        $ruleName = "CustomRule_Port_$port"
        New-NetFirewallRule -DisplayName $ruleName `
                            -Direction Inbound `
                            -Action Allow `
                            -Protocol TCP `
                            -LocalPort $port `
                            -Profile Any
        Write-Host " -> Port $port (TCP) autorisé"
    }

    # Autoriser le ping (ICMP)
    New-NetFirewallRule -DisplayName "CustomRule_ICMP_Ping" `
                        -Protocol ICMPv4 `
                        -Direction Inbound `
                        -Action Allow `
                        -Profile Any

    Write-Host "`n[+] Règles de pare-feu appliquées avec succès." -ForegroundColor Green
}

function Disable-Firewall {
    Write-Host "`n[+] Désactivation du pare-feu..." -ForegroundColor Yellow
    Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
    Write-Host "[+] Pare-feu désactivé pour tous les profils." -ForegroundColor Yellow
}

function Show-FirewallRules {
    Write-Host "`n[+] Règles de pare-feu actives (personnalisées) :" -ForegroundColor Cyan
    Get-NetFirewallRule | Where-Object {$_.DisplayName -like "CustomRule_*"} | Format-Table DisplayName, Enabled, Direction, Action, Profile, Protocol, LocalPort
}

# Menu interactif
do {
    Write-Host "`n=== GESTION PARE-FEU WINDOWS - VERSION 1.0 ===" -ForegroundColor Cyan
    Write-Host "Auteur : Sadek S." -ForegroundColor DarkCyan
    Write-Host "---------------------------------------------"
    Write-Host "1. Activer le pare-feu avec règles"
    Write-Host "2. Désactiver
