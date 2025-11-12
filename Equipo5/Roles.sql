--Creación de roles.
CREATE ROLE administrador LOGIN;
CREATE ROLE usuario LOGIN;

--Permisos para el administrador (acceso total).
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA tp TO administrador;

--Permisos para el usuario.
GRANT INSERT ON
    Publicaciones,
    Grupos,
    Mensajes
TO usuario;