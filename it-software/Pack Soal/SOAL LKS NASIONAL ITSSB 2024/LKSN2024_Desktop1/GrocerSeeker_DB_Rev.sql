
DROP DATABASE IF EXISTS grocerseeker

CREATE DATABASE grocerseeker;
GO
USE grocerseeker;
GO

DROP TABLE IF EXISTS categories;

CREATE TABLE categories (
  id int NOT NULL,
  name varchar(255) DEFAULT NULL,
  is_active smallint DEFAULT NULL,
  created_at datetime2(0) NULL DEFAULT GETDATE(),
  updated_at datetime2(0) NULL DEFAULT GETDATE() /* ON UPDATE GETDATE() */,
  PRIMARY KEY (id)
)

INSERT INTO categories VALUES (1,'production',1,'2024-08-15 12:57:30','2024-08-15 12:57:33'),(2,'dairy',0,'2024-08-15 12:58:32','2024-08-15 12:58:32'),(3,'meat',1,'2024-08-15 12:58:49','2024-08-15 12:58:50'),(4,'bakery',0,'2024-08-15 12:59:07','2024-08-15 12:59:07'),(5,'pantry',1,'2024-08-15 14:08:35','2024-08-15 14:08:37'),(6,'beverages',1,'2024-08-15 14:09:02','2024-08-15 14:09:02'),(7,'frozen foods',1,'2024-08-15 14:09:19','2024-08-15 14:09:19'),(8,'household goods',1,'2024-08-15 14:09:35','2024-08-15 14:09:36'),(9,'personal care',1,'2024-08-15 14:09:53','2024-08-15 14:09:53'),(10,'baby products',0,'2024-08-15 14:10:03','2024-08-15 14:10:04');

DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id int NOT NULL,
  phone_number varchar(255) DEFAULT NULL,
  email varchar(255) DEFAULT NULL,
  password varchar(100) DEFAULT NULL,
  cust_active smallint DEFAULT NULL,
  vendor_active smallint DEFAULT NULL,
  cust_name varchar(255) DEFAULT NULL,
  cust_address varchar(max),
  cust_latitude float DEFAULT NULL,
  cust_longitude float DEFAULT NULL,
  vendor_name varchar(255) DEFAULT NULL,
  vendor_address varchar(max),
  vendor_latitude float DEFAULT NULL,
  vendor_longitude float DEFAULT NULL,
  created_at datetime2(0) NULL DEFAULT GETDATE(),
  updated_at datetime2(0) NULL DEFAULT GETDATE() /* ON UPDATE GETDATE() */,
  PRIMARY KEY (id)
)

INSERT INTO users VALUES (1,'0873956046825','rimari025@gmail.com','Rimari46825',1,1,'Rimari Shidan','Jl. kota Tua No.32',-6.137,106.838,'Rimari Groceries','Jl. Benyamin Sueb ',-6.147,106.845,'2024-08-16 02:26:38','2024-08-16 02:26:38'),(2,'083277066310','anto17@gmail.com','Anto66310',1,0,'Antony Reynald','Jl. Kedoya Utara No.4',-6.178,106.762,'','',NULL,NULL,'2024-08-16 02:26:38','2024-08-16 02:26:38'),(3,'088625040024','wj.farm@farmer.com','Wijaya40024',0,1,'','',NULL,NULL,'WJ Farm','Jl. Rego 4, Cadasari',-6.266,106.122,'2024-08-16 02:26:38','2024-08-16 02:26:38'),(4,'08861554350','prg@hotmail.com','Prggro1234',0,1,NULL,'',NULL,NULL,'PR Groceries','Pakuan Ratu Area',-4.492,104.823,'2024-08-16 02:26:38','2024-08-16 02:26:38'),(5,'08825457768','sangka@hotmail.com','Sangka12345',1,1,'Abdul Sangka','Jl.Setia Bumi 6',-4.309,105.082,'Qtela Farm','Jl. Setia Bumi,Gunung Terang',-4.309,105.077,'2024-08-16 02:26:38','2024-08-16 02:26:38'),(6,'088298769349','shinta98@outlook.com','Shint123',1,0,'Shinta Sabilla','Jl. Swadaya',-1.144,116.867,'','',NULL,NULL,'2024-08-16 02:26:38','2024-08-16 02:26:38');

DROP TABLE IF EXISTS products;

