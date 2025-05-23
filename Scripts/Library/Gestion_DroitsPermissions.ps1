####################################################################################
# Auteur : Pauline 
# Version : 1.1 
# Description : Script droit et permission.ps1
# État : À tester
####################################################################################

# --- Infos SSH ---
$ip = Read-Host "Adresse IP de la machine distante"
$sshUser = Read-Host "Nom d'utilisateur SSH"

# --- Chemin et utilisateur concerné ---
$chemin = Read-Host "Veuillez indiquer le chemin du fichier/dossier"
$user = Read-Host "Veuillez indiquer l'utilisateur concerné"

# --- Vérification existence fichier/dossier et utilisateur ---
try {
    $testCommand = "[ -e '$chemin' ] && id '$user' &> /dev/null"
    Invoke-Command -HostName $ip -UserName $sshUser -ScriptBlock {
        param($cmd)
        bash -c $cmd
    } -ArgumentList $testCommand -ErrorAction Stop

    Write-Host "Vérification réussie." -ForegroundColor Green
}
catch {
    Write-Host "Le fichier/dossier ou l'utilisateur n'existe pas sur la machine distante." -ForegroundColor Red
    exit
}

# --- Menu principal ---
$choix = ""
while ($choix -ne "retour") {
    Write-Host "`n---------- Menu Gestion des Droits ----------"
    Write-Host "→ pour ajouter un droit : add"
    Write-Host "→ pour supprimer un droit : del"
    Write-Host "→ pour revenir au menu precedent : retour"
    $choix = Read-Host "Votre choix"

    switch ($choix) {
        "add" {
            $choixAdd = ""
            while ($choixAdd -ne "retour") {
                Write-Host "`n→ pour ajouter 'lecture' : +r"
                Write-Host "→ pour ajouter 'écriture' : +w"
                Write-Host "→ pour ajouter 'exécution' : +x"
                Write-Host "→ pour retourner au menu précédent : retour"
                $choixAdd = Read-Host "Votre choix"

                $cmd = ""
                switch ($choixAdd) {
                    "+r" { $cmd = "chmod u+r '$chemin'" }
                    "+w" { $cmd = "chmod u+w '$chemin'" }
                    "+x" { $cmd = "chmod u+x '$chemin'" }
                }

                if ($cmd) {
                    Invoke-Command -HostName $ip -UserName $sshUser -ScriptBlock {
                        param($commande)
                        bash -c $commande
                    } -ArgumentList $cmd

                    Write-Host "Droit '$choixAdd' ajouté avec succès sur '$chemin'."
                }
            }
        }

        "del" {
            $choixDel = ""
            while ($choixDel -ne "retour") {
                Write-Host "`n→ pour supprimer 'lecture' : -r"
                Write-Host "→ pour supprimer 'écriture' : -w"
                Write-Host "→ pour supprimer 'exécution' : -x"
                Write-Host "→ pour retourner au menu précédent : retour"
                $choixDel = Read-Host "Votre choix"

                $cmd = ""
                switch ($choixDel) {
                    "-r" { $cmd = "chmod u-r '$chemin'" }
                    "-w" { $cmd = "chmod u-w '$chemin'" }
                    "-x" { $cmd = "chmod u-x '$chemin'" }
                }

                if ($cmd) {
                    Invoke-Command -HostName $ip -UserName $sshUser -ScriptBlock {
                        param($commande)
                        bash -c $commande
                    } -ArgumentList $cmd

                    Write-Host "Droit '$choixDel' supprimé avec succès sur '$chemin'."
                }
            }
        }

        "retour" {
            Write-Host " Fin du script."
        }

        default {
            Write-Host " Choix invalide. Essayez encore." -ForegroundColor Yellow
        }
    }
}
