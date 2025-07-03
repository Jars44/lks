USE [master];
GO
DROP DATABASE IF EXISTS [HovRailKiosk];
GO
CREATE DATABASE [HovRailKiosk];
GO
USE [HovRailKiosk];

CREATE TABLE [City](
	cityID					INT				IDENTITY
	,cityName					VARCHAR(100)	NOT NULL
	,PRIMARY KEY(cityID)
);

CREATE TABLE [Station](
	stationID				INT				IDENTITY
	,cityID					INT				NOT NULL
	,stationName			VARCHAR(100)	NOT NULL
	,PRIMARY KEY(stationID)
	,FOREIGN KEY(cityID) REFERENCES [City](cityID)
);

CREATE TABLE [Route](
	routeID					INT				IDENTITY
	,routeName				VARCHAR(255)	NOT NULL
	,departureStationID		INT				NOT NULL
	,arrivalStationID		INT				NOT NULL
	,fixedPrice				DECIMAL(11,2)	NOT NULL
	,pricePerHour			DECIMAL(11,2)	NOT NULL
	,PRIMARY KEY(routeID)
	,FOREIGN KEY(departureStationID) REFERENCES [Station](stationID)
	,FOREIGN KEY(arrivalStationID) REFERENCES [Station](stationID)
);

CREATE TABLE [RouteDetail](
	routeDetailID			INT				IDENTITY
	,routeID				INT				NOT NULL
	,destinationStationID	INT				NOT NULL
	,stationSequenceNo		INT				NOT NULL
	,travelHour				DECIMAL(5,2)	NOT NULL	
	,PRIMARY KEY(routeDetailID)
	,FOREIGN KEY(routeID) REFERENCES [Route](routeID)
	,FOREIGN KEY(destinationStationID) REFERENCES [Station](stationID)
);

CREATE TABLE [Train](
	trainID					INT				IDENTITY
	,trainName				VARCHAR(100)	NOT NULL
	,capacity				INT				NOT NULL
	,PRIMARY KEY (trainID)
);

CREATE TABLE [Schedule](
	scheduleID				INT				IDENTITY
	,trainID				INT				NOT NULL
	,routeID				INT				NOT NULL
	,departureTime			DATETIME		NOT NULL
	,createdAt				DATETIME		DEFAULT CURRENT_TIMESTAMP
	,PRIMARY KEY(scheduleID)
	,FOREIGN KEY(trainID) REFERENCES [Train](trainID)
	,FOREIGN KEY(routeID) REFERENCES [Route](routeID)
);

CREATE TABLE [Ticket](
	ticketID				INT				IDENTITY
	,scheduleID				INT				NOT NULL
	,departureStationID		INT				NOT NULL
	,departureTime			DATETIME		NOT NULL
	,arrivalStationID		INT				NOT NULL
	,arrivalTime			DATETIME		NOT NULL
	,seatNumber				INT				NOT NULL
	,passengerName			VARCHAR(255)	NOT NULL
	,price					DECIMAL			NOT NULL
	,createdAt				DATETIME		DEFAULT CURRENT_TIMESTAMP
	,PRIMARY KEY(ticketID)
	,FOREIGN KEY(scheduleID) REFERENCES [Schedule](scheduleID)
	,FOREIGN KEY(departureStationID) REFERENCES [Station](stationID)
	,FOREIGN KEY(arrivalStationID) REFERENCES [Station](stationID)
);



