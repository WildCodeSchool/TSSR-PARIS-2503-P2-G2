# Auteur : Chahine MARZOUK
# Version : 1.0
# Description : Script Informations Logs en PowerShell

$LOG_FILE = "log_evt.log"

if (-Not (Test-Path $LOG_FILE)) {
    Write-Host "Erreur : le fichier $LOG_FILE est introuvable."
    exit 1
}

Write-Host "=== Analyse de $LOG_FILE ==="
Write-Host "1. Rechercher les événements pour un utilisateur"
Write-Host "2. Rechercher les événements pour un ordinateur"
$choix = Read-Host "Choisissez une option (1 ou 2)"

switch ($choix) {
    "1" {
        $utilisateur = Read-Host "Entrez le nom de l'utilisateur"
        Write-Host "`n📄 Événements pour l'utilisateur '$utilisateur' :"
        Select-String -Path $LOG_FILE -Pattern $utilisateur -SimpleMatch | ForEach-Object { $_.Line }
    }
    "2" {
        $ordinateur = Read-Host "Entrez le nom de l'ordinateur"
        Write-Host "`n📄 Événements pour l'ordinateur '$ordinateur' :"
        Select-String -Path $LOG_FILE -Pattern $ordinateur -SimpleMatch | ForEach-Object { $_.Line }
    }
    default {
        Write-Host "Option invalide. Veuillez choisir 1 ou 2."
        exit 1
    }
}
