# Sistema de Red Social - Base de Datos

Un proyecto académico que implementa el modelo de base de datos relacional para una plataforma de red social tipo Facebook, incluyendo normalización hasta FNBC.

## Descripción General

Este proyecto contiene el diseño e implementación completa de una base de datos relacional para un sistema de red social, incluyendo gestión de usuarios, grupos, amistades, publicaciones, mensajes directos y notificaciones. El proyecto incluye definición de esquemas SQL normalizados, inserción de datos de prueba, consultas de ejemplo, y control de acceso basado en roles.

## Estructura del Proyecto

```
sql/
├── Creacion_Tablas.sql      # Definición del esquema de base de datos
├── Ingreso_datos.sql        # Datos iniciales de prueba
├── Querys.sql               # Consultas SQL de ejemplo
├── Roles.sql                # Definición de roles y permisos
```

---

## Modelo Entidad-Relación

### Hipótesis de Diseño

El modelo se fundamenta en las siguientes hipótesis:

- **Especialización de Usuario:** Un usuario puede ser emisor y receptor de mensajes
- **Publicaciones Multigrupo:** Un usuario puede subir publicaciones a múltiples grupos o tener publicaciones personales
- **Autoría Única:** Una publicación pertenece a un único usuario (no existen publicaciones colaborativas)
- **Creador de Grupo:** El primer miembro de un grupo es su creador (mínimo un miembro siempre)

---

## Entidades Principales

### Usuario (Entidad Fuerte)
**Clave Primaria:** `id_usuario` (subrogada)

| Atributo | Tipo | Descripción |
|----------|------|-------------|
| id_usuario | INT | Identificador único, inmutable y eficiente |
| nombre | VARCHAR(100) | Nombre del usuario |
| apellido | VARCHAR(100) | Apellido del usuario |
| email | VARCHAR(255) | Email único (validación @gmail.com) |
| fecha_ingreso | DATE | Fecha de registro en la plataforma |
| cantidad_ingresos | INT | Contador de ingresos del usuario |
| pais | ENUM | País de procedencia (Argentina, Chile, Paraguay, Bolivia, Perú, Uruguay) |

**Justificación:** Se utilizó clave subrogada para asegurar un identificador único, inmutable e independiente de los datos personales.

### Emisor (Especialización de Usuario)
**Clave Primaria:** `id_usuario`
- Rol de usuario que envía mensajes
- Hereda todos los atributos de Usuario
- Permite especialización sin atributos adicionales

### Receptor (Especialización de Usuario)
**Clave Primaria:** `id_usuario`
- Rol de usuario que recibe mensajes
- Hereda todos los atributos de Usuario
- Permite especialización sin atributos adicionales

### Publicación (Entidad Fuerte)
**Clave Primaria:** `id_publicacion` (subrogada)

| Atributo | Tipo | Descripción |
|----------|------|-------------|
| id_publicacion | INT | Identificador único |
| id_usuario | INT | FK → Usuario (autor) |
| tipo | VARCHAR(50) | Tipo de contenido (imagen, video, texto) |
| fecha_creacion | TIMESTAMP | Momento de creación |
| descripcion | VARCHAR(255) | Descripción del contenido |
| contenido | BYTEA | Contenido multimedia |

**Justificación:** Clave subrogada para garantizar eficiencia en las operaciones de consulta.

### Grupo (Entidad Fuerte)
**Clave Primaria:** `id_grupo` (subrogada)

| Atributo | Tipo | Descripción |
|----------|------|-------------|
| id_grupo | INT | Identificador único |
| nombre | VARCHAR(255) | Nombre del grupo |
| descripcion | VARCHAR(255) | Descripción del grupo |
| fecha_creacion | DATE | Fecha de creación del grupo |

**Justificación:** Clave subrogada para simplificar identificación y relaciones con otras entidades.

### Notificación (Entidad Débil)
**Clave Primaria:** `(id_receptor, descripcion, fecha_emision)` compuesta

| Atributo | Tipo | Descripción |
|----------|------|-------------|
| id_receptor | INT | FK → Usuario (receptor) |
| descripcion | VARCHAR(255) | Descripción discriminante |
| fecha_emision | TIMESTAMP | Fecha y hora discriminante |
| tipo | VARCHAR(50) | Tipo de notificación |

**Justificación:** Entidad débil que depende de Usuario. Los atributos discriminantes `descripcion` y `fecha_emision` permiten distinguir múltiples notificaciones del mismo usuario.

### Envío (Entidad Débil)
**Clave Primaria:** `(id_emisor, fecha_envio)` compuesta

| Atributo | Tipo | Descripción |
|----------|------|-------------|
| id_emisor | INT | FK → Emisor |
| fecha_envio | TIMESTAMP | Fecha y hora discriminante |

**Justificación:** Entidad débil que depende de Emisor. Representa la acción de envío y almacena el timestamp para diferenciar múltiples envíos del mismo usuario.

### Mensaje (Entidad Débil)
**Clave Primaria:** `(id_emisor, id_receptor, fecha_envio)` compuesta

