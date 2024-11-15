#!/bin/bash

# Generar claves SSH para el usuario
echo "Generando claves SSH para el usuario..."
ssh-keygen -t ed25519
echo "Claves SSH generadas."

# Copiar clave pública en authorized_keys
echo "Agregando clave pública al archivo authorized_keys..."
cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys

# Instalar net-tools para obtener la IP si no está instalado
echo "Instalando net-tools para ver la IP..."
sudo apt update
sudo apt install -y net-tools
echo "IP de la máquina:"
ifconfig | grep 'inet ' | grep -v '127.0.0.1' # Verifica la IP para el archivo de equipo

# Probar la conexión SSH con el servidor
echo "Comprobando conexión SSH con el servidor..."
ssh -o StrictHostKeyChecking=accept-new carbonaro@$(hostname -I | awk '{print $1}')
echo "Conexión SSH establecida con éxito."

# Ir a la carpeta de trabajo Ansible
cd ~/UTN-FRA_SO_Examenes/202406/ansible
echo "Directorio actual: $(pwd)"

# Crear roles de Ansible
echo "Creando roles necesarios para el proyecto..."
ansible-galaxy role init roles/estructura
ansible-galaxy role init roles/archivo
ansible-galaxy role init roles/sudoers
echo "Roles creados."

# Configurar el rol 'estructura'
echo "Configurando el rol 'estructura'..."
cat > roles/estructura/tasks/main.yml << 'EOF'
---
# tasks file for estructura
- name: "Crear directorios en /tmp/2do_parcial/"
  file:
    path: "/tmp/2do_parcial/{{ item }}"
    state: directory
    mode: '0775'
    recurse: yes
  with_items:
    - "alumno"
    - "equipo"
EOF

# Configurar el rol 'archivo'
echo "Configurando el rol 'archivo'..."
mkdir -p roles/archivo/templates
cat > roles/archivo/tasks/main.yml << 'EOF'
---
# tasks file for archivo
- name: "Generar datos del alumno en /tmp/2do_parcial/alumno/datos_alumno.txt"
  template:
    src: "datos_alumno.txt.j2"
    dest: "/tmp/2do_parcial/alumno/datos_alumno.txt"

- name: "Generar datos del equipo en /tmp/2do_parcial/equipo/datos_equipo.txt"
  template:
    src: "datos_equipo.txt.j2"
    dest: "/tmp/2do_parcial/equipo/datos_equipo.txt"
EOF

# Crear plantillas para el rol 'archivo'
echo "Creando plantillas para el rol 'archivo'..."
cat > roles/archivo/templates/datos_alumno.txt.j2 << 'EOF'
Nombre: {{ nombre }}
Apellido: {{ apellido }}
División: {{ division }}
EOF

cat > roles/archivo/templates/datos_equipo.txt.j2 << 'EOF'
IP: {{ ansible_default_ipv4.address }}
Distribución: {{ ansible_facts['distribution'] }}
Cantidad de Cores: {{ ansible_facts['processor_cores'] }}
EOF

# Configurar variables para el rol 'archivo'
echo "Configurando variables para el rol 'archivo'..."
cat > roles/archivo/vars/main.yml << 'EOF'
---
# vars file for archivo
nombre: "Joaquin"
apellido: "Carbonaro"
division: "311"
EOF

# Configurar el rol 'sudoers'
echo "Configurando el rol 'sudoers'..."
cat > roles/sudoers/tasks/main.yml << 'EOF'
---
# tasks file for sudoers
- name: "Configurar sudoers para el grupo 2PSupervisores sin contraseña"
  become: yes
  lineinfile:
    path: /etc/sudoers
    state: present
    regexp: '^%2PSupervisores'
    line: '%2PSupervisores ALL=(ALL) NOPASSWD: ALL'
    validate: 'visudo -cf %s'
EOF

# Configurar playbook para importar roles
echo "Configurando el playbook para importar roles..."
cat > playbook.yml << 'EOF'
---
- hosts: all

  tasks:
    - include_role:
        name: 2do_parcial
    
    - name: "Otra tarea"
      debug:
        msg: "Despues de la ejecucion del rol"

    - name: "Importar rol estructura"
      import_role:
        name: estructura

    - name: "Importar rol archivo"
      import_role:
        name: archivo

    - name: "Importar rol sudoers"
      import_role:
        name: sudoers
EOF

# Ejecutar el playbook
echo "Ejecutando el playbook para aplicar configuraciones..."
ansible-playbook -i inventory playbook.yml

# Verificación de la configuración
echo "Verificación de los resultados:"
echo "Revisando directorios creados en /tmp/2do_parcial/..."
ls -l /tmp/2do_parcial/

echo "Contenido del archivo datos_alumno.txt:"
cat /tmp/2do_parcial/alumno/datos_alumno.txt

echo "Contenido del archivo datos_equipo.txt:"
cat /tmp/2do_parcial/equipo/datos_equipo.txt

echo "Verificando configuración de sudoers..."
sudo visudo -c

echo "Script completado exitosamente."
