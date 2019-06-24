blue=$(tput setaf 4)

printf "%s\n" "${blue}This script was only tested on a fresh install of Debian 9." "" ""

apt-get update && apt-get -y upgrade 
apt-get -y install software-properties-common dirmngr git apt-transport-https ca-certificates curl gnupg2 pdns-server pdns-backend-mysql apt-utils python-pip cat

nano /etc/powerdns/pdns.d/pdns.local.gmysql.conf

printf "%s\n" "${blue}Please set up the DB tables manually. A file is provided." "" ""
read -p "Press enter to continue"

NUMBER=$(cat /dev/urandom | tr -dc '0-9' | fold -w 256 | head -n 1 | head --bytes 18)
b='api-key='
a=$b$NUMBER

printf "%s\n" "${blue}Write this API key down! You will need it later in the process." "" "$NUMBER"

read -p "Press enter to continue"

echo 'api=yes' >> /etc/powerdns/pdns.conf
echo $a >> /etc/powerdns/pdns.conf
echo 'webserver=yes' >> /etc/powerdns/pdns.conf
echo 'webserver-address=0.0.0.0' >> /etc/powerdns/pdns.conf
echo 'webserver-allow-from=0.0.0.0/0,::/0' >> /etc/powerdns/pdns.conf
echo 'webserver-port=8081' >> /etc/powerdns/pdns.conf

service pdns restart

git clone https://github.com/ngoduykhanh/PowerDNS-Admin.git
cd PowerDNS-Admin

printf "%s\n" "${blue}Please change your username and password to something secure. Leave the host as it is as it tends to break stuff." "" ""
read -p "Press enter to continue"

nano .env

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt update && apt install -y docker-ce

curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose up -d
docker start $(docker ps -q)
docker-compose up