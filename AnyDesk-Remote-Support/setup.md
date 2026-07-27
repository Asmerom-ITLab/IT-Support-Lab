# AnyDesk — Setup Handleiding

Stap voor stap installatie en configuratie van AnyDesk
voor remote support in het lab.

---

## Stap 1 — AnyDesk downloaden op DC01

Ga naar DC01 en open een browser:
```
https://anydesk.com/download
```

Klik op **Download** voor Windows en installeer AnyDesk.

---

## Stap 2 — AnyDesk downloaden op Windows 10

Zelfde procedure op Windows 10 client.

---

## Stap 3 — AnyDesk adres noteren van DC01

1. Open AnyDesk op DC01
2. Je ziet een 9-cijferig adres — bijv. `123 456 789`
3. Noteer dit adres — je hebt het nodig op Windows 10

---

## Stap 4 — Verbinding maken vanuit Windows 10

1. Open AnyDesk op Windows 10
2. Typ het adres van DC01 in het zoekveld
3. Klik op **Connect**

---

## Stap 5 — Verbinding accepteren op DC01

Op DC01 verschijnt een popup:
```
Incoming session request from Windows 10
Accept / Decline
```

Klik op **Accept**

---

## Stap 6 — Remote sessie gebruiken

Je hebt nu volledige toegang tot DC01 vanuit Windows 10.

Voer een test commando uit:
```powershell
Get-ADUser -Filter * | Select-Object Name | Out-File "C:\remote-test.txt"
notepad "C:\remote-test.txt"
```

---

## Stap 7 — Bestand overdragen

1. Klik op het **File Manager** icoon in AnyDesk
2. Selecteer een bestand op Windows 10
3. Sleep het naar de DC01 kant
4. Controleer of het bestand is overgekomen

---

## Stap 8 — Sessie beëindigen

1. Klik op **Disconnect** in AnyDesk
2. De remote sessie is beëindigd
