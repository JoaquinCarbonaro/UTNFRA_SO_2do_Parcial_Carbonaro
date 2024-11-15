pwd
sudo apt update
sudo apt install git -y
git --version
pwd
git clone https://github.com/upszot/UTN-FRA_SO_Examenes.git
./UTN-FRA_SO_Examenes/202406/script_Precondicion.sh
source ~/.bashrc
ls -l
cd RTA_Examen_20241113/
ls -l
cd ..
cd UTN-FRA_SO_Examenes/
ls -l
cd ..
ls -l
pwd
history -a
pwd
ssh-keygen -t ed25519
ls -la
cd .ssh/
ls -l
cat id_ed25519.pub 
cd ..
pwd
ls -l
git clone git@github.com:JoaquinCarbonaro/UTNFRA_SO_2do_Parcial_Carbonaro.git
ls -l
sudo fdisk -l
sudo apt install ansible
ansible --version
sudo apt list --installed | grep ansible
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
# Add the repository to Apt sources:
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo docker run hello-world
docker --version
sudo fdisk -l
sudo visudo
sudo fdisk -l
sudo fdisk /dev/sdc
sudo fdisk /dev/sdd
free -h
sudo fdisk -l
sudo pvcreate /dev/sdd1
sudo pvcreate /dev/sdc1
sudo pvs
sudo vgcreate vg_datos /dev/sdc1
sudo vgcreate vg_temp /dev/sdd1
sudo vgs
sudo lvcreate -L 5M -n lv_docker vg_datos
sudo lvs
sudo lvcreate -L 1.5G -n lv_workareas vg_datos
sudo lvs
sudo lvremove /dev/vg_datos/lv_docker
sudo lvs
sudo lvremove /dev/vg_datos/lv_workareas
sudo lvs
sudo vgremove vg_datos
sudo vgcreate -s 1M vg_datos /dev/sdc1
sudo vgs
sudo lvcreate -L 5Mib -n lv_docker vg_datos
sudo lvcreate -l 100%FREE -n lv_workareas vg_datos
sudo lvs
sudo lvremove -y /dev/vg_datos/lv_docker
sudo lvremove -y /dev/vg_datos/lv_workareas
sudo lvcreate -L 5M -n lv_docker vg_datos
sudo lvcreate -L 1.5G -n lv_workareas vg_datos
sudo lvs
sudo lvcreate -L 512M -n lv_swap vg_temp
sudo lvcreate -l 100%FREE -n lv_swap vg_temp
sudo lvs
sudo fdisk -l
sudo mkfs -t ext4 /dev/mapper/vg_datos-lv_docker
sudo mkfs -t ext4 /dev/mapper/vg_datos-lv_workareas
sudo mkswap /dev/mapper/vg_temp-lv_swap
sudo swapon /dev/mapper/vg_temp-lv_swap
free -h
sudo ls -l /var/lib/docker/
sudo mount /dev/mapper/vg_datos-lv_docker /var/lib/docker
sudo systemctl status Docker
sudo systemctl status docker
sudo systemctl restart docker
sudo systemctl status docker
sudo ls -l /var/lib/docker/
lsblk -f
ls /
sudo mkdir /work
ls /
sudo mount /dev/mapper/vg_datos-lv_workareas /work/
df -h
lsblk -f
echo "/dev/mapper/vg_datos-lv_docker  /var/lib/docker  ext4  defaults  0  0" | sudo tee -a /etc/fstab > /dev/null
echo "/dev/mapper/vg_datos-lv_workareas  /work  ext4  defaults  0  0" | sudo tee -a /etc/fstab > /dev/null
echo "/dev/mapper/vg_temp-lv_swap  none  swap  sw  0  0" | sudo tee -a /etc/fstab > /dev/null
sudo mount -a
pwd
ls -l
cd RTA_Examen_20241113/
ls -l
vim Punto_A.sh 
cat Punto_A.sh 
cd ..
pwd
ls -l
cd UTNFRA_SO_2do_Parcial_Carbonaro/
ls -l
vim README.md 
cat README.md 
cp -r ~/RTA_Examen_20241113/ .
ls -l
cd RTA_Examen_20241113/
ls -l
cat Punto_A.sh 
cd ..
git status
git add .
git commit -m "ADD: README y carpeta RTA_Examen_20241113 con Punto_A"
git config --global user.email "joacolcarbo@gmail.com"
git config --global user.name "JoaquinCarbonaro"
git status
git push origin main
git status
git commit -m "ADD: README y carpeta RTA_Examen_20241113 con Punto_A"
git push origin main
cd ..
pwd
exit
lsblk -f
pwd
ls -l
cd UTN-FRA_SO_Examenes/
ls -l
cd 202406
ls -l
cd bash_script/
ls -l
cat Lista_Usuarios.txt 
cd
pwd
cd /usr/local/bin/
ls -l
sudo vim Carbonaro_AltaUser-Groups.sh
cat Carbonaro_AltaUser-Groups.sh 
pwd
cd
pwd
cd /usr/local/bin/
ls -l
sudo chmod 744 Carbonaro_AltaUser-Groups.sh
ls -l
cd
ls -l
cd RTA_Examen_20241113/
ls -l
vim Punto_B.sh 
cat Punto_B.sh 
cd
ls -l
cd UTNFRA_SO_2do_Parcial_Carbonaro/
ls -l
cd RTA_Examen_20241113/
ls -l
cp ~/RTA_Examen_20241113/Punto_B.sh ~/UTNFRA_SO_2do_Parcial_Carbonaro/RTA_Examen_20241113/
ls -l
cat Punto_B.sh 
cd ..
ls -l
git status
git add .
git commit -m "ADD: Punto_B"
git push origin main
git status
cd
pwd
ls -l
cd UTN-FRA_SO_Examenes/202406/docker/
ls -l
cat index.html 
cd
pwd
whoami
id
sudo usermod -a -G $(whoami)
sudo usermod -aG docker $(whoami)
id
exit
id
sudo systemctl status docker
cd UTN-FRA_SO_Examenes/202406/docker/
ls -l
vim index.html
vim Dockerfile
docker build -t web1-carbonaro .
df -h
sudo lvextend -L +50M /dev/mapper/vg_datos-lv_docker
sudo resize2fs /dev/mapper/vg_datos-lv_docker
df -h /dev/mapper/vg_datos-lv_docker
docker build -t web1-carbonaro .
sudo lvdisplay /dev/vg_datos/lv_docker
df -h /var/lib/docker
sudo vgs
sudo lvextend -l +100%FREE /dev/mapper/vg_datos-lv_docker
sudo resize2fs /dev/mapper/vg_datos-lv_docker
df -h /dev/mapper/vg_datos-lv_docker
sudo lvdisplay /dev/vg_datos/lv_docker
df -h /var/lib/docker
docker build -t web1-carbonaro .
sudo fdisk /dev/sdd
sudo pvcreate /dev/sdd2
sudo vgextend vg_datos /dev/sdd2
sudo fdisk -l
sudo lvextend -l +100%FREE /dev/mapper/vg_datos-lv_docker
sudo resize2fs /dev/mapper/vg_datos-lv_docker
df -h /dev/mapper/vg_datos-lv_docker
docker build -t web1-carbonaro .
docker login -u joacocarbo
ls -l
cat Dockerfile 
docker tag web1-carbonaro <tu-usuario-docker-hub>/web1-carbonaro
docker tag web1-carbonaro joacocarbo/web1-carbonaro
docker push docker push <tu-usuario-docker-hub>/web1-carbonaro
/web1-carbonaro
docker push joacocarbo/web1-carbonaro
vim run.sh
ls -l
chmod 764 run.sh
ls -l
./run.sh
vim index.html 
./run.sh
vim index.html 
ls -l
cd
pwd
ls -l
cd RTA_Examen_20241113/
ls -l
vim Punto_C.sh 
cat Punto_C.sh 
cd
ls -l
cd UTNFRA_SO_2do_Parcial_Carbonaro/
ls -l
cd RTA_Examen_20241113/
ls -l
cp ~/RTA_Examen_20241113/Punto_C.sh ~/UTNFRA_SO_2do_Parcial_Carbonaro/RTA_Examen_20241113/
ls -l
cat Punto_C.sh 
cd ..
ls -l
git status
git add .
git commit -m "ADD: Punto_C"
git push origin main
cd
exit
pwd
ls
ls -l
sudo apt install tree -y
ls -l
cd /usr/local/bin/
ls -l
cat Carbonaro_AltaUser-Groups.sh 
ls ~/UTN-FRA_SO_Examenes/202406/bash_script/Lista_Usuarios.txt
ls -l ~/UTN-FRA_SO_Examenes/202406/bash_script/Lista_Usuarios.txt
ls -l
cd ~/UTN-FRA_SO_Examenes/202406/bash_script/Lista_Usuarios.txt
cd ~/UTN-FRA_SO_Examenes/202406/bash_script/
ls -l
cat Lista_Usuarios.txt 
cd /usr/local/bin/
ls -l
cat Carbonaro_AltaUser-Groups.sh 
sudo /usr/local/bin/Carbonaro_AltaUser-Groups.sh carbonaro ~/UTN-FRA_SO_Examenes/202406/bash_script/Lista_Usuarios.txt
vim Carbonaro_AltaUser-Groups.sh 
ls -l
sudo rm -rf /usr/local/bin/Directorio_home
ls -l
sudo rm -rf /usr/local/bin/Directorio_Home
ls -l
cut -d: -f1 /etc/passwd
cut -d: -f1 /etc/group
id 2P_202406_Prog1
getent passwd 2P_202406_Prog1
id 2P_202406_Prog2
getent passwd 2P_202406_Prog2
id 2P_202406_Test1
getent passwd 2P_202406_Test1
id 2P_202406_Supervisor
getent passwd 2P_202406_Supervisor
ls -ld /work/2P_202406_Prog1
ls -ld /work/2P_202406_Prog2
ls -ld /work/2P_202406_Test1
ls -ld /work/2P_202406_Supervisor
ls -l
cat Carbonaro_AltaUser-Groups.sh 
pwd
cd
pwd
exit
pwd
ls -la
cd .ssh/
ls -l
cat id_ed25519.pub 
ls -la
-l -a
ls l -l-a
cd..
cd ..
tree
pwd
cd
ls -la
cd .ssh/
ls -la
cat id_ed25519.pub >> authorized_keys
cat authorized_keys 
ls -la
ifconfig
sudo apt install net-tools
ifconfig
exit
ssh carbonaro@192.168.56.3
pwd
exit
pwd
cd
exit
ssh carbonaro@192.168.56.3
ls -l
cd UTN-FRA_SO_Examenes/
ls -l
cd 202406/ansible/
ls -l
cd roles/
ls -l
cd 2do_parcial/
ls -l
cd ..
ls -l
ansible-galaxy role init estructura
ls -l
cd estructura/
ls -l
cd tasks/
ls -l
vim main.yml 
cd ..
ansible-galaxy role init archivo
ls -l
cd archivo/
ls -l
cd tasks/
ls -l
vim main.yml 
cd ..
ls -l
mkdir templates
ls -l
ls -la
cd templates/
ls -l
vim datos_alumno.txt.j2
vim datos_equipo.txt.j2
ls -l
cd ..
ls -l
cd vars/
ls -l
vim main.yml 
cd ..
ls -l
cd templates/
ls -l
vim datos_alumno.txt.j2 
vim datos_equipo.txt.j2 
cd ..
ls -l
cd vars/
ls -l
vim main.yml 
cd ..
ls -l
cd templates/
ls -l
cd ..
ansible-galaxy role init sudoers
ls -l
cd sudoers/
ls -l
cd tasks/
ls -l
vm main.yml 
vim main.yml 
cd ..
ls -l
vim ansible.cfg 
vim playbook.yml 
cd inventory/
ls -l
cat host
cd ..
ls -l
ansible-playbook -i /tests/inventory tests/test.yml
ansible-playbook -i inventory playbook.yml
ls -l
cd roles/
ls -l
cd ..
vim playbook.yml 
ansible-playbook -i inventory playbook.yml
vim playbook.yml 
ansible-playbook -i inventory playbook.yml
ls -l /tmp/2do_parcial/
cat /tmp/2do_parcial/alumno/datos_alumno.txt
cat /tmp/2do_parcial/equipo/datos_equipo.txt
getent group 2PSupervisores
sudo visudo -c
cd ..
cd
pwd
ls -l
cd RTA_Examen_20241113/
ls -l
vim Punto_D.sh 
cd
ls -l
cd UTNFRA_SO_2do_Parcial_Carbonaro/
ls -l
cp -r ~/UTN-FRA_SO_Examenes/202406/ .
ls -l
tree .
[200~git status
git status
git add .
git commit -m "ADD: Punto_E"
git push origin main
CD
cd
ls -l
cd RTA_Examen_20241113/
ls -l
vim Punto_D.sh 
cat Punto_D.sh 
cat Punto_C.sh 
cd
ls -l
cd UTNFRA_SO_2do_Parcial_Carbonaro/
ls -l
cd RTA_Examen_20241113/
ls -l
cp ~/RTA_Examen_20241113/Punto_D.sh .
ls -l
cat Punto_D.sh 
git status
git add .
git commit -m "ADD: Punto_D"
git push origin main
cd
cd UTN-FRA_SO_Examenes/202406/docker/
ls -l
./run.sh
docker ps
cd
ls -l
pwd
git status
cd UTNFRA_SO_2do_Parcial_Carbonaro/
git status
history -a
ls -l
