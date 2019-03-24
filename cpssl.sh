#!/bin/bash


#copy ssl cert from apache to nginx (cpanel servers)

echo "Enter domain name "
read domainname
echo "Enter nginx ssl conf file "
read nginxfile
diff  /var/cpanel/ssl/apache_tls/$domainname/certificates $nginxfile > diff.txt
if [ "$?" -eq 0 ]; then
 echo "the ssl certificate already updated "
else
# echo "please enter nginx ssl certificate file"
# read nginxsslcert
 echo "Enter nginx ssl key file"
 read nginxsslkey

 clear

 \cp /var/cpanel/ssl/apache_tls/$domainname/certificates $nginxfile
 head -n27 /var/cpanel/ssl/apache_tls/$domainname/combined > $nginxsslkey
 nginx -t 2> nginx.txt || grep -q 'successful' nginx.txt


if [ "$?" -eq 0 ]; then
 echo "Successful,nginx will be restared...."
  systemctl restart nginx

else
 echo "Problem"

 mail -s "issue" ahmed.emam@horizontechs.com <<< there is an error with copying ssl
fi

fi

