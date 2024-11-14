#!/bin/bash

# Verificar si se pasaron los parámetros necesarios
if [ "$#" -ne 2 ]; then
  echo "Uso: $0 <usuario_para_clave> <ruta_Lista_Usuarios.txt>"
  exit 1
fi

# Asignar parámetros a variables para mayor claridad
usuario_clave="$1"
archivo_usuarios="$2"

# Verificar que el usuario base existe en el sistema
if ! id "$usuario_clave" &>/dev/null; then
  echo "Error: El usuario $usuario_clave no existe en el sistema."
  exit 1
fi

# Obtener la clave encriptada del usuario de referencia
clave=$(sudo getent shadow "$usuario_clave" | cut -d: -f2)

# Verificar que el archivo existe
if [ ! -f "$archivo_usuarios" ]; then
  echo "Error: El archivo $archivo_usuarios no existe."
  exit 1
fi

# Procesar el archivo y crear usuarios y grupos
while IFS=',' read -r nombre_usuario grupo_primario directorio_home; do
  # Eliminar espacios en blanco antes y después de cada campo
  nombre_usuario=$(echo "$nombre_usuario" | xargs)
  grupo_primario=$(echo "$grupo_primario" | xargs)
  directorio_home=$(echo "$directorio_home" | xargs)

  # Crear el grupo si no existe
  if ! getent group "$grupo_primario" &>/dev/null; then
    echo "Creando grupo $grupo_primario..."
    sudo groupadd "$grupo_primario"
  fi

  # Crear el usuario si no existe
  if ! id "$nombre_usuario" &>/dev/null; then
    echo "Creando usuario $nombre_usuario con grupo $grupo_primario y directorio home $directorio_home..."
    sudo useradd -m -d "$directorio_home" -g "$grupo_primario" "$nombre_usuario"
    sudo mkdir -p "$directorio_home"
    sudo chown "$nombre_usuario:$grupo_primario" "$directorio_home"
    
    # Asignar la contraseña encriptada
    sudo usermod -p "$clave" "$nombre_usuario"
  else
    echo "El usuario $nombre_usuario ya existe, omitiendo..."
  fi
done < "$archivo_usuarios"

echo "Proceso completado."

