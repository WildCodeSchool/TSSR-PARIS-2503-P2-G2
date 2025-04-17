# Script PowerShell pour la gestion des utilisateurs via WinRM
# Auteur : Chahine MARZOUK - Adapté PowerShell/WinRM
# Version : 2.0

function Show-Menu {
    Clear-Host
    Write-Host "=== Gestion des utilisateurs sur la machine distante ==="
    Write-Host "1) Création de compte utilisateur local"
    Write-Host "2) Changement de mot de passe"
    Write-Host "3) Suppression de compte utilisateur local"
    Write-Host "4) Désactivation de compte utilisateur local"
    Write-Host "5) Quitter"
}

do {
    Show-Menu
    $choix = Read-Host "Choisissez une option (1-5)"

    switch ($choix) {
        "1" {
            $newUser = Read-Host "Nom du nouvel utilisateur"
            $password = Read-Host "Mot de passe pour $newUser" -AsSecureString
            $plainPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))
            net user $newUser $plainPassword /add
            Write-Host "Utilisateur $newUser créé avec succès."
        }
        "2" {
            $user = Read-Host "Nom de l'utilisateur"
            $password = Read-Host "Nouveau mot de passe pour $user" -AsSecureString
            $plainPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))
            net user $user $plainPassword
            Write-Host "Mot de passe de $user modifié."
        }
        "3" {
            $delUser = Read-Host "Nom de l'utilisateur à supprimer"
            net user $delUser /delete
            Write-Host "Utilisateur $delUser supprimé."
        }
        "4" {
            $disableUser = Read-Host "Nom de l'utilisateur à désactiver"
            net user $disableUser /active:no
            Write-Host "Utilisateur $disableUser désactivé."
        }
        "5" {
            Write-Host "Fin du script."
            break
        }
        default {
            Write-Host "Option invalide. Veuillez choisir un nombre entre 1 et 5."
        }
    }

    if ($choix -ne "5") {
        Pause
    }
} while ($choix -ne "5")
