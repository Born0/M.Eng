Okay, with table names in plural and columns in singular like:

CREATE TABLE Users (
id VARCHAR(50) PRIMARY KEY,
name VARCHAR(100) NOT NULL,  
password VARCHAR(100) NOT NULL
);

CREATE TABLE PurchaseOrders ( 
id INT IDENTITY(1,1) PRIMARY KEY,
number VARCHAR(50) NOT NULL,   
entered_on DATE NOT NULL,
supplier_id INT NOT NULL,
FOREIGN KEY (supplier_id) REFERENCES Suppliers(id)
);

CREATE TABLE Suppliers (
id INT IDENTITY(1,1) PRIMARY KEY,
name VARCHAR(100) NOT NULL,
contact_info_id INT NOT NULL,
org_id INT NOT NULL,  
FOREIGN KEY (contact_info_id) REFERENCES Contacts(contact_info_id),
FOREIGN KEY (org_id) REFERENCES Organizations(id)  
);

CREATE TABLE Organizations (
id INT IDENTITY(1,1) PRIMARY KEY, 
name VARCHAR(100) NOT NULL,
contact_info_id INT NOT NULL,
FOREIGN KEY (contact_info_id) REFERENCES Contacts(contact_info_id)
);

CREATE TABLE PurchaseOrderDetails (
id INT IDENTITY(1,1) PRIMARY KEY,
po_id INT NOT NULL,
product_id INT NOT NULL, 
FOREIGN KEY (po_id) REFERENCES PurchaseOrders(id),
FOREIGN KEY (product_id) REFERENCES Products(id)
);

CREATE TABLE Products (
id INT IDENTITY(1,1) PRIMARY KEY,
name VARCHAR(100) NOT NULL,
code VARCHAR(50) NOT NULL,  
barcode VARCHAR(50) NOT NULL,
mrp NUMERIC(10,2) NOT NULL,
sale_price NUMERIC(10,2) NOT NULL,
img_path VARCHAR(200),
last_updated_on DATE,
last_updated_by INT,
uom_id INT,
FOREIGN KEY (last_updated_by) REFERENCES Users(id),
FOREIGN KEY (uom_id) REFERENCES UOMs(id)
);

CREATE TABLE UOMs (
id INT IDENTITY(1,1) PRIMARY KEY,
name VARCHAR(50) NOT NULL
);

CREATE TABLE Contacts ( 
contact_info_id INT IDENTITY(1,1) PRIMARY KEY,
name VARCHAR(100),
phone VARCHAR(15),
email VARCHAR(100)
);