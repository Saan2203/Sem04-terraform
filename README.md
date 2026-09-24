Este proyecto utiliza Terraform y Docker para aprovisionar dos entornos (DEV y QA) simulando una arquitectura de tres capas (Frontend, Backend, Base de Datos).

Requisitos
- Tener Docker Desktop instalado y en ejecución.
- Tener Terraform instalado.

Instrucciones de despliegue

1. Descargar el proyecto:
   Abre una terminal en la carpeta raíz del proyecto descargado (donde se encuentra el archivo `main.tf`).

2. Inicializar Terraform:
   Descarga los providers necesarios (en este caso, `kreuzwerker/docker`).
   ```bash
   terraform init