BEGIN -- Insert to Table City
	INSERT INTO City(cityName) VALUES('Aelios')
	INSERT INTO City(cityName) VALUES('Aurenth')
	INSERT INTO City(cityName) VALUES('Caldris')
	INSERT INTO City(cityName) VALUES('Delarion')
	INSERT INTO City(cityName) VALUES('Eldaris')
	INSERT INTO City(cityName) VALUES('Helinth')
	INSERT INTO City(cityName) VALUES('Kerath')
	INSERT INTO City(cityName) VALUES('Koral')
	INSERT INTO City(cityName) VALUES('Korath')
	INSERT INTO City(cityName) VALUES('Lathis')
	INSERT INTO City(cityName) VALUES('Lorath')
	INSERT INTO City(cityName) VALUES('Mendor')
	INSERT INTO City(cityName) VALUES('Merinth')
	INSERT INTO City(cityName) VALUES('Morath')
	INSERT INTO City(cityName) VALUES('Myrrath')
	INSERT INTO City(cityName) VALUES('Naloris')
	INSERT INTO City(cityName) VALUES('Nyros')
	INSERT INTO City(cityName) VALUES('Rhenia')
	INSERT INTO City(cityName) VALUES('Sereth')
	INSERT INTO City(cityName) VALUES('Thaldor')
	INSERT INTO City(cityName) VALUES('Thalor')
	INSERT INTO City(cityName) VALUES('Theris')
	INSERT INTO City(cityName) VALUES('Therron')
	INSERT INTO City(cityName) VALUES('Valis')
	INSERT INTO City(cityName) VALUES('Vathis')
	INSERT INTO City(cityName) VALUES('Velaroth')
	INSERT INTO City(cityName) VALUES('Velentis')
	INSERT INTO City(cityName) VALUES('Veloria')
	INSERT INTO City(cityName) VALUES('Verion')
	INSERT INTO City(cityName) VALUES('Veros')
	INSERT INTO City(cityName) VALUES('Xalor')
	INSERT INTO City(cityName) VALUES('Xenith')
	INSERT INTO City(cityName) VALUES('Xerath')
	INSERT INTO City(cityName) VALUES('Xeroth')
	INSERT INTO City(cityName) VALUES('Xylaris')
	INSERT INTO City(cityName) VALUES('Xylith')
	INSERT INTO City(cityName) VALUES('Xytheon')
	INSERT INTO City(cityName) VALUES('Zaldor')
	INSERT INTO City(cityName) VALUES('Zelanis')
	INSERT INTO City(cityName) VALUES('Zelor')
	INSERT INTO City(cityName) VALUES('Zerthis')
	INSERT INTO City(cityName) VALUES('Zheron')
END


BEGIN -- Insert to Table Station
	INSERT INTO Station(cityID, stationName) VALUES(6, 'Aurora')
	INSERT INTO Station(cityID, stationName) VALUES(31, 'Axium')
	INSERT INTO Station(cityID, stationName) VALUES(5, 'Boramis')
	INSERT INTO Station(cityID, stationName) VALUES(38, 'Brelior')
	INSERT INTO Station(cityID, stationName) VALUES(13, 'Caldor')
	INSERT INTO Station(cityID, stationName) VALUES(15, 'Dalina')
	INSERT INTO Station(cityID, stationName) VALUES(34, 'Dalnor')
	INSERT INTO Station(cityID, stationName) VALUES(9, 'Eldora')
	INSERT INTO Station(cityID, stationName) VALUES(19, 'Elona')
	INSERT INTO Station(cityID, stationName) VALUES(14, 'Embrus')
	INSERT INTO Station(cityID, stationName) VALUES(22, 'Felmar')
	INSERT INTO Station(cityID, stationName) VALUES(11, 'Fionis')
	INSERT INTO Station(cityID, stationName) VALUES(37, 'Helisar')
	INSERT INTO Station(cityID, stationName) VALUES(7, 'Ithara')
	INSERT INTO Station(cityID, stationName) VALUES(23, 'Ivoria')
	INSERT INTO Station(cityID, stationName) VALUES(16, 'Karion')
	INSERT INTO Station(cityID, stationName) VALUES(20, 'Kelmar')
	INSERT INTO Station(cityID, stationName) VALUES(42, 'Kelmora')
	INSERT INTO Station(cityID, stationName) VALUES(24, 'Keltran')
	INSERT INTO Station(cityID, stationName) VALUES(4, 'Ketheris')
	INSERT INTO Station(cityID, stationName) VALUES(21, 'Marentis')
	INSERT INTO Station(cityID, stationName) VALUES(29, 'Meldar')
	INSERT INTO Station(cityID, stationName) VALUES(40, 'Mirelia')
	INSERT INTO Station(cityID, stationName) VALUES(28, 'Novara')
	INSERT INTO Station(cityID, stationName) VALUES(18, 'Oska')
	INSERT INTO Station(cityID, stationName) VALUES(4, 'Pheron')
	INSERT INTO Station(cityID, stationName) VALUES(30, 'Quethara')
	INSERT INTO Station(cityID, stationName) VALUES(41, 'Raylith')
	INSERT INTO Station(cityID, stationName) VALUES(36, 'Rendora')
	INSERT INTO Station(cityID, stationName) VALUES(39, 'Rhadon')
	INSERT INTO Station(cityID, stationName) VALUES(2, 'Solaria')
	INSERT INTO Station(cityID, stationName) VALUES(8, 'Theon')
	INSERT INTO Station(cityID, stationName) VALUES(25, 'Theros')
	INSERT INTO Station(cityID, stationName) VALUES(33, 'Valaris')
	INSERT INTO Station(cityID, stationName) VALUES(32, 'Valion')
	INSERT INTO Station(cityID, stationName) VALUES(10, 'Veldor')
	INSERT INTO Station(cityID, stationName) VALUES(1, 'Velora')
	INSERT INTO Station(cityID, stationName) VALUES(35, 'Veltis')
	INSERT INTO Station(cityID, stationName) VALUES(12, 'Veridia')
	INSERT INTO Station(cityID, stationName) VALUES(17, 'Verith')
	INSERT INTO Station(cityID, stationName) VALUES(22, 'Xerith')
	INSERT INTO Station(cityID, stationName) VALUES(26, 'Xethion')
	INSERT INTO Station(cityID, stationName) VALUES(3, 'Zerith')
	INSERT INTO Station(cityID, stationName) VALUES(27, 'Zoralis')
	INSERT INTO Station(cityID, stationName) VALUES(27, 'Zoralis')
