# AnyDesk Remote Support Lab

AnyDesk remote support tool geinstalleerd op DC01 en Windows 10.
Een remote verbinding is gemaakt tussen twee virtuele machines om
te demonstreren hoe IT Support medewerkers gebruikers op afstand helpen.

---

## Omgeving

| Onderdeel | Details |
|---|---|
| Remote machine | DC01 — 192.168.50.10 |
| Client machine | Windows 10 |
| Tool | AnyDesk |
| Gebruik | Remote support verbinding |

---

## Wat ik heb gedaan

- AnyDesk gedownload en geinstalleerd op DC01
- AnyDesk gedownload en geinstalleerd op Windows 10
- Remote verbinding gemaakt van Windows 10 naar DC01
- Verbinding geaccepteerd op DC01
- Commando uitgevoerd op DC01 via remote sessie
- Bestand overgedragen via AnyDesk File Manager
- Remote sessie netjes beëindigd

---

## Hoe remote support werkt

```
Gebruiker heeft probleem op DC01
        |
IT Support opent AnyDesk op Windows 10
        |
IT Support typt het AnyDesk adres van DC01 in
        |
DC01 toont een verzoek — gebruiker accepteert
        |
IT Support heeft nu volledig toegang tot DC01
        |
Probleem wordt opgelost via remote sessie
        |
Sessie wordt beëindigd
```

---

## Testresultaten

| Test | Resultaat |
|---|---|
| AnyDesk installatie op DC01 | Werkt |
| AnyDesk installatie op Windows 10 | Werkt |
| Remote verbinding tot stand gebracht | Werkt |
| Commando uitvoeren via remote sessie | Werkt |
| Bestand overdracht via File Manager | Werkt |
| Sessie netjes beëindigd | Werkt |

---

## Waarom remote support belangrijk is

Als IT Support Technician help je gebruikers vaak op afstand.
Dit is sneller dan fysiek naar de gebruiker toe gaan en
maakt het mogelijk om thuis werkende medewerkers te helpen.

---

## Wat ik heb geleerd

- Hoe AnyDesk werkt als remote support tool
- Hoe je een veilige remote verbinding maakt
- Hoe je bestanden overdraagt via een remote sessie
- Het belang van remote support in moderne IT omgevingen

---

## Screenshots

| Screenshot | Wat je ziet |
|---|---|
| 204-anydesk-install.png | AnyDesk geinstalleerd op DC01 |
| 205-anydesk-adres.png | AnyDesk adres van DC01 |
| 206-anydesk-verbinding.png | Verbinding maken vanuit Windows 10 |
| 207-anydesk-sessie.png | Actieve remote sessie op DC01 |
| 208-anydesk-bestand.png | Bestand overdracht via AnyDesk |
