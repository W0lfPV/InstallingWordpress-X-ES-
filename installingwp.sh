#!/bin/bash
echo "Se va a proceder a descargar la última versión de Wordpress"
wget https://wordpress.org/latest.zip
echo "Se debe instalar lo necesario"
apt-get install apache2 mysql-server mysql-client zenity
echo "Se debe haber instalado con normalidad"
echo "Moviendo el archivo descargado a /var/www/html"
mv latest.zip /var/www/html
cd /var/www/html
unzip latest.zip
carpeta=$(zenity --entry --title "Configúrelo a su gusto" --text "¿Qué nombre quiere ponerle al directorio de Wordpress en el servidor? Al añadir localhost/**** como URL podrá acceder a Wordpress")
mv wordpress $carpeta
echo $carpeta creado
chown www-data:www-data $carpeta -R
echo $carpeta configurado
rm latest.zip
cd 
touch sql.txt
basededatos=$(zenity --entry --title "Creando base de datos" --text "¿Qué nombre quiere ponerle a la base de datos?")
usuariobase=$(zenity --entry --title "Creando usuario de base de datos" --text "¿Qué nombre quiere ponerle al usuario en la base de datos?")
passuserbase=$(zenity --entry --title "Creando contraseña para usuario" --text "¿Qué contraseña quiere ponerle al usuario de la base de datos?")
echo "CREATE DATABASE $basededatos;" > sql.txt
echo "GRANT ALL PRIVILEGES ON $basededatos.* TO '$usuariobase'@'localhost' IDENTIFIED BY '$passuserbase';" >> sql.txt
zenity --info --title "Procesamos a la creación de la base de datos" --text "A continuación le pedirá la contraseña del usuario "root" de su base de datos, introduzcala y pulse Enter, si nunca la ha cambiado es posible que sea 123."
mysql -u root -p < sql.txt
rm sql.txt
zenity --info --title "Todo correcto." --text "Creado directorio de Wordpress /var/www/html/$carpeta , configurado según sus especificaciones."
exit
