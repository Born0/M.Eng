-- General Tables

CREATE TABLE OrganizationCategories (
    id INT PRIMARY KEY IDENTITY(1,1),
    code VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    inserted_on DATETIME DEFAULT GETDATE(),
    updated_on DATETIME DEFAULT GETDATE()
);

CREATE TABLE Contacts (
    id INT PRIMARY KEY IDENTITY(1,1),
    email2 VARCHAR(255),
    phone2 VARCHAR(50),
    country VARCHAR(50),
    region VARCHAR(50),
    city VARCHAR(50),
    address_line1 VARCHAR(255),
    address_line2 VARCHAR(255),
    inserted_on DATETIME DEFAULT GETDATE(),
    updated_on DATETIME DEFAULT GETDATE()
);

CREATE TABLE Organizations (
    id INT PRIMARY KEY IDENTITY(1,1),
    org_category_id INT REFERENCES OrganizationCategories(id),
    name VARCHAR(255) NOT NULL,
    contact_id INT REFERENCES Contacts(id),
    inserted_on DATETIME DEFAULT GETDATE(),
    updated_on DATETIME DEFAULT GETDATE()
);

CREATE TABLE Users (
    id INT PRIMARY KEY IDENTITY(1,1),
    org_id INT REFERENCES Organizations(id),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    full_name AS (first_name + ' ' + last_name),  -- Computed column
    primary_email VARCHAR(255),
    primary_phone VARCHAR(50),
    password VARCHAR(255) NOT NULL,  -- Store securely (hashing recommended)
    contact_id INT REFERENCES Contacts(id),
    is_discontinued BIT DEFAULT 0,
    is_deleted BIT DEFAULT 0,
    inserted_on DATETIME DEFAULT GETDATE(),
    updated_on DATETIME DEFAULT GETDATE()
);


CREATE TABLE UOMs (  -- Units of Measure
    id INT PRIMARY KEY IDENTITY(1,1),
    org_id INT REFERENCES Organizations(id),
    code VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    inserted_on DATETIME DEFAULT GETDATE(),
    updated_on DATETIME DEFAULT GETDATE()
);


-- Products

CREATE TABLE ProductCategories (
    id INT PRIMARY KEY IDENTITY(1,1),
    parent_id INT REFERENCES ProductCategories(id), -- Self-referencing for hierarchy
    code VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    uom_id INT REFERENCES UOMs(id),  -- Corrected to uom_id
    inserted_on DATETIME DEFAULT GETDATE(),
    updated_on DATETIME DEFAULT GETDATE()
);


CREATE TABLE Products (
    id INT PRIMARY KEY IDENTITY(1,1),
    org_id INT REFERENCES Organizations(id),
    product_category_id INT REFERENCES ProductCategories(id),
    code VARCHAR(50) NOT NULL,
    barcode VARCHAR(50) UNIQUE,
    mrp DECIMAL(19,4) NOT NULL,
    sale_price DECIMAL(19,4) NOT NULL,
    inserted_on DATETIME DEFAULT GETDATE(),
    updated_on DATETIME DEFAULT GETDATE()
);



-- Purchases

CREATE TABLE Purchases (
    id INT PRIMARY KEY IDENTITY(1,1),
    org_id INT REFERENCES Organizations(id),
    code VARCHAR(50) NOT NULL,  -- Consider making this auto-generated
    supplier_id INT REFERENCES Users(id), -- Assuming suppliers are also users
    grand_total_amount DECIMAL(19,4) NOT NULL,
    purchase_date DATETIME,  -- Added purchase date
    inserted_on DATETIME DEFAULT GETDATE(),
    updated_on DATETIME DEFAULT GETDATE(),
    inserted_by INT REFERENCES Users(id),
    updated_by INT REFERENCES Users(id)
);




CREATE TABLE PurchaseDetails (
    id INT PRIMARY KEY IDENTITY(1,1),
    purchase_id INT REFERENCES Purchases(id),
    product_id INT REFERENCES Products(id),
    uom_id INT REFERENCES UOMs(id), -- Using uom_id
    purchase_price DECIMAL(19,4) NOT NULL,
    quantity INT NOT NULL,
    total_amount DECIMAL(19,4) NOT NULL,
    inserted_on DATETIME DEFAULT GETDATE(),
    updated_on DATETIME DEFAULT GETDATE(),
    inserted_by INT REFERENCES Users(id),
    updated_by INT REFERENCES Users(id)
);


-- Stock

CREATE TABLE StockDetails (
    id INT PRIMARY KEY IDENTITY(1,1),
    product_id INT REFERENCES Products(id),
    purchase_details_id INT REFERENCES PurchaseDetails(id),
    quantity INT NOT NULL,
    unit_cost DECIMAL(19,4) NOT NULL,
    inserted_on DATETIME DEFAULT GETDATE(),
    updated_on DATETIME DEFAULT GETDATE(),
    inserted_by INT REFERENCES Users(id),
    updated_by INT REFERENCES Users(id)
);



-- Discounts

CREATE TABLE Discounts (
    id INT PRIMARY KEY IDENTITY(1,1),
    discount_class VARCHAR(50) CHECK (discount_class IN ('coupon_code', 'store_sale')), -- Enforce valid values
    type VARCHAR(50) CHECK (type IN ('Percentage', 'Fixed Amount')), -- Enforce valid values
    value DECIMAL(19,4) NOT NULL,
    description VARCHAR(255),
    inserted_on DATETIME DEFAULT GETDATE(),
    updated_on DATETIME DEFAULT GETDATE()
);


