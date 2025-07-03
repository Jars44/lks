CREATE DATABASE [Tiks.id]
GO
USE [Tiks.id]
GO

CREATE TABLE [User]
(
	[ID]				INT				NOT NULL	PRIMARY KEY IDENTITY(1, 1),
	[Fullname]			VARCHAR(200)	NOT NULL,
	[Email]				VARCHAR(200)	NOT NULL,
	[Password]			VARCHAR(200)	NOT NULL,
);

CREATE TABLE [Movie]
(
	[ID]				INT				NOT NULL	PRIMARY KEY IDENTITY(1, 1),
	[Title]				VARCHAR(200)	NOT NULL,
	[Description]		VARCHAR(200)	NOT NULL,
	[Duration]			INT				NOT NULL,
	[ReleaseDate]		DATE			NOT NULL,
	[Poster]			TEXT			NOT NULL
);

CREATE TABLE [Genre]
(
	[ID]				INT				NOT NULL	PRIMARY KEY IDENTITY(1, 1),
	[Name]				VARCHAR(200)	NOT NULL
);

CREATE TABLE [MovieGenre]
(
	[ID]				INT				NOT NULL	PRIMARY KEY IDENTITY(1, 1),
	[MovieID]			INT				NOT NULL,
	[GenreID]			INT				NOT NULL,

	CONSTRAINT FK_MovieGenre_Movie FOREIGN KEY ([MovieID]) REFERENCES [Movie]([ID]),
	CONSTRAINT FK_MovieGenre_Genre FOREIGN KEY ([GenreID]) REFERENCES [Genre]([ID]),
);

CREATE TABLE [Theater]
(
	[ID]				INT				NOT NULL	PRIMARY KEY IDENTITY(1, 1),
	[Name]				VARCHAR(200)	NOT NULL,
	[Section]			INT				NOT NULL,
	[Column]			INT				NOT NULL,
	[Row]				INT				NOT NULL
);

CREATE TABLE [Schedule]
(
	[ID]				INT				NOT NULL	PRIMARY KEY IDENTITY(1, 1),
	[MovieID]			INT				NOT NULL,
	[TheaterID]			INT				NOT NULL,
	[Date]				DATE			NOT NULL,
	[Time]				TIME			NOT NULL,
	[Price]				FLOAT			NOT NULL,

	CONSTRAINT FK_Schedule_Movie FOREIGN KEY ([MovieID]) REFERENCES [Movie]([ID]),
	CONSTRAINT FK_Schedule_Theater FOREIGN KEY ([TheaterID]) REFERENCES [Theater]([ID]),
);

CREATE TABLE [Transaction]
(
	[ID]				INT				NOT NULL	PRIMARY KEY IDENTITY(1, 1),
	[UserID]			INT				NOT NULL,
	[ScheduleID]		INT				NOT NULL,
	[TransactionDate]	DATETIME		NOT NULL,

	CONSTRAINT FK_Transaction_User FOREIGN KEY ([UserID]) REFERENCES [User]([ID]),
	CONSTRAINT FK_Transaction_Schedule FOREIGN KEY ([ScheduleID]) REFERENCES [Schedule]([ID]),
);

CREATE TABLE [TransactionDetail]
(
	[ID]				INT				NOT NULL	PRIMARY KEY IDENTITY(1, 1),
	[TransactionID]		INT				NOT NULL,
	[Seat]				TEXT			NOT NULL,
	[Price]				FLOAT			NOT NULL,

	CONSTRAINT FK_TransactionDetail_Transaction FOREIGN KEY ([TransactionID]) REFERENCES [Transaction]([ID]),
);




INSERT INTO [User] ([Fullname], [Email], [Password])
VALUES
    ('Alice Johnson', 'alice.johnson@example.com', 'password123'),
    ('Bob Smith', 'bob.smith@example.com', 'password456'),
    ('Charlie Brown', 'charlie.brown@example.com', 'password789'),
    ('Diana Prince', 'diana.prince@example.com', 'wonderwoman'),
    ('Evan Thompson', 'evan.thompson@example.com', 'evanpass123'),
    ('Fiona Gallagher', 'fiona.gallagher@example.com', 'fionapass'),
    ('George Lucas', 'george.lucas@example.com', 'starwarsfan'),
    ('Hannah Brown', 'hannah.brown@example.com', 'hannah1234'),
    ('Isaac Newton', 'isaac.newton@example.com', 'gravityforce'),
    ('Julia Roberts', 'julia.roberts@example.com', 'juliarocks');