END


BEGIN -- Insert to Table [Route]
	INSERT INTO [Route](routeName, departureStationID, arrivalStationID, fixedPrice, pricePerHour) VALUES('Astralon', 31, 8, 60000, 20000)
	INSERT INTO [Route](routeName, departureStationID, arrivalStationID, fixedPrice, pricePerHour) VALUES('Orvion', 8, 27, 30000, 5000)
	INSERT INTO [Route](routeName, departureStationID, arrivalStationID, fixedPrice, pricePerHour) VALUES('Lunaris', 8, 21, 30000, 10000)
	INSERT INTO [Route](routeName, departureStationID, arrivalStationID, fixedPrice, pricePerHour) VALUES('Velthar', 8, 27, 45000, 5000)
	INSERT INTO [Route](routeName, departureStationID, arrivalStationID, fixedPrice, pricePerHour) VALUES('Thalara', 8, 4, 50000, 10000)
	INSERT INTO [Route](routeName, departureStationID, arrivalStationID, fixedPrice, pricePerHour) VALUES('Mythorian', 31, 25, 35000, 150000)
END


BEGIN -- Insert to Table RouteDetail
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(1, 31, 1, 0)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(1, 24, 2, 1)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(1, 2, 3, 1.5)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(1, 37, 4, 2.5)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(1, 6, 5, 1)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(1, 43, 6, 2.5)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(1, 9, 7, 3)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(1, 21, 8, 2)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(1, 36, 9, 3)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(1, 25, 10, 1)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(1, 4, 11, 1.5)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(1, 27, 12, 2.5)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(1, 8, 13, 1.5)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(2, 8, 1, 0)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(2, 40, 2, 2)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(2, 13, 3, 1.5)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(2, 21, 4, 2.5)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(2, 4, 5, 3)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(2, 27, 6, 2.5)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(3, 8, 1, 0)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(3, 40, 2, 3)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(3, 13, 3, 2.5)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(3, 6, 4, 2)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(3, 2, 5, 1.5)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(3, 9, 6, 2.5)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(3, 21, 7, 2)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(4, 8, 1, 0)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(4, 40, 2, 3)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(4, 13, 3, 2.5)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(4, 6, 4, 2)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(4, 9, 5, 1.5)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(4, 4, 6, 2.5)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(4, 27, 7, 1.5)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(5, 8, 1, 0)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(5, 40, 2, 2.5)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(5, 13, 3, 2)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(5, 6, 4, 3)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(5, 2, 5, 1.5)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(5, 9, 6, 2)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(5, 4, 7, 2.5)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(6, 31, 1, 0)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(6, 4, 2, 2)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(6, 21, 3, 2.5)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(6, 8, 4, 3)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(6, 27, 5, 1.5)
	INSERT INTO RouteDetail(routeID, destinationStationID, stationSequenceNo, travelHour) VALUES(6, 25, 6, 1)
