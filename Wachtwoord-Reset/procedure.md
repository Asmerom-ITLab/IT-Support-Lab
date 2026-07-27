# Wachtwoord Reset — Officiële Helpdesk Procedure

Dit document beschrijft de officiële procedure voor het resetten
van wachtwoorden in het lab.local domein. Volg deze stappen altijd
in volgorde voor een veilige en correcte wachtwoord reset.

---

## Stap 1 — Identiteit verificeren

Voordat je een wachtwoord reset uitvoert, moet je controleren
of de persoon die belt of mailt echt de eigenaar van het account is.

Stel deze vragen:
- Wat is je volledige naam?
- Wat is je gebruikersnaam?
- Wat is je afdeling?
- Wat is je directe leidinggevende?

Controleer de antwoorden in Active Directory.

---

## Stap 2 — Account status controleren

Open **PowerShell als Administrator** op DC01:

```powershell
# Account status bekijken
# Vervang hr-user1 door de echte gebruikersnaam
Get-ADUser -Identity "hr-user1" -Properties LockedOut, BadLogonCount, LastLogonDate |
  Select-Object Name, SamAccountName, LockedOut, BadLogonCount, LastLogonDate

# Wat betekent elk veld:
# LockedOut      = True als account vergrendeld is
# BadLogonCount  = Aantal verkeerde inlogpogingen
# LastLogonDate  = Wanneer de gebruiker voor het laatst ingelogd heeft
```

---

## Stap 3 — Account ontgrendelen indien nodig

```powershell
# Account ontgrendelen als LockedOut True is
Unlock-ADAccount -Identity "hr-user1"

# Bevestiging tonen
Write-Host "Account ontgrendeld voor: hr-user1" -ForegroundColor Green

# Controleer of ontgrendeling gelukt is
Get-ADUser -Identity "hr-user1" -Properties LockedOut |
  Select-Object Name, LockedOut
```

---

## Stap 4 — Wachtwoord resetten

```powershell
# Nieuw tijdelijk wachtwoord instellen
$gebruiker = "hr-user1"
$nieuwWachtwoord = ConvertTo-SecureString "TijdelijkWW@123" -AsPlainText -Force

# Wachtwoord resetten
Set-ADAccountPassword -Identity $gebruiker -NewPassword $nieuwWachtwoord -Reset

# Gebruiker verplichten nieuw wachtwoord in te stellen bij volgende login
Set-ADUser -Identity $gebruiker -ChangePasswordAtLogon $true

# Bevestiging tonen
Write-Host "Wachtwoord gereset voor: $gebruiker" -ForegroundColor Green
Write-Host "Tijdelijk wachtwoord: TijdelijkWW@123" -ForegroundColor Yellow
Write-Host "Gebruiker moet wachtwoord wijzigen bij volgende login" -ForegroundColor Yellow
```

---

## Stap 5 — Gebruiker informeren

Vertel de gebruiker:
- Het tijdelijke wachtwoord: `TijdelijkWW@123`
- Ze moeten direct een nieuw wachtwoord instellen bij de volgende login
- Het nieuwe wachtwoord moet voldoen aan het wachtwoordbeleid:
  - Minimaal 8 tekens
  - Hoofdletter en kleine letter
  - Cijfer of speciaal teken

---

## Stap 6 — Reset documenteren

Documenteer de reset in het ticketsysteem:
- Datum en tijd van de reset
- Naam van de gebruiker
- Reden voor de reset
- Wie de reset heeft uitgevoerd

---

## Wachtwoord reset script — volledig

```powershell
# Volledig wachtwoord reset script
# Bewaard als C:\Scripts\wachtwoord-reset.ps1

param(
    [Parameter(Mandatory=$true)]
    [string]$Gebruikersnaam
)

Write-Host "=== Wachtwoord Reset Script ===" -ForegroundColor Cyan
Write-Host "Gebruiker: $Gebruikersnaam" -ForegroundColor White

# Stap 1 — Gebruiker opzoeken
$gebruiker = Get-ADUser -Identity $Gebruikersnaam -Properties LockedOut, BadLogonCount -ErrorAction Stop

Write-Host "Naam: $($gebruiker.Name)" -ForegroundColor White
Write-Host "Vergrendeld: $($gebruiker.LockedOut)" -ForegroundColor White
Write-Host "Mislukte pogingen: $($gebruiker.BadLogonCount)" -ForegroundColor White

# Stap 2 — Ontgrendelen indien nodig
if ($gebruiker.LockedOut) {
    Unlock-ADAccount -Identity $Gebruikersnaam
    Write-Host "Account ontgrendeld!" -ForegroundColor Green
}

# Stap 3 — Wachtwoord resetten
$nieuwWachtwoord = ConvertTo-SecureString "TijdelijkWW@123" -AsPlainText -Force
Set-ADAccountPassword -Identity $Gebruikersnaam -NewPassword $nieuwWachtwoord -Reset
Set-ADUser -Identity $Gebruikersnaam -ChangePasswordAtLogon $true

Write-Host "Wachtwoord gereset!" -ForegroundColor Green
Write-Host "Tijdelijk wachtwoord: TijdelijkWW@123" -ForegroundColor Yellow
Write-Host "Gebruiker moet wachtwoord wijzigen bij volgende login." -ForegroundColor Yellow
Write-Host "=== Reset voltooid ===" -ForegroundColor Cyan
```

Gebruik het script:
```powershell
.\wachtwoord-reset.ps1 -Gebruikersnaam "hr-user1"
```
