#!/bin/bash

# Paso 1: Crear particiones
echo "Creando particiones..."
sudo fdisk /dev/sdc <<EOF
n
p
1


t
8e
w
EOF

sudo fdisk /dev/sdd <<EOF
n
p
1

+512M
t
82
w
EOF

# Paso 2: Crear los volúmenes físicos (PV)
echo "Limpiamos basura y creando volúmenes físicos..."
#limpiamos basura (no se realiza en la swap)
wipefs -a /dev/sdc1
sudo pvcreate /dev/sdc1
sudo pvcreate /dev/sdd1

# Paso 3: Crear los grupos de volúmenes (VG)
echo "Creando los grupos de volúmenes..."
# -s para que no redondee a la hora de crear el lv_docker de 5M
sudo vgcreate -s 1M vg_datos /dev/sdc1
sudo vgcreate vg_temp /dev/sdd1

# Paso 4: Crear los volúmenes lógicos (LV)
echo "Creando volúmenes lógicos..."
# Crea lv_docker con exactamente 5 MB
sudo lvcreate -L 5M -n lv_docker vg_datos
# Crea lv_workareas con exactamente 1.5 GB
sudo lvcreate -L 1.5G -n lv_workareas vg_datos
# LV para Swap
sudo lvcreate -l 100%FREE -n lv_swap vg_temp

# Paso 5: Formatear los volúmenes lógicos
echo "Formateando los volúmenes lógicos..."
sudo mkfs -t ext4 /dev/mapper/vg_datos-lv_docker
sudo mkfs -t ext4 /dev/mapper/vg_datos-lv_workareas
sudo mkswap /dev/mapper/vg_temp-lv_swap

# Paso 6: Montar los volúmenes lógicos
sudo swapon /dev/mapper/vg_temp-lv_swap

echo "Montando los volúmenes lógicos..."
sudo mount /dev/mapper/vg_datos-lv_docker /var/lib/Docker

# Reiniciar Docker para que reconozca el volumen
echo "Reiniciando Docker..."
sudo systemctl restart docker
sudo systemctl status docker

# Crear punto de montaje
echo "Creando el punto de montaje..."
sudo mkdir /work
sudo mount /dev/mapper/vg_datos-lv_workareas /work/

# Paso 7: Configurar el archivo /etc/fstab para montajes automáticos
echo "Configurando /etc/fstab..."
echo "/dev/mapper/vg_datos-lv_docker  /var/lib/docker  ext4  defaults  0  0" | sudo tee -a /etc/fstab > /dev/null
echo "/dev/mapper/vg_datos-lv_workareas  /work  ext4  defaults  0  0" | sudo tee -a /etc/fstab > /dev/null
echo "/dev/mapper/vg_temp-lv_swap  none  swap  sw  0  0" | sudo tee -a /etc/fstab > /dev/null
sudo mount -a

