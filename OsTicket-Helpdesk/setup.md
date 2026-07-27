# osTicket — Setup Handleiding

Stap voor stap installatie van osTicket op Ubuntu Server.

---

## Vereisten

| Onderdeel | Vereiste |
|---|---|
| Server | Ubuntu Server 24.04 LTS |
| RAM | Minimaal 2GB |
| IP adres | 192.168.50.20 |
| Internet | Vereist voor download |

---

## Stap 1 — Systeem updaten

```bash
sudo apt update && sudo apt upgrade -y
```

---

## Stap 2 — Software installeren

```bash
sudo apt install apache2 mysql-server php php-mysql php-xml php-mbstring php-intl php-apcu php-gd php-curl php-zip unzip wget -y
```

---

## Stap 3 — Database aanmaken

```bash
sudo mysql -uroot << EOF
CREATE DATABASE osticket CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'osticket'@'localhost' IDENTIFIED BY 'Welkom@123';
GRANT ALL PRIVILEGES ON osticket.* TO 'osticket'@'localhost';
FLUSH PRIVILEGES;
EOF
```

---

## Stap 4 — osTicket downloaden en installeren

```bash
cd /tmp
wget https://github.com/osTicket/osTicket/releases/download/v1.18.1/osTicket-v1.18.1.zip
unzip osTicket-v1.18.1.zip -d osticket
sudo cp -r osticket/upload /var/www/html/osticket
sudo cp /var/www/html/osticket/include/ost-sampleconfig.php /var/www/html/osticket/include/ost-config.php
sudo chmod 0666 /var/www/html/osticket/include/ost-config.php
sudo chown -R www-data:www-data /var/www/html/osticket
```

---

## Stap 5 — Apache configureren

```bash
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

sudo a2ensite osticket.conf
sudo a2enmod rewrite
sudo systemctl restart apache2
sudo ufw allow 80/tcp
sudo ufw reload
```

---

## Stap 6 — Setup wizard uitvoeren

Ga naar browser op Windows 10:
```
http://192.168.50.20/osticket/setup
```

| Veld | Waarde |
|---|---|
| Helpdesk naam | Lab Helpdesk |
| Default email | helpdesk@lab.local |
| Admin voornaam | Admin |
| Admin achternaam | Lab |
| Admin email | admin@lab.local |
| Admin gebruikersnaam | admin |
| Admin wachtwoord | Welkom@123 |
| Database host | localhost |
| Database naam | osticket |
| Database gebruiker | osticket |
| Database wachtwoord | Welkom@123 |

Klik **Install Now** en wacht op: **Congratulations!**

---

## Stap 7 — Beveiliging na installatie

```bash
sudo rm -rf /var/www/html/osticket/setup
sudo chmod 0644 /var/www/html/osticket/include/ost-config.php
```

---

## Stap 8 — Inloggen

Admin dashboard:
```
http://192.168.50.20/osticket/scp
admin / Welkom@123
```

Gebruikers portal:
```
http://192.168.50.20/osticket
```

---

## Veelvoorkomende problemen

| Probleem | Oplossing |
|---|---|
| Witte pagina | Controleer PHP modules: `php -m` |
| Database fout | Controleer MySQL gebruiker en wachtwoord |
| Permission denied | `sudo chown -R www-data:www-data /var/www/html/osticket` |
| 403 Forbidden | Controleer Apache `Require all granted` instelling |
| Setup pagina na installatie | `sudo rm -rf /var/www/html/osticket/setup` |
