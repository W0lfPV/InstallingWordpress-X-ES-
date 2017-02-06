#!/bin/bash
echo "Se va a proceder a descargar la última versión de Wordpress"
wget https://wordpress.org/latest.zip
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
zenity --info --title "Todo correcto." --text "Creado directorio de Wordpress /var/www/html/$carpeta , configurado según sus especificaciones."
exit

