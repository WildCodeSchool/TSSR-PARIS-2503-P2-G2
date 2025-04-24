# Auteur : Sadek SABIRI
# Version : 1.0
# Description : Script Gestion Droits Permissions à distance via SSH

# === Demande les infos de connexion SSH ===
$ip = Read-Host "Adresse IP de la machine distante"
$ssh_user = Read-Host "Nom d'utilisateur SSH"

# === Affichage du menu utilisateur ===
Write-Host "`n=== Menu de gestion de l'ordinateur distant ==="
Write-Host "1) Arrêter l'ordinateur"
Write-Host "2) Redémarrer l'ordinateur"
Write-Host "3) Verrouiller la session"
Write-Host "4) Quitter"

# Lecture du choix de l'utilisateur
$choix = Read-Host "Votre choix"
Write-Host "Vous avez entré : $choix"

switch ($choix) {
    '1' {
        Write-Host "Arrêt de l'ordinateur distant..."
        Start-Sleep -Seconds 3
        ssh "$ssh_user@$ip" 'sudo shutdown now'
    }
    '2' {
        Write-Host "Redémarrage de l'ordinateur distant..."
        Start-Sleep -Seconds 3
        ssh "$ssh_user@$ip" 'sudo reboot'
    }
    '3' {
        Write-Host "Verrouillage de la session distante..."
        Start-Sleep -Seconds 3

        $lockCommand = @"
SESSION_ID=\$(loginctl | grep \$(whoami) | awk '{print \$1}')
if [ -n "\$SESSION_ID" ]; then
    loginctl lock-session "\$SESSION_ID"
else
    echo "Impossible de déterminer l'ID de session pour l'utilisateur distant."
fi
"@

        ssh "$ssh_user@$ip" "bash -c '$lockCommand'"
    }
    '4' {
        Write-Host "Fermeture du script."
        exit 0
    }
    default {
        Write-Host "Choix invalide. Merci de sélectionner 1, 2, 3 ou 4."
    }
}