INSERT INTO [Movie] ([Title], [Description], [Duration], [ReleaseDate], [Poster])
VALUES 
    ('The Book of Clarence', 'A powerful drama set in biblical times exploring faith and survival.', 136, '2024-01-12', 'the-book-of-clarence.jpg'),
    ('Mean Girls: The Musical', 'A musical adaptation of the classic high school comedy.', 128, '2024-01-12', 'mean-girls-the-musical.jpg'),
    ('Lift', 'A high-stakes heist thriller on an airplane.', 115, '2024-01-12', 'lift.jpg'),
    ('Distant', 'Two strangers find themselves isolated on an alien planet.', 120, '2024-01-19', 'distant.jpg'),
    ('Argylle', 'A spy adventure featuring high-tech action.', 117, '2024-02-02', 'argylle.jpg'),
    ('Orion and the Dark', 'A charming animated story about facing one’s fears.', 95, '2024-02-02', 'orion-and-the-dark.jpg'),
    ('It Ends With Us', 'A heartfelt romantic drama based on the bestselling novel.', 125, '2024-02-09', 'it-ends-with-us.jpg'),
    ('The Fall Guy', 'A stuntman is drawn into a dangerous conspiracy.', 135, '2024-03-01', 'the-fall-guy.jpg'),
    ('Imaginary', 'A horror thriller involving childhood imaginations.', 100, '2024-03-08', 'imaginary.jpg'),
    ('Cabrini', 'The story of a revered humanitarian, Mother Cabrini.', 120, '2024-03-08', 'cabrini.jpg'),
    ('Dune: Part Two', 'The epic continuation of Paul Atreides'' journey.', 156, '2024-03-15', 'dune-part-two.jpg'),
    ('Godzilla x Kong: The New Empire', 'The legendary clash continues as Kong and Godzilla face new threats.', 145, '2024-04-12', 'godzilla-x-kong-the-new-empire.jpg'),
    ('Rebel Moon: Part Two – The Scargiver', 'A space epic about rebellion against a tyrannical force.', 140, '2024-04-19', 'rebel-moon-part-two.jpg'),
    ('Dreamer', 'An inspiring story about a young dreamer overcoming obstacles.', 110, '2024-04-05', 'dreamer.jpg'),
    ('My Ex-Friend''s Wedding', 'A comedy about friendship and betrayal at a wedding.', 102, '2024-05-10', 'my-ex-friends-wedding.jpg'),
    ('Furiosa', 'A prequel set in the Mad Max universe.', 130, '2024-05-24', 'furiosa.jpg'),
    ('Kingdom of the Planet of the Apes', 'A new saga begins in the Planet of the Apes series.', 125, '2024-05-24', 'kingdom-of-the-planet-of-the-apes.jpg'),
    ('The Watchers', 'A thriller involving mysterious watchers and hidden truths.', 110, '2024-06-07', 'the-watchers.jpg'),
    ('Inside Out 2', 'The emotions are back in a heartwarming animated sequel exploring the complexities of growing up.', 95, '2024-06-14', 'inside-out-2.jpg'),
    ('Bad Boys 4', 'Action-packed sequel following the iconic detective duo.', 115, '2024-06-14', 'bad-boys-4.jpg'),
    ('Horizon: An American Saga – Chapter 1', 'A historical epic set in the American West.', 158, '2024-06-28', 'horizon-an-american-saga.jpg'),
    ('A Quiet Place: Day One', 'A prequel to the horror thriller series, detailing the start of the alien invasion.', 100, '2024-06-28', 'a-quiet-place-day-one.jpg'),
    ('Deadpool & Wolverine', 'Deadpool and friends face new enemies in an action-packed adventure.', 114, '2024-07-26', 'deadpool-&-wolverine.jpg'),
    ('Beetlejuice 2', 'The ghostly comedy returns with more supernatural antics.', 120, '2024-09-06', 'beetlejuice-2.jpg'),
    ('Joker 2', 'A continuation of the origin story of Gotham’s most infamous villain.', 130, '2024-10-04', 'joker-2.jpg');


