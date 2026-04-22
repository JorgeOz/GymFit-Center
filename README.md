# GymFit Center - Gestión de Gimnasio

Proyecto Intermodular de Desarrollo de Aplicaciones Multiplataforma. Actualmente en **Fase 1: Diseño y Modelado de Datos**.

## 📊 Estado del Proyecto
- [x] Análisis de requisitos.
- [x] Diseño del Diagrama Entidad-Relación (DER).
- [x] Script de creación de Base de Datos (MySQL).
- [ ] Implementación de lógica de negocio (Java).
- [ ] Interfaz de usuario.

## 🗄️ Base de Datos
El sistema cuenta con una arquitectura robusta para gestionar:
* **Usuarios y Socios:** Control de accesos y perfiles.
* **Actividades:** Gestión de clases dirigidas y horarios.
* **Reservas:** Sistema de inscripción a actividades.

## 💾 Arquitectura de Datos
La base de datos se ha diseñado siguiendo el modelo relacional, garantizando la integridad referencial y la escalabilidad del sistema.

### Entidades Principales:
* **Gestión de Usuarios:** Sistema de herencia entre Usuarios, Socios y Monitores.
* **Control de Acceso:** Implementación de Roles y Permisos (RBAC).
* **Operativa:** Gestión de Actividades, Instalaciones, Horarios y Reservas.
* **Comercial:** Sistema de Ofertas, Contratos y Promociones.
  
> Puedes encontrar el diagrama del modelo de datos en la carpeta `/design`.
