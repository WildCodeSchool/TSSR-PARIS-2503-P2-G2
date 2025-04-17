####################################################################################
# Autor : Pauline 
# Version : 1.0 
# Description : Script droit et permission.ps1
# Etat : a tester
####################################################################################


# Demande de la machine distante
$remotePC = Read-Host "Entrez le nom ou l'IP de la machine distante (Windows 11)"
$credential = Get-Credential -Message "Identifiants pour $remotePC"

# Demande du chemin sur la machine distante
$chemin = Read-Host "Entrez le chemin du fichier ou dossier sur la machine distante"
if (-not $chemin) {
    Write-Host "❌ Aucun chemin spécifié." -ForegroundColor Red
    exit
}

# Demande de l'utilisateur cible
$utilisateur = Read-Host "Entrez le nom de l'utilisateur (ex: Administrateur, DOMAIN\Utilisateur)"

# Menu principal
$choixPrincipal = ""

while ($choixPrincipal -ne "3") {
    Clear-Host
    Write-Host "===== MENU PRINCIPAL =====" -ForegroundColor Cyan
    Write-Host "1 - Ajouter un droit"
    Write-Host "2 - Supprimer un droit"
    Write-Host "3 - Retour au menu précédent"
    $choixPrincipal = Read-Host "Faites un choix (1-3)"

    switch ($choixPrincipal) {
        "1" {
            $choixAjout = ""
            while ($choixAjout -ne "d") {
                Write-Host "`n== Ajouter un droit =="
                Write-Host "a - Lecture"
                Write-Host "b - Écriture"
                Write-Host "c - Exécution"
                Write-Host "d - Retour"
                $choixAjout = Read-Host "Choix"

                $droit = switch ($choixAjout) {
                    "a" { "Read" }
                    "b" { "Write" }
                    "c" { "ReadAndExecute" }
                    default { $null }
                }

                if ($droit) {
                    try {
                        Invoke-Command -ComputerName $remotePC -Credential $credential -ArgumentList $chemin, $utilisateur, $droit -ScriptBlock {
                            param ($c, $u, $d)
                            $acl = Get-Acl $c
                            $rule = New-Object System.Security.AccessControl.FileSystemAccessRule($u, $d, "Allow")
                            $acl.SetAccessRule($rule)
                            Set-Acl $c $acl
                            Write-Output "✅ Droit $d ajouté pour $u sur $c"
                        }
                    }
                    catch {
                        Write-Host "❌ Erreur lors de l'ajout : $_" -ForegroundColor Red
                    }
                }
            }
        }

        "2" {
            $choixSupp = ""
            while ($choixSupp -ne "d") {
                Write-Host "`n== Supprimer un droit =="
                Write-Host "a - Lecture"
                Write-Host "b - Écriture"
                Write-Host "c - Exécution"
                Write-Host "d - Retour"
                $choixSupp = Read-Host "Choix"

                $droit = switch ($choixSupp) {
                    "a" { "Read" }
                    "b" { "Write" }
                    "c" { "ReadAndExecute" }
                    default { $null }
                }

                if ($droit) {
                    try {
                        Invoke-Command -ComputerName $remotePC -Credential $credential -ArgumentList $chemin, $utilisateur, $droit -ScriptBlock {
                            param ($c, $u, $d)
                            $acl = Get-Acl $c
                            $rule = New-Object System.Security.AccessControl.FileSystemAccessRule($u, $d, "Allow")
                            $acl.RemoveAccessRule($rule)
                            Set-Acl $c $acl
                            Write-Output "✅ Droit $d supprimé pour $u sur $c"
                        }
                    }
                    catch {
                        Write-Host "❌ Erreur lors de la suppression : $_" -ForegroundColor Red
                    }
                }
            }
        }

        "3" {
            Write-Host "`nRetour au menu précédent..." -ForegroundColor Yellow
        }

        default {
            Write-Host "`n❗ Choix invalide. Veuillez entrer 1, 2 ou 3." -ForegroundColor Red
        }
    }

    Read-Host "`nAppuyez sur Entrée pour continuer..."
}
