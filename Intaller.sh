#!/bin/bash

# ==============================================
# AutoNmap Installer
# Autor: N20
# Descripción: Instala AutoNmap y sus dependencias.
# Uso: sudo ./installer.sh
# ==============================================

#Colores

R='\033[1;31m'
G='\033[1;32m'
Y='\033[1;33m'
B='\033[1;34m'
M='\033[1;35m'
C='\033[1;36m'
W='\033[1;37m'
NC='\033[0m'

show_banner() {
    echo -e "${G}   █████╗ ██╗   ██╗████████╗ ██████╗ ███╗   ██╗███╗   ███╗ █████╗ ██████╗ "
	echo -e "${G}  ██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗████╗  ██║████╗ ████║██╔══██╗██╔══██╗"
    echo -e "${Y}  ███████║██║   ██║   ██║   ██║   ██║██╔██╗ ██║██╔████╔██║███████║██████╔╝"
    echo -e "${R}  ██╔══██║██║   ██║   ██║   ██║   ██║██║╚██╗██║██║╚██╔╝██║██╔══██║██╔═══╝ "
    echo -e "${R}  ██║  ██║╚██████╔╝   ██║   ╚██████╔╝██║ ╚████║██║ ╚═╝ ██║██║  ██║██║     "
    echo -e "${R}  ╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ${NC}"
    echo ""
    echo -e "${C}                    ⚡      Instalador de autonmap    ⚡${NC}"
    echo -e "${W}                                   N2O${NC}"
    echo "-------------------------------------------------------------"
    echo ""
}

# Función para imprimir errores y salir
error_exit() {
    echo -e "${R}[!] Error: $1${NC}" >&2
    exit 1
}

# Función para mostrar progreso
print_step() {
    echo -e "${B}[*] $1...${NC}"
}

print_success() {
    echo -e "${G}[✓] $1${NC}"
}

print_warning() {
    echo -e "${Y}[!] $1${NC}"
}

# Mostrar banner
show_banner

# ----------------------------------------------
# 1. Verificar root
# ----------------------------------------------
print_step "Verificando permisos de administrador"
if [ "$EUID" -ne 0 ]; then
    echo -e "${Y}[!] Se requieren privilegios de root.${NC}"
    echo -e "${Y}    Por favor, ejecuta: sudo ./installer.sh${NC}"
    exit 1
fi
print_success "Permisos de root correctos"

# ----------------------------------------------
# 2. Detectar SO (solo Debian/Ubuntu)
# ----------------------------------------------
print_step "Detectando sistema operativo"
if ! command -v apt &> /dev/null; then
    error_exit "Este instalador solo es compatible con distribuciones basadas en Debian/Ubuntu."
fi
print_success "Sistema basado en Debian/Ubuntu detectado"

# ----------------------------------------------
# 3. Actualizar repositorios
# ----------------------------------------------
print_step "Actualizando lista de paquetes"
apt update -qq || error_exit "No se pudo actualizar la lista de paquetes."
print_success "Repositorios actualizados"

# ----------------------------------------------
# 4. Instalar dependencias principales
# ----------------------------------------------
print_step "Instalando dependencias (nmap, xclip, git)"
apt install -y nmap git || error_exit "No se pudieron instalar las dependencias."
print_success "nmap, git instalados"

# ----------------------------------------------
# 5. Instalar whichSystem.py
# ----------------------------------------------
print_step "Verificando whichSystem.py"
if command -v whichSystem.py &> /dev/null; then
    print_success "whichSystem.py ya está instalado"
else
    print_step "Clonando e instalando whichSystem.py"
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR" || error_exit "No se pudo crear directorio temporal"
    git clone https://github.com/Commmodore64/whichsystem.git || error_exit "No se pudo clonar el repositorio"
    cd whichsystem || error_exit "No se pudo acceder al directorio"
    cp whichSystem.py /usr/local/bin/ || error_exit "No se pudo copiar el script"
    chmod +x /usr/local/bin/whichSystem.py
    cd / || error_exit "No se pudo volver al directorio raíz"
    rm -rf "$TEMP_DIR"
    print_success "whichSystem.py instalado correctamente"
fi

# ----------------------------------------------
# 6. Instalar AutoNmap
# ----------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
print_step "Instalando AutoNmap en /usr/local/bin"

# Verificar si el script autonmap existe en el directorio actual
if [ ! -f "$SCRIPT_DIR/autonmap" ]; then
    error_exit "No se encontró el script 'autonmap' en $SCRIPT_DIR"
fi

# Copiar el script principal
mkdir $HOME/.local/bin
cp "$SCRIPT_DIR/autonmap" $HOME/.local/bin/autonmap || error_exit "No se pudo copiar el script"
chmod +x $HOME/.local/bin/autonmap
print_success "AutoNmap instalado en $HOME/.local/bin/autonmap"

# ----------------------------------------------
# 7. Verificar instalación
# ----------------------------------------------
print_step "Verificando instalación"
if command -v autonmap &> /dev/null; then
    print_success "AutoNmap instalado correctamente"
else
    print_warning "AutoNmap no se encuentra en el PATH. Asegúrate de que $HOME/.local/bin esté en tu PATH."
fi

# ----------------------------------------------
# 8. Resumen final
# ----------------------------------------------
echo ""
echo -e "${C}==================================================${NC}"
echo -e "${G}          ¡Instalación completada!${NC}"
echo -e "${C}==================================================${NC}"
echo ""
echo -e "Ahora puedes usar AutoNmap desde cualquier lugar:"
echo -e "  ${W}sudo autonmap <IP>${NC}"
echo ""
echo -e "Para más información, consulta el README.md"
echo ""
