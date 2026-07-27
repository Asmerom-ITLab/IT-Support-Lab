# Wachtwoord Reset Script
# Bewaar dit bestand als: C:\Scripts\wachtwoord-reset.ps1
# Voer uit als Domain Admin

param(
    [Parameter(Mandatory=$true)]
    [string]$Gebruikersnaam
)

Write-Host "=== Wachtwoord Reset Script ===" -ForegroundColor Cyan
Write-Host "Datum: $(Get-Date)" -ForegroundColor White
Write-Host "Gebruiker: $Gebruikersnaam" -ForegroundColor White
Write-Host "================================" -ForegroundColor Cyan

# Stap 1 - Gebruiker opzoeken in Active Directory
try {
    $gebruiker = Get-ADUser -Identity $Gebruikersnaam `
      -Properties LockedOut, BadLogonCount, LastLogonDate, Enabled -ErrorAction Stop
} catch {
    Write-Host "FOUT: Gebruiker '$Gebruikersnaam' niet gevonden!" -ForegroundColor Red
    exit 1
}

# Stap 2 - Gebruiker informatie tonen
Write-Host ""
Write-Host "Gebruiker gevonden:" -ForegroundColor White
Write-Host "  Naam:              $($gebruiker.Name)" -ForegroundColor White
Write-Host "  Gebruikersnaam:    $($gebruiker.SamAccountName)" -ForegroundColor White
Write-Host "  Account actief:    $($gebruiker.Enabled)" -ForegroundColor White
Write-Host "  Vergrendeld:       $($gebruiker.LockedOut)" -ForegroundColor White
Write-Host "  Mislukte pogingen: $($gebruiker.BadLogonCount)" -ForegroundColor White
Write-Host "  Laatste login:     $($gebruiker.LastLogonDate)" -ForegroundColor White

# Stap 3 - Controleer of account actief is
if (-not $gebruiker.Enabled) {
    Write-Host ""
    Write-Host "WAARSCHUWING: Account is uitgeschakeld!" -ForegroundColor Yellow
    Write-Host "Schakel het account in via ADUC of gebruik Enable-ADAccount." -ForegroundColor Yellow
    exit 1
}

# Stap 4 - Account ontgrendelen indien nodig
if ($gebruiker.LockedOut) {
    Write-Host ""
    Write-Host "Account is vergrendeld. Ontgrendelen..." -ForegroundColor Yellow
    Unlock-ADAccount -Identity $Gebruikersnaam
    Write-Host "Account succesvol ontgrendeld!" -ForegroundColor Green
}

# Stap 5 - Wachtwoord resetten
Write-Host ""
Write-Host "Wachtwoord resetten..." -ForegroundColor White
$tijdelijkWachtwoord = ConvertTo-SecureString "TijdelijkWW@123" -AsPlainText -Force
Set-ADAccountPassword -Identity $Gebruikersnaam -NewPassword $tijdelijkWachtwoord -Reset

# Stap 6 - Gebruiker verplichten nieuw wachtwoord in te stellen
Set-ADUser -Identity $Gebruikersnaam -ChangePasswordAtLogon $true

# Stap 7 - Bevestiging tonen
Write-Host ""
Write-Host "================================" -ForegroundColor Cyan
Write-Host "Reset succesvol voltooid!" -ForegroundColor Green
Write-Host ""
Write-Host "Geef dit door aan de gebruiker:" -ForegroundColor White
Write-Host "  Tijdelijk wachtwoord: TijdelijkWW@123" -ForegroundColor Yellow
Write-Host "  Bij volgende login moet de gebruiker een nieuw wachtwoord instellen." -ForegroundColor Yellow
Write-Host ""
Write-Host "Vereisten nieuw wachtwoord:" -ForegroundColor White
Write-Host "  - Minimaal 8 tekens" -ForegroundColor White
Write-Host "  - Minimaal 1 hoofdletter" -ForegroundColor White
Write-Host "  - Minimaal 1 kleine letter" -ForegroundColor White
Write-Host "  - Minimaal 1 cijfer of speciaal teken" -ForegroundColor White
Write-Host "================================" -ForegroundColor Cyan
