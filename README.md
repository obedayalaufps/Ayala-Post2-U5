
# Arquitectura de Computadores - Unidad 5: Post-Contenido 2

## Datos del Estudiante
- **Nombre:** Obed Ayala
- **Institución:** Universidad Francisco de Paula Santander (UFPS)
- **Programa:** Ingeniería de Sistemas
- **Año:** 2026

## Descripción de la Máquina Virtual
Para este laboratorio se ha configurado una máquina virtual (VM) con las siguientes especificaciones técnicas para garantizar un rendimiento óptimo en un entorno minimalista:

- **Nombre de la VM:** Lab5-Alpine
- **Sistema Operativo:** Alpine Linux 3.19 (Standard Edition, x86_64)
- **Memoria RAM:** 1024 MB (1 GB)
- **Almacenamiento:** 10 GB (VDI, Asignación dinámica)
- **Procesador:** 1 CPU

## Estructura del Repositorio
El proyecto está organizado bajo la siguiente jerarquía de archivos:
```text
Ayala-post2-u5/
├── capturas/               # Evidencias de cada checkpoint
├── VBoxManage_commands.sh  # Script con todos los comandos utilizados
└── README.md               # Documentación técnica completa
```

## Resultados por Fase (Checkpoints)

**Checkpoint 1: Creación y Configuración de la VM**  
Se configuró el hardware virtual inicial y se adjuntó la imagen ISO de Alpine Linux. La red se estableció inicialmente en modo NAT.

**Checkpoint 2: Instalación de Alpine Linux**  
Se ejecutó el script setup-alpine, configurando el teclado en us, el hostname como lab5-vm y realizando la instalación completa en el disco sda con el modo sys.

**Checkpoint 3: Verificación de Modos de Red**  
Se realizaron pruebas de conectividad utilizando diferentes configuraciones de red.

| Modo de Red | Dirección IP Obtenida | Acceso a Internet          | Conexión con Anfitrión |
|-------------|-----------------------|----------------------------|------------------------|
| NAT        | 10.0.2.15            | Sí (vía Gateway 10.0.2.2) | Limitado              |
| Host-Only  | 192.168.56.101         | No                        | Total (Bidireccional) |

**Checkpoint 4: Gestión de Snapshots**  
Se implementó un sistema de control de estados mediante snapshots para permitir la reversión de cambios en el sistema.  

**Árbol de Snapshots:**  
- snap base: Alpine Linux 3.19 recién instalado, sin modificaciones.  
- snap con herramientas: Alpine con curl, wget, nano y htop instalados.

**Checkpoint 5: Exportación OVA y Consolidación**  
La VM fue exportada correctamente en formato portable .ova. El repositorio final incluye el script de comandos VBoxManage_commands.sh que documenta la automatización del proceso.

## Conclusiones Técnicas
Modos de Red: Se observó que el modo NAT es ideal para actualizaciones de software iniciales debido al acceso directo a internet, mientras que Host-Only es la opción más segura para entornos de desarrollo aislados donde solo se requiere comunicación entre la VM y la máquina física.  

Snapshots: El uso de snapshots demostró ser una herramienta crítica en la administración de sistemas, permitiendo restaurar el sistema al estado base en segundos tras verificar que el software instalado adicionalmente ya no estaba presente tras la restauración.  

Portabilidad: La exportación en formato OVF/OVA garantiza que la VM pueda ser distribuida y ejecutada en cualquier otro hipervisor compatible, manteniendo la integridad de la configuración y los datos.