INSERT INTO [Genre] ([Name])
VALUES 
    ('Drama'),          -- GenreID 1
    ('Comedy'),         -- GenreID 2
    ('Action'),         -- GenreID 3
    ('Thriller'),       -- GenreID 4
    ('Sci-Fi'),         -- GenreID 5
    ('Animation'),      -- GenreID 6
    ('Romance'),        -- GenreID 7
    ('Adventure'),      -- GenreID 8
    ('Horror'),         -- GenreID 9
    ('Fantasy'),        -- GenreID 10
    ('Musical');        -- GenreID 11




INSERT INTO [MovieGenre] ([MovieID], [GenreID])
VALUES 
    (1, 1),   -- The Book of Clarence: Drama
    (1, 8),   -- Adventure
    (2, 11),  -- Mean Girls: The Musical: Musical
    (2, 2),   -- Comedy
    (3, 4),   -- Lift: Thriller
    (3, 8),   -- Adventure
    (4, 5),   -- Distant: Sci-Fi
    (4, 8),   -- Adventure
    (5, 3),   -- Argylle: Action
    (5, 4),   -- Thriller
    (6, 6),   -- Orion and the Dark: Animation
    (6, 10),  -- Fantasy
    (6, 1),   -- Drama
    (7, 7),   -- It Ends With Us: Romance
    (7, 1),   -- Drama
    (8, 3),   -- The Fall Guy: Action
    (8, 4),   -- Thriller
    (9, 9),   -- Imaginary: Horror
    (9, 4),   -- Thriller
    (10, 1),  -- Cabrini: Drama
    (10, 8),  -- Adventure
    (11, 8),  -- Dune: Part Two: Adventure
    (11, 5),  -- Sci-Fi
    (11, 10), -- Fantasy
    (12, 8),  -- Godzilla x Kong: The New Empire: Adventure
    (12, 5),  -- Sci-Fi
    (12, 3),  -- Action
    (12, 10), -- Fantasy
    (13, 8),  -- Rebel Moon: Part Two: Adventure
    (13, 5),  -- Sci-Fi
    (13, 10), -- Fantasy
    (13, 4),  -- Thriller
    (14, 1),  -- Dreamer: Drama
    (14, 7),  -- Romance
    (15, 2),  -- My Ex-Friend’s Wedding: Comedy
    (15, 7),  -- Romance
    (16, 3),  -- Furiosa: Action
    (16, 8),  -- Adventure
    (16, 5),  -- Sci-Fi
    (17, 8),  -- Kingdom of the Planet of the Apes: Adventure
    (17, 5),  -- Sci-Fi
    (17, 10), -- Fantasy
    (18, 4),  -- The Watchers: Thriller
    (18, 1),  -- Drama
    (19, 6),  -- Inside Out 2: Animation
    (19, 1),  -- Drama
    (19, 10), -- Fantasy
    (20, 3),  -- Bad Boys 4: Action
    (20, 2),  -- Comedy
    (20, 4),  -- Thriller
    (21, 1),  -- Horizon: An American Saga: Drama
    (21, 8),  -- Adventure
    (22, 9),  -- A Quiet Place: Day One: Horror
    (22, 4),  -- Thriller
    (23, 3),  -- Deadpool 3: Action
    (23, 2),  -- Comedy
    (24, 2),  -- Beetlejuice 2: Comedy
    (24, 10), -- Fantasy
    (25, 1),  -- Joker 2: Drama
    (25, 4);  -- Thriller


INSERT INTO [Theater] ([Name], [Section], [Column], [Row])
VALUES 
    ('The Grand Theater', 1, 12, 15),
    ('Cinema City', 2, 10, 20),
    ('Galaxy Cinemas', 1, 8, 12),
    ('Regal Palace', 3, 15, 18),
    ('Cineplex Odeon', 2, 20, 22),
    ('AMC Downtown', 1, 14, 10),
    ('Movie Palace', 3, 5, 8),
    ('Star Light Cinema', 1, 10, 10),
    ('Cinemark Theater', 2, 12, 15),
    ('IMAX Experience', 1, 20, 20),
    ('Theater Royale', 3, 9, 14),
    ('Sunset Cinemas', 2, 18, 16),
    ('The Film House', 1, 11, 13),
    ('Cineworld', 2, 16, 17),
    ('The Studio', 1, 13, 19);


