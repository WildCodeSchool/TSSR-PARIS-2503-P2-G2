####################################################################################
# Auteur : Pauline 
# Version : 1.1 
# Description : information os.ps1
# État : à tester
####################################################################################

Write-Host "1 - Voir la version de l'OS d'une machine distante"
Write-Host "2 - Retour au menu précédent"
$choix = Read-Host "Faites un choix (1 ou 2)"

while ($choix -ne "2") {

    switch ($choix) {
        "1" {
            # Demander le nom de la machine distante
            $remotePC = Read-Host "`nEntrez le nom ou l'adresse IP de la machine distante (Windows 11)"

            # Demander les identifiants pour se connecter à la machine distante
            $credential = Get-Credential -Message "Identifiants de la machine distante (Windows 11)"

            # Essayer d’exécuter la commande distante
            try {
                $osInfo = Invoke-Command -ComputerName $remotePC -Credential $credential -ScriptBlock {
                    $os = Get-CimInstance Win32_OperatingSystem
                    return $os
                }

                Write-Host "Nom de l'OS      : $($osInfo.Caption)"
                Write-Host "Version          : $($osInfo.Version)"
            }
            catch {
                Write-Host "Erreur lors de la connexion ou de l’exécution : $_" -ForegroundColor Red
            }

            # Revenir au menu après un délai de pause
            Read-Host "Appuyez sur Entrée pour revenir au menu..."
        }

        "2" {
            Write-Host "Retour au menu précédent..." -ForegroundColor Yellow
        }

        default {
            Write-Host "Choix invalide. Veuillez entrer 1 ou 2." -ForegroundColor Red
            Start-Sleep -Seconds 3
        }
    }

    # Reprendre le choix après une pause
    $choix = Read-Host "Faites un choix (1 ou 2)"
}
