
CREATE TABLE Usuarios (
    id_usuario INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    fecha_ingreso DATE NOT NULL,
    cantidad_ingresos INT DEFAULT 0,
    pais VARCHAR(100)
);

CREATE TABLE Grupos (
    id_grupo INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    fecha_creacion DATE NOT NULL
);


CREATE TABLE Usuarios_Grupos (
    id_usuario INT NOT NULL,
    id_grupo INT NOT NULL,
    fecha DATE NOT NULL,
    rol VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_usuario, id_grupo),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_grupo) REFERENCES Grupos(id_grupo) 
);

CREATE TABLE Amistades (
    id_usuario_1 INT NOT NULL,
    id_usuario_2 INT NOT NULL,
    fecha DATE NOT NULL,
    PRIMARY KEY (id_usuario_1, id_usuario_2),
    FOREIGN KEY (id_usuario_1) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario_2) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    CHECK (id_usuario_1 < id_usuario_2)
);


CREATE TABLE Notificaciones (
    tipo VARCHAR(50) NOT NULL,
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descripcion VARCHAR(255) NOT NULL,
    id_usuario INT NOT NULL,
    PRIMARY KEY (id_usuario, descripcion, fecha),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE
);


CREATE TABLE Mensajes (
    contenido VARCHAR(255) NOT NULL,
    fecha_envio TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_lectura TIMESTAMP,
    id_emisor INT NOT NULL,
    id_receptor INT NOT NULL,
    PRIMARY KEY (id_emisor, id_receptor, fecha_envio),
    FOREIGN KEY (id_emisor) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_receptor) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE
);


CREATE TABLE Publicaciones (
    id_publicacion INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descripcion VARCHAR(255) NOT NULL,
    id_usuario INT NOT NULL,
    contenido BYTEA NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE
);


CREATE TABLE Publicaciones_Grupo (
    id_publicacion INT NOT NULL,
    id_grupo INT NOT NULL,
    PRIMARY KEY (id_publicacion, id_grupo),
    FOREIGN KEY (id_publicacion) REFERENCES Publicaciones(id_publicacion) ON DELETE CASCADE, 
    FOREIGN KEY (id_grupo) REFERENCES Grupos(id_grupo)
);

CREATE TABLE Usuarios_Publicaciones_Favoritas (
    id_usuario INT NOT NULL,
    id_publicacion INT NOT NULL,
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_usuario, id_publicacion),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_publicacion) REFERENCES Publicaciones(id_publicacion) ON DELETE CASCADE
);

-- ==============================
-- INSERTS EN TABLA USUARIOS
-- ==============================
INSERT INTO Usuarios (nombre, apellido, email, fecha_ingreso, cantidad_ingresos, pais) VALUES
('Joani', 'Pranteda', 'joani.pranteda@example.com', '2023-03-15', 25, 'Argentina'),
('Daira', 'Gomez', 'daira.gomez@example.com', '2023-05-10', 15, 'Argentina'),
('Naomy', 'Lopez', 'naomy.lopez@example.com', '2022-11-20', 40, 'Chile'),
('Lucas', 'Martinez', 'lucas.martinez@example.com', '2024-01-05', 8, 'Uruguay'),
('Sofia', 'Perez', 'sofia.perez@example.com', '2024-07-02', 5, 'Argentina'),
('Diego', 'Gomez Perci', 'diego.gomezperci@example.com', '2022-09-13', 60, 'Argentina'),
('Camila', 'Fernandez', 'camila.fernandez@example.com', '2023-10-01', 12, 'Paraguay'),
('Mateo', 'Sanchez', 'mateo.sanchez@example.com', '2024-03-18', 10, 'Bolivia'),
('Valentina', 'Suarez', 'valentina.suarez@example.com', '2023-12-28', 22, 'Perú'),
('Martina', 'Rossi', 'martina.rossi@example.com', '2022-06-19', 33, 'Argentina');

