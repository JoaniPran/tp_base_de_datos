-- Registrar un usuario.
INSERT INTO Usuarios (nombre, apellido, email, fecha_ingreso, cantidad_ingresos, pais) VALUES 
('Rogelio', 'Buen Dia', 'rogelio_buendia@gmail.com', '2024-03-18', 1, 'Argentina');

-- Listar todos los usuarios de la red social.
SELECT *
FROM usuarios;

-- Listar todas las amistades de la red social.
SELECT u.nombre AS nombre_usuario, u.apellido AS apellido_usuario, us.nombre AS nombre_amigo, us.apellido AS apellido_amigo, a.fecha_amistad
FROM Usuarios u
JOIN Amistades a ON u.id_usuario = a.id_usuario_1
JOIN Usuarios us ON a.id_usuario_2 = us.id_usuario;

-- Listar los amigos de un usuario particular de la red social.
SELECT 
    u2.id_usuario,
    u2.nombre,
    u2.apellido
FROM Amistades a
INNER JOIN Usuarios u2 ON a.id_usuario_2 = u2.id_usuario
WHERE a.id_usuario_1 = 10

UNION

SELECT 
    u1.id_usuario,
    u1.nombre,
    u1.apellido
FROM Amistades a
INNER JOIN Usuarios u1 ON a.id_usuario_1 = u1.id_usuario
WHERE a.id_usuario_2 = 10
ORDER BY nombre, apellido;

-- Listar todos los mensajes de la red social.
SELECT * 
FROM Mensajes;

-- Contabilizar la cantidad de usuarios, agrupados por país.
SELECT pais, COUNT(*) AS cantidad_usuarios
FROM Usuarios
GROUP BY pais
ORDER BY cantidad_usuarios DESC;

-- Realizar una publicación (dar un ejemplo de cada tipo).
-- Texto.
INSERT INTO Publicaciones (tipo, fecha_creacion, descripcion, id_usuario, contenido) VALUES 
('Texto', '2024-08-10 10:00:00', 'Inicio de proyecto', 5, convert_to('Empezando el desarrollo del nuevo sistema, ¡motivación al máximo!', 'UTF8'));

-- Imagen.
INSERT INTO Publicaciones (tipo, fecha_creacion, descripcion, id_usuario, contenido) VALUES 
('Imagen', '2024-09-12 14:25:00', 'Vista desde el laboratorio', 6, decode('89504E470D0A1A0A0000000D49484452AABBCCDD', 'hex'));

-- Video.
INSERT INTO Publicaciones (tipo, fecha_creacion, descripcion, id_usuario, contenido) VALUES 
('Video', '2024-10-05 19:45:00', 'Resumen de la hackathon', 8, decode('52494646BBAACCDD574156456D7034323032', 'hex'));

-- Actualizar una publicación (dar un ejemplo de cada tipo).
-- Texto.
UPDATE Publicaciones
SET descripcion = 'Actualización de avance del proyecto',
    contenido = convert_to('El módulo de autenticación ya está completo y funcionando correctamente.', 'UTF8')
WHERE id_publicacion = 12;

-- Imagen.
UPDATE Publicaciones
SET descripcion = 'Nueva foto del laboratorio con el equipo',
    contenido = decode('FFD8FFE000104A4649460001AABBCCDD99887766', 'hex')
WHERE id_publicacion = 13;

-- Video.
UPDATE Publicaciones
SET descripcion = 'Video editado: resumen final de la hackathon',
    contenido = decode('52494646CCBBAADD574156456D70343230335F757064', 'hex')
WHERE id_publicacion = 14;

-- Eliminar una publicación (dar un ejemplo de cada tipo).
DELETE from Publicaciones
WHERE id_publicacion = 1;

-- Desregistrar a un usuario de la aplicación (dar un ejemplo).
DELETE FROM Usuarios WHERE id_usuario = 1;
-- SELECT * FROM Usuarios; --El usuario desaparecio de la tabla usuarios
-- SELECT * FROM Amistades; --El usurio se elimina junto a sus amistades
-- SELECT * FROM Publicaciones_Grupo; --Se elimina la referencia a esa id_publicacion que realizo ese usurio
-- SELECT * FROM Publicaciones --Se elimina todo registro done el usuario haya hecho una publicacion
-- SELECT * FROM Usuarios_publicaciones_favoritas --Se elimina los registros del usuario con sus publicaciones favoritas y si un usuario tenia como favorito una publicacion del usuario eliminado este registro tambien se elimina
;

-- Mostrar las publicaciones más populares ordenadas por cantidad de “favoritos” que poseen.
SELECT p.id_publicacion, p.descripcion, p.tipo, p.fecha_creacion,
    u.nombre || ' ' || u.apellido AS autor,
    COUNT(upf.id_publicacion) AS cantidad_favoritos
FROM Publicaciones p
JOIN Usuarios u ON p.id_usuario = u.id_usuario
LEFT JOIN Usuarios_publicaciones_favoritas upf ON p.id_publicacion = upf.id_publicacion
GROUP BY p.id_publicacion, p.descripcion, p.tipo, p.fecha_creacion, u.nombre, u.apellido
ORDER BY cantidad_favoritos DESC;

-- Mostrar los usuarios más populares basandose en la cantidad de publicaciones “favoritas” que poseen sus publicaciones.
WITH publicaciones_favoritas(publicacion, cantidad) AS (
    SELECT id_publicacion, COUNT(*)
    FROM usuarios_publicaciones_favoritas
    GROUP BY id_publicacion
)
SELECT *
FROM usuarios
WHERE id_usuario IN (
    SELECT pu.id_usuario
    FROM publicaciones pu
    JOIN publicaciones_favoritas pf ON pu.id_publicacion = pf.publicacion
    WHERE pf.cantidad = (SELECT MAX(cantidad) FROM publicaciones_favoritas)
);