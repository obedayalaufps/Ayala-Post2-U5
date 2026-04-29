#!/bin/bash
# Laboratorio: VirtualBox - Creación y Gestión de Máquinas Virtuales
# Estudiante: Obed Ayala
# Asignatura: Arquitectura de Computadores
# Institución: UFPS - 2026

echo "=== Fase 1: Creación y Configuración de la VM ==="
# Crear la máquina virtual y registrarla
VBoxManage createvm --name "Lab5-Alpine" --ostype "Linux_64" --register

# Configurar hardware básico: 1GB RAM, 16MB VRAM, 1 CPU y red NAT[cite: 1]
VBoxManage modifyvm "Lab5-Alpine" --memory 1024 --vram 16 --cpus 1 --nic1 nat[cite: 1]

# Crear el disco duro virtual de 10GB en formato VDI[cite: 1]
VBoxManage createmedium disk --filename "Lab5-Alpine.vdi" --size 10240 --format VDI[cite: 1]

# Configurar controlador SATA y conectar el disco duro[cite: 1]
VBoxManage storagectl "Lab5-Alpine" --name "SATA" --add sata[cite: 1]
VBoxManage storageattach "Lab5-Alpine" --storagectl "SATA" --port 0 --device 0 --type hdd --medium "Lab5-Alpine.vdi"[cite: 1]

# Configurar controlador IDE y conectar la ISO de Alpine Linux[cite: 1]
VBoxManage storagectl "Lab5-Alpine" --name "IDE" --add ide[cite: 1]
VBoxManage storageattach "Lab5-Alpine" --storagectl "IDE" --port 0 --device 0 --type dvddrive --medium "alpine-standard-3.19.0-x86_64.iso"[cite: 1]

echo "=== Fase 3: Configuración de Modos de Red ==="[cite: 1]
# Apagar la VM antes de realizar cambios de red[cite: 1]
VBoxManage controlvm "Lab5-Alpine" poweroff[cite: 1]

# Configuración de red: Modo Host-Only (Solo-Anfitrión)[cite: 1]
VBoxManage hostonlyif create[cite: 1]
VBoxManage modifyvm "Lab5-Alpine" --nic1 hostonly --hostonlyadapter1 "vboxnet0"[cite: 1]

# Configuración de red: Modo Bridge (Puente)[cite: 1]
VBoxManage modifyvm "Lab5-Alpine" --nic1 bridged --bridgeadapter1 "Ethernet"[cite: 1]

echo "=== Fase 4: Gestión de Snapshots ==="[cite: 1]
# Tomar snapshot del estado base[cite: 1]
VBoxManage snapshot "Lab5-Alpine" take "snap base" --description "Alpine Linux 3.19 recién instalado, sin modificaciones"[cite: 1]

# Tomar segundo snapshot después de instalar herramientas (curl, nano, etc.)[cite: 1]
VBoxManage snapshot "Lab5-Alpine" take "snap con herramientas" --description "Alpine con curl, wget, nano y htop instalados"[cite: 1]

# Listar snapshots para verificar el árbol[cite: 1]
VBoxManage snapshot "Lab5-Alpine" list[cite: 1]

# Restaurar al estado base para verificar funcionalidad[cite: 1]
VBoxManage snapshot "Lab5-Alpine" restore "snap base"[cite: 1]

# Iniciar la VM para verificar la restauración[cite: 1]
VBoxManage startvm "Lab5-Alpine" --type gui[cite: 1]

echo "=== Fase 5: Exportación en formato OVA ==="[cite: 1]
# Apagar la VM para exportación segura[cite: 1]
VBoxManage controlvm "Lab5-Alpine" poweroff[cite: 1]

# Exportar la VM incluyendo el manifiesto para integridad[cite: 1]
VBoxManage export "Lab5-Alpine" --output "Lab5-Alpine-export.ova" --manifest --options manifest[cite: 1]