-- ==============================
-- INSERTS EN TABLA GRUPOS
-- ==============================
INSERT INTO Grupos (id_grupo, nombre, descripcion, fecha_creacion) VALUES
(1, 'Programadores Java', 'Grupo dedicado al intercambio de conocimientos sobre Java', '2023-04-10'),
(2, 'Café y Charlas', 'Un espacio para conversar sobre cualquier tema con buena compañía', '2023-08-25'),
(3, 'Modelación Numérica', 'Estudiantes y docentes compartiendo ejercicios y tips', '2024-03-05'),
(4, 'Gamers', 'Comunidad para organizar partidas online y hablar de videojuegos', '2022-09-11'),
(5, 'Música y Producción', 'Intercambio de ideas y recursos sobre producción musical', '2023-07-14');

-- ==============================
-- INSERTS EN USUARIOS_GRUPOS
-- ==============================
INSERT INTO Usuarios_Grupos (id_usuario, id_grupo, fecha, rol) VALUES
(1, 1, '2023-04-12', 'Administrador'),
(1, 2, '2023-09-01', 'Miembro'),
(2, 2, '2023-09-02', 'Administrador'),
(3, 3, '2024-03-06', 'Miembro'),
(4, 4, '2023-10-15', 'Administrador'),
(5, 4, '2023-10-16', 'Miembro'),
(6, 1, '2023-04-13', 'Miembro'),
(7, 5, '2023-07-20', 'Administrador'),
(8, 5, '2023-08-01', 'Miembro'),
(9, 3, '2024-03-07', 'Miembro'),
(10, 2, '2023-09-03', 'Miembro');

-- ==============================
-- INSERTS EN AMISTADES
-- ==============================
INSERT INTO Amistades (id_usuario_1, id_usuario_2, fecha) VALUES
(1, 2, '2023-06-10'),
(1, 3, '2023-07-21'),
(1, 4, '2024-02-01'),
(2, 5, '2023-10-10'),
(3, 6, '2022-12-05'),
(4, 7, '2024-01-14'),
(5, 8, '2024-03-30'),
(6, 9, '2023-05-22'),
(7, 10, '2023-12-12'),
(9, 10, '2024-05-02');

-- ==============================
-- INSERTS EN NOTIFICACIONES
-- ==============================
INSERT INTO Notificaciones (tipo, fecha, descripcion, id_usuario) VALUES
('Amistad', '2023-06-10 10:15:00', 'Daira te ha enviado una solicitud de amistad', 1),
('Grupo', '2023-09-01 08:30:00', 'Fuiste agregado al grupo Café y Charlas', 1),
('Mensaje', '2023-07-21 14:45:00', 'Naomy te envió un mensaje', 1),
('Publicación', '2023-10-05 09:00:00', 'Nueva publicación en tu grupo Modelación Numérica', 3),
('Amistad', '2024-01-14 18:00:00', 'Lucas te agregó como amigo', 7);

-- ==============================
-- INSERTS EN MENSAJES
-- ==============================
INSERT INTO Mensajes (contenido, fecha_envio, fecha_lectura, id_emisor, id_receptor) VALUES
('Hola Daira, ¿cómo estás?', '2023-06-10 10:00:00', '2023-06-10 10:05:00', 1, 2),
('Todo bien Joani, ¿vos?', '2023-06-10 10:06:00', '2023-06-10 10:07:00', 2, 1),
('Te pasé el código del ejercicio de LU', '2024-03-06 15:10:00', '2024-03-06 15:20:00', 3, 1),
('¿Nos juntamos a estudiar?', '2024-03-07 16:00:00', '2024-03-07 16:10:00', 1, 3),
('¿Jugamos esta noche?', '2023-10-15 18:00:00', '2023-10-15 18:10:00', 4, 5),
('Dale, me conecto a las 22', '2023-10-15 18:20:00', '2023-10-15 18:25:00', 5, 4),
('Che Diego, te debo algo?', '2023-11-01 11:00:00', '2023-11-01 11:05:00', 1, 6),
('No, al contrario, yo te debo a vos jajaja', '2023-11-02 11:10:00', '2023-11-02 11:15:00', 6, 1);


