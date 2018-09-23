echo "Installation du socketserver sur debian 8"


#Installation de docker
curl -sSL https://get.docker.com/ | sh
systemctl start docker

#Let's encrypt
echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
apt-get update 
apt-get -t jessie-backports install certbot -y
apt-get install python-certbot-nginx -y

echo "Supprimer le firewall. Presser une touche quand c'est fait"
read -n 1 -s
certbot --authenticator standalone --email hhoareau@gmail.com --installer nginx -d socketserver.shifumix.com --pre-hook "systemctl stop nginx" --post-hook "systemctl start nginx"
echo "Remettre le firewall. Presser une touche quand c'est fait"
read -n 1 -s

#Installation de l'image
docker run --restart=always -d -p 4567:4567 hhoareau/socketserver

#A vérifier : 
#le fichier /etc/nginx/sites-enabled/default doit contenir le nom du domaine dans server_name
#regenerer la cle javakeystore si changement de domaine


certbot certonly --manual --preferred-challenges dns -d socketserver.shifumix.com --email hhoareau@gmail.com
sudo cat /etc/letsencrypt/live/socketserver.shifumix.com/*.pem > fullcert.pem
openssl pkcs12 -export -out fullchain.pkcs12 -in fullcert.pem
#et souvent passage sous windows et execution de 
keytool -v -importkeystore -srckeystore fullchain.pkcs12 -destkeystore keystore.jks -deststoretype JKS
#puis intégration du fichier keystore.jsk dans le build docker