| Atributo | Tipo | Descripción |
|----------|------|-------------|
| id_emisor | INT | FK → Emisor |
| id_receptor | INT | FK → Receptor |
| fecha_envio | TIMESTAMP | Fecha discriminante |
| fecha_lectura | TIMESTAMP | Momento de lectura (NULL si no leído) |
| contenido | VARCHAR(255) | Contenido del mensaje |

**Justificación:** Entidad débil que depende de Envío. La clave compuesta garantiza unicidad de cada envío entre usuarios. Incluye validación: `fecha_lectura >= fecha_envio`.

---

## Relaciones Implementadas

| Relación | Entidades | Cardinalidad | Descripción |
|----------|-----------|--------------|-------------|
| **Amigo de** | Usuario - Usuario | M:M | Relación bidireccional entre usuarios |
| **Crea** | Usuario - Publicación | 1:N | Usuario crea múltiples publicaciones |
| **Marca favorita** | Usuario - Publicación | M:M | Usuario marca publicaciones como favoritas |
| **Tiene** | Publicación - Grupo | M:N | Publicación pertenece a múltiples grupos |
| **Miembro de** | Usuario - Grupo | M:N | Usuario es miembro de múltiples grupos |
| **Realiza** | Emisor - Envío | 1:N | Emisor realiza múltiples envíos |
| **Genera** | Envío - Mensaje | 1:1 | Cada envío genera exactamente un mensaje |
| **Recibe (Msg)** | Usuario - Mensaje | 1:N | Usuario recibe múltiples mensajes |
| **Recibe (Not)** | Usuario - Notificación | 1:N | Usuario recibe múltiples notificaciones |

---

## Modelo Relacional (Pasaje del ER)

### Tablas Principales

```sql
-- Tabla de usuarios
Usuarios(id_usuario, nombre, apellido, email, fecha_ingreso, cantidad_ingresos, pais)

-- Tabla de amistades (relación M:M)
Amistades(id_usuario_1, id_usuario_2, fecha_amistad)

-- Tabla de grupos
Grupos(id_grupo, nombre, descripcion, fecha_creacion)

-- Tabla de membresía en grupos (relación M:N)
Usuarios_Grupos(id_usuario, id_grupo, fecha_ingreso, rol_usuario)

-- Tabla de publicaciones
Publicaciones(id_publicacion, id_usuario, tipo, fecha_creacion, descripcion, contenido)

-- Tabla de asociación publicación-grupo (relación M:N)
Publicaciones_Grupo(id_publicacion, id_grupo)

-- Tabla de publicaciones favoritas (relación M:N)
Usuarios_Publicaciones_Favoritas(id_usuario, id_publicacion, fecha_favorito)

-- Tabla de notificaciones
Notificaciones(id_receptor, descripcion, fecha_emision, tipo)

-- Tabla de mensajes
Mensajes(id_emisor, id_receptor, fecha_envio, fecha_lectura, contenido)
```

### Claves Foráneas Implementadas

- `Amistades.id_usuario_1` → `Usuarios.id_usuario`
- `Amistades.id_usuario_2` → `Usuarios.id_usuario`
- `Usuarios_Grupos.id_usuario` → `Usuarios.id_usuario`
- `Usuarios_Grupos.id_grupo` → `Grupos.id_grupo`
- `Publicaciones.id_usuario` → `Usuarios.id_usuario`
- `Publicaciones_Grupo.id_publicacion` → `Publicaciones.id_publicacion`
- `Publicaciones_Grupo.id_grupo` → `Grupos.id_grupo`
- `Usuarios_Publicaciones_Favoritas.id_usuario` → `Usuarios.id_usuario`
- `Usuarios_Publicaciones_Favoritas.id_publicacion` → `Publicaciones.id_publicacion`
- `Notificaciones.id_receptor` → `Usuarios.id_usuario`
- `Mensajes.id_emisor` → `Usuarios.id_usuario`
- `Mensajes.id_receptor` → `Usuarios.id_usuario`

---

## Formas Normales Implementadas

### Primera Forma Normal (1FN)

Todos los atributos son atómicos. No hay atributos compuestos ni multivaluados.

### Segunda Forma Normal (2FN)

Se cumple 1FN y todo atributo no primo depende de la clave primaria completa:

| Tabla | Dependencia |
|-------|-------------|
| **Usuarios** | id_usuario → {nombre, apellido, email, fecha_ingreso, cantidad_ingresos, pais} |
| **Amistades** | id_usuario_1, id_usuario_2 → fecha_amistad |
| **Grupos** | id_grupo → {nombre, descripcion, fecha_creacion} |
| **Usuarios_Grupos** | id_usuario, id_grupo → {fecha_ingreso, rol_usuario} |
| **Publicaciones** | id_publicacion → {id_usuario, tipo, fecha_creacion, descripcion, contenido} |
| **Usuarios_Publicaciones_Favoritas** | id_usuario, id_publicacion → fecha_favorito |
| **Notificaciones** | id_receptor, descripcion, fecha_emision → tipo |
| **Mensajes** | id_emisor, id_receptor, fecha_envio → {fecha_lectura, contenido} |

