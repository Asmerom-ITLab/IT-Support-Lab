# Onboarding Checklist — Nieuwe Medewerker

Deze checklist gebruik je wanneer een nieuwe medewerker start.
Doorloop alle stappen om ervoor te zorgen dat de medewerker
direct aan het werk kan.

---

## Gegevens nieuwe medewerker

| Veld | Waarde |
|---|---|
| Naam | |
| Afdeling | |
| Startdatum | |
| Leidinggevende | |
| Werkplek | |

---

## Stap 1 — Account aanmaken in Active Directory

```powershell
# Nieuw account aanmaken
# Pas de gegevens aan voor de nieuwe medewerker
New-ADUser `
  -Name "Nieuwe Medewerker" `
  -SamAccountName "nieuwe.medewerker" `
  -UserPrincipalName "nieuwe.medewerker@lab.local" `
  -Path "OU=Medewerkers,DC=lab,DC=local" `
  -AccountPassword (ConvertTo-SecureString "TijdelijkWW@123" -AsPlainText -Force) `
  -Enabled $true `
  -ChangePasswordAtLogon $true `
  -GivenName "Nieuwe" `
  -Surname "Medewerker" `
  -Department "IT" `
  -Title "Junior Medewerker"

Write-Host "Account aangemaakt!" -ForegroundColor Green
```

**Afvinken:** ☐ Account aangemaakt in AD

---

## Stap 2 — Groepen toevoegen

```powershell
# Toevoegen aan juiste afdeling groep
# Pas IT-Groep aan naar de juiste afdeling
Add-ADGroupMember -Identity "IT-Groep" -Members "nieuwe.medewerker"

# Controleren
Get-ADUser "nieuwe.medewerker" -Properties MemberOf |
  Select-Object -ExpandProperty MemberOf
```

**Afvinken:** ☐ Toegevoegd aan juiste groep

---

## Stap 3 — Computer klaarmaken

```powershell
# Op Windows 10 of 11 als Administrator:

# Chocolatey installeren voor software
Set-ExecutionPolicy Bypass -Scope Process -Force
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Standaard software installeren
choco install 7zip notepadplusplus googlechrome -y

# Computer joinen aan domein
Add-Computer -DomainName "lab.local" -Restart
```

**Afvinken:** ☐ Computer gejoined aan domein
**Afvinken:** ☐ Software geinstalleerd

---

## Stap 4 — Toegang tot gedeelde mappen controleren

```powershell
# Test toegang tot de juiste share
Test-Path "\\DC01\IT"

# Als toegang geweigerd wordt - NTFS rechten controleren op DC01
Get-Acl "C:\Shares\IT" | Format-List
```

**Afvinken:** ☐ Toegang tot share getest

---

## Stap 5 — Printer instellen

```powershell
# Printer toevoegen
Add-Printer -ConnectionName "\\DC01\Lab-Printer"

# Controleren
Get-Printer | Where-Object {$_.Name -like "*Lab-Printer*"}
```

**Afvinken:** ☐ Printer ingesteld

---

## Stap 6 — Eerste login testen

1. Log in op Windows 10 of 11 met het nieuwe account
2. Stel nieuw wachtwoord in
3. Controleer dat het bureaublad correct laadt
4. Test internet verbinding
5. Test toegang tot gedeelde map
6. Test printer

**Afvinken:** ☐ Eerste login succesvol
**Afvinken:** ☐ Wachtwoord gewijzigd
**Afvinken:** ☐ Bureaublad correct
**Afvinken:** ☐ Internet werkt
**Afvinken:** ☐ Share toegankelijk
**Afvinken:** ☐ Printer werkt

---

## Stap 7 — Documenteren in ticketsysteem

Maak een ticket aan in osTicket:
- Onderwerp: `Onboarding nieuwe medewerker — [naam]`
- Noteer alle stappen die zijn uitgevoerd
- Sluit ticket als alles werkt

**Afvinken:** ☐ Ticket aangemaakt en gesloten

---

## Samenvatting

| Stap | Beschrijving | Klaar |
|---|---|---|
| 1 | Account aangemaakt in AD | ☐ |
| 2 | Toegevoegd aan juiste groep | ☐ |
| 3 | Computer gejoined en software geinstalleerd | ☐ |
| 4 | Toegang tot share getest | ☐ |
| 5 | Printer ingesteld | ☐ |
| 6 | Eerste login succesvol | ☐ |
| 7 | Gedocumenteerd in ticketsysteem | ☐ |

---

**Uitgevoerd door:** _______________
**Datum:** _______________
**Handtekening nieuwe medewerker:** _______________
