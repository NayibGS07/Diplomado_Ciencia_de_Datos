CREATE database diplomado;

USE diplomado;
CREATE table customers (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50),
    email VARCHAR(50)
);

INSERT INTO customers (id, nombre, email)
VALUES (1, 'Omar Garcia', 'omar.garcia@uaq.mx');

SELECT * FROM customers;

SELECT nombre, email FROM customers;

INSERT INTO customers (id, nombre, email)
VALUES (2, 'Fernanda Martin', 'fernanda.martin@uaq.mx');	

SELECT * FROM customers;

UPDATE customers 
SET email = 'fer.martin@uaq.mx' 
WHERE id = 2;

SELECT * FROM customers;

DELETE FROM customers
WHERE id = 2;

SELECT * FROM customers;

USE chinook;

SELECT * FROM artist;

SELECT * FROM album 
LIMIT 5; 

SELECT * FROM invoice;

SELECT InvoiceId, CustomerId, InvoiceDate, Total FROM invoice
ORDER BY Total DESC
LIMIT 10;

SELECT InvoiceId, CustomerId, InvoiceDate, Total FROM invoice
ORDER BY InvoiceDate ASC
LIMIT 10;

SELECT SUM(Total) AS Ventas FROM Invoice;

SELECT * FROM track;

SELECT AVG(Milliseconds) AS Duracion FROM track;

SELECT MIN(Milliseconds) AS Mas_Corta, MAX(Milliseconds) as Mas_Larga FROM track;

SELECT * FROM artist;

ALTER TABlE artist
ADD Age INT;

ALTER TABLE artist
RENAME COLUMN Age TO Rating;

SELECT * FROM track;

SELECT GenreId, COUNT(*) AS Cuenta FROM track
GROUP BY GenreId
ORDER BY Cuenta DESC;

SELECT AlbumId, SUM(Milliseconds) as Duracion FROM Track
GROUP BY AlbumId;

SELECT AlbumId, SUM(Milliseconds) as Duracion FROM Track
GROUP BY AlbumId
HAVING Duracion > 3000000;

SELECT AlbumId, SUM(Milliseconds) as Duracion FROM Track
WHERE GenreId = 1
GROUP BY AlbumId;

SELECT AlbumId, SUM(Milliseconds) as Duracion FROM Track
WHERE GenreId = 1
GROUP BY AlbumId
HAVING Duracion > 3000000;

SELECT AlbumId, GenreId, SUM(Milliseconds) as Duracion FROM Track
GROUP BY AlbumId, GenreId
HAVING GenreId = 1 AND Duracion > 3000000;

SELECT * FROM album;
SELECT * FROM track;

SELECT track.TrackId, track.Name, album.Title
FROM track
INNER JOIN album ON track.AlbumId = album.AlbumId;

SELECT track.TrackId, track.Name AS TrackName, artist.Name, album.Title
FROM  track
JOIN album ON track.AlbumId = album.AlbumId
JOIN artist ON album.ArtistId = artist.ArtistId;

CREATE VIEW canciones_rock AS(
SELECT t.TrackId, t.Name AS TrackName, ar.Name, al.Title
FROM track t
JOIN album al ON t.AlbumId = al.AlbumId
JOIN artist ar ON al.ArtistId = ar.ArtistId
Join Genre g ON t.GenreId = g.GenreId
WHERE g.Name = 'Rock'
);

SELECT * FROM canciones_rock;

CREATE OR REPLACE VIEW canciones_rock AS(
SELECT t.TrackId, t.Name AS TrackName, ar.Name, al.Title
FROM track t
JOIN album al ON t.AlbumId = al.AlbumId
JOIN artist ar ON al.ArtistId = ar.ArtistId
);

SELECT DISTINCT Name FROM canciones_rock;

SELECT COUNT(DISTINCT Name) AS Artitstas FROM canciones_rock;

DROP VIEW canciones_rock;

/*Ejercicio 1:
Escribe una consulta para recuperar toda la información de los clientes de la tabla "Customer".*/

/*Ejercicio 2:
Escribe una consulta para recuperar el nombre de la pista 
y el precio unitario de la tabla "Track" para todas las pistas con un precio unitario mayor a $0.99.*/

/*Ejercicio 3:
Escribe una consulta para recuperar el título del álbum, el nombre del artista y 
la cantidad de pistas para todos los álbumes en la tabla "Album", 
ordenados por la cantidad de pistas de forma descendente.*/

/*Ejercicio 4:
Escribe una consulta para recuperar el nombre del cliente, la fecha de la factura 
y el monto total para todas las facturas en la tabla "Invoice", 
ordenadas por la fecha de la factura de forma ascendente.*/

/*Ejercicio 5:
Escribe una consulta para recuperar el nombre del género y el número 
total de pistas para cada género de las tablas "Genre" y "Track", agrupados por género 
y ordenados por la cantidad de pistas de forma descendente.*/
