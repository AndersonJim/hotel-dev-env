apt-get update
apt-get -y upgrade
echo y |  apt-get install tzdata
echo y |  apt install git python3-pip build-essential wget python3-dev python3-venv python3-wheel libxslt-dev libzip-dev libldap2-dev libsasl2-dev python3-setuptools node-less
echo y |  apt-get install python-psycopg2
apt-get -y install libpq-dev wget nano

git clone https://www.github.com/odoo/odoo --depth 1 --branch ${ODOO_VERSION} --single-branch
cd /odoo
pip3 install -r requirements.txt
cd /

echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nInstalled Python Modules\nInstalled Python Modules\nInstalled Python Modules\n\n\n\n\n\n\n\n\n\n\n\n"

 apt-get install -y npm
 ln -s /usr/bin/nodejs /usr/bin/node
 npm install -g less less-plugin-clean-css
 apt-get install -y  node-less
 python3 -m pip install libsass

## install postgres
apt-get install -y python3-software-properties
touch /etc/apt/sources.list.d/pgdg.list
echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' >> /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc |  apt-key add -
apt-get -y update
echo y |  apt-get install postgresql-9.6


echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nInstalled Postgres\nInstalled Postgres\nInstalled Postgres\n\n\n\n\n\n\n\n\n\n\n\n"


## create database user for odoo
su -c "createuser -s odoo" postgres


## create odoo user and group
adduser --system --home=/opt/odoo --group odoo

## install python packages
cd /opt/odoo
wget https://pypi.python.org/packages/a8/70/bd554151443fe9e89d9a934a7891aaffc63b9cb5c7d608972919a002c03c/gdata-2.0.18.tar.gz
tar zxvf gdata-2.0.18.tar.gz
chown -R odoo: gdata-2.0.18
cd gdata-2.0.18 
python setup.py install

echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nSetup python packages\n\n\n\n\n\n\n\n\n\n\n\n\n"


mv /odoo /opt/odoo
cd /opt/odoo

echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nInstalled Odoo\nInstalled Odoo\nInstalled Odoo\n\n\n\n\n\n\n\n\n\n\n\n"

## odoo log file
 mkdir /var/log/odoo
 chown -R odoo:root /var/log/odoo


#Copy and paste below content in config file , write correct addons paths
echo -e '[options]\n; This is the password that allows database operations:\n; admin_passwd = admin\n; admin_passwd = admin\ndb_host = False\ndb_port = False\ndb_user = odoo\ndb_password = False\nlogfile = /var/log/odoo/odoo-server.log\naddons_path = /opt/odoo/addons,/opt/odoo/odoo/addons' > /etc/odoo.conf
chown odoo: /etc/odoo.conf

## Edit odoo configuration file
wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.bionic_amd64.deb
echo y |  apt install ./wkhtmltox_0.12.6-1.bionic_amd64.deb
cp /usr/local/bin/wkhtmltoimage /usr/bin/wkhtmltoimage
cp /usr/local/bin/wkhtmltopdf /usr/bin/wkhtmltopdf

#  ufw allow 8069
# echo y | ufw enable
# ufw allow 8069
# ufw allow 22

#echo y |  apt install apache2

# cd /etc/apache2/sites-available/
# rm 000-default.conf
# echo -e '<VirtualHost *:80>\nServerName' $1'\nRedirect / https://'$1'/\n</VirtualHost>' >> 000-default.conf
# rm default-ssl.conf
# echo -e '<VirtualHost *:443>\nServerName' $1'RewriteEngine On\nRewriteCond %{HTTP:Upgrade} =websocket [NC]\nRewriteRule /(.*)           ws://localhost:8069/$1 [P,L]\nRewriteCond %{HTTP:Upgrade} !=websocket [NC]\nRewriteRule /(.*)           http://localhost:8069/$1 [P,L]\nProxyPassReverse / http://localhost:8069/\n</VirtualHost>' >> default-ssl.conf

# echo y |  apt install certbot