INSERT INTO [Schedule] ([MovieID], [TheaterID], [Date], [Time], [Price])
VALUES 
    -- The Book of Clarence
    (1, 1, '2024-11-01', '14:00', 65625),  
    (1, 2, '2024-11-01', '18:00', 68250),
    (1, 3, '2024-11-02', '20:00', 68250),
    (1, 1, '2024-11-03', '16:30', 57750),
    (1, 4, '2024-11-04', '12:00', 57750),
    (1, 2, '2024-11-05', '21:30', 73500),

    -- Mean Girls: The Musical
    (2, 1, '2024-11-02', '19:00', 52500),
    (2, 2, '2024-11-03', '14:00', 57750),
    (2, 3, '2024-11-04', '16:00', 49875),
    (2, 4, '2024-11-06', '18:30', 55125),
    (2, 1, '2024-11-07', '21:45', 63000),
    (2, 3, '2024-11-10', '16:00', 63000),

    -- Lift
    (3, 2, '2024-11-01', '17:00', 78750),
    (3, 3, '2024-11-02', '14:00', 73500),
    (3, 1, '2024-11-03', '19:00', 63000),
    (3, 4, '2024-11-05', '20:00', 78750),
    (3, 1, '2024-11-07', '22:00', 84000),
    (3, 2, '2024-11-08', '13:30', 57750),

    -- Distant
    (4, 2, '2024-11-01', '20:00', 73500),
    (4, 1, '2024-11-02', '16:00', 68250),
    (4, 3, '2024-11-04', '18:30', 63000),
    (4, 4, '2024-11-05', '19:30', 57750),
    (4, 2, '2024-11-08', '20:30', 73500),
    (4, 3, '2024-11-10', '17:00', 63000),

    -- Argylle
    (5, 2, '2024-11-02', '15:00', 68250),
    (5, 3, '2024-11-03', '17:00', 63000),
    (5, 4, '2024-11-04', '20:00', 75900),
    (5, 1, '2024-11-06', '19:00', 52500),
    (5, 3, '2024-11-09', '18:45', 68250),
    (5, 4, '2024-11-11', '14:15', 57750),

    -- Orion and the Dark
    (6, 3, '2024-11-01', '18:00', 54900),
    (6, 2, '2024-11-02', '20:00', 57750),
    (6, 4, '2024-11-03', '14:30', 63000),
    (6, 1, '2024-11-04', '17:00', 49875),
    (6, 1, '2024-11-06', '11:00', 47250),
    (6, 4, '2024-11-08', '22:00', 65625),

    -- It Ends With Us
    (7, 1, '2024-11-05', '20:00', 60375),
    (7, 2, '2024-11-06', '18:30', 52500),
    (7, 3, '2024-11-07', '14:00', 49875),
    (7, 4, '2024-11-08', '17:30', 63000),
    (7, 2, '2024-11-10', '15:00', 57750),
    (7, 3, '2024-11-12', '20:45', 65625),

    -- The Fall Guy
    (8, 1, '2024-11-01', '19:00', 63000),
    (8, 2, '2024-11-03', '15:00', 55125),
    (8, 3, '2024-11-04', '20:00', 60375),
    (8, 4, '2024-11-05', '17:00', 73500),
    (8, 3, '2024-11-06', '13:00', 68250),
    (8, 4, '2024-11-08', '18:30', 63000),

    -- Imaginary
    (9, 2, '2024-11-01', '20:00', 47250),
    (9, 1, '2024-11-02', '19:00', 52500),
    (9, 3, '2024-11-03', '18:00', 63000),
    (9, 4, '2024-11-04', '16:00', 57750),
    (9, 2, '2024-11-05', '21:30', 57750),
    (9, 4, '2024-11-08', '15:30', 52500),

    -- Cabrini
    (10, 1, '2024-11-05', '14:00', 63000),
    (10, 2, '2024-11-06', '20:00', 73500),
    (10, 3, '2024-11-07', '18:30', 60375),
    (10, 4, '2024-11-08', '17:00', 68250),
    (10, 2, '2024-11-10', '19:00', 68250),
    (10, 3, '2024-11-11', '15:00', 57750),

    -- Dune: Part Two
    (11, 2, '2024-11-01', '14:00', 78750),
    (11, 3, '2024-11-02', '18:00', 75900),
    (11, 1, '2024-11-04', '20:00', 84000),
    (11, 4, '2024-11-05', '17:30', 70875),
    (11, 2, '2024-11-06', '21:00', 78750),
    (11, 4, '2024-11-08', '19:15', 73500),

    -- Godzilla x Kong
    (12, 3, '2024-11-02', '19:00', 63000),
    (12, 2, '2024-11-03', '20:00', 68250),
    (12, 1, '2024-11-04', '16:00', 73500),
    (12, 4, '2024-11-05', '14:30', 78750),
    (12, 2, '2024-11-07', '13:00', 68250),
    (12, 3, '2024-11-08', '18:00', 73500),

    -- Rebel Moon
    (13, 1, '2024-11-06', '20:00', 68250),
    (13, 2, '2024-11-07', '19:00', 63000),
    (13, 3, '2024-11-08', '15:00', 57750),
    (13, 4, '2024-11-09', '16:30', 70875),
    (13, 3, '2024-11-10', '14:15', 68250),
    (13, 1, '2024-11-12', '21:00', 73500),

    -- Dreamer
    (14, 2, '2024-11-02', '14:00', 57750),
    (14, 3, '2024-11-03', '16:00', 63000),
    (14, 1, '2024-11-04', '17:30', 68250),
    (14, 4, '2024-11-05', '15:00', 57750),
    (14, 2, '2024-11-07', '12:30', 63000),
    (14, 3, '2024-11-10', '20:00', 73500),

    -- Kraven the Hunter
    (15, 2, '2024-11-01', '18:30', 73500),
    (15, 1, '2024-11-03', '20:00', 68250),
    (15, 3, '2024-11-04', '13:00', 63000),
    (15, 4, '2024-11-06', '15:30', 70875),
    (15, 1, '2024-11-08', '21:00', 73500),
    (15, 2, '2024-11-10', '17:15', 68250),

    -- Strangers
    (16, 3, '2024-11-01', '20:00', 57750),
    (16, 2, '2024-11-02', '14:30', 57750),
    (16, 4, '2024-11-03', '17:30', 63000),
    (16, 1, '2024-11-04', '16:00', 60375),
    (16, 3, '2024-11-07', '20:15', 65625),
    (16, 4, '2024-11-09', '13:30', 57750),

    -- Society of the Snow
    (17, 1, '2024-11-02', '20:00', 63000),
    (17, 2, '2024-11-03', '18:00', 70875),
    (17, 3, '2024-11-05', '19:30', 68250),
    (17, 4, '2024-11-06', '16:45', 73500),
    (17, 1, '2024-11-08', '14:00', 55125),
    (17, 2, '2024-11-10', '21:15', 73500),

    -- Another Round
    (18, 3, '2024-11-02', '12:00', 55125),
    (18, 2, '2024-11-04', '20:00', 68250),
    (18, 4, '2024-11-05', '19:30', 65625),
    (18, 1, '2024-11-06', '14:30', 63000),
    (18, 2, '2024-11-08', '17:15', 55125),
    (18, 4, '2024-11-11', '21:45', 65625),

    -- Havoc
    (19, 2, '2024-11-02', '19:00', 63000),
    (19, 1, '2024-11-03', '16:30', 68250),
    (19, 3, '2024-11-04', '18:45', 65625),
    (19, 4, '2024-11-06', '14:00', 70875),
    (19, 2, '2024-11-08', '20:30', 68250),
    (19, 4, '2024-11-10', '15:00', 63000),

    -- The Trainer
    (20, 3, '2024-11-01', '14:30', 55125),
    (20, 1, '2024-11-02', '13:30', 57750),
    (20, 2, '2024-11-03', '17:00', 63000),
    (20, 4, '2024-11-04', '15:15', 65625),
    (20, 3, '2024-11-07', '12:45', 60375),
    (20, 2, '2024-11-08', '18:30', 57750),

    -- Untitled Taika Waititi Project
    (21, 1, '2024-11-01', '15:00', 63000),
    (21, 2, '2024-11-03', '12:00', 65625),
    (21, 3, '2024-11-04', '20:00', 57750),
    (21, 4, '2024-11-05', '18:00', 60375),
    (21, 1, '2024-11-07', '13:15', 55125),
    (21, 2, '2024-11-09', '16:00', 57750),

    -- Inside Out 2
    (22, 3, '2024-11-01', '19:30', 68250),
    (22, 2, '2024-11-03', '16:30', 65625),
    (22, 4, '2024-11-04', '14:00', 70875),
    (22, 1, '2024-11-05', '13:00', 55125),
    (22, 2, '2024-11-07', '21:30', 68250),
    (22, 3, '2024-11-08', '12:00', 55125),

    -- Wicked Part One
    (23, 2, '2024-11-02', '13:30', 68250),
    (23, 3, '2024-11-04', '20:30', 70875),
    (23, 1, '2024-11-06', '18:00', 57750),
    (23, 4, '2024-11-07', '16:45', 60375),
    (23, 3, '2024-11-08', '22:15', 68250),
    (23, 1, '2024-11-10', '14:30', 57750),

    -- PAW Patrol 2
    (24, 1, '2024-11-01', '17:00', 63000),
    (24, 2, '2024-11-02', '15:00', 57750),
    (24, 3, '2024-11-03', '12:00', 65625),
    (24, 4, '2024-11-05', '16:30', 57750),
    (24, 2, '2024-11-08', '19:00', 52500),
    (24, 3, '2024-11-11', '14:15', 57750),

    -- Killers of the Flower Moon
    (25, 1, '2024-11-02', '20:00', 84000),
    (25, 2, '2024-11-04', '18:00', 73500),
    (25, 3, '2024-11-05', '14:00', 68250),
    (25, 4, '2024-11-06', '15:00', 73500),
    (25, 1, '2024-11-08', '21:30', 78750),
    (25, 3, '2024-11-10', '13:00', 73500);