CREATE TABLE DiscountOnProducts (
    id INT PRIMARY KEY IDENTITY(1,1), -- Added an ID for this table
    product_id INT REFERENCES Products(id),
    discount_id INT REFERENCES Discounts(id),
    start_date DATE,
    end_date DATE,
    inserted_on DATETIME DEFAULT GETDATE(),
    updated_on DATETIME DEFAULT GETDATE()

);

-- Sales

CREATE TABLE PaymentTypes (
    id INT PRIMARY KEY IDENTITY(1,1), -- Added an ID
    code VARCHAR(50) NOT NULL,
    description VARCHAR(255) CHECK (description IN ('Cash', 'Card', 'Other')), -- Enforce valid values
    inserted_on DATETIME DEFAULT GETDATE(),
    updated_on DATETIME DEFAULT GETDATE()
);


CREATE TABLE SalesOrders (
    id INT PRIMARY KEY IDENTITY(1,1),
    buyer_id INT REFERENCES Users(id),  -- Customers are also users
    sales_man_id INT REFERENCES Users(id), -- Salesperson
    total_amount DECIMAL(19,4) NOT NULL,
    total_discount DECIMAL(19,4) DEFAULT 0,  -- Allow for zero discount
    grand_total_amount DECIMAL(19,4) NOT NULL,
    payment_type INT REFERENCES PaymentTypes(id), -- Corrected foreign key
    sales_date DATETIME, -- Added sales date
    inserted_on DATETIME DEFAULT GETDATE(),
    updated_on DATETIME DEFAULT GETDATE(),
    inserted_by INT REFERENCES Users(id),
    updated_by INT REFERENCES Users(id)
);



CREATE TABLE SalesOrderDetails (
    id INT PRIMARY KEY IDENTITY(1,1),
    sales_order_id INT REFERENCES SalesOrders(id),
    product_id INT REFERENCES Products(id),
    unit_price DECIMAL(19,4) NOT NULL,
    quantity INT NOT NULL,
    subtotal_amount DECIMAL(19,4) NOT NULL,
    discount_id INT REFERENCES Discounts(id),
    discount_amount DECIMAL(19,4),       -- Added discount amount
    total_amount DECIMAL(19,4) NOT NULL, -- Total after discount
    inserted_on DATETIME DEFAULT GETDATE(),
    updated_on DATETIME DEFAULT GETDATE(),
    inserted_by INT REFERENCES Users(id),
    updated_by INT REFERENCES Users(id)
);


-- Returns

CREATE TABLE SalesReturns (
    id INT PRIMARY KEY IDENTITY(1,1),
    sales_order_id INT REFERENCES SalesOrders(id),
    return_date DATETIME NOT NULL,
    reason VARCHAR(255),
    total_amount DECIMAL(19,4) NOT NULL,
    inserted_on DATETIME DEFAULT GETDATE(),
    updated_on DATETIME DEFAULT GETDATE(),
    inserted_by INT REFERENCES Users(id),
    updated_by INT REFERENCES Users(id)
);



CREATE TABLE SalesReturnDetails (
    id INT PRIMARY KEY IDENTITY(1,1),
    sales_return_id INT REFERENCES SalesReturns(id),
    sales_order_detail_id INT REFERENCES SalesOrderDetails(id),
    product_id INT REFERENCES Products(id),
    returned_quantity INT NOT NULL,
    refund_amount DECIMAL(19,4) NOT NULL,
    inserted_on DATETIME DEFAULT GETDATE(),
    updated_on DATETIME DEFAULT GETDATE(),
    inserted_by INT REFERENCES Users(id),
    updated_by INT REFERENCES Users(id)
);



CREATE TABLE PurchaseReturns (
    id INT PRIMARY KEY IDENTITY(1,1),
    purchase_id INT REFERENCES Purchases(id),
    return_date DATETIME NOT NULL,
    reason VARCHAR(255),
    total_amount DECIMAL(19,4) NOT NULL,
    inserted_on DATETIME DEFAULT GETDATE(),
    updated_on DATETIME DEFAULT GETDATE(),
    inserted_by INT REFERENCES Users(id),
    updated_by INT REFERENCES Users(id)
);


CREATE TABLE PurchaseReturnDetails (
    id INT PRIMARY KEY IDENTITY(1,1),
    purchase_return_id INT REFERENCES PurchaseReturns(id),
    purchase_detail_id INT REFERENCES PurchaseDetails(id),
    product_id INT REFERENCES Products(id),
    returned_quantity INT NOT NULL,
    refund_amount DECIMAL(19,4) NOT NULL,
    inserted_on DATETIME DEFAULT GETDATE(),
    updated_on DATETIME DEFAULT GETDATE(),
    inserted_by INT REFERENCES Users(id),
    updated_by INT REFERENCES Users(id)
);




-- Finance

CREATE TABLE TransactionTypes (
    id INT PRIMARY KEY IDENTITY(1,1),  -- Added an ID
    code VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    inserted_on DATETIME DEFAULT GETDATE(),
    updated_on DATETIME DEFAULT GETDATE()
);



CREATE TABLE Finance (
    id INT PRIMARY KEY IDENTITY(1,1),
    org_id INT REFERENCES Organizations(id),
    user_id INT REFERENCES Users(id), -- Combined pay_to/receive_from
    sales_order_id INT REFERENCES SalesOrders(id),
    purchase_id INT REFERENCES Purchases(id),
    transaction_type INT REFERENCES TransactionTypes(id), -- Corrected foreign key
    amount DECIMAL(19,4) NOT NULL,
    due_date DATE,
    inserted_on DATETIME DEFAULT GETDATE(),
    updated_on DATETIME DEFAULT GETDATE(),
    inserted_by INT REFERENCES Users(id),
    updated_by INT REFERENCES Users(id)
);