CREATE TABLE products (
  id int NOT NULL,
  vendor_id int DEFAULT NULL,
  product_name varchar(255) DEFAULT NULL,
  category_id int DEFAULT NULL,
  unit_type varchar(255) DEFAULT NULL,
  price_per_unit decimal(10,0) DEFAULT NULL,
  unit_stock float DEFAULT NULL,
  is_active smallint DEFAULT '1',
  created_at datetime2(0) NULL DEFAULT GETDATE(),
  updated_at datetime2(0) NULL DEFAULT GETDATE() /* ON UPDATE GETDATE() */,
  deleted_at datetime2(0) NULL DEFAULT NULL,
  PRIMARY KEY (id)
,
  CONSTRAINT products_ibfk_1 FOREIGN KEY (vendor_id) REFERENCES users (id),
  CONSTRAINT products_ibfk_2 FOREIGN KEY (category_id) REFERENCES categories (id)
)

CREATE INDEX vendor_id ON products (vendor_id);
CREATE INDEX category_id ON products (category_id);

INSERT INTO products VALUES (1,3,'white rice',1,'measurable',26600,25,1,'2024-08-16 03:53:50','2024-08-16 04:06:50',NULL),(2,3,'US cow meat',3,'measurable',125000,12.5,1,'2024-08-16 03:53:50','2024-08-16 03:53:50',NULL),(3,3,'Raw sweet corn',1,'measurable',20000,3.5,0,'2024-08-16 03:53:50','2024-08-16 03:53:50',NULL),(4,3,'Chicken breast fillet',3,'measurable',28500,24,1,'2024-08-16 03:53:50','2024-08-16 03:53:50',NULL),(5,3,'Frozen whole chicken pack @250gr',7,'countable',27000,15,1,'2024-08-16 03:53:50','2024-08-16 03:53:50',NULL),(6,3,'Beef rendang meat pack @250gr',7,'countable',122000,10,1,'2024-08-16 03:53:50','2024-08-16 03:53:50',NULL),(7,3,'Catfish meat pack @250gr',7,'countable',30000,0,1,'2024-08-16 03:53:50','2024-08-16 03:53:50',NULL),(8,4,'water galon',6,'countable',50000,12,1,'2024-08-16 03:53:50','2024-08-16 03:53:50',NULL),(9,4,'Whoosh detergent 600ml',8,'countable',25500,24,1,'2024-08-16 03:53:50','2024-08-16 03:53:50',NULL),(10,4,'LEAFY Tissue 250g',9,'countable',31000,48,1,'2024-08-16 03:53:50','2024-08-16 03:53:50',NULL),(11,4,'The colas 1ltr',6,'countable',15000,24,1,'2024-08-16 03:53:50','2024-08-16 03:53:50',NULL),(12,4,'4 Set silverware set stainless steel',8,'countable',30000,100,1,'2024-08-16 03:53:50','2024-08-16 03:53:50',NULL),(13,4,'Shamphoo 500ml',9,'countable',49000,24,1,'2024-08-16 03:53:50','2024-08-16 03:53:50',NULL),(14,4,'White Sugar',5,'measurable',18000,10,0,'2024-08-16 03:53:50','2024-08-16 03:53:50',NULL),(15,1,'Brown Sugar',5,'measurable',77500,2.5,1,'2024-08-16 03:53:50','2024-08-16 03:53:50',NULL),(16,1,'Flour',5,'measurable',13500,0,1,'2024-08-16 03:53:50','2024-08-16 03:53:50',NULL),(17,1,'Frying Oil',5,'measurable',25000,25,1,'2024-08-16 03:53:50','2024-08-16 03:53:50',NULL),(18,1,'Premium Corn Oil 1ltr',5,'countable',50000,12,1,'2024-08-16 03:53:50','2024-08-16 03:53:50',NULL),(19,1,'Mouthwash',9,'countable',25000,24,1,'2024-08-16 03:53:50','2024-08-16 03:53:50',NULL),(20,5,'Spinach',1,'measurable',20000,5,1,'2024-08-16 03:53:50','2024-08-16 03:53:50',NULL),(21,5,'Cassava',1,'measurable',15500,7.5,1,'2024-08-16 03:53:50','2024-08-16 03:53:50',NULL),(22,5,'Mini Tomato',1,'measurable',24500,7.75,1,'2024-08-16 03:53:50','2024-08-16 03:53:50',NULL),(23,5,'Mix vegetable pack @250g',1,'countable',66500,12,1,'2024-08-16 03:53:50','2024-08-16 03:53:50',NULL),(24,5,'Mix mushroom pack @250g',1,'countable',45500,10,1,'2024-08-16 03:53:50','2024-08-16 03:53:50',NULL);