INSERT INTO [Transaction] ([UserID], [ScheduleID], [TransactionDate])
VALUES 
    (1, 1, '2024-11-04 13:00:00'),
    (1, 2, '2024-11-04 13:30:00'),
    (2, 3, '2024-11-04 14:00:00'),
    (3, 4, '2024-11-04 14:30:00'),
    (4, 5, '2024-11-04 15:00:00'),
    (5, 6, '2024-11-04 15:30:00'),
    (6, 7, '2024-11-04 16:00:00'),
    (7, 8, '2024-11-04 16:30:00'),
    (8, 9, '2024-11-04 17:00:00'),
    (9, 10, '2024-11-04 17:30:00'),
    (10, 11, '2024-11-04 18:00:00'),
    (1, 12, '2024-11-04 18:30:00'),
    (2, 13, '2024-11-04 19:00:00'),
    (3, 14, '2024-11-04 19:30:00'),
    (4, 15, '2024-11-04 20:00:00'),
    (5, 16, '2024-11-04 20:30:00'),
    (6, 17, '2024-11-04 21:00:00'),
    (7, 18, '2024-11-04 21:30:00'),
    (8, 19, '2024-11-04 22:00:00'),
    (9, 20, '2024-11-04 22:30:00'),
    (10, 21, '2024-11-04 23:00:00');

INSERT INTO [TransactionDetail] ([TransactionID], [Seat], [Price])
VALUES 
    (1, 'A1', 65625),
    (1, 'A2', 65625),
    (2, 'B1', 68250),
    (2, 'B2', 68250),
    (2, 'B3', 68250),  -- Three tickets for user 2
    (3, 'C1', 78750),
    (3, 'C2', 78750),
    (4, 'D1', 57750),
    (4, 'D2', 57750),
    (4, 'D3', 57750),  -- Three tickets for user 4
    (5, 'E1', 49875),
    (5, 'E2', 49875),
    (5, 'E3', 49875),  -- Three tickets for user 5
    (6, 'F1', 63000),
    (6, 'F2', 63000),
    (6, 'F3', 63000),  -- Three tickets for user 6
    (7, 'G1', 52500),
    (7, 'G2', 52500),
    (8, 'H1', 47250),
    (8, 'H2', 47250),
    (8, 'H3', 47250),  -- Three tickets for user 8
    (9, 'I1', 49875),
    (9, 'I2', 49875),
    (10, 'J1', 60375),
    (10, 'J2', 60375),
    (10, 'J3', 60375);  -- Three tickets for user 10
