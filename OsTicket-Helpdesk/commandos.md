# osTicket — Gebruikte commando's met uitleg

Elk commando wordt uitgelegd zodat je begrijpt wat het doet
en waarom het nodig is.

---

## Installatie commando's

```bash
# Systeem updaten
# Dit zorgt dat alle bestaande pakketten up to date zijn
# Altijd doen voordat je nieuwe software installeert
sudo apt update && sudo apt upgrade -y
```

```bash
# Webserver, database en PHP installeren
# apache2    = webserver die osTicket laat zien in de browser
# mysql-server = database waar tickets en gebruikers worden opgeslagen
# php        = programmeertaal die osTicket gebruikt
# php-mysql  = laat PHP praten met MySQL database
# php-xml    = voor verwerken van XML bestanden in osTicket
# php-mbstring = voor ondersteuning van speciale tekens
# php-intl   = voor internationale taal ondersteuning
# php-apcu   = snellere cache voor betere prestaties
# php-gd     = voor verwerken van afbeeldingen
# php-curl   = voor het maken van web verbindingen
# php-zip    = voor het uitpakken van zip bestanden
# unzip      = uitpakken van het osTicket zip bestand
# wget       = downloaden van bestanden via internet
sudo apt install apache2 mysql-server php php-mysql php-xml \
  php-mbstring php-intl php-apcu php-gd php-curl php-zip unzip wget -y
```

```bash
# MySQL database aanmaken voor osTicket
# -uroot = inloggen als root gebruiker
# CREATE DATABASE = nieuwe database aanmaken
# utf8mb4 = tekens opslaan inclusief emoji en speciale tekens
sudo mysql -uroot -e "CREATE DATABASE osticket CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

# Nieuwe MySQL gebruiker aanmaken voor osTicket
# Dit is veiliger dan de root gebruiker gebruiken
sudo mysql -uroot -e "CREATE USER 'osticket'@'localhost' IDENTIFIED BY 'Welkom@123';"

# Alle rechten geven op de osticket database
# GRANT ALL = volledige toegang tot alle tabellen
sudo mysql -uroot -e "GRANT ALL PRIVILEGES ON osticket.* TO 'osticket'@'localhost';"

# Rechten herladen zodat ze direct actief zijn
sudo mysql -uroot -e "FLUSH PRIVILEGES;"
```

```bash
# Naar de tijdelijke map gaan voor de download
cd /tmp

# osTicket v1.18.1 downloaden van GitHub
# -O = bewaar bestand met de opgegeven naam
wget https://github.com/osTicket/osTicket/releases/download/v1.18.1/osTicket-v1.18.1.zip

# Zip bestand uitpakken naar een map genaamd osticket
unzip osTicket-v1.18.1.zip -d osticket
```

```bash
# osTicket bestanden kopiëren naar de Apache webroot
# /var/www/html is de standaard map voor websites op Ubuntu
sudo cp -r osticket/upload /var/www/html/osticket

# Voorbeeldconfiguratie kopiëren naar echte configuratie
# Dit bestand bevat de database instellingen
sudo cp /var/www/html/osticket/include/ost-sampleconfig.php \
  /var/www/html/osticket/include/ost-config.php

# Configuratiebestand schrijfbaar maken voor de setup wizard
# 0666 = iedereen mag lezen en schrijven
sudo chmod 0666 /var/www/html/osticket/include/ost-config.php

# Apache gebruiker (www-data) eigenaar maken van alle bestanden
# Apache heeft dit nodig om de bestanden te kunnen lezen
sudo chown -R www-data:www-data /var/www/html/osticket
```

```bash
# Apache virtual host configuratie aanmaken
# Dit vertelt Apache waar osTicket staat en welke map te gebruiken
# AllowOverride All = .htaccess bestanden worden toegestaan
# Require all granted = iedereen mag de website bezoeken
sudo bash -c 'cat > /etc/apache2/sites-available/osticket.conf << EOF
<VirtualHost *:80>
    ServerName osticket.lab.local
    DocumentRoot /var/www/html/osticket
    <Directory /var/www/html/osticket>
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF'

# osTicket site inschakelen in Apache
sudo a2ensite osticket.conf

# mod_rewrite inschakelen — nodig voor mooie URLs in osTicket
sudo a2enmod rewrite

# Apache herstarten zodat de nieuwe configuratie actief wordt
sudo systemctl restart apache2
```

