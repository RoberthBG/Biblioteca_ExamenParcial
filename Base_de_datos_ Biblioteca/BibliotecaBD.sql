USE master
GO
IF EXISTS (SELECT name FROM sys.databases WHERE name='Biblioteca')
	DROP DATABASE Biblioteca
GO

CREATE DATABASE Biblioteca;
GO

USE Biblioteca;
GO

-- Tabla Categorías
CREATE TABLE Categorias (
    Id INT IDENTITY(1,1),
    Nombre NVARCHAR(50) NOT NULL,
	CONSTRAINT PKCategoria PRIMARY KEY(Id),
	CONSTRAINT UQNombreCategoria UNIQUE (nombre)
);
GO

-- Tabla Autores
CREATE TABLE Autores (
    Id INT IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
	Nacionalidad NVARCHAR(80) NOT NULL,
	FechaNacimiento DATE NULL
	CONSTRAINT PKAutores PRIMARY KEY(Id),
	CONSTRAINT UQNombreAutor UNIQUE(Nombre)
);
GO

-- Tabla Libros
CREATE TABLE Libros (
    Id INT IDENTITY(1,1),
    Titulo NVARCHAR(250) NOT NULL,
    Publicacion INT,
    IdAutor INT NOT NULL,
    IdCategoria INT NOT NULL,
	CONSTRAINT PKLibros PRIMARY KEY(Id),
	CONSTRAINT UQTituloLibro UNIQUE(Titulo),
    CONSTRAINT FKLibros_Autores FOREIGN KEY (IdAutor) REFERENCES Autores(Id),
    CONSTRAINT FKLibros_Categorias FOREIGN KEY (IdCategoria) REFERENCES Categorias(Id)
);
GO

-- Tabla Ejemplares
CREATE TABLE Ejemplares (
    Id INT IDENTITY(1,1),
    Codigo CHAR(6) NOT NULL,
    IdLibro INT NOT NULL,
	Estado CHAR(50) NOT NULL CONSTRAINT DFEstadoEjemplar DEFAULT 'D',
	CONSTRAINT PKEjemplares PRIMARY KEY(Id),
    CONSTRAINT UQCodigoEjemplar UNIQUE (Codigo),
    CONSTRAINT FKEjemplares_Libros FOREIGN KEY (IdLibro) REFERENCES Libros(Id)
);
GO

-- Insertar categorías
INSERT INTO Categorias (Nombre) VALUES
('Novela'),
('Narrativa Peruana'),
('Ficción Histórica'),
('Literatura Contemporánea'),
('Infantil'),
('Ciencia Ficción'),
('Ensayo'),
('Poesía');
GO

-- Insertar autores
INSERT INTO Autores (Nombre, Nacionalidad, FechaNacimiento) VALUES
('Mario Vargas Llosa','Peru','1936-03-28'),
('César Vallejo','Peru','1892-03-16'),
('Santiago Roncagliolo','Peru','1975-05-29'),
('Alonso Cueto','Peru','1954-12-10'),
('Gustavo Rodríguez','Peru','1968-01-01'),
('Gabriel Rimachi Sialer','Peru','1974-01-01'),
('Claudia Salazar Jiménez','Peru','1976-07-05'),
('Isabel Allende','Chile','1942-08-02'),
('Gabriel García Márquez','Colombia','1927-03-06'),
('J. K. Rowling','Reino Unido','1965-07-31'),
('Haruki Murakami','Japón','1949-01-12'),
('Kazuo Ishiguro','Reino Unido','1954-11-08'),
('Colson Whitehead','EEUU','1969-11-06'),
('Hilary Mantel','Reino Unido','1952-07-06'),
('Elena Ferrante','Italia','1943-10-05');

