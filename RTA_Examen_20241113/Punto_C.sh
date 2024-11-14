#!/bin/bash

# Paso 1: Agregar al usuario al grupo 'docker' y verificar que Docker esté en ejecución
echo "Agrego al usuario al grupo 'docker'..."
sudo usermod -aG docker $(whoami)

# Verifico el estado del servicio Docker
echo "Verifico el estado del servicio Docker..."
sudo systemctl status docker

# Paso 2: Cambiar al directorio de trabajo
echo "Cambio al directorio de trabajo..."
cd ~/UTN-FRA_SO_Examenes/202406/docker/

# Paso 3: Modificar el archivo index.html
echo "Edito el archivo index.html..."
vim index.html

# El contenido final que utilicé para index.html es:
# <div>
# <h1> Sistemas Operativos - UTNFRA </h1></br>
# <h2> 2do Parcial - Noviembre 2024 </h2> </br>
# <h3> Joaquín Carbonaro</h3>
# <h3> División: 311</h3>
# </div>

# Paso 4: Crear el archivo Dockerfile
echo "Creo el archivo Dockerfile..."
vim Dockerfile

# El contenido que incluí en el Dockerfile es el siguiente:
# Usa la imagen base de nginx
FROM nginx:latest

# Copia el archivo index.html modificado a la carpeta de Nginx
COPY index.html /usr/share/nginx/html/index.html

# Paso 5: Construir la imagen de Docker
echo "Construyo la imagen Docker..."
docker build -t web1-carbonaro .

# En este paso, me encontré con un error debido a que no había suficiente espacio en lv_docker.
# Primero intenté asignar todo el espacio libre disponible en vg_datos, pero el espacio seguía siendo insuficiente.
echo "Intento extender el espacio de lv_docker..."
sudo lvextend -l +100%FREE /dev/mapper/vg_datos-lv_docker
sudo resize2fs /dev/mapper/vg_datos-lv_docker

# Verifico el espacio disponible después de intentar la extensión
df -h /dev/mapper/vg_datos-lv_docker

# Dado que el espacio sigue siendo insuficiente, decido crear una nueva partición en /dev/sdd.
echo "El espacio sigue siendo insuficiente, así que procedo a crear una nueva partición..."

# Paso 6: Crear una nueva partición de 500MB en /dev/sdd
sudo fdisk /dev/sdd <<EOF
n
p
2

+500M
w
EOF

# Luego, creo un volumen físico en la nueva partición /dev/sdd2
sudo pvcreate /dev/sdd2

# Agrego la nueva partición al grupo de volúmenes vg_datos
sudo vgextend vg_datos /dev/sdd2

# Aumento el tamaño del volumen lógico lv_docker con el espacio libre de vg_datos
sudo lvextend -l +100%FREE /dev/mapper/vg_datos-lv_docker
sudo resize2fs /dev/mapper/vg_datos-lv_docker

# Verifico que el espacio se haya ampliado correctamente
df -h /dev/mapper/vg_datos-lv_docker

# Paso 7: Reconstruir la imagen de Docker
echo "Reconstruyo la imagen Docker sin errores de espacio insuficiente..."
docker build -t web1-carbonaro .

# Paso 8: Etiquetar la imagen de Docker
echo "Etiqueto la imagen Docker..."
docker tag web1-carbonaro joacocarbo/web1-carbonaro

# Paso 9: Subir la imagen al repositorio de Docker Hub
echo "Subo la imagen a Docker Hub..."
docker push joacocarbo/web1-carbonaro

# Paso 10: Crear el archivo run.sh para ejecutar el contenedor Docker
echo "Creo el archivo run.sh para ejecutar el contenedor..."
vim run.sh

# El contenido final que incluí en el archivo run.sh es:
!/bin/bash
docker run -d -p 80:80 joacocarbo/web1-carbonaro

# Paso 11: Asignar permisos de ejecución al script run.sh
echo "Asigno permisos de ejecución al archivo run.sh..."
chmod 764 run.sh

echo "Proceso completado con éxito."

