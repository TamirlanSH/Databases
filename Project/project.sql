CREATE TABLE Customers(
    ID_customer INTEGER PRIMARY KEY,
    Name Text NOT NULL,
    Type_of_customer Text NOT NULL,
    Ranting INTEGER NOT NULL,
    Phone_number Text NOT NULL
);

CREATE TABLE Sales_data(
    ID_sales INTEGER PRIMARY KEY,
    Name_of_product TEXT NOT NULL,
    Shop_name TEXT NOT NULL,
    Product_group TEXT NOT NULL,
    Season VARCHAR(10) NOT NULL ,
    Time_period date NOT NULL ,
    Country varchar(20),
    City varchar(20),
    Street varchar(20)
);

CREATE TABLE Products(
    Tracking_number varchar(20) PRIMARY KEY,
    Name_of_product TEXT UNIQUE NOT NULL ,
    Type_of_product TEXT NOT NULL ,
    Manufacturer_name TEXT NOT NULL ,
    Price INTEGER NOT NULL
);

CREATE TABLE Shop(
    Shop_Id INTEGER PRIMARY KEY,
    Shop_name VARCHAR(20) NOT NULL,
    Country varchar(20) NOT NULL,
    City varchar(20) NOT NULL,
    Street varchar(20) NOT NULL
);

CREATE TABLE Inventory(
    ID_building INTEGER PRIMARY KEY,
    Num_of_products INTEGER NOT NULL ,
    Type_of_inventory TEXT NOT NULL ,
    Inventory_status BOOLEAN,
    Country varchar(20) NOT NULL,
    City varchar(20) NOT NULL ,
    Street varchar(20) NOT NULL
);

CREATE TABLE Payment(
    ID_customer INTEGER,
    Shop_ID INTEGER,
    Tracking_num VARCHAR(20),
    Type_of_payment TEXT NOT NULL,
    FOREIGN KEY (ID_customer) REFERENCES Customers(ID_customer)
);

CREATE TABLE Shipper(
    Shipper_ID INTEGER NOT NULL,
    ID_Warehouse INTEGER NOT NULL,
    Tracking_number VARCHAR(20) NOT NULL,
    FOREIGN KEY (Tracking_number) REFERENCES Products(Tracking_number),
    FOREIGN KEY (ID_Warehouse) REFERENCES Inventory(ID_building)
);

INSERT INTO Products(Tracking_number, Name_of_product, Type_of_product, Manufacturer_name, Price)
    VALUES (122345, 'TV 2000 SBE', 'TV', 'Samsung', 50000);
INSERT INTO Products(Tracking_number, Name_of_product, Type_of_product, Manufacturer_name, Price)
    VALUES (156445, 'WASH-II', 'Washing machine', 'Collen', 40000);
INSERT INTO Products(Tracking_number, Name_of_product, Type_of_product, Manufacturer_name, Price)
    VALUES (922436, 'SBL-12', 'Smartphone', 'Cruller', 20000);
INSERT INTO Products(Tracking_number, Name_of_product, Type_of_product, Manufacturer_name, Price)
    VALUES (749623, 'TV 21ER', 'TV', 'LG', 55000);
INSERT INTO Products(Tracking_number, Name_of_product, Type_of_product, Manufacturer_name, Price)
    VALUES (239341, 'ASW-10', 'Headphones', 'Samsung', 10000);
INSERT INTO Products(Tracking_number, Name_of_product, Type_of_product, Manufacturer_name, Price)
    VALUES (213441, 'FAD-IV', 'Headphones', 'Gerk', 7000);

INSERT INTO Customers(ID_customer, Name, Type_of_customer, Ranting, Phone_number)
    VALUES (1, 'Jonah', 'Regular', 0,  '8-727-876-12-44');
INSERT INTO Customers(ID_customer, Name, Type_of_customer, Ranting, Phone_number)
    VALUES (2, 'Alex', 'Regular', 20, '8-727-387-32-99');
INSERT INTO Customers(ID_customer, Name, Type_of_customer, Ranting, Phone_number)
    VALUES (3, 'Mary', 'Regular', 10, '8-727-981-02-10');

INSERT INTO Shop(Shop_Id, Shop_name, Country, City, Street)
    VALUES (1, 'Fairy', 'USA', 'California', 'Melno-street');
INSERT INTO Shop(Shop_Id, Shop_name, Country, City, Street)
    VALUES (2, 'Magic', 'USA', 'New-York', 'Delta-street');
INSERT INTO Shop(Shop_Id, Shop_name, Country, City, Street)
    VALUES (3, 'Hope', 'USA', 'Washington', 'Alpha-street');

INSERT INTO Inventory(ID_building, Num_of_products, Type_of_inventory, Inventory_status, Country, City, Street)
    VALUES (1, 453, 'Shop', FALSE, 'USA', 'California', 'Melno-street');
INSERT INTO Inventory(ID_building, Num_of_products, Type_of_inventory, Inventory_status, Country, City, Street)
    VALUES (2, 234, 'Shop', FALSE, 'USA', 'New-York', 'Delta-street');
INSERT INTO Inventory(ID_building, Num_of_products, Type_of_inventory, Inventory_status, Country, City, Street)
    VALUES (3, 978, 'Shop', FALSE, 'USA', 'Washington', 'Alpha-street');
INSERT INTO Inventory(ID_building, Num_of_products, Type_of_inventory, Inventory_status, Country, City, Street)
    VALUES (4, 3000, 'Warehouse', FALSE, 'USA', 'New-York', 'Jordon-street');
INSERT INTO Inventory(ID_building, Num_of_products, Type_of_inventory, Inventory_status, Country, City, Street)
    VALUES (5, 4000, 'Warehouse', FALSE, 'USA', 'California', 'Kellen-street');

INSERT INTO Payment(ID_customer, Shop_ID, Tracking_num, Type_of_payment)
    VALUES(1, 3, 156445, 'cash');
INSERT INTO Payment(ID_customer, Shop_ID, Tracking_num, Type_of_payment)
    VALUES(2, 2, 239341, 'cash');

INSERT INTO Sales_data(ID_sales, Name_of_product, Shop_name, Product_group, Season, Time_period, Country, City, Street)
    VALUES(1, 'WASH-II', 'Hope', 'Washing machine', 'Summer', '2012-03-22', 'USA', 'Washington', 'Alpha-street');
INSERT INTO Sales_data(ID_sales, Name_of_product, Shop_name, Product_group, Season, Time_period, Country, City, Street)
    VALUES(2, 'FAD-IV', 'Magic', 'Headphones', 'Autumn', '2012-03-01', 'USA', 'New-York', 'Delta-street');

--DROP TABLE Shipper;
--DROP TABLE Sales_data;
--DROP TABLE Shop;
--DROP TABLE Products;
--DROP TABLE Inventory;
--DROP TABLE Payment;
--DROP TABLE Customers;