```bash
# Poort 80 openen in UFW firewall
# Zonder dit kan niemand de website bezoeken
sudo ufw allow 80/tcp

# Firewall regels herladen zodat de nieuwe regel actief is
sudo ufw reload
```

```bash
# Setup map verwijderen na installatie
# Dit is een beveiligingsmaatregel — de setup pagina
# mag niet meer bereikbaar zijn na de installatie
sudo rm -rf /var/www/html/osticket/setup

# Configuratiebestand alleen-lezen maken
# 0644 = eigenaar mag lezen en schrijven, anderen alleen lezen
sudo chmod 0644 /var/www/html/osticket/include/ost-config.php
```

---

## Services beheren

```bash
# Apache status bekijken — is de webserver actief?
sudo systemctl status apache2

# Apache herstarten na configuratiewijziging
sudo systemctl restart apache2

# Apache stoppen
sudo systemctl stop apache2

# Apache starten
sudo systemctl start apache2

# Apache automatisch starten bij herstart van de server
sudo systemctl enable apache2

# MySQL status bekijken — draait de database?
sudo systemctl status mysql

# MySQL herstarten
sudo systemctl restart mysql

# MySQL automatisch starten bij herstart
sudo systemctl enable mysql
```

---

## Database beheer

```bash
# Inloggen op MySQL als root
sudo mysql -uroot

# Alle databases bekijken — controleer of osticket erin staat
SHOW DATABASES;

# Overschakelen naar de osticket database
USE osticket;

# Alle tabellen bekijken die osTicket heeft aangemaakt
SHOW TABLES;

# Database backup maken — bewaar dit op een veilige plek
# -u osticket = inloggen als osticket gebruiker
# -p = vraag om wachtwoord
# > = stuur uitvoer naar bestand
mysqldump -u osticket -p osticket > osticket-backup.sql

# Database herstellen vanuit backup
# < = lees invoer van bestand
mysql -u osticket -p osticket < osticket-backup.sql
```

---

## Bestandsbeheer

```bash
# Rechten van configuratiebestand bekijken
ls -la /var/www/html/osticket/include/ost-config.php

# Rechten herstellen als er iets mis is gegaan
# -R = ook alle submappen en bestanden aanpassen
sudo chown -R www-data:www-data /var/www/html/osticket
sudo chmod 0644 /var/www/html/osticket/include/ost-config.php

# Inhoud van de osTicket map bekijken
ls /var/www/html/osticket
```

---

## Logs bekijken

```bash
# Apache foutlog bekijken — hier staan foutmeldingen van de webserver
# -f = blijf nieuwe regels tonen (stop met Ctrl+C)
sudo tail -f /var/log/apache2/error.log

# Apache toegangslog — wie heeft de website bezocht?
sudo tail -f /var/log/apache2/access.log

# MySQL foutlog — problemen met de database
sudo tail -f /var/log/mysql/error.log
```

---

## Troubleshooting

```bash
# Controleer of alle benodigde PHP modules zijn geinstalleerd
# Als een module ontbreekt werkt osTicket niet correct
php -m | grep -E "mysql|xml|mbstring|intl|gd|curl|zip"

# PHP versie bekijken — osTicket werkt met PHP 7.4 of hoger
php --version

# Apache configuratie testen op fouten voordat je herstart
sudo apache2ctl configtest

# Controleer of Apache luistert op poort 80
# Als je niets ziet draait Apache niet correct
sudo ss -tlnp | grep :80

# Firewall status bekijken — staat poort 80 open?
sudo ufw status

# Poort 80 openen als het geblokkeerd is
sudo ufw allow 80/tcp
sudo ufw reload
```

---

## Handige URLs

| URL | Gebruik |
|---|---|
| http://192.168.50.20/osticket | Gebruikers portal — tickets aanmaken |
| http://192.168.50.20/osticket/scp | Admin dashboard — tickets beheren |
| http://192.168.50.20/osticket/setup | Setup wizard — alleen tijdens installatie |
