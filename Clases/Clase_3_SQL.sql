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