-- ==============================
-- INSERTS EN PUBLICACIONES
-- ==============================
-- El contenido BYTEA puede representarse como datos binarios simulados con formato hexadecimal
INSERT INTO Publicaciones (tipo, fecha_creacion, descripcion, id_usuario, contenido) VALUES
('Texto', CURRENT_TIMESTAMP, 'Pensamiento del día', 1, convert_to('Hoy empiezo el gym', 'UTF8')),
('Imagen', '2023-09-02 09:30:00', 'Foto del grupo en el café', 2, decode('FFD8FFE000104A4649460001','hex')),
('Texto', CURRENT_TIMESTAMP, 'Pensamiento del día', 3, convert_to('Hoy empiezo el gym', 'UTF8')),
('Texto', CURRENT_TIMESTAMP, 'Pensamiento del día', 4, convert_to('Hoy empiezo el gym', 'UTF8')),
('Video', '2023-07-20 13:00:00', 'Demo de nueva canción', 7, decode('52494646AABBCCDD57415645','hex')),
('Texto', CURRENT_TIMESTAMP, 'Pensamiento del día', 9, convert_to('Hoy empiezo el gym', 'UTF8')),
('Texto', CURRENT_TIMESTAMP, 'Pensamiento del día', 10, convert_to('Hoy empiezo el gym', 'UTF8'));

-- ==============================
-- INSERTS EN PUBLICACIONES_GRUPO
-- ==============================
INSERT INTO Publicaciones_Grupo (id_publicacion, id_grupo) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 3),
(7, 2);

-- ==============================
-- INSERTS EN USUARIOS_PUBLICACIONES_FAVORITAS
-- ==============================
INSERT INTO Usuarios_Publicaciones_Favoritas (id_usuario, id_publicacion, fecha) VALUES
(1, 2, '2023-09-03 11:00:00'),
(1, 5, '2023-07-25 13:15:00'),
(2, 1, '2023-04-13 10:30:00'),
(3, 3, '2024-03-10 09:00:00'),
(4, 4, '2023-10-20 20:10:00'),
(5, 2, '2023-09-05 15:00:00'),
(6, 1, '2023-04-15 08:00:00'),
(7, 5, '2023-07-22 14:30:00'),
(8, 6, '2024-03-08 16:45:00'),
(9, 7, '2024-05-03 11:10:00'),
(10, 3, '2024-03-12 09:20:00');

#1 Registrar un usuario
INSERT INTO Usuarios (nombre, apellido, email, fecha_ingreso, cantidad_ingresos, pais)
VALUES ('Rogelio', 'BuenDia', 'RogelioBuenDia@gmail.com', CURRENT_TIMESTAMP, 3, 'Argentina');

#2 Listar todos los usuarios de la red social.
SELECT *
FROM usuarios

#3 Listar todas las amistades de la red social.
SELECT 
u.nombre AS nombre_usuario, u.apellido AS apellido_usuario, us.nombre AS nombre_amigo, us.apellido AS apellido_amigo, a.fecha AS fecha_amistad
FROM Usuarios u
JOIN Amistades a ON u.id_usuario = a.id_usuario_1
JOIN Usuarios us ON a.id_usuario_2 = us.id_usuario

#4 Listar todos los mensajes de la red social (deberia mostrar toda la tabla? o solo algunos mensajes)
SELECT * 
FROM Mensajes

#5 Desregistrar a un usuario de la aplicación (dar un ejemplo)
DELETE FROM Usuarios WHERE id_usuario = 1;

SELECT * FROM Usuarios --El usuario desaparecio de la tabla usuarios
SELECT * FROM Amistades --El usurio se elimina junto a sus amistades
SELECT * FROM Publicaciones_Grupo --Se elimina la referencia a esa id_publicacion que realizo ese usurio
SELECT * FROM Publicaciones --Se elimina todo registro done el usuario haya hecho una publicacion
SELECT * FROM Usuarios_publicaciones_favoritas --Se elimina los registros del usuario con sus publicaciones favoritas 
                                                --Y si un usuario tenia como favorito una publicacion del usuario eliminado este registro tambien se elimina

