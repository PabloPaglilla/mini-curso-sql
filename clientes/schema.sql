CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE, -- Puede ser NULL
    universidad VARCHAR(50)
);

CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(255) NOT NULL,
    precio_unitario INT NOT NULL,
    cantidad_en_stock INT NOT NULL
);

CREATE TABLE ordenes (
    id_orden INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);

INSERT INTO clientes (nombre, apellido, fecha_nacimiento, universidad) VALUES
    ('Pablo', 'Paglilla', STR_TO_DATE('16-04-1999', '%d-%m-%Y'), 'UTN');

INSERT INTO clientes (nombre, apellido, universidad) VALUES
    ('Belen', 'Karamanukian', 'UBA'), ('Lihue', 'Mahmoud', 'UTN'), ('Maximo', 'Romano', 'ITBA');

INSERT INTO productos (descripcion, precio_unitario, cantidad_en_stock) VALUES
    ('Metegol', 10000, 10),
    ('Mesa de Ping Pong', 10000, 9),
    ('Pelota de Futbol', 1200, 50),
    ('Pelota de Voley', 1000, 35);

INSERT INTO ordenes (id_cliente, id_producto, cantidad) VALUES
    (1, 1, 1), -- Pablo compró un metegol
    (1, 4, 1), -- Pablo compró una pelota de voley
    (2, 3, 2), -- Belu compró dos pelotas de futbol
    (3, 4, 1), -- El Chakal compró una pelota de voley
    (4, 2, 1); -- Machi compró una mesa de Ping Pong