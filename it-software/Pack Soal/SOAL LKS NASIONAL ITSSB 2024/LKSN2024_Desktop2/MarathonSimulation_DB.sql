CREATE DATABASE MarathonDB;
USE MarathonDB;

CREATE TABLE Events (
    EventID INT PRIMARY KEY IDENTITY(1,1),
    EventName NVARCHAR(50),
    DistanceKm INT
);

CREATE TABLE Participants (
    ParticipantID INT PRIMARY KEY IDENTITY(1,1),
    EventID INT FOREIGN KEY REFERENCES Events(EventID),
    Name NVARCHAR(50),
    Age INT,
    Speed DECIMAL(5, 2)
);

INSERT INTO Events (EventName, DistanceKm) VALUES ('5K Run', 5);
INSERT INTO Events (EventName, DistanceKm) VALUES ('10K Run', 10);
INSERT INTO Events (EventName, DistanceKm) VALUES ('20K Run', 20);

INSERT INTO Participants (EventID, Name, Age, Speed) VALUES (1, 'John Doe', 25, 3);
INSERT INTO Participants (EventID, Name, Age, Speed) VALUES (1, 'Jane Smith', 30, 4);
INSERT INTO Participants (EventID, Name, Age, Speed) VALUES (1, 'Alice Brown', 22, 2.5);
INSERT INTO Participants (EventID, Name, Age, Speed) VALUES (2, 'Bob Johnson', 28, 3.5);
INSERT INTO Participants (EventID, Name, Age, Speed) VALUES (2, 'Charlie Davis', 35, 5);
INSERT INTO Participants (EventID, Name, Age, Speed) VALUES (2, 'Eve Williams', 27, 4.2);
INSERT INTO Participants (EventID, Name, Age, Speed) VALUES (3, 'Frank Miller', 40, 4);
INSERT INTO Participants (EventID, Name, Age, Speed) VALUES (3, 'Grace Lee', 32, 3.8);
INSERT INTO Participants (EventID, Name, Age, Speed) VALUES (3, 'Henry Wilson', 29, 4.5);
INSERT INTO Participants (EventID, Name, Age, Speed) VALUES (3, 'Irene Thomas', 34, 3.7);
INSERT INTO Participants (EventID, Name, Age, Speed) VALUES (3, 'Arrival Sentosa', 27, 3.2);
