create database MotorcycleRepair;

use MotorcycleRepair;

create table MotorcycleServices(
	ServiceCode char(5),
	ServiceName varchar(100),
	Cost int,
	primary key (ServiceCode)
);

create table Products(
	ProductCode char(5),
	ProductName varchar(100),
	Price int,
	primary key (ProductCode)
);

create table Users(
	UserCode char(9),
	UserName varchar(60),
	UserPassword varchar(50),
	primary key (UserCode)
);

create table Mechanics(
	MechanicCode char(5),
	MechanicName varchar(60),
	primary key (MechanicCode)
);

create table TransactionService(
	TransactionNumber char(10),
	TransactionDate date,
	PoliceRegistrationNumber varchar(10),
	Damage varchar(250),
	TotalServiceCost int,
	TotalProductPrice int,
	TotalCharge int,
	Paid int,
	ChangeMoney int,
	UserCode char(9),
	MechanicCode char(5),
	primary key (TransactionNumber),
	foreign key (UserCode) references Users,
	foreign key (MechanicCode) references Mechanics
);

create table DetailService(
	TransactionNumber char(10),
	ServiceCode char(5),
	Cost int,
	primary key (TransactionNumber, ServiceCode),
	foreign key (ServiceCode) references MotorcycleServices,
	foreign key (TransactionNumber) references TransactionService
);

create table DetailProduct(
	TransactionNumber char(10),
	ProductCode char(5),
	Price int,
	Amount int,
	Total int,
	primary key (TransactionNumber, ProductCode),
	foreign key (ProductCode) references Products,
	foreign key (TransactionNumber) references TransactionService
);

INSERT INTO Users(UserCode, UserName, UserPassword)
VALUES
('USR-20-01', 'Agus Supriadi', 'y7IGGjwH'),
('USR-20-02', 'Denira Fitria', 'tTRBiju9'),
('USR-22-01', 'Jessica Andriani', 'iXEyVoLc'),
('USR-23-01', 'Clara Rika', '5ycAXFEK'),
('USR-24-01', 'Puspa Winarsih', 'MfY5RCrM');

INSERT INTO MotorcycleServices(ServiceCode, ServiceName, Cost)
VALUES
('SR001', 'Service Matic 110cc', 95000),
('SR002', 'Service Matic 125cc', 110000),
('SR003', 'Service Matic 150cc', 120000),
('SR004', 'Service Manual 110cc', 125000),
('SR005', 'Service Manual 125cc', 135000),
('SR006', 'Service Manual 150cc', 150000),
('SR007', 'Tire Replacement Service', 15000),
('SR008', 'Speedometer Replacement Service', 45000);

INSERT INTO Products(ProductCode, ProductName, Price)
VALUES
('PR001', 'ACCELERATOR GRIP', 30000),
('PR002', 'ACCELERATOR / THROTTLE  CABLE', 30000),
('PR003', 'AIR CLEANER COMPLETE', 120000),
('PR004', 'AIR CLEANER HOSE PIPE', 25000),
('PR005', 'AIR CLEANER ELEMENT FOAM TYPE', 35000),
('PR006', 'BRAKE CABLE', 40000),
('PR007', 'BRAKE CAM FRONT', 30000),
('PR008', 'BRAKE CAM REAR', 20000),
('PR009', 'BRAKE PAD /SHOE REAR', 50000),
('PR010', 'BRAKE PAD/ SHOE FRONT', 50000),
('PR011', 'BRAKE PEDAL', 90000),
('PR012', 'OIL FILTER', 85000),
('PR013', 'OIL PUMP', 85000),
('PR014', 'SPEEDOMETER CABLE', 35000),
('PR015', 'SPEEDOMETER COMPLETE /DASHBOARD', 400000),
('PR016', 'HEAD LAMP BULB', 30000),
('PR017', 'TAIL LAMP BULB', 10000),
('PR018', 'SPARK PLUG', 35000),
('PR019', 'FRONT TYRE', 360000),
('PR020', 'REAR TYRE', 450000),
('PR021', 'REARVIEW MIRROR', 45000);

INSERT INTO Mechanics(MechanicCode, MechanicName)
VALUES
('MC001', 'Toni Setiawan'),
('MC002', 'Ardi Mandala'),
('MC003', 'Eman Megantara'),
('MC004', 'Lutfan Wibowo'),
('MC005', 'Rangga Prakasa'),
('MC006', 'Ajiono Halim'),
('MC007', 'Galih Waluyo');