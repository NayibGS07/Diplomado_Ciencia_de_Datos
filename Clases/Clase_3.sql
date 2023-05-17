-- Crear Base de Datos
CREATE DATABASE myMusic;

-- Crear tabla
CREATE TABLE Album (
	AlbumID INT PRIMARY KEY,
	Title VARCHAR(255),
	Artist VARCHAR(255),
	ReleaseYear INT,
	Genre VARCHAR(255),
	Label VARCHAR(255)
);


-- Agregar fila
INSERT INTO Album (AlbumID, Title, Artist, ReleaseYear, Genre, Label) VALUES 
(1, 'Back in Black', 'AC/DC', 1980, 'Rock', 'Atlantic Records');

-- Visualizar toda la tabla
SELECT * 
FROM Album;

-- Visualizar columnas en especifico
SELECT Title, Artist
FROM Album;

-- Cambiar base de datos a usar
USE Chinook;

SELECT *
FROM Artist;

-- Revisar tablas de la base de datos
SELECT name FROM sys.tables;

-- Mostrar n número de filas 
SELECT TOP 5 *
FROM Artist;

-- Filtrar
SELECT *
FROM Artist
WHERE ArtistId = 10;

-- Ordenar
SELECT *
FROM Artist
ORDER BY Name ASC; --Ascendente

SELECT *
FROM Artist
ORDER BY Name DESC; --Descendente

-- Contar número de filas
SELECT COUNT(*) AS TotalTracks
FROM Track;

SELECT *
FROM Invoice;

-- Sumar valores de columna
SELECT SUM(Total) as Ventas
FROM Invoice;

SELECT *
FROM Track;

-- Promedio de valores de columna
SELECT AVG(Milliseconds) AS Duracion
FROM Track;

-- Máximo y Mínimo en de columna
SELECT MIN(Milliseconds) AS Min_Track, MAX(Milliseconds) AS Max_Track
From Track;

SELECT *
FROM Artist;

INSERT INTO Artist(ArtistId, Name) VALUES 
(276, 'Valentin Elizalde');

-- Agregar columna
ALTER TABLE Artist
ADD Edad INT;

-- Cambiar nombre de columna
EXEC sp_rename 'Artist.Edad', 'Numero', 'COLUMN'; 

-- Modificar valor de fila
UPDATE Artist
SET Name = 'Peso Pluma'
WHERE ArtistId = 276;

-- Agrupar tabla
SELECT GenreId, COUNT(*) AS Total_Track
FROM Track
GROUP BY GenreId
ORDER BY Total_Track DESC;

SELECT AlbumId, AVG(Milliseconds) as Duracion
FROM Track
GROUP BY AlbumId
HAVING AVG(Milliseconds) > 231636;

-- WHERE vs HAVING
SELECT AlbumId, GenreId, AVG(Milliseconds) as Duracion
FROM Track
WHERE GenreId = 1 -- Siempre antes de GROUP BY
GROUP BY AlbumId, GenreId
HAVING AVG(Milliseconds) > 231636; -- Siempre después de GROUP BY

-- Unir Tablas
SELECT Track.TrackId, Track.Name, Album.Title
FROM Track
INNER JOIN Album ON Track.AlbumId = Album.AlbumId;

SELECT *
FROM Track;

SELECT *
FROM Album;

SELECT Customer.CustomerId, Customer.FirstName, Customer.LastName, Invoice.InvoiceId
FROM Customer
LEFT JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId;

SELECT Customer.CustomerId, Customer.FirstName, Customer.LastName, Invoice.InvoiceId
FROM Invoice
RIGHT JOIN Customer ON Customer.CustomerId = Invoice.CustomerId;

SELECT t.TrackId, t.Name AS TrackName, ar.Name AS ArtistName, al.Title AS AlbumTitle
FROM Track t
JOIN Album al ON t.AlbumId = al.AlbumId
JOIN Artist ar ON al.ArtistId = ar.ArtistId
JOIN Genre g ON t.GenreId = g.GenreId
WHERE g.Name = 'Rock';

-- Crear Vista
CREATE VIEW canciones AS (
SELECT t.TrackId, t.Name AS TrackName, ar.Name AS ArtistName, al.Title AS AlbumTitle
FROM Track t
JOIN Album al ON t.AlbumId = al.AlbumId
JOIN Artist ar ON al.ArtistId = ar.ArtistId
JOIN Genre g ON t.GenreId = g.GenreId
WHERE g.Name = 'Rock');

SELECT *
FROM canciones;

-- Modificar Vista
CREATE OR ALTER VIEW canciones AS (
SELECT t.TrackId, t.Name AS TrackName, ar.Name AS ArtistName, al.Title AS AlbumTitle
FROM Track t
JOIN Album al ON t.AlbumId = al.AlbumId
JOIN Artist ar ON al.ArtistId = ar.ArtistId
JOIN Genre g ON t.GenreId = g.GenreId);

SELECT *
FROM canciones;

-- Valores unicos (unique)
SELECT DISTINCT ArtistName 
FROM canciones;

-- # Valores unicos (nunique)
SELECT COUNT(DISTINCT ArtistName) 
FROM canciones;

-- Eliminar Vista
DROP VIEW canciones;

-- Soluciones Ejercicios
/*Ejercicio 1:
Escribe una consulta para recuperar toda la información de los clientes de la tabla "Customer".*/
SELECT * 
FROM Customer;

/*Ejercicio 2:
Escribe una consulta para recuperar el nombre de la pista y el precio unitario de la tabla "Track" para todas las pistas con un precio unitario mayor a $0.99.*/
SELECT Name AS TrackName, UnitPrice
FROM Track
WHERE UnitPrice > 0.99;

/*Ejercicio 3:
Escribe una consulta para recuperar el título del álbum, el nombre del artista y la cantidad de pistas para todos los álbumes en la tabla "Album", ordenados por la cantidad de pistas de forma descendente.*/
SELECT al.Title AS AlbumTitle, ar.Name AS ArtistName, COUNT(t.TrackId) AS TrackCount
FROM Album al
JOIN Artist ar ON al.ArtistId = ar.ArtistId
JOIN Track t ON al.AlbumId = t.AlbumId
GROUP BY al.Title, ar.Name
ORDER BY TrackCount DESC;

/*Ejercicio 4:
Escribe una consulta para recuperar el nombre del cliente, la fecha de la factura y el monto total para todas las facturas en la tabla "Invoice", ordenadas por la fecha de la factura de forma ascendente.*/
SELECT c.FirstName + ' ' + c.LastName AS CustomerName, i.InvoiceDate, i.Total
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
ORDER BY i.InvoiceDate ASC;

/*Ejercicio 5:
Escribe una consulta para recuperar el nombre del género y el número total de pistas para cada género de las tablas "Genre" y "Track", agrupados por género y ordenados por la cantidad de pistas de forma descendente.*/
SELECT g.Name AS GenreName, COUNT(t.TrackId) AS TrackCount
FROM Genre g
JOIN Track t ON g.GenreId = t.GenreId
GROUP BY g.Name
ORDER BY TrackCount DESC;