#CONSULTA 6: Contar cuántos usuarios hay en la red social agrupados por país
#Usamos GROUP BY para agrupar los registros por país, y COUNT(*) para contar los usuarios en cada grupo.
#Ordenamos de mayor a menor cantidad para ver qué país tiene más usuarios registrados.

SELECT pais, COUNT(*) AS cantidad_usuarios
FROM Usuarios
GROUP BY pais
ORDER BY cantidad_usuarios DESC;


#7 Realizar una publicación (dar un ejemplo de cada tipo).
INSERT INTO Publicaciones (tipo, fecha_creacion, descripcion, id_usuario, contenido)
VALUES ('texto', CURRENT_TIMESTAMP, 'Pensamiento del día', 3, convert_to('Hoy empiezo el gym', 'UTF8'));

--Publicacion Imagen--
INSERT INTO Publicaciones (tipo, fecha_creacion, descripcion, id_usuario, contenido)
VALUES ('imagen', CURRENT_TIMESTAMP, 'Foto de mi gato', 3, decode('FFD8FFE000104A46494600010101006000600000FFD9', 'hex'));

--Publicacion Video--
INSERT INTO Publicaciones (tipo, fecha_creacion, descripcion, id_usuario, contenido)
VALUES ('video', CURRENT_TIMESTAMP, 'Video corto del amanecer', 3, decode('000000186674797069736F6D0000020069736F6D69736F32617663', 'hex'));


#8 Actualizar una publicación (dar un ejemplo de cada tipo)

#Publicacion de texto
UPDATE Publicaciones
SET descripcion = 'Actualización del mensaje de bienvenida',
    contenido = decode('4E7565766F206D656E73616A65206465206269656E76656E69646121', 'hex')
WHERE id_publicacion = 1;

# Publicación de Imagen
UPDATE Publicaciones
SET descripcion = 'Foto grupal actualizada en el café',
    contenido = decode('FFD8FFE000104A464946000102', 'hex')
WHERE id_publicacion = 2;

# Publicación de Texto
UPDATE Publicaciones
SET descripcion = 'Versión revisada de la guía de modelación numérica',
    contenido = decode('255044462D312E350A25E2E3CFD30A', 'hex')
WHERE id_publicacion = 3;

# Publicación de AUDIO 
UPDATE Publicaciones
SET descripcion = 'Versión final de la canción demo',
    contenido = decode('52494646BBAACCDD57415645', 'hex')
WHERE id_publicacion = 5;

#PUBLICACION DE AVISO 
UPDATE Publicaciones
SET descripcion = 'Nuevo horario para el torneo online',
    fecha_creacion = CURRENT_DATE
WHERE id_publicacion = 4;

-- CONSULTA 9: Mostrar las publicaciones más populares según cuántos usuarios las marcaron como favoritas.
-- Se hace un LEFT JOIN entre Publicaciones y la tabla intermedia Usuarios_publicaciones_favoritas para contar favoritos.
-- Se agrupa por publicación y se cuenta cuántos registros hay por cada una.
-- Incluye información del autor para contextualizar.
-- Usamos LEFT JOIN para que también se vean las publicaciones con 0 favoritos.

SELECT p.id_publicacion, p.descripcion, p.tipo, p.fecha_creacion,
  u.nombre || ' ' || u.apellido AS autor,
  COUNT(upf.id_publicacion) AS cantidad_favoritos
FROM Publicaciones p
JOIN Usuarios u ON p.id_usuario = u.id_usuario
LEFT JOIN Usuarios_publicaciones_favoritas upf ON p.id_publicacion = upf.id_publicacion
GROUP BY p.id_publicacion, p.descripcion, p.tipo, p.fecha_creacion, u.nombre, u.apellido
ORDER BY cantidad_favoritos DESC;

#12 Mostrar los usuarios más populares basandose en la cantidad de publicaciones “favoritas” que poseen sus publicaciones
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


