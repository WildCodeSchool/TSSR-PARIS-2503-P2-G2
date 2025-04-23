####################################################################################
# Auteur : Pauline 
# Version : 1.1 
# Description : Script application et utilisateur.ps1 (version PowerShell locale)
# État : a tester
####################################################################################

# --- Boucle de menu principal ---
$choix = ""

while ($choix -ne "retour") {
    Write-Host "`n========= MENU PRINCIPAL ========="
    Write-Host "1 → Liste des applications installées"
    Write-Host "2 → Liste des paquets installés (Programmes MSI/EXE)"
    Write-Host "3 → Liste des utilisateurs locaux"
    Write-Host "retour → Quitter le script"
    $choix = Read-Host "Votre choix"

    switch ($choix) {
        "1" {
            Write-Host "`n Liste des applications installées (via Get-WmiObject)"
            Get-WmiObject -Class Win32_Product | Select-Object Name, Version | Format-Table -AutoSize
        }

        "2" {
            Write-Host "`n Liste des programmes installés (via registre)"
            Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |
                Select-Object DisplayName, DisplayVersion | Where-Object { $_.DisplayName } |
                Sort-Object DisplayName | Format-Table -AutoSize
        }

        "3" {
            Write-Host "`n Liste des utilisateurs locaux"
            Get-LocalUser | Select-Object Name, Enabled, LastLogon | Format-Table -AutoSize
        }

        "retour" {
            Write-Host " Fin du script. À bientôt !" -ForegroundColor Cyan
        }

        default {
            Write-Host " Choix invalide. Merci de recommencer." -ForegroundColor Yellow
        }
    }
}
