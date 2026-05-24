CREATE TYPE PAIS AS ENUM ('Argentina', 'Chile', 'Paraguay', 'Bolivia', 'Peru', 'Uruguay');

CREATE TABLE Usuarios (
    id_usuario INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    fecha_ingreso DATE NOT NULL,
    cantidad_ingresos INT DEFAULT 0,
    pais PAIS NOT NULL,
    CONSTRAINT chk_email CHECK (email LIKE '%@gmail.com')
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
    fecha_ingreso DATE NOT NULL,
    rol_usuario VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_usuario, id_grupo),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_grupo) REFERENCES Grupos(id_grupo) 
);

CREATE TABLE Amistades (
    id_usuario_1 INT NOT NULL,
    id_usuario_2 INT NOT NULL,
    fecha_amistad DATE NOT NULL,
    PRIMARY KEY (id_usuario_1, id_usuario_2),
    FOREIGN KEY (id_usuario_1) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario_2) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    CHECK (id_usuario_1 < id_usuario_2)
);

CREATE TABLE Notificaciones (
    tipo VARCHAR(50) NOT NULL,
    fecha_emision TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descripcion VARCHAR(255) NOT NULL,
    id_receptor INT NOT NULL,
    PRIMARY KEY (id_receptor, descripcion, fecha_emision),
    FOREIGN KEY (id_receptor) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE Mensajes (
    contenido VARCHAR(255) NOT NULL,
    fecha_envio TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_lectura TIMESTAMP,
    id_emisor INT NOT NULL,
    id_receptor INT NOT NULL,
    PRIMARY KEY (id_emisor, id_receptor, fecha_envio),
    FOREIGN KEY (id_emisor) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_receptor) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    CHECK (fecha_lectura IS NULL OR fecha_lectura >= fecha_envio)
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
    fecha_favorito TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_usuario, id_publicacion),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_publicacion) REFERENCES Publicaciones(id_publicacion) ON DELETE CASCADE
);