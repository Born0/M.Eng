-- OrganizationCategory
INSERT INTO OrganizationCategories (code, description) VALUES ('RETAIL', 'Retail Store');
INSERT INTO OrganizationCategories (code, description) VALUES ('WHOLESALE', 'Wholesale Distributor');

-- Contacts
INSERT INTO Contacts (email2, phone2, country, region, city, address_line1, address_line2)
VALUES ('info@example.com', '+15551234567', 'USA', 'CA', 'Los Angeles', '123 Main St', 'Suite 456');

-- Organizations
INSERT INTO Organizations (org_category_id, name, contact_id) VALUES (1, 'Example Retail Store', 1);

-- Users (Customers and Employees)
INSERT INTO Users (org_id, first_name, last_name, primary_email, primary_phone, password, contact_id, is_discontinued, is_deleted)
VALUES (1, 'John', 'Doe', 'john.doe@example.com', '+15559876543', 'securepassword', 1, 0, 0); -- Salesperson/Employee

INSERT INTO Users (org_id, first_name, last_name, primary_email, primary_phone, password, contact_id, is_discontinued, is_deleted)
VALUES (1, 'Jane', 'Smith', 'jane.smith@example.com', '+15551112222', 'securepassword', NULL, 0, 0); -- Customer

-- UOMs
INSERT INTO UOMs (org_id, code, description) VALUES (1, 'EACH', 'Each');
INSERT INTO UOMs (org_id, code, description) VALUES (1, 'KG', 'Kilogram');
INSERT INTO UOMs (org_id, code, description) VALUES (1, 'L', 'Liter');

-- ProductCategories
INSERT INTO ProductCategories (parent_id, code, description, uom_id) VALUES (NULL, 'FOOD', 'Food Items', 1);
INSERT INTO ProductCategories (parent_id, code, description, uom_id) VALUES (1, 'SNACKS', 'Snacks', 1);
INSERT INTO ProductCategories (parent_id, code, description, uom_id) VALUES (1, 'DRINKS', 'Drinks', 3);


-- Products
INSERT INTO Products (org_id, product_category_id, code, barcode, mrp, sale_price) VALUES (1, 2, 'CHIPS', '1234567890', 2.00, 1.80);
INSERT INTO Products (org_id, product_category_id, code, barcode, mrp, sale_price) VALUES (1, 3, 'SODA', '9876543210', 1.50, 1.25);


-- Purchases
INSERT INTO Purchases (org_id, code, supplier_id, grand_total_amount, purchase_date, inserted_by) VALUES (1, 'P001', 1, 100.00, GETDATE(), 1); -- John Doe made the purchase

-- PurchaseDetails
INSERT INTO PurchaseDetails (purchase_id, product_id, uom_id, purchase_price, quantity, total_amount, inserted_by) VALUES (1, 1, 1, 1.50, 50, 75.00, 1);
INSERT INTO PurchaseDetails (purchase_id, product_id, uom_id, purchase_price, quantity, total_amount, inserted_by) VALUES (1, 2, 1, 1.00, 25, 25.00, 1);

-- StockDetails
INSERT INTO StockDetails (product_id, purchase_details_id, quantity, unit_cost, inserted_by) VALUES (1, 1, 50, 1.50, 1);
INSERT INTO StockDetails (product_id, purchase_details_id, quantity, unit_cost, inserted_by) VALUES (2, 2, 25, 1.00, 1);

-- Discounts
INSERT INTO Discounts (discount_class, type, value, description) VALUES ('store_sale', 'Percentage', 10, '10% off storewide sale');

-- DiscountOnProducts
INSERT INTO DiscountOnProducts (product_id, discount_id, start_date, end_date) VALUES (1, 1, GETDATE(), DATEADD(day, 7, GETDATE()));

-- PaymentTypes
INSERT INTO PaymentTypes (code, description) VALUES ('CASH', 'Cash');
INSERT INTO PaymentTypes (code, description) VALUES ('CARD', 'Card');

-- SalesOrders
INSERT INTO SalesOrders (buyer_id, sales_man_id, total_amount, total_discount, grand_total_amount, payment_type, sales_date, inserted_by)
VALUES (2, 1, 20.00, 2.00, 18.00, 1, GETDATE(), 1);  -- Jane Smith bought, John Doe sold

-- SalesOrderDetails
INSERT INTO SalesOrderDetails (sales_order_id, product_id, unit_price, quantity, subtotal_amount, discount_id, discount_amount, total_amount, inserted_by)
VALUES (1, 1, 1.80, 10, 18.00, 1, 2.00, 16.00, 1); -- 10 chips with 10% discount


-- SalesReturns
INSERT INTO SalesReturns (sales_order_id, return_date, reason, total_amount, inserted_by) VALUES (1, GETDATE(), 'Defective product', 5.00, 1);

-- SalesReturnDetails
INSERT INTO SalesReturnDetails (sales_return_id, sales_order_detail_id, product_id, returned_quantity, refund_amount, inserted_by)
VALUES (1, 1, 1, 2, 3.60, 1);  -- Return 2 chips


-- PurchaseReturns
INSERT INTO PurchaseReturns (purchase_id, return_date, reason, total_amount, inserted_by) VALUES (1, GETDATE(), 'Damaged goods', 10.00, 1);


-- PurchaseReturnDetails
INSERT INTO PurchaseReturnDetails (purchase_return_id, purchase_detail_id, product_id, returned_quantity, refund_amount, inserted_by)
VALUES (1, 1, 1, 5, 7.50, 1);


-- TransactionTypes
INSERT INTO TransactionTypes (code, description) VALUES ('SALE', 'Sales Transaction');
INSERT INTO TransactionTypes (code, description) VALUES ('PURCHASE', 'Purchase Transaction');

-- Finance
INSERT INTO Finance (org_id, user_id, sales_order_id, transaction_type, amount, inserted_by) VALUES (1, 2, 1, 1, 18.00, 1); -- Sale transaction
INSERT INTO Finance (org_id, user_id, purchase_id, transaction_type, amount, inserted_by) VALUES (1, 1, 1, 2, 100.00, 1); -- Purchase transaction