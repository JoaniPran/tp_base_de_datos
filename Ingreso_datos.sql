INSERT INTO Usuarios (nombre, apellido, email, fecha_ingreso, cantidad_ingresos, pais) VALUES
('Joani', 'Pranteda', 'joani_pranteda@gmail.com', '2023-03-15', 25, 'Argentina'),
('Daira', 'Gomez', 'daira_gomez@gmail.com', '2023-05-10', 15, 'Argentina'),
('Naomy', 'Lopez', 'naomy_lopez@gmail.com', '2022-11-20', 40, 'Chile'),
('Lucas', 'Martinez', 'lucas_martinez@gmail.com', '2024-01-05', 8, 'Uruguay'),
('Sofia', 'Perez', 'sofia_perez@gmail.com', '2024-07-02', 5, 'Argentina'),
('Diego', 'Gomez Perci', 'diego_gomezperci@gmail.com', '2022-09-13', 60, 'Argentina'),
('Camila', 'Fernandez', 'camila_fernandez@gmail.com', '2023-10-01', 12, 'Paraguay'),
('Mateo', 'Sanchez', 'mateo_sanchez@gmail.com', '2024-03-18', 10, 'Bolivia'),
('Valentina', 'Suarez', 'valentina_suarez@gmail.com', '2023-12-28', 22, 'Peru'),
('Martina', 'Rossi', 'martina_rossi@gmail.com', '2022-06-19', 33, 'Argentina');

INSERT INTO Grupos (id_grupo, nombre, descripcion, fecha_creacion) VALUES
(1, 'Programadores Java', 'Grupo dedicado al intercambio de conocimientos sobre Java', '2023-04-12'),
(2, 'Café y Charlas', 'Un espacio para conversar sobre cualquier tema con buena compañía', '2023-09-02'),
(3, 'Modelación Numérica', 'Estudiantes y docentes compartiendo ejercicios y tips', '2024-03-06'),
(4, 'Gamers', 'Comunidad para organizar partidas online y hablar de videojuegos', '2023-10-15'),
(5, 'Música y Producción', 'Intercambio de ideas y recursos sobre producción musical', '2023-07-20');

INSERT INTO Usuarios_Grupos (id_usuario, id_grupo, fecha_ingreso, rol_usuario) VALUES
(1, 1, '2023-04-12', 'Administrador'),
(1, 2, '2023-09-01', 'Miembro'),
(2, 2, '2023-09-02', 'Administrador'),
(3, 3, '2024-03-06', 'Administrador'),
(4, 4, '2023-10-15', 'Administrador'),
(5, 4, '2023-10-16', 'Miembro'),
(6, 1, '2023-04-13', 'Miembro'),
(7, 5, '2023-07-20', 'Administrador'),
(8, 5, '2023-08-01', 'Miembro'),
(9, 3, '2024-03-07', 'Miembro'),
(10, 2, '2023-09-03', 'Miembro');

INSERT INTO Amistades (id_usuario_1, id_usuario_2, fecha_amistad) VALUES
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

INSERT INTO Notificaciones (tipo, fecha_emision, descripcion, id_receptor) VALUES
('Solicitud de amistad', '2023-06-10 10:15:00', 'Daira te ha enviado una solicitud de amistad.', 1),
('Publicación en grupo', '2023-09-01 08:30:00', 'Nueva publicación en el grupo "Café y Charlas".', 1),
('Publicación de amigo', '2023-07-21 14:45:00', 'Tu amiga Naomy ha compartido una nueva publicación.', 1),
('Publicación en grupo', '2023-10-05 09:00:00', 'Nueva publicación en el grupo "Modelación Numérica".', 9),
('Solicitud de amistad', '2024-01-14 18:00:00', 'Lucas te ha enviado una solicitud de amistad.', 7),
('Solicitud de amistad', '2024-04-09 16:20:00', 'Sofia te ha enviado una solicitud de amistad.', 6);

INSERT INTO Mensajes (contenido, fecha_envio, fecha_lectura, id_emisor, id_receptor) VALUES
('Hola Daira, ¿cómo estás?', '2023-06-10 10:00:00', '2023-06-10 10:05:00', 1, 2),
('Todo bien Joani, ¿vos?', '2023-06-10 10:06:00', '2023-06-10 10:07:00', 2, 1),
('Te pasé el código del ejercicio de LU', '2023-07-21 15:10:00', '2023-07-21 15:20:00', 3, 1),
('¿Nos juntamos a estudiar?', '2023-07-21 16:00:00', '2024-03-07 16:10:00', 1, 3),
('¿Jugamos esta noche?', '2024-07-10 18:00:00', '2024-07-10 18:10:00', 4, 5),
('Dale, me conecto a las 22', '2024-07-10 18:20:00', NULL, 5, 4),
('Che Diego, te debo algo?', '2023-11-01 11:00:00', '2023-11-01 11:05:00', 1, 6),
('No, al contrario, yo te debo a vos jajaja', '2023-11-02 11:10:00', NULL, 6, 1);

INSERT INTO Publicaciones (tipo, fecha_creacion, descripcion, id_usuario, contenido) VALUES
('Texto', '2023-06-01 09:15:00', 'Reflexión matutina', 1, convert_to('Cada error me acerca un paso más al éxito.', 'UTF8')),
('Texto', '2023-09-02 08:45:00', 'Pensamiento del día', 3, convert_to('Estudiar sin pausa, pero sin prisa.', 'UTF8')),
('Texto', '2024-02-10 11:30:00', 'Motivación del día', 4, convert_to('El código limpio también es arte.', 'UTF8')),
('Texto', '2024-04-01 18:00:00', 'Inspiración musical', 9, convert_to('La música habla cuando las palabras fallan.', 'UTF8')),
('Texto', '2024-07-25 22:15:00', 'Cierre de jornada', 10, convert_to('Hoy aprendí que siempre hay algo nuevo que descubrir.', 'UTF8')),
('Imagen', '2023-09-02 09:30:00', 'Foto del grupo en el café', 2, decode('FFD8FFE000104A4649460001AABBCCDDEEFF', 'hex')),
('Imagen', '2024-03-06 14:10:00', 'Gráfico del proyecto final', 3, decode('89504E470D0A1A0A0000000D49484452', 'hex')),
('Video', '2023-07-20 13:00:00', 'Demo de nueva canción', 7, decode('52494646AABBCCDD574156456D70342066696C65', 'hex'));

INSERT INTO Publicaciones_Grupo (id_publicacion, id_grupo) VALUES 
(2, 3),  
(3, 4),  
(4, 3),  
(5, 2), 
(6, 2), 
(7, 3), 
(8, 5); 

INSERT INTO Usuarios_Publicaciones_Favoritas (id_usuario, id_publicacion, fecha_favorito) VALUES
(1, 2, '2023-09-03 11:00:00'),
(1, 5, '2024-07-26 13:15:00'), 
(2, 1, '2023-06-02 10:30:00'), 
(3, 3, '2024-03-10 09:00:00'),
(4, 4, '2024-04-02 20:10:00'), 
(5, 2, '2023-09-05 15:00:00'),
(6, 1, '2023-06-02 08:00:00'), 
(7, 5, '2024-07-26 14:30:00'),
(8, 6, '2024-03-08 16:45:00'),
(9, 7, '2024-05-03 11:10:00'),
(10, 3, '2024-03-12 09:20:00');





