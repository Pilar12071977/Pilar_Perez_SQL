CREATE TABLE alumno (
    alumno_id SERIAL PRIMARY KEY,
    nombre VARCHAR(255), 
    email VARCHAR(255),
    telefono VARCHAR(20),
    contrasena VARCHAR(255),
    Fecha_Registro DATE,
 );



CREATE TABLE profesor (
    profesor_id SERIAL PRIMARY KEY,
    nombre VARCHAR(255),
    email VARCHAR(255),
    telefono VARCHAR(20)
);

CREATE TABLE bootcamp (
    bootcamp_id SERIAL PRIMARY KEY,
    Titulo VARCHAR(255),
    Fecha_Inicio DATE,
    Fecha_Final DATE
);

CREATE TABLE modulo (
    modulo_id SERIAL PRIMARY KEY,
    ditulo VARCHAR(255),
    descripcion TEXT,
    FOREIGN KEY (bootcamp_id) REFERENCES bootcamp(bootcamp_id)
);

CREATE TABLE inscripcion (
    inscripcion SERIAL PRIMARY KEY,
    FOREIGN KEY(alumno_id) REFERENCES alumno(alumno_id),
    FOREIGN KEY(bootcamp_id) REFERENCES bootcamp(bootcamp_id),
    Fecha_Inscripcion DATE
  );

CREATE TABLE evaluacion (
    evaluacion SERIAL PRIMARY KEY,
    alumno_id INTEGER REFERENCES alumno(alumno_id),
    modulo_id INTEGER REFERENCES modulo(modulo_id),
    calificacion BOOLEAN NOT NULL
);


ALTER TABLE evaluacion
ADD CONSTRAINT valid_calificacion CHECK (calificacion IN (true, false));

ALTER TABLE bootcamp
ADD COLUMN profesor_id INTEGER REFERENCES profesor(profesor_id);

ALTER TABLE modulo
ADD COLUMN bootcamp_id INTEGER REFERENCES bootcamp(bootcamp_id);

ALTER TABLE evaluacion
ADD COLUMN modulo_id INTEGER REFERENCES modulo(modulo_id);

ALTER TABLE evaluacion
ADD COLUMN alumno_id INTEGER REFERENCES alumno(alumno_id);

--No lo pongo porque no se porque me da error, queria decir  que el email es unico 
--ALTER TABLE alumno
--ADD CONSTRAINT unique_email UNIQUE (email);
--ALTER TABLE profesor
--ADD CONSTRAINT unique_email UNIQUE (email);

INSERT INTO alumno (nombre, email, telefono, contrasena, Fecha_Registro) VALUES 
('Juan Pérez', 'juan.perez@example.com', '555-1234', 'contrasena123', '2024-09-01'),
('María López', 'maria.lopez@example.com', '555-5678', 'contrasena456', '2024-09-02');

INSERT INTO profesor (nombre, email, telefono) VALUES 
('Dr. Carlos García', 'carlos.garcia@example.com', '555-8765'),
('Lic. Ana Martínez', 'ana.martinez@example.com', '555-4321');

INSERT INTO bootcamp (Titulo, Fecha_Inicio, Fecha_Final, profesor_id) VALUES 
('Bootcamp de IA', '2024-09-15', '2024-12-15', 1),  
('Bootcamp de Web Development', '2024-10-01', '2024-12-01', 2);  

INSERT INTO modulo (titulo, descripcion, bootcamp_id) VALUES 
('Introducción a la IA', 'Módulo básico sobre inteligencia artificial.', 1),
('Desarrollo Web con HTML y CSS', 'Aprender los fundamentos de HTML y CSS.', 2);

INSERT INTO inscripcion (alumno_id, bootcamp_id, Fecha_Inscripcion) VALUES 
(1, 1, '2024-09-10'),  -- Juan Pérez se inscribe en el Bootcamp de IA
(2, 2, '2024-09-20');  -- María López se inscribe en el Bootcamp de Web Developmen

SELECT * FROM alumno;
SELECT * FROM profesor;
SELECT * FROM bootcamp;
SELECT * FROM modulo;
SELECT * FROM inscripcion;
SELECT * FROM evaluacion;