-- Insertar libros
INSERT INTO Libros (Titulo, Publicacion, IdAutor, IdCategoria) VALUES
('Abril rojo', 2006, 3, 2),
('La hora azul', 2005, 4, 2),
('Cocinero en su tinta', 2012, 5, 2),
('Madrugada', 2018, 5, 2),
('La sangre de la aurora', 2013, 7, 8),
('El sueño del celta', 2010, 1, 3),
('Los heraldos negros', 2001, 2, 8),
('Harry Potter y la piedra filosofal', 2001, 10, 5),
('Kafka en la orilla', 2005, 11, 1),
('Never Let Me Go', 2005, 12, 1),
('The Corrections', 2001, 12, 1),
('Lincoln in the Bardo', 2017, 13, 1),
('Pachinko', 2017, 15, 3),
('The Underground Railroad', 2016, 13, 3),
('My Brilliant Friend', 2012, 15, 1),
('2666', 2008, 12, 1),
('Station Eleven', 2014, 12, 1),
('The Road', 2006, 13, 1),
('Bel Canto', 2001, 12, 1),
('The Book Thief', 2005, 10, 5),
('Life of Pi', 2001, 12, 1),
('Homegoing', 2016, 13, 1),
('Shantaram', 2004, 12, 1),
('A Little Life', 2015, 12, 1),
('Normal People', 2018, 12, 1),
('Hamnet', 2020, 14, 1),
('The Night Circus', 2011, 13, 1),
('The Goldfinch', 2013, 12, 1),
('Where the Crawdads Sing', 2018, 13, 1),
('Cloud Atlas', 2004, 12, 1),
('The Shadow of the Wind', 2001, 13, 1),
('Anxious People', 2019, 12, 1),
('Small Great Things', 2016, 12, 1),
('The Midnight Library', 2020, 12, 1),
('The Seven Husbands of Evelyn Hugo', 2017, 12, 1),
('Circe', 2018, 14, 1),
('The Song of Achilles', 2011, 14, 1),
('Lessons in Chemistry', 2022, 12, 1),
('Project Hail Mary', 2021, 13, 6),
('The Silent Patient', 2019, 13, 1),
('Verity', 2018, 12, 1),
('Mexican Gothic', 2020, 14, 1),
('The Night Watchman', 2020, 13, 1),
('Trust', 2022, 12, 1),
('Sea of Tranquility', 2022, 12, 1),
('The Paris Library', 2021, 12, 1),
('American Dirt', 2020, 12, 1),
('The Vanishing Half', 2020, 12, 1),
('The Testaments', 2019, 13, 1),
('Daisy Jones & The Six', 2019, 12, 1),
('The Paper Palace', 2021, 12, 1),
('The Giver of Stars', 2019, 12, 1),
('The Dutch House', 2019, 12, 1),
('Transcendent Kingdom', 2020, 13, 1),
('The Henna Artist', 2020, 12, 1),
('Malibu Rising', 2021, 12, 1),
('Book Lovers', 2022, 12, 1),
('The Love Hypothesis', 2021, 12, 1),
('It Ends with Us', 2016, 12, 1),
('Ugly Love', 2014, 12, 1),
('November 9', 2015, 12, 1),
('Reminders of Him', 2022, 12, 1),
('Wish You Were Here', 2021, 12, 1),
('The Lincoln Highway', 2021, 12, 1),
('Lessons', 2022, 12, 1),
('Oh William!', 2021, 12, 1),
('French Braid', 2022, 12, 1),
('Lucy by the Sea', 2022, 12, 1),
('Horse', 2022, 12, 1),
('Sorrow and Bliss', 2021, 12, 1),
('The Maid', 2022, 12, 1),
('The Push', 2021, 12, 1),
('The Sanatorium', 2021, 12, 1),
('The Book of Lost Names', 2020, 12, 1),
('The Alice Network', 2017, 12, 1),
('The Huntress', 2019, 12, 1),
('The Rose Code', 2021, 12, 1),
('The Diamond Eye', 2022, 12, 1),
('Code Name Helene', 2020, 12, 1),
('The Nightingale', 2015, 12, 1),
('All the Light We Cannot See', 2014, 12, 1),
('The Tattooist of Auschwitz', 2018, 12, 1),
('Cilka’s Journey', 2019, 12, 1),
('The Orphan’s Tale', 2017, 12, 1),
('The Paris Architect', 2013, 12, 1);
GO

-------
SELECT * FROM Autores;
SELECT * FROM Categorias;
SELECT * FROM Ejemplares;
SELECT * FROM Libros;