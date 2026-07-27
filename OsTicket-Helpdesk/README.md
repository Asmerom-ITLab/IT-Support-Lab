# osTicket Helpdesk Lab

osTicket open source helpdesk systeem geinstalleerd op Ubuntu Server.
Dit simuleert een echte IT helpdesk omgeving waar gebruikers tickets
kunnen aanmaken en IT medewerkers deze kunnen oplossen.

Dit lab laat zien hoe een IT Support afdeling dagelijks werkt met
een ticketsysteem voor het beheren van problemen en verzoeken.

---

## Omgeving

| Onderdeel | Details |
|---|---|
| Server | Ubuntu Server 24.04 LTS — 192.168.50.20 |
| Admin dashboard | http://192.168.50.20/osticket/scp |
| Gebruikers portal | http://192.168.50.20/osticket |
| Database | MySQL — osticket |
| Admin gebruiker | admin |
| Versie | osTicket v1.18.1 |

---

## Wat ik heb gedaan

- Apache, MySQL en PHP geinstalleerd op Ubuntu Server
- MySQL database aangemaakt voor osTicket
- osTicket v1.18.1 gedownload en geinstalleerd
- Apache virtual host geconfigureerd
- Admin account aangemaakt via setup wizard
- Drie afdelingen aangemaakt — IT Support, Netwerk, Security
- SLA plans geconfigureerd per prioriteit
- Help topics aangemaakt voor veelvoorkomende problemen
- Agents aangemaakt per afdeling
- Drie test tickets aangemaakt vanuit gebruikersperspectief
- Tickets toegewezen, behandeld en opgelost als agent

---

## Afdelingen

| Afdeling | Verantwoordelijk voor | SLA |
|---|---|---|
| IT Support | Algemene IT problemen | SEV-A — 1 uur |
| Netwerk | Verbindingsproblemen | SEV-B — 4 uur |
| Security | Beveiligingsincidenten | SEV-A — 1 uur |

---

## SLA Plans

| Plan | Responstijd | Schema | Gebruik |
|---|---|---|---|
| SEV-A | 1 uur | 24/7 | Kritieke problemen |
| SEV-B | 4 uur | Maandag-Vrijdag | Hoge prioriteit |
| SEV-C | 8 uur | Maandag-Vrijdag | Normale prioriteit |

---

## Help Topics

| Topic | Afdeling |
|---|---|
| Wachtwoord reset | IT Support |
| Kan niet inloggen | IT Support |
| Printer probleem | IT Support |
| Internet werkt niet | Netwerk |
| Software installatie | IT Support |

---

## Test tickets

| Ticket | Gebruiker | Probleem | Prioriteit | Status |
|---|---|---|---|---|
| #1 | hr-user1 | Kan niet inloggen op domein | Hoog | Opgelost |
| #2 | it-user1 | Printer werkt niet | Normaal | Opgelost |
| #3 | mgmt-user1 | Geen internet verbinding | Hoog | Opgelost |

---

## Ticket workflow

```
Gebruiker maakt ticket aan via portal
        |
Ticket komt binnen in de juiste afdeling queue
        |
Agent pakt ticket op en wijst toe aan zichzelf
        |
Agent onderzoekt het probleem
        |
Agent voegt notitie toe en communiceert met gebruiker
        |
Probleem opgelost — ticket gesloten als Resolved
        |
Gebruiker ontvangt bevestiging per email
```

---

## Testresultaten

| Test | Resultaat |
|---|---|
| osTicket dashboard bereikbaar | Werkt |
| Afdelingen aangemaakt | Werkt |
| SLA plans actief | Werkt |
| Help topics aangemaakt | Werkt |
| Ticket aanmaken als gebruiker | Werkt |
| Ticket behandelen als agent | Werkt |
| Ticket oplossen en sluiten | Werkt |

---

## Waarom een ticketsysteem belangrijk is

In een bedrijf komen dagelijks IT problemen voor van medewerkers.
Zonder een ticketsysteem:
- Vergeet je problemen die gemeld zijn
- Weet je niet welke problemen al opgelost zijn
- Kun je geen rapportage maken over responstijden
- Is er geen bewijs dat problemen zijn opgelost

Met osTicket heeft de IT afdeling een professionele werkwijze.

---

## Wat ik heb geleerd

- Hoe een helpdesk ticketsysteem werkt
- Hoe je osTicket installeert op Ubuntu met Apache en MySQL
- Hoe je SLA plans instelt per prioriteit
- Hoe je afdelingen en agents configureert
- Hoe je tickets aanmaakt, behandelt en oplost
- Hoe je helpdesk workflows inricht
- Het belang van een ticketsysteem in IT Support

---

## Screenshots

Zie de `screenshots/` map voor bewijs van elke stap.

| Screenshot | Wat je ziet |
|---|---|
| 196-osticket-install.png | Setup wizard voltooid |
| 197-osticket-dashboard.png | Admin dashboard na inloggen |
| 198-osticket-departments.png | IT, Netwerk en Security afdelingen |
| 199-osticket-sla.png | SLA plans SEV-A, SEV-B en SEV-C |
| 200-osticket-ticket-open.png | Open tickets overzicht |
| 201-osticket-ticket-detail.png | Ticket details en behandeling |
| 202-osticket-ticket-solved.png | Ticket opgelost en gesloten |
| 203-osticket-agents.png | Agents overzicht per afdeling |
