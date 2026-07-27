# Wachtwoord Reset Procedure

Officiële helpdesk procedure voor het resetten van wachtwoorden
in het lab.local domein. Dit is een van de meest voorkomende
taken voor een IT Support Technician.

---

## Omgeving

| Onderdeel | Details |
|---|---|
| Server | DC01 — Windows Server 2025 |
| Domein | lab.local |
| Tool | Active Directory en PowerShell |
| Rechten | Domain Admin vereist |

---

## Wanneer gebruik je deze procedure?

- Gebruiker is zijn wachtwoord vergeten
- Account is vergrendeld na te veel verkeerde pogingen
- Gebruiker wil wachtwoord wijzigen
- Beveiligingsincident — wachtwoord vermoedelijk gelekt

---

## Wat ik heb gedaan

- PowerShell script geschreven voor wachtwoord reset
- Account vergrendeling procedure gedocumenteerd
- Procedure getest met hr-user1
- Reset uitgevoerd — gebruiker moest nieuw wachtwoord instellen
- Succesvol ingelogd na reset

---

## Testresultaten

| Test | Resultaat |
|---|---|
| Account vergrendeling controleren | Werkt |
| Account ontgrendelen | Werkt |
| Wachtwoord resetten via script | Werkt |
| Gebruiker moet wachtwoord wijzigen | Werkt |
| Succesvol ingelogd na reset | Werkt |

---

## Vereisten

- Domain Admin rechten op DC01
- PowerShell als Administrator openen
- Gebruikersnaam van de medewerker weten

---

## Wat ik heb geleerd

- Hoe wachtwoord reset werkt via PowerShell
- Hoe je een account ontgrendelt in Active Directory
- Hoe je gebruikers dwingt een nieuw wachtwoord in te stellen
- Het belang van een veilige wachtwoord reset procedure
- Hoe je een officiële IT procedure documenteert

---

## Screenshots

| Screenshot | Wat je ziet |
|---|---|
| 209-reset-script.png | Wachtwoord reset script output |
| 210-reset-unlock.png | Account ontgrendeld |
| 211-reset-login.png | Nieuw wachtwoord vereist bij login |
| 212-reset-success.png | Succesvol ingelogd na reset |