DROP TABLE IF EXISTS transactions;

CREATE TABLE transactions (
  id int NOT NULL IDENTITY,
  vendor_id int DEFAULT NULL,
  customer_id int DEFAULT NULL,
  product_id int DEFAULT NULL,
  quantity float DEFAULT NULL,
  total_price decimal(10,0) DEFAULT NULL,
  delivery_cost decimal(10,0) DEFAULT NULL,
  status varchar(255) DEFAULT NULL,
  created_at datetime2(0) NULL DEFAULT GETDATE(),
  updated_at datetime2(0) NULL DEFAULT GETDATE() /* ON UPDATE GETDATE() */,
  PRIMARY KEY (id)
,
  CONSTRAINT transactions_ibfk_1 FOREIGN KEY (vendor_id) REFERENCES users (id),
  CONSTRAINT transactions_ibfk_2 FOREIGN KEY (product_id) REFERENCES products (id),
  CONSTRAINT transactions_ibfk_3 FOREIGN KEY (customer_id) REFERENCES users (id)
)

CREATE INDEX vendor_id ON transactions (vendor_id);
CREATE INDEX product_id ON transactions (product_id);
CREATE INDEX customer_id ON transactions (customer_id);


SET IDENTITY_INSERT transactions ON;

INSERT INTO transactions(id,vendor_id,customer_id,product_id,quantity,total_price,delivery_cost,status,created_at,updated_at) VALUES (1,3,1,1,1.25,33250,15000,'success','2024-08-17 08:35:03','2024-08-17 09:12:33'),(2,3,1,5,2,54000,15000,'abort','2024-08-17 08:37:15','2024-08-17 09:12:33'),(3,3,1,4,0.5,14250,15000,'pending','2024-08-17 08:39:43','2024-08-17 08:39:43'),(4,3,1,5,2,54000,15000,'pending','2024-08-17 08:39:48','2024-08-17 08:39:48'),(5,4,1,9,5,127500,45000,'success','2024-08-17 08:39:54','2024-08-17 09:12:33'),(6,4,1,10,4,124000,45000,'pending','2024-08-17 08:39:58','2024-08-17 08:39:58'),(7,4,1,11,5,75000,45000,'pending','2024-08-17 08:40:02','2024-08-17 08:40:02'),(8,3,1,1,0.3,7980,15000,'pending','2024-08-17 08:40:07','2024-08-17 08:40:07'),(9,3,1,1,0.1,2660,15000,'pending','2024-08-17 08:40:12','2024-08-17 08:40:12'),(10,4,1,12,10,300000,45000,'pending','2024-08-17 08:40:42','2024-08-17 08:40:42'),(11,5,2,24,2,91000,45000,'pending','2024-08-17 08:47:07','2024-08-17 08:47:07'),(12,5,2,22,2.75,67375,45000,'pending','2024-08-17 08:47:18','2024-08-17 08:47:18'),(13,5,2,21,0.5,7750,45000,'pending','2024-08-17 08:47:24','2024-08-17 08:47:24'),(14,5,2,20,0.5,10000,45000,'pending','2024-08-17 08:47:28','2024-08-17 08:47:28'),(15,1,2,19,3,75000,15000,'pending','2024-08-17 08:47:34','2024-08-17 08:47:34'),(16,4,5,11,2,30000,15000,'pending','2024-08-17 08:50:06','2024-08-17 08:50:06'),(17,4,5,10,3,93000,15000,'pending','2024-08-17 08:50:11','2024-08-17 08:50:11'),(18,1,5,15,0.5,38750,45000,'pending','2024-08-17 08:50:18','2024-08-17 08:50:18'),(19,3,6,5,2,54000,210000,'pending','2024-08-17 08:51:57','2024-08-17 08:51:57'),(20,4,6,8,2,100000,210000,'pending','2024-08-17 08:52:02','2024-08-17 08:52:02'),(21,4,6,9,3,76500,210000,'pending','2024-08-17 08:52:07','2024-08-17 08:52:07'),(22,4,6,10,1,31000,210000,'pending','2024-08-17 08:52:11','2024-08-17 08:52:11'),(23,4,6,11,1,15000,210000,'pending','2024-08-17 08:52:17','2024-08-17 08:52:17');

SET IDENTITY_INSERT transactions OFF;