### Tercera Forma Normal (3FN)

Se cumple 2FN y no existen dependencias transitivas. Todos los atributos no primos dependen directamente de la clave primaria, sin depender de otros atributos no primos.

### Forma Normal de Boyce-Codd (FNBC)

Para toda dependencia funcional no trivial X → Y, X es superclave. Se elimina toda redundancia lógica y se garantiza la más alta normalización posible.

---

## Sistema de Roles y Permisos

### Roles Implementados

**Administrador**
- Acceso total a todas las tablas
- Permisos CRUD completos
- Gestión de roles y permisos

**Usuario**
- Insertar publicaciones
- Crear grupos
- Enviar mensajes
- Lectura limitada de datos

---

## Cómo Usar

### Requisitos
- PostgreSQL 12 o superior
- Cliente SQL (psql, pgAdmin, DBeaver, DataGrip, etc.)
- Acceso de administrador a la base de datos

### Instalación y Ejecución

1. **Crear la base de datos**
```sql
CREATE DATABASE tp_base_de_datos;
```

2. **Conectarse a la base de datos**
```bash
psql -U postgres -d tp_base_de_datos
```

3. **Ejecutar los scripts en orden** (muy importante)
```bash
# Script 1: Crear todas las tablas y restricciones
\i Creacion_Tablas.sql

# Script 2: Crear roles y permisos
\i Roles.sql

# Script 3: Insertar datos de prueba
\i Ingreso_datos.sql

# Script 4: Ejecutar consultas de ejemplo (opcional)
\i Querys.sql
```

4. **Verificar datos de prueba**
```sql
SELECT COUNT(*) FROM Usuarios;
SELECT COUNT(*) FROM Grupos;
SELECT COUNT(*) FROM Publicaciones;
SELECT COUNT(*) FROM Amistades;
```

5. **Consultar datos específicos**
```sql
-- Ver todos los usuarios
SELECT id_usuario, nombre, apellido, email, pais FROM Usuarios;

-- Ver grupos creados
SELECT id_grupo, nombre, descripcion, fecha_creacion FROM Grupos;

-- Ver membresía en grupos
SELECT u.nombre, g.nombre, ug.rol_usuario 
FROM Usuarios_Grupos ug
JOIN Usuarios u ON ug.id_usuario = u.id_usuario
JOIN Grupos g ON ug.id_grupo = g.id_grupo;

-- Ver publicaciones favoritas
SELECT u.nombre, p.descripcion, upf.fecha_favorito
FROM Usuarios_Publicaciones_Favoritas upf
JOIN Usuarios u ON upf.id_usuario = u.id_usuario
JOIN Publicaciones p ON upf.id_publicacion = p.id_publicacion;
```

---

## Características Técnicas

### Restricciones y Validaciones

- **Claves Primarias:** Garantizan unicidad en cada tabla
- **Claves Foráneas:** Mantienen integridad referencial
- **Validaciones de Email:** `CHECK (email LIKE '%@gmail.com')`
- **Integridad Referencial:** CASCADE DELETE en relaciones críticas
- **Tipo Personalizado:** ENUM para países latinoamericanos
- **Timestamps Automáticos:** `DEFAULT CURRENT_TIMESTAMP`
- **Validaciones Temporales:** `CHECK (fecha_lectura IS NULL OR fecha_lectura >= fecha_envio)`
- **Ordenamiento de Amistades:** `CHECK (id_usuario_1 < id_usuario_2)` evita duplicados

### Datos de Prueba Incluidos

- **10 usuarios registrados** con emails y países variados
- **5 grupos de interés** especializados
- **Amistades bidireccionales** entre usuarios
- **Relaciones de membresía** con roles (Administrador, Miembro)
- **Notificaciones de ejemplo** (solicitudes, publicaciones, grupos)
- **Mensajes directos** entre usuarios
- **Publicaciones y favoritos** para demostrar funcionalidad

### Optimizaciones Implementadas

- Uso de claves subrogadas para mejor rendimiento en JOINs
- Índices implícitos en claves primarias
- Normalización completa para evitar redundancia
- Relaciones M:N implementadas con tablas de unión

---

## Integrantes del Equipo 5

- Gonzalo Laos Pinto
- Luis Trebejo
- Joani Pranteda
- Fiorilo, Roy
- Maddalena, Martin Andres

---

## Temas de Base de Datos Cubiertos

- Modelado relacional (ER a Modelo Relacional)
- Normalización completa (1FN, 2FN, 3FN, FNBC)
- Integridad referencial y restricciones
- Control de acceso (Roles y Permisos)
- Tipos de datos personalizados (ENUM)
- Relaciones especializadas (Usuarios: Emisor/Receptor)
- Entidades débiles (Notificaciones, Envío, Mensaje)
- Relaciones reflexivas (Amistades)
- Claves compuestas y subrogadas

---

## Licencia

Proyecto académico - Uso educativo

---

## Contacto

Para consultas sobre el proyecto, contactar a los integrantes del Equipo 5.

---

**Última actualización:** Mayo 2026
**Estado:** Completo y Normalizado (FNBC)
