# Script PowerShell pour la gestion des utilisateurs via WinRM
# Auteur : Chahine MARZOUK - Version : 2.0 (WinRM)

$remotePC = "172.16.20.20"
$cred = Get-Credential  # Utilisateur du domaine ou local de la machine distante

function Show-Menu {
    Clear-Host
    Write-Host "=== Gestion des utilisateurs sur la machine distante ($remotePC) ==="
    Write-Host "1) Creation de compte utilisateur local"
    Write-Host "2) Changement de mot de passe"
    Write-Host "3) Suppression de compte utilisateur local"
    Write-Host "4) Desactivation de compte utilisateur local"
    Write-Host "5) Quitter"
}

do {
    Show-Menu
    $choix = Read-Host "Choisissez une option (1-5)"

    switch ($choix) {
        "1" {
            $newUser = Read-Host "Nom du nouvel utilisateur"
            $password = Read-Host "Mot de passe" -AsSecureString
            $plain = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
                [Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))

            Invoke-Command -ComputerName $remotePC -Credential $cred -ScriptBlock {
                param($u, $p)
                net user $u $p /add
            } -ArgumentList $newUser, $plain
        }

        "2" {
            $user = Read-Host "Nom de l'utilisateur"
            $password = Read-Host "Nouveau mot de passe" -AsSecureString
            $plain = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
                [Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))

            Invoke-Command -ComputerName $remotePC -Credential $cred -ScriptBlock {
                param($u, $p)
                net user $u $p
