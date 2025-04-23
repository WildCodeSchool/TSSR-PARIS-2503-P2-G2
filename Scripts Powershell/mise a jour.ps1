# Auteur : Sadek SABIRI
# Version : 1.0
# Description : Script de mise à jour via SSH

# === Couleurs ===
$Green = "`e[32m"
$Red = "`e[31m"
$Reset = "`e[0m"

# === Demander les infos ===
$clientIP = Read-Host "Adresse IP ou nom d'hôte du client Ubuntu"
$clientUser = Read-Host "Nom d'utilisateur SSH du client"

Write-Host "${Green}➡ Connexion à $clientUser@$clientIP...${Reset}"

# === Bloc de commandes à exécuter sur le client ===
$remoteCommands = @"
echo 'Client distant : \$(hostname)'
echo 'Mise à jour du système...'
sudo apt-get update && sudo apt-get upgrade -y
echo 'Mise à jour terminée.'
"@

# === Préparer la commande SSH ===
$sshFullCommand = "bash -c '$remoteCommands'"
sshCommand = @("ssh", "$clientUser@$clientIP", $sshFullCommand)

# === Exécution SSH sécurisée ===
$proc = Start-Process -FilePath $sshCommand[0] -ArgumentList $sshCommand[1..2] -NoNewWindow -Wait -PassThru

# === Résultat ===
if ($proc.ExitCode -eq 0) {
    Write-Host "${Green}✔ Mise à jour réussie sur $clientIP${Reset}"
} else {
    Write-Host "${Red}✖ Échec de la mise à jour sur $clientIP${Reset}"
}
