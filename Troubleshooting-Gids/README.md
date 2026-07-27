# Troubleshooting Gids

Veelvoorkomende IT Support problemen en hoe je ze oplost.
Deze gids is gebaseerd op praktische ervaring in het home lab.

---

## Netwerk problemen

### Probleem — Geen internet verbinding

**Symptomen:**
- Browser toont "This site can't be reached"
- Ping naar 8.8.8.8 geeft timeout

**Controleer stap voor stap:**

```powershell
# Stap 1 - IP adres controleren
ipconfig /all
# Verwacht: IPv4 adres in 192.168.50.x reeks
# Als je 169.254.x.x ziet is er geen DHCP verbinding

# Stap 2 - Gateway bereikbaar?
ping 192.168.50.1
# Als dit niet werkt is er een netwerk configuratie probleem

# Stap 3 - DNS testen
ping 8.8.8.8
# Als dit werkt maar websites niet is het een DNS probleem

# Stap 4 - DNS controleren
Resolve-DnsName google.com
# Als dit faalt is DNS niet correct ingesteld

# Stap 5 - Netwerk adapter resetten
ipconfig /release
ipconfig /flushdns
ipconfig /renew
```

**Oplossingen:**
- Geen IP adres → controleer netwerk adapter in VMware
- Geen gateway → controleer DHCP server op DC01
- Geen DNS → controleer DNS server instelling

---

### Probleem — Kan niet verbinden met gedeelde map

**Symptomen:**
- Foutmelding "You do not have permission"
- Map is niet zichtbaar

```powershell
# Stap 1 - Controleer of je ingelogd bent als domein gebruiker
whoami

# Stap 2 - Groepslidmaatschap controleren
whoami /groups | findstr "Groep"

# Stap 3 - Verbinding testen met share
Test-Path "\\DC01\HR"

# Stap 4 - Share handmatig verbinden
net use Z: \\DC01\HR
```

**Oplossing:** Controleer in Active Directory of de gebruiker
in de juiste groep zit voor die share.

---

## Wachtwoord problemen

### Probleem — Gebruiker kan niet inloggen

**Symptomen:**
- Foutmelding "The username or password is incorrect"
- Account vergrendeld melding

```powershell
# Controleer account status op DC01
Get-ADUser -Identity "gebruikersnaam" -Properties LockedOut, Enabled, BadLogonCount |
  Select-Object Name, LockedOut, Enabled, BadLogonCount

# Account ontgrendelen
Unlock-ADAccount -Identity "gebruikersnaam"

# Wachtwoord resetten
# Zie Wachtwoord-Reset/procedure.md
```

---

## Printer problemen

### Probleem — Printer werkt niet

**Symptomen:**
- Print job blijft hangen in de wachtrij
- Printer offline melding

```powershell
# Stap 1 - Print Spooler herstarten
Restart-Service -Name Spooler

# Stap 2 - Print jobs verwijderen
Get-PrintJob -PrinterName "Lab-Printer" | Remove-PrintJob

# Stap 3 - Printer status bekijken
Get-Printer -Name "Lab-Printer"

# Stap 4 - Printer verwijderen en opnieuw toevoegen
Remove-Printer -Name "Lab-Printer"
Add-Printer -ConnectionName "\\DC01\Lab-Printer"
```

---

## Active Directory problemen

### Probleem — Computer kan niet joinen aan domein

**Symptomen:**
- Foutmelding tijdens domain join
- DNS naam niet gevonden

```powershell
# Stap 1 - DNS controleren
nslookup lab.local 192.168.50.10

# Stap 2 - DC bereikbaar?
Test-NetConnection -ComputerName 192.168.50.10 -Port 389

# Stap 3 - Domein joinen met specifieke DC
Add-Computer -DomainName "lab.local" `
  -Server "DC01.lab.local" `
  -Credential (Get-Credential) `
  -Restart
```

---

## Windows Update problemen

### Probleem — Updates worden niet geinstalleerd

```powershell
# Windows Update service herstarten
Stop-Service -Name wuauserv
Start-Service -Name wuauserv

# Update cache leegmaken
Remove-Item "C:\Windows\SoftwareDistribution\Download" -Recurse -Force

# Updates opnieuw controleren
wuauclt /detectnow
wuauclt /reportnow
```

---

## Algemene troubleshooting stappen

Bij elk probleem volg je altijd deze volgorde:

1. **Luister** naar de gebruiker — wat is het exacte probleem?
2. **Herhaal** het probleem terug zodat je zeker bent dat je het begrijpt
3. **Controleer** de basis — is alles aangesloten? Is het aan?
4. **Reproduceer** het probleem — kun je het zelf ook zien?
5. **Zoek** in de event logs naar foutmeldingen
6. **Documenteer** wat je hebt geprobeerd en wat het resultaat was
7. **Escaleer** als je er niet uitkomt naar een senior collega