END


BEGIN -- Insert to Table Train
	INSERT INTO Train(trainName, capacity) VALUES('Aurora Express', 5)
	INSERT INTO Train(trainName, capacity) VALUES('Silver Streak', 6)
	INSERT INTO Train(trainName, capacity) VALUES('Crimson Comet', 7)
	INSERT INTO Train(trainName, capacity) VALUES('Blue Horizon', 5)
	INSERT INTO Train(trainName, capacity) VALUES('Golden Zephyr', 5)
	INSERT INTO Train(trainName, capacity) VALUES('Emerald Arrow', 7)
	INSERT INTO Train(trainName, capacity) VALUES('Radiant Falcon', 5)
	INSERT INTO Train(trainName, capacity) VALUES('Scarlet Serpent', 5)
END


BEGIN -- -- Insert to Table Schedule
	DECLARE @DateTimeValue DATETIME;
	SET @DateTimeValue = GETDATE();
	INSERT INTO Schedule(trainID, routeID, departureTime) VALUES(1, 1, @DateTimeValue)

	SET @DateTimeValue = CAST(DATEADD(DAY, 4, GETDATE()) AS DATETIME);
	INSERT INTO Schedule(trainID, routeID, departureTime) VALUES(1, 1, @DateTimeValue)


	-- Prepare table for dummy data
	DECLARE @DummyData TABLE (id INT, trainID INT, routeID INT, departureTime TIME);
	INSERT INTO @DummyData (id, trainID, routeID, departureTime) VALUES
	(1, 5, 5, '08:00:00'),
	(2, 7, 5, '08:00:00'),
	(3, 3, 3, '08:30:00'),
	(4, 2, 2, '09:00:00'),
	(5, 1, 1, '10:30:00'),
	(6, 4, 4, '10:30:00'),
	(7, 6, 6, '11:00:00'),
	(8, 1, 2, '17:00:00'),
	(9, 2, 1, '18:00:00'),
	(10, 4, 6, '18:30:00'),
	(11, 6, 4, '19:00:00'),
	(12, 3, 3, '19:30:00'),
	(13, 8, 5, '20:00:00');

	-- Set variable for the function
	DECLARE @CurrentID INT;
	DECLARE @CurrentTrainID INT;
	DECLARE @CurrentRouteID INT;
	DECLARE @CurrentDepartureTime TIME;
	DECLARE @DateValue DATE;
	SET @DateValue = CAST(DATEADD(DAY, 1, GETDATE()) AS DATE);

	DECLARE @DataCount INT;
	DECLARE @Index INT = 1;

	-- Get number of dummy data
	SET @DataCount = (SELECT COUNT(*) FROM @DummyData);

	WHILE @Index <= @DataCount
	BEGIN
		-- Get the current selected data
		SELECT
			@CurrentID = ID,
			@CurrentTrainID = trainID,
			@CurrentRouteID = routeID,
			@CurrentDepartureTime = departureTime
		FROM @DummyData 
		ORDER BY ID OFFSET @Index - 1 ROWS FETCH NEXT 1 ROWS ONLY;

		-- Insert the combined date and time into the Schedule table
		INSERT INTO Schedule (trainID, routeID, departureTime)
		VALUES (@CurrentTrainID, 
				@CurrentRouteID,
				CAST(CAST(@DateValue AS DATETIME) + CAST(@CurrentDepartureTime AS DATETIME) AS DATETIME));

		-- Increment the index
		SET @Index = @Index + 1;
	END

END


