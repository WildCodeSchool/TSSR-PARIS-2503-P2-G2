# Auteur : Sadek SABIRI
# Version : 1.0
# Description : Script de création ou suppression d’un répertoire à distance via SSH

# Demander l'adresse IP ou le nom d'hôte de la machine distante
$client = Read-Host "Adresse IP ou nom d'hôte de la machine distante"

# Demander le nom d'utilisateur SSH
$remote_user = Read-Host "Nom de l'utilisateur SSH"

function Creer-Repertoire {
    param (
        [string]$repertoire
    )
    ssh "$remote_user@$client" "if [ ! -d '$repertoire' ]; then mkdir -p '$repertoire' && echo 'Le répertoire $repertoire a été créé.' || echo 'Erreur de création.'; else echo 'Le répertoire $repertoire existe déjà.'; fi"
}

function Supprimer-Repertoire {
    param (
        [string]$repertoire
    )
    $confirmation = Read-Host "Voulez-vous vraiment supprimer $repertoire ? (o/n)"
    if ($confirmation -eq 'o' -or $confirmation -eq 'O') {
        ssh "$remote_user@$client" "if [ -d '$repertoire' ]; then rm -rf '$repertoire' && echo 'Le répertoire $repertoire a été supprimé.' || echo 'Erreur de suppression.'; else echo 'Le répertoire $repertoire n''existe pas.'; fi"
    }
    else {
        Write-Host "Suppression annulée."
    }
}

# Menu principal
while ($true) {
    Write-Host "`n1. Créer un répertoire"
    Write-Host "2. Supprimer un répertoire"
    Write-Host "3. Quitter"
    $option = Read-Host "Choisissez une option (1-3)"

    switch ($option) {
        '1' {
            $chemin = Read-Host "Entrez le chemin du répertoire à créer"
            Creer-Repertoire -repertoire $chemin
        }
        '2' {
            $chemin = Read-Host "Entrez le chemin du répertoire à supprimer"
            Supprimer-Repertoire -repertoire $chemin
        }
        '3' {
            Write-Host "Au revoir !"
            break
        }
        default {
            Write-Host "Option invalide. Veuillez choisir entre 1 et 3."
        }
    }
}
