

# 🔍 AutoNmap - Automated Network Scanner

**AutoNmap** es una herramienta de automatización para escaneos de red utilizando `nmap`. Está diseñada para entornos de pentesting y CTFs, agilizando el proceso de enumeración de puertos, detección de sistema operativo y extracción de resultados.

## ✨ Características

- 🖥️ **Banner estilo hacker** con el nombre `AUTONMAP`.
- 🔐 **Verificación de privilegios root** (requiere `sudo`).
- 🧠 **Detección de sistema operativo** mediante `whichSystem.py`.
- 🚀 **Escaneo completo de puertos** con `nmap` (TCP SYN Scan, alto rendimiento).
- 📦 **Extracción automática de puertos**.
- 🎨 **Salida con colores** para mejor legibilidad.

## 📋 Requisitos

- Sistema operativo Linux (probado en Kali Linux / Parrot OS).
- `nmap` instalado.
- `whichSystem.py` (herramienta de S4vitar).
  
### Instalación de dependencias


# Instalar nmap y xclip

sudo apt update && sudo apt install nmap -y

---

# Clonar e instalar whichSystem.py (ejemplo)

aqui te comparto tambien la herramienta de S4vitar whichSystem.py

sudo cp whichSystem.py /usr/local/bin

---

🛠️ Instalación de AutoNmap

1. Clona este repositorio o descarga el script autonmap.sh:
   ```bash
   git clone https://github.com/Gax-n2o/autonmap
   cd autonmap
   ```
2. Da permisos de ejecución:
   ```bash
   chmod +x autonmap
   ```
3. (Opcional) Instálalo en el PATH para usarlo desde cualquier ubicación:
   ```bash
   sudo cp autonmap /.local/bin/autonmap
   ```

🚀 Uso

Si lo instalaste en el PATH:

```bash
sudo autonmap 192.168.1.10
```

📁 Archivos generados

· escaneo_<IP>.gnmap: Salida en formato grepeable de Nmap.
· puertos_<IP>.txt: Lista de puertos abiertos separados por comas.

⚙️ Personalización

Puedes modificar las variables de color o el banner editando las secciones correspondientes al inicio del script:

```bash
R='\033[1;31m'   # Rojo
G='\033[1;32m'   # Verde
Y='\033[1;33m'   # Amarillo
# ...
```

🐛 Solución de problemas

· El banner no se muestra con colores: Asegúrate de usar echo -e y que tu terminal soporte ANSI.
· Error whichSystem.py: command not found: Instala la herramienta o comenta la línea correspondiente.

🤝 Créditos

· N20 - Desarrollo del script.
· S4vitar - Inspiración y herramientas base (whichSystem.py).

# N2O