BEGIN -- Insert to Table Ticket
	INSERT INTO Ticket(scheduleID, departureStationID, departureTime, arrivalStationID, arrivalTime, seatNumber, PassengerName, price) VALUES(3, 8, '11/08/2024 08:00:00', 4, '11/08/2024 21:30:00', 1, 'Liam Bennett', 185000)
	INSERT INTO Ticket(scheduleID, departureStationID, departureTime, arrivalStationID, arrivalTime, seatNumber, PassengerName, price) VALUES(3, 8, '11/08/2024 08:00:00', 4, '11/08/2024 21:30:00', 4, 'Ethan Rivera', 185000)
	INSERT INTO Ticket(scheduleID, departureStationID, departureTime, arrivalStationID, arrivalTime, seatNumber, PassengerName, price) VALUES(3, 8, '11/08/2024 08:00:00', 4, '11/08/2024 21:30:00', 5, 'Ava Thompson', 185000)
	INSERT INTO Ticket(scheduleID, departureStationID, departureTime, arrivalStationID, arrivalTime, seatNumber, PassengerName, price) VALUES(3, 8, '11/08/2024 08:00:00', 4, '11/08/2024 21:30:00', 2, 'Oliver Carter', 185000)
	INSERT INTO Ticket(scheduleID, departureStationID, departureTime, arrivalStationID, arrivalTime, seatNumber, PassengerName, price) VALUES(3, 8, '11/08/2024 08:00:00', 4, '11/08/2024 21:30:00', 3, 'Sophia Martinez', 185000)
	INSERT INTO Ticket(scheduleID, departureStationID, departureTime, arrivalStationID, arrivalTime, seatNumber, PassengerName, price) VALUES(4, 8, '11/08/2024 08:00:00', 4, '11/08/2024 21:30:00', 5, 'Noah Mitchell', 185000)
	INSERT INTO Ticket(scheduleID, departureStationID, departureTime, arrivalStationID, arrivalTime, seatNumber, PassengerName, price) VALUES(4, 8, '11/08/2024 08:00:00', 4, '11/08/2024 21:30:00', 1, 'Grace Collins', 185000)
	INSERT INTO Ticket(scheduleID, departureStationID, departureTime, arrivalStationID, arrivalTime, seatNumber, PassengerName, price) VALUES(5, 40, '11/08/2024 08:30:00', 13, '11/08/2024 14:00:00', 2, 'Leo Carter', 55000)
	INSERT INTO Ticket(scheduleID, departureStationID, departureTime, arrivalStationID, arrivalTime, seatNumber, PassengerName, price) VALUES(6, 21, '11/08/2024 09:00:00', 27, '11/08/2024 14:30:00', 1, 'Nora Sanders', 57500)
	INSERT INTO Ticket(scheduleID, departureStationID, departureTime, arrivalStationID, arrivalTime, seatNumber, PassengerName, price) VALUES(7, 31, '11/08/2024 10:30:00', 8, '11/09/2024 09:30:00', 3, 'Zoe Brooks', 520000)
	INSERT INTO Ticket(scheduleID, departureStationID, departureTime, arrivalStationID, arrivalTime, seatNumber, PassengerName, price) VALUES(7, 31, '11/08/2024 10:30:00', 8, '11/09/2024 09:30:00', 1, 'Mia Harrison', 520000)
	INSERT INTO Ticket(scheduleID, departureStationID, departureTime, arrivalStationID, arrivalTime, seatNumber, PassengerName, price) VALUES(7, 31, '11/08/2024 10:30:00', 8, '11/09/2024 09:30:00', 4, 'Ryan Foster', 520000)
	INSERT INTO Ticket(scheduleID, departureStationID, departureTime, arrivalStationID, arrivalTime, seatNumber, PassengerName, price) VALUES(7, 31, '11/08/2024 10:30:00', 9, '11/08/2024 22:00:00', 5, 'Emma Scott', 290000)
	INSERT INTO Ticket(scheduleID, departureStationID, departureTime, arrivalStationID, arrivalTime, seatNumber, PassengerName, price) VALUES(7, 31, '11/08/2024 10:30:00', 8, '11/09/2024 09:30:00', 2, 'Lucas Perez', 520000)
	INSERT INTO Ticket(scheduleID, departureStationID, departureTime, arrivalStationID, arrivalTime, seatNumber, PassengerName, price) VALUES(8, 13, '11/08/2024 10:30:00', 27, '11/08/2024 18:00:00', 1, 'Benjamin Hayes', 82500)
END