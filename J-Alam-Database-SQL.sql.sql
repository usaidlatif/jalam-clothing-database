-- ============================================================
-- J.ALAM DATABASE
-- CREATE TABLE + INSERT INTO STATEMENTS
-- Oracle SQL — Following Lab Manual Format
-- ============================================================
-- IMPORTANT: Run tables in this exact order due to Foreign Keys:
-- 1.  Supplier
-- 2.  Customer
-- 3.  Product
-- 4.  ProductStitched
-- 5.  ProductUnstitched
-- 6.  PaymentMethodDetail
-- 7.  JOrder
-- 8.  OrderProduct
-- 9.  Delivery
-- 10. Payment
-- 11. ALTER TABLE Payment (add DeliveryID FK after Delivery exists)
-- 12. Defect
-- 13. Refund
-- ============================================================


-- ============================================================
-- TABLE 1: SUPPLIER
-- ============================================================

CREATE TABLE Supplier (
    SupplierID   VARCHAR2(5),
    SupplierName VARCHAR2(100) NOT NULL,
    CONSTRAINT Supplier_SupplierID_PK PRIMARY KEY (SupplierID)
);

INSERT INTO Supplier VALUES ('S01', 'Sapphire');
INSERT INTO Supplier VALUES ('S02', 'Khaadi');
INSERT INTO Supplier VALUES ('S03', 'Generation');
INSERT INTO Supplier VALUES ('S04', 'Ethnic by Outfitters');

COMMIT;


-- ============================================================
-- TABLE 2: CUSTOMER
-- ============================================================

CREATE TABLE Customer (
    CustomerID   VARCHAR2(5),
    FullName     VARCHAR2(100) NOT NULL,
    Phone        VARCHAR2(15)  NOT NULL,
    Address      VARCHAR2(255) NOT NULL,
    City         VARCHAR2(50)  NOT NULL,
    CustomerType VARCHAR2(10)  NOT NULL,
    CONSTRAINT Customer_CustomerID_PK    PRIMARY KEY (CustomerID),
    CONSTRAINT Customer_Phone_UQ         UNIQUE (Phone),
    CONSTRAINT Customer_CustomerType_CHK CHECK (CustomerType IN ('Old', 'New'))
);

INSERT INTO Customer VALUES ('C01', 'Ayesha Tariq',  '03001234567', 'House 12 Block B Gulberg III',    'Lahore',     'Old');
INSERT INTO Customer VALUES ('C02', 'Fatima Malik',  '03111234568', 'Flat 5 Clifton Block 4',          'Karachi',    'Old');
INSERT INTO Customer VALUES ('C03', 'Sara Hussain',  '03211234569', 'House 7 F-8 Markaz',              'Islamabad',  'Old');
INSERT INTO Customer VALUES ('C04', 'Zara Ahmed',    '03311234560', 'House 3 Hayatabad Phase 2',       'Peshawar',   'New');
INSERT INTO Customer VALUES ('C05', 'Hina Baig',     '03421234561', 'Flat 9 Bahria Town Phase 4',      'Rawalpindi', 'Old');
INSERT INTO Customer VALUES ('C06', 'Sana Qureshi',  '03501234562', 'House 22 DHA Phase 6',            'Lahore',     'Old');
INSERT INTO Customer VALUES ('C07', 'Maria Iqbal',   '03021234563', 'Flat 2 North Nazimabad Block H',  'Karachi',    'New');
INSERT INTO Customer VALUES ('C08', 'Nadia Raza',    '03121234564', 'House 45 G-10 Markaz',            'Islamabad',  'Old');
INSERT INTO Customer VALUES ('C09', 'Asma Khan',     '03221234565', 'House 8 Model Town',              'Lahore',     'New');
INSERT INTO Customer VALUES ('C10', 'Rabia Ali',     '03321234566', 'Flat 11 Defence Phase 2',         'Karachi',    'Old');
INSERT INTO Customer VALUES ('C11', 'Ume Kulsoom',   '03401234570', 'House 6 Johar Town',              'Lahore',     'New');
INSERT INTO Customer VALUES ('C12', 'Bushra Noor',   '03451234571', 'Flat 14 Gulshan-e-Iqbal Block 3', 'Karachi',    'Old');
INSERT INTO Customer VALUES ('C13', 'Amna Siddiqui', '03061234572', 'House 18 E-7 Islamabad',          'Islamabad',  'New');
INSERT INTO Customer VALUES ('C14', 'Rida Farooq',   '03161234573', 'House 9 Saddar Cantonment',       'Rawalpindi', 'Old');
INSERT INTO Customer VALUES ('C15', 'Maham Riaz',    '03261234574', 'Flat 3 Bahria Town Precinct 12',  'Karachi',    'New');
INSERT INTO Customer VALUES ('C16', 'Iqra Shahid',   '03361234575', 'House 33 Cavalry Ground',         'Lahore',     'Old');
INSERT INTO Customer VALUES ('C17', 'Nimra Javed',   '03461234576', 'House 5 Satellite Town',          'Rawalpindi', 'New');
INSERT INTO Customer VALUES ('C18', 'Kiran Nasir',   '03071234577', 'Flat 7 F-11 Markaz',              'Islamabad',  'Old');
INSERT INTO Customer VALUES ('C19', 'Sadia Pervaiz', '03171234578', 'House 2 Wapda Town Phase 1',      'Lahore',     'New');
INSERT INTO Customer VALUES ('C20', 'Maryam Zahid',  '03271234579', 'Flat 6 Block 13 Gulshan',         'Karachi',    'Old');

COMMIT;


-- ============================================================
-- TABLE 3: PRODUCT
-- FIX: Stock renamed to ProductQuantity throughout
-- (After normalization: StitchedSize and UnstitchedPieces removed)
-- ============================================================

CREATE TABLE Product (
    ProductID       VARCHAR2(5),
    ProductName     VARCHAR2(100) NOT NULL,
    ClothingType    VARCHAR2(12)  NOT NULL,
    PurchasePrice   NUMBER(10,2)  NOT NULL,
    SellingPrice    NUMBER(10,2)  NOT NULL,
    ProductQuantity NUMBER(4)     NOT NULL,
    PurchaseDate    DATE          NOT NULL,
    SupplierID      VARCHAR2(5)   NOT NULL,
    CONSTRAINT Product_ProductID_PK       PRIMARY KEY (ProductID),
    CONSTRAINT Product_SupplierID_FK      FOREIGN KEY (SupplierID)    REFERENCES Supplier(SupplierID),
    CONSTRAINT Product_ClothingType_CHK   CHECK (ClothingType    IN ('Stitched', 'Unstitched')),
    CONSTRAINT Product_PurchasePrice_CHK  CHECK (PurchasePrice   > 0),
    CONSTRAINT Product_SellingPrice_CHK   CHECK (SellingPrice    > 0),
    CONSTRAINT Product_Quantity_CHK       CHECK (ProductQuantity >= 0)
);

-- ProductID, ProductName, ClothingType, PurchasePrice, SellingPrice, ProductQuantity, PurchaseDate, SupplierID
INSERT INTO Product VALUES ('P01', 'Sapphire Embroidered 3PC Lawn Suit', 'Unstitched', 5500, 7000,  8,  TO_DATE('12-02-2024','DD-MM-YYYY'), 'S01');
INSERT INTO Product VALUES ('P02', 'Sapphire Printed 2PC Lawn',          'Unstitched', 3800, 4800,  12, TO_DATE('12-02-2024','DD-MM-YYYY'), 'S01');
INSERT INTO Product VALUES ('P03', 'Sapphire Lawn Stitched Shirt',       'Stitched',   2800, 3500,  15, TO_DATE('15-02-2024','DD-MM-YYYY'), 'S01');
INSERT INTO Product VALUES ('P04', 'Sapphire Khaddar Stitched Kurta',    'Stitched',   2400, 3000,  10, TO_DATE('15-02-2024','DD-MM-YYYY'), 'S01');
INSERT INTO Product VALUES ('P05', 'Sapphire Winter Embroidered 1PC',    'Unstitched', 2200, 2800,  20, TO_DATE('20-02-2024','DD-MM-YYYY'), 'S01');
INSERT INTO Product VALUES ('P06', 'Khaadi Embroidered 3PC Khaddar',     'Unstitched', 6000, 7800,  6,  TO_DATE('03-03-2024','DD-MM-YYYY'), 'S02');
INSERT INTO Product VALUES ('P07', 'Khaadi Printed 2PC Lawn',            'Unstitched', 4000, 5200,  14, TO_DATE('03-03-2024','DD-MM-YYYY'), 'S02');
INSERT INTO Product VALUES ('P08', 'Khaadi Khaddar Stitched Kurta',      'Stitched',   3200, 4000,  9,  TO_DATE('05-03-2024','DD-MM-YYYY'), 'S02');
INSERT INTO Product VALUES ('P09', 'Khaadi Stitched Shirt',              'Stitched',   2600, 3300,  11, TO_DATE('05-03-2024','DD-MM-YYYY'), 'S02');
INSERT INTO Product VALUES ('P10', 'Khaadi Printed 1PC Dupatta',         'Unstitched', 1500, 2000,  25, TO_DATE('10-03-2024','DD-MM-YYYY'), 'S02');
INSERT INTO Product VALUES ('P11', 'Generation Embroidered 3PC',         'Unstitched', 4800, 6200,  7,  TO_DATE('18-03-2024','DD-MM-YYYY'), 'S03');
INSERT INTO Product VALUES ('P12', 'Generation Printed 1PC Dupatta',     'Unstitched', 1800, 2400,  18, TO_DATE('18-03-2024','DD-MM-YYYY'), 'S03');
INSERT INTO Product VALUES ('P13', 'Generation Stitched Linen Shirt',    'Stitched',   2500, 3200,  13, TO_DATE('20-03-2024','DD-MM-YYYY'), 'S03');
INSERT INTO Product VALUES ('P14', 'Generation Lawn 2PC Suit',           'Unstitched', 3500, 4500,  9,  TO_DATE('22-03-2024','DD-MM-YYYY'), 'S03');
INSERT INTO Product VALUES ('P15', 'Generation Stitched Formal Kurta',   'Stitched',   3000, 3800,  8,  TO_DATE('25-03-2024','DD-MM-YYYY'), 'S03');
INSERT INTO Product VALUES ('P16', 'Ethnic Printed Lawn 3PC',            'Unstitched', 3800, 4800,  10, TO_DATE('10-04-2024','DD-MM-YYYY'), 'S04');
INSERT INTO Product VALUES ('P17', 'Ethnic Embroidered 2PC',             'Unstitched', 3500, 4500,  12, TO_DATE('10-04-2024','DD-MM-YYYY'), 'S04');
INSERT INTO Product VALUES ('P18', 'Ethnic Stitched Casual Kurta',       'Stitched',   2000, 2600,  16, TO_DATE('12-04-2024','DD-MM-YYYY'), 'S04');
INSERT INTO Product VALUES ('P19', 'Ethnic Printed 1PC Shirt',           'Unstitched', 1600, 2100,  22, TO_DATE('12-04-2024','DD-MM-YYYY'), 'S04');
INSERT INTO Product VALUES ('P20', 'Ethnic Stitched Khaddar Kurta',      'Stitched',   2800, 3500,  7,  TO_DATE('15-04-2024','DD-MM-YYYY'), 'S04');
INSERT INTO Product VALUES ('P21', 'Sapphire Summer Printed 2PC',        'Unstitched', 4200, 5400,  11, TO_DATE('18-04-2024','DD-MM-YYYY'), 'S01');
INSERT INTO Product VALUES ('P22', 'Khaadi Summer Stitched Shirt',       'Stitched',   2700, 3400,  9,  TO_DATE('20-04-2024','DD-MM-YYYY'), 'S02');

COMMIT;


-- ============================================================
-- TABLE 4: PRODUCTSTITCHED
-- (New table after normalization — ProductID + StitchedSize only)
-- ============================================================

CREATE TABLE ProductStitched (
    ProductID    VARCHAR2(5),
    StitchedSize VARCHAR2(5) NOT NULL,
    CONSTRAINT ProductStitched_ProductID_PK PRIMARY KEY (ProductID),
    CONSTRAINT ProductStitched_ProductID_FK FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    CONSTRAINT ProductStitched_Size_CHK     CHECK (StitchedSize IN ('8', '10', '12', '14', '16'))
);

INSERT INTO ProductStitched VALUES ('P03', '10');
INSERT INTO ProductStitched VALUES ('P04', '12');
INSERT INTO ProductStitched VALUES ('P08', '14');
INSERT INTO ProductStitched VALUES ('P09', '8');
INSERT INTO ProductStitched VALUES ('P13', '16');
INSERT INTO ProductStitched VALUES ('P15', '10');
INSERT INTO ProductStitched VALUES ('P18', '10');
INSERT INTO ProductStitched VALUES ('P20', '12');
INSERT INTO ProductStitched VALUES ('P22', '14');

COMMIT;


-- ============================================================
-- TABLE 5: PRODUCTUNSTITCHED
-- (New table after normalization — ProductID + UnstitchedPieces only)
-- ============================================================

CREATE TABLE ProductUnstitched (
    ProductID        VARCHAR2(5),
    UnstitchedPieces VARCHAR2(10) NOT NULL,
    CONSTRAINT ProductUnstitched_ProductID_PK PRIMARY KEY (ProductID),
    CONSTRAINT ProductUnstitched_ProductID_FK FOREIGN KEY (ProductID)  REFERENCES Product(ProductID),
    CONSTRAINT ProductUnstitched_Pieces_CHK   CHECK (UnstitchedPieces IN ('1 Piece', '2 Piece', '3 Piece'))
);

INSERT INTO ProductUnstitched VALUES ('P01', '3 Piece');
INSERT INTO ProductUnstitched VALUES ('P02', '2 Piece');
INSERT INTO ProductUnstitched VALUES ('P05', '1 Piece');
INSERT INTO ProductUnstitched VALUES ('P06', '3 Piece');
INSERT INTO ProductUnstitched VALUES ('P07', '2 Piece');
INSERT INTO ProductUnstitched VALUES ('P10', '1 Piece');
INSERT INTO ProductUnstitched VALUES ('P11', '3 Piece');
INSERT INTO ProductUnstitched VALUES ('P12', '1 Piece');
INSERT INTO ProductUnstitched VALUES ('P14', '2 Piece');
INSERT INTO ProductUnstitched VALUES ('P16', '3 Piece');
INSERT INTO ProductUnstitched VALUES ('P17', '2 Piece');
INSERT INTO ProductUnstitched VALUES ('P19', '1 Piece');
INSERT INTO ProductUnstitched VALUES ('P21', '2 Piece');

COMMIT;


-- ============================================================
-- TABLE 6: PAYMENTMETHODDETAIL
-- (New table after normalization — maps PaymentMethod to AccountUsed)
-- ============================================================

CREATE TABLE PaymentMethodDetail (
    PaymentMethod VARCHAR2(10),
    AccountUsed   VARCHAR2(15) NOT NULL,
    CONSTRAINT PaymentMethodDetail_PK          PRIMARY KEY (PaymentMethod),
    CONSTRAINT PaymentMethodDetail_Method_CHK  CHECK (PaymentMethod IN ('Advance', 'COD', 'Cash')),
    CONSTRAINT PaymentMethodDetail_Account_CHK CHECK (AccountUsed   IN ('Account A', 'Account B'))
);

INSERT INTO PaymentMethodDetail VALUES ('Advance', 'Account A');
INSERT INTO PaymentMethodDetail VALUES ('COD',     'Account B');
INSERT INTO PaymentMethodDetail VALUES ('Cash',    'Account B');

COMMIT;


-- ============================================================
-- TABLE 7: JORDER
-- (Named JOrder because ORDER is a reserved word in Oracle)
-- ============================================================
-- TotalAmount Calculation Reference (OrderQuantity x SellingPrice):
-- O01: P03(1x3500)=3500
-- O02: P04(1x3000)=3000
-- O03: P08(1x4000)+P07(1x5200)=9200
-- O04: P09(1x3300)+P13(1x3200)=6500
-- O05: P03(1x3500)=3500
-- O06: P06(1x7800)=7800
-- O07: P18(1x2600)+P04(1x3000)=5600
-- O08: P04(1x3000)=3000
-- O09: P03(1x3500)=3500
-- O10: P08(1x4000)+P09(1x3300)=7300
-- O11: P06(1x7800)+P07(1x5200)=13000
-- O12: P13(1x3200)=3200
-- O13: P18(1x2600)=2600
-- O14: P08(2x4000)=8000
-- O15: P03(3x3500)+P04(1x3000)=13500
-- O16: P07(1x5200)=5200
-- O17: P09(1x3300)=3300
-- O18: P16(1x4800)=4800
-- O19: P13(1x3200)=3200
-- O20: P11(1x6200)=6200
-- O21: P06(1x7800)=7800
-- O22: P03(1x3500)=3500
-- O23: P08(2x4000)=8000
-- O24: P12(1x2400)=2400
-- O25: P17(1x4500)=4500
-- O26: P11(1x6200)=6200
-- O27: P18(2x2600)=5200
-- O28: P06(1x7800)=7800
-- O29: P03(1x3500)=3500
-- O30: P13(1x3200)=3200

CREATE TABLE JOrder (
    OrderID     VARCHAR2(5),
    OrderDate   DATE          NOT NULL,
    TotalAmount NUMBER(10,2)  NOT NULL,
    CustomerID  VARCHAR2(5)   NOT NULL,
    CONSTRAINT JOrder_OrderID_PK      PRIMARY KEY (OrderID),
    CONSTRAINT JOrder_CustomerID_FK   FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    CONSTRAINT JOrder_TotalAmount_CHK CHECK (TotalAmount > 0)
);

-- FIX: TotalAmount corrected to match OrderQuantity x SellingPrice exactly
INSERT INTO JOrder VALUES ('O01', TO_DATE('03-05-2024','DD-MM-YYYY'),  3500,  'C01');
INSERT INTO JOrder VALUES ('O02', TO_DATE('03-05-2024','DD-MM-YYYY'),  3000,  'C03');
INSERT INTO JOrder VALUES ('O03', TO_DATE('03-05-2024','DD-MM-YYYY'),  9200,  'C05');
INSERT INTO JOrder VALUES ('O04', TO_DATE('03-05-2024','DD-MM-YYYY'),  6500,  'C08');
INSERT INTO JOrder VALUES ('O05', TO_DATE('03-05-2024','DD-MM-YYYY'),  3500,  'C12');
INSERT INTO JOrder VALUES ('O06', TO_DATE('03-05-2024','DD-MM-YYYY'),  7800,  'C16');
INSERT INTO JOrder VALUES ('O07', TO_DATE('03-05-2024','DD-MM-YYYY'),  5600,  'C18');
INSERT INTO JOrder VALUES ('O08', TO_DATE('08-05-2024','DD-MM-YYYY'),  3000,  'C02');
INSERT INTO JOrder VALUES ('O09', TO_DATE('08-05-2024','DD-MM-YYYY'),  3500,  'C06');
INSERT INTO JOrder VALUES ('O10', TO_DATE('08-05-2024','DD-MM-YYYY'),  7300,  'C09');
INSERT INTO JOrder VALUES ('O11', TO_DATE('08-05-2024','DD-MM-YYYY'), 13000,  'C10');
INSERT INTO JOrder VALUES ('O12', TO_DATE('08-05-2024','DD-MM-YYYY'),  3200,  'C14');
INSERT INTO JOrder VALUES ('O13', TO_DATE('08-05-2024','DD-MM-YYYY'),  2600,  'C17');
INSERT INTO JOrder VALUES ('O14', TO_DATE('13-05-2024','DD-MM-YYYY'),  8000,  'C01');
INSERT INTO JOrder VALUES ('O15', TO_DATE('13-05-2024','DD-MM-YYYY'), 13500,  'C03');
INSERT INTO JOrder VALUES ('O16', TO_DATE('13-05-2024','DD-MM-YYYY'),  5200,  'C04');
INSERT INTO JOrder VALUES ('O17', TO_DATE('13-05-2024','DD-MM-YYYY'),  3300,  'C07');
INSERT INTO JOrder VALUES ('O18', TO_DATE('13-05-2024','DD-MM-YYYY'),  4800,  'C11');
INSERT INTO JOrder VALUES ('O19', TO_DATE('13-05-2024','DD-MM-YYYY'),  3200,  'C15');
INSERT INTO JOrder VALUES ('O20', TO_DATE('13-05-2024','DD-MM-YYYY'),  6200,  'C20');
INSERT INTO JOrder VALUES ('O21', TO_DATE('19-05-2024','DD-MM-YYYY'),  7800,  'C02');
INSERT INTO JOrder VALUES ('O22', TO_DATE('19-05-2024','DD-MM-YYYY'),  3500,  'C05');
INSERT INTO JOrder VALUES ('O23', TO_DATE('19-05-2024','DD-MM-YYYY'),  8000,  'C08');
INSERT INTO JOrder VALUES ('O24', TO_DATE('19-05-2024','DD-MM-YYYY'),  2400,  'C13');
INSERT INTO JOrder VALUES ('O25', TO_DATE('19-05-2024','DD-MM-YYYY'),  4500,  'C19');
INSERT INTO JOrder VALUES ('O26', TO_DATE('25-05-2024','DD-MM-YYYY'),  6200,  'C06');
INSERT INTO JOrder VALUES ('O27', TO_DATE('25-05-2024','DD-MM-YYYY'),  5200,  'C10');
INSERT INTO JOrder VALUES ('O28', TO_DATE('25-05-2024','DD-MM-YYYY'),  7800,  'C12');
INSERT INTO JOrder VALUES ('O29', TO_DATE('25-05-2024','DD-MM-YYYY'),  3500,  'C16');
INSERT INTO JOrder VALUES ('O30', TO_DATE('25-05-2024','DD-MM-YYYY'),  3200,  'C18');

COMMIT;


-- ============================================================
-- TABLE 8: ORDERPRODUCT (Associative Entity)
-- ============================================================

CREATE TABLE OrderProduct (
    OrderID       VARCHAR2(5),
    ProductID     VARCHAR2(5),
    OrderQuantity NUMBER(4) NOT NULL,
    CONSTRAINT OrderProduct_PK           PRIMARY KEY (OrderID, ProductID),
    CONSTRAINT OrderProduct_OrderID_FK   FOREIGN KEY (OrderID)   REFERENCES JOrder(OrderID),
    CONSTRAINT OrderProduct_ProductID_FK FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    CONSTRAINT OrderProduct_Quantity_CHK CHECK (OrderQuantity > 0)
);

INSERT INTO OrderProduct VALUES ('O01', 'P03', 1);
INSERT INTO OrderProduct VALUES ('O02', 'P04', 1);
INSERT INTO OrderProduct VALUES ('O03', 'P08', 1);
INSERT INTO OrderProduct VALUES ('O03', 'P07', 1);
INSERT INTO OrderProduct VALUES ('O04', 'P09', 1);
INSERT INTO OrderProduct VALUES ('O04', 'P13', 1);
INSERT INTO OrderProduct VALUES ('O05', 'P03', 1);
INSERT INTO OrderProduct VALUES ('O06', 'P06', 1);
INSERT INTO OrderProduct VALUES ('O07', 'P18', 1);
INSERT INTO OrderProduct VALUES ('O07', 'P04', 1);
INSERT INTO OrderProduct VALUES ('O08', 'P04', 1);
INSERT INTO OrderProduct VALUES ('O09', 'P03', 1);
INSERT INTO OrderProduct VALUES ('O10', 'P08', 1);
INSERT INTO OrderProduct VALUES ('O10', 'P09', 1);
INSERT INTO OrderProduct VALUES ('O11', 'P06', 1);
INSERT INTO OrderProduct VALUES ('O11', 'P07', 1);
INSERT INTO OrderProduct VALUES ('O12', 'P13', 1);
INSERT INTO OrderProduct VALUES ('O13', 'P18', 1);
INSERT INTO OrderProduct VALUES ('O14', 'P08', 2);
INSERT INTO OrderProduct VALUES ('O15', 'P03', 3);
INSERT INTO OrderProduct VALUES ('O15', 'P04', 1);
INSERT INTO OrderProduct VALUES ('O16', 'P07', 1);
INSERT INTO OrderProduct VALUES ('O17', 'P09', 1);
INSERT INTO OrderProduct VALUES ('O18', 'P16', 1);
INSERT INTO OrderProduct VALUES ('O19', 'P13', 1);
INSERT INTO OrderProduct VALUES ('O20', 'P11', 1);
INSERT INTO OrderProduct VALUES ('O21', 'P06', 1);
INSERT INTO OrderProduct VALUES ('O22', 'P03', 1);
INSERT INTO OrderProduct VALUES ('O23', 'P08', 2);
INSERT INTO OrderProduct VALUES ('O24', 'P12', 1);
INSERT INTO OrderProduct VALUES ('O25', 'P17', 1);
INSERT INTO OrderProduct VALUES ('O26', 'P11', 1);
INSERT INTO OrderProduct VALUES ('O27', 'P18', 2);
INSERT INTO OrderProduct VALUES ('O28', 'P06', 1);
INSERT INTO OrderProduct VALUES ('O29', 'P03', 1);
INSERT INTO OrderProduct VALUES ('O30', 'P13', 1);

COMMIT;


-- ============================================================
-- TABLE 9: DELIVERY
-- (Created before Payment so DeliveryID FK can be added to Payment)
-- ============================================================

CREATE TABLE Delivery (
    DeliveryID     VARCHAR2(5),
    TrackingNumber VARCHAR2(20) NOT NULL,
    DeliveryStatus VARCHAR2(10) NOT NULL,
    DeliveryDate   DATE,
    OrderID        VARCHAR2(5)  NOT NULL,
    CONSTRAINT Delivery_DeliveryID_PK PRIMARY KEY (DeliveryID),
    CONSTRAINT Delivery_OrderID_UQ    UNIQUE (OrderID),
    CONSTRAINT Delivery_OrderID_FK    FOREIGN KEY (OrderID) REFERENCES JOrder(OrderID),
    CONSTRAINT Delivery_Status_CHK    CHECK (DeliveryStatus IN ('Delivered', 'Pending'))
);

INSERT INTO Delivery VALUES ('D01', 'TCS-2024-05001', 'Delivered', TO_DATE('08-05-2024','DD-MM-YYYY'), 'O01');
INSERT INTO Delivery VALUES ('D02', 'TCS-2024-05002', 'Delivered', TO_DATE('08-05-2024','DD-MM-YYYY'), 'O02');
INSERT INTO Delivery VALUES ('D03', 'TCS-2024-05003', 'Delivered', TO_DATE('09-05-2024','DD-MM-YYYY'), 'O03');
INSERT INTO Delivery VALUES ('D04', 'TCS-2024-05004', 'Delivered', TO_DATE('09-05-2024','DD-MM-YYYY'), 'O04');
INSERT INTO Delivery VALUES ('D05', 'TCS-2024-05005', 'Delivered', TO_DATE('09-05-2024','DD-MM-YYYY'), 'O06');
INSERT INTO Delivery VALUES ('D06', 'TCS-2024-05006', 'Delivered', TO_DATE('10-05-2024','DD-MM-YYYY'), 'O07');
INSERT INTO Delivery VALUES ('D07', 'TCS-2024-05007', 'Delivered', TO_DATE('14-05-2024','DD-MM-YYYY'), 'O08');
INSERT INTO Delivery VALUES ('D08', 'TCS-2024-05008', 'Delivered', TO_DATE('14-05-2024','DD-MM-YYYY'), 'O09');
INSERT INTO Delivery VALUES ('D09', 'TCS-2024-05009', 'Delivered', TO_DATE('14-05-2024','DD-MM-YYYY'), 'O11');
INSERT INTO Delivery VALUES ('D10', 'TCS-2024-05010', 'Delivered', TO_DATE('15-05-2024','DD-MM-YYYY'), 'O12');
INSERT INTO Delivery VALUES ('D11', 'TCS-2024-05011', 'Delivered', TO_DATE('19-05-2024','DD-MM-YYYY'), 'O14');
INSERT INTO Delivery VALUES ('D12', 'TCS-2024-05012', 'Delivered', TO_DATE('19-05-2024','DD-MM-YYYY'), 'O15');
INSERT INTO Delivery VALUES ('D13', 'TCS-2024-05013', 'Pending',   NULL,                               'O18');
INSERT INTO Delivery VALUES ('D14', 'TCS-2024-05014', 'Delivered', TO_DATE('20-05-2024','DD-MM-YYYY'), 'O20');
INSERT INTO Delivery VALUES ('D15', 'TCS-2024-05015', 'Pending',   NULL,                               'O21');
INSERT INTO Delivery VALUES ('D16', 'TCS-2024-05016', 'Pending',   NULL,                               'O22');
INSERT INTO Delivery VALUES ('D17', 'TCS-2024-05017', 'Pending',   NULL,                               'O23');
INSERT INTO Delivery VALUES ('D18', 'TCS-2024-05018', 'Pending',   NULL,                               'O26');
INSERT INTO Delivery VALUES ('D19', 'TCS-2024-05019', 'Pending',   NULL,                               'O27');
INSERT INTO Delivery VALUES ('D20', 'TCS-2024-05020', 'Pending',   NULL,                               'O28');
INSERT INTO Delivery VALUES ('D21', 'TCS-2024-05021', 'Pending',   NULL,                               'O30');

COMMIT;


-- ============================================================
-- TABLE 10: PAYMENT
-- FIX: CustomerID removed (transitive dependency through OrderID)
-- FIX: Delivery table created first so DeliveryID FK added via ALTER TABLE below
-- ============================================================

CREATE TABLE Payment (
    PaymentID     VARCHAR2(6),
    PaymentMethod VARCHAR2(10) NOT NULL,
    PaymentDate   DATE         NOT NULL,
    PaymentStatus VARCHAR2(10) NOT NULL,
    OrderID       VARCHAR2(5)  NOT NULL,
    DeliveryID    VARCHAR2(5),
    CONSTRAINT Payment_PaymentID_PK      PRIMARY KEY (PaymentID),
    CONSTRAINT Payment_OrderID_UQ        UNIQUE (OrderID),
    CONSTRAINT Payment_PaymentMethod_FK  FOREIGN KEY (PaymentMethod) REFERENCES PaymentMethodDetail(PaymentMethod),
    CONSTRAINT Payment_OrderID_FK        FOREIGN KEY (OrderID)       REFERENCES JOrder(OrderID),
    CONSTRAINT Payment_PaymentStatus_CHK CHECK (PaymentStatus IN ('Received', 'Pending'))
);

-- FIX: CustomerID removed from all INSERT statements
-- (CustomerID retrieved via JOIN: Payment -> JOrder -> CustomerID)
INSERT INTO Payment VALUES ('PM01', 'COD',     TO_DATE('10-05-2024','DD-MM-YYYY'), 'Received', 'O01', 'D01');
INSERT INTO Payment VALUES ('PM02', 'COD',     TO_DATE('10-05-2024','DD-MM-YYYY'), 'Received', 'O02', 'D02');
INSERT INTO Payment VALUES ('PM03', 'COD',     TO_DATE('10-05-2024','DD-MM-YYYY'), 'Received', 'O03', 'D03');
INSERT INTO Payment VALUES ('PM04', 'COD',     TO_DATE('10-05-2024','DD-MM-YYYY'), 'Received', 'O04', 'D04');
INSERT INTO Payment VALUES ('PM05', 'Advance', TO_DATE('03-05-2024','DD-MM-YYYY'), 'Received', 'O05', NULL);
INSERT INTO Payment VALUES ('PM06', 'COD',     TO_DATE('10-05-2024','DD-MM-YYYY'), 'Received', 'O06', 'D05');
INSERT INTO Payment VALUES ('PM07', 'COD',     TO_DATE('10-05-2024','DD-MM-YYYY'), 'Received', 'O07', 'D06');
INSERT INTO Payment VALUES ('PM08', 'COD',     TO_DATE('15-05-2024','DD-MM-YYYY'), 'Received', 'O08', 'D07');
INSERT INTO Payment VALUES ('PM09', 'COD',     TO_DATE('15-05-2024','DD-MM-YYYY'), 'Received', 'O09', 'D08');
INSERT INTO Payment VALUES ('PM10', 'Advance', TO_DATE('08-05-2024','DD-MM-YYYY'), 'Received', 'O10', NULL);
INSERT INTO Payment VALUES ('PM11', 'COD',     TO_DATE('15-05-2024','DD-MM-YYYY'), 'Received', 'O11', 'D09');
INSERT INTO Payment VALUES ('PM12', 'COD',     TO_DATE('15-05-2024','DD-MM-YYYY'), 'Received', 'O12', 'D10');
INSERT INTO Payment VALUES ('PM13', 'Advance', TO_DATE('08-05-2024','DD-MM-YYYY'), 'Received', 'O13', NULL);
INSERT INTO Payment VALUES ('PM14', 'COD',     TO_DATE('20-05-2024','DD-MM-YYYY'), 'Received', 'O14', 'D11');
INSERT INTO Payment VALUES ('PM15', 'COD',     TO_DATE('20-05-2024','DD-MM-YYYY'), 'Received', 'O15', 'D12');
INSERT INTO Payment VALUES ('PM16', 'Advance', TO_DATE('13-05-2024','DD-MM-YYYY'), 'Received', 'O16', NULL);
INSERT INTO Payment VALUES ('PM17', 'Advance', TO_DATE('13-05-2024','DD-MM-YYYY'), 'Received', 'O17', NULL);
INSERT INTO Payment VALUES ('PM18', 'COD',     TO_DATE('20-05-2024','DD-MM-YYYY'), 'Pending',  'O18', 'D13');
INSERT INTO Payment VALUES ('PM19', 'Advance', TO_DATE('13-05-2024','DD-MM-YYYY'), 'Received', 'O19', NULL);
INSERT INTO Payment VALUES ('PM20', 'COD',     TO_DATE('20-05-2024','DD-MM-YYYY'), 'Received', 'O20', 'D14');
INSERT INTO Payment VALUES ('PM21', 'COD',     TO_DATE('26-05-2024','DD-MM-YYYY'), 'Pending',  'O21', 'D15');
INSERT INTO Payment VALUES ('PM22', 'COD',     TO_DATE('26-05-2024','DD-MM-YYYY'), 'Pending',  'O22', 'D16');
INSERT INTO Payment VALUES ('PM23', 'COD',     TO_DATE('26-05-2024','DD-MM-YYYY'), 'Pending',  'O23', 'D17');
INSERT INTO Payment VALUES ('PM24', 'Cash',    TO_DATE('19-05-2024','DD-MM-YYYY'), 'Received', 'O24', NULL);
INSERT INTO Payment VALUES ('PM25', 'Advance', TO_DATE('19-05-2024','DD-MM-YYYY'), 'Received', 'O25', NULL);
INSERT INTO Payment VALUES ('PM26', 'COD',     TO_DATE('01-06-2024','DD-MM-YYYY'), 'Pending',  'O26', 'D18');
INSERT INTO Payment VALUES ('PM27', 'COD',     TO_DATE('01-06-2024','DD-MM-YYYY'), 'Pending',  'O27', 'D19');
INSERT INTO Payment VALUES ('PM28', 'COD',     TO_DATE('01-06-2024','DD-MM-YYYY'), 'Pending',  'O28', 'D20');
INSERT INTO Payment VALUES ('PM29', 'Cash',    TO_DATE('25-05-2024','DD-MM-YYYY'), 'Received', 'O29', NULL);
INSERT INTO Payment VALUES ('PM30', 'COD',     TO_DATE('01-06-2024','DD-MM-YYYY'), 'Pending',  'O30', 'D21');

COMMIT;


-- ============================================================
-- FIX 4: ALTER TABLE — Add DeliveryID Foreign Key to Payment
-- (Done after both Payment and Delivery tables are created)
-- ============================================================

ALTER TABLE Payment
ADD CONSTRAINT Payment_DeliveryID_FK
FOREIGN KEY (DeliveryID) REFERENCES Delivery(DeliveryID);


-- ============================================================
-- TABLE 11: DEFECT
-- FIX: DF01 description corrected to match P09 which is size 8
-- ============================================================

CREATE TABLE Defect (
    DefectID          VARCHAR2(5),
    DefectDescription VARCHAR2(255) NOT NULL,
    DefectDate        DATE          NOT NULL,
    OrderID           VARCHAR2(5)   NOT NULL,
    ProductID         VARCHAR2(5)   NOT NULL,
    CONSTRAINT Defect_DefectID_PK  PRIMARY KEY (DefectID),
    CONSTRAINT Defect_OrderID_FK   FOREIGN KEY (OrderID)   REFERENCES JOrder(OrderID),
    CONSTRAINT Defect_ProductID_FK FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- FIX: DF01 description changed from "ordered size 12, received size 14"
--      to "ordered size 8, received size 10" to match P09 (Khaadi Stitched Shirt, size 8)
INSERT INTO Defect VALUES ('DF01', 'Wrong size delivered - ordered size 8, received size 10',        TO_DATE('11-05-2024','DD-MM-YYYY'), 'O04', 'P09');
INSERT INTO Defect VALUES ('DF02', 'Fabric torn at seam on Khaadi Embroidered 3PC Khaddar',          TO_DATE('12-05-2024','DD-MM-YYYY'), 'O06', 'P06');
INSERT INTO Defect VALUES ('DF03', 'Missing piece - 3PC suit had only 2 pieces in parcel',           TO_DATE('21-05-2024','DD-MM-YYYY'), 'O15', 'P03');
INSERT INTO Defect VALUES ('DF04', 'Color fading - product not matching live session display',       TO_DATE('22-05-2024','DD-MM-YYYY'), 'O14', 'P08');
INSERT INTO Defect VALUES ('DF05', 'Wrong item delivered - received Generation instead of Khaadi',  TO_DATE('23-05-2024','DD-MM-YYYY'), 'O11', 'P06');

COMMIT;


-- ============================================================
-- TABLE 12: REFUND
-- FIX: RefundAmount corrected to defective product price only
--      (not full order total — J.Alam refunds per defective product)
-- FIX: RefundAccount removed (normalization fix — transitive dependency)
-- ============================================================

CREATE TABLE Refund (
    RefundID     VARCHAR2(5),
    RefundDate   DATE         NOT NULL,
    RefundAmount NUMBER(10,2) NOT NULL,
    RefundStatus VARCHAR2(10) NOT NULL,
    DefectID     VARCHAR2(5)  NOT NULL,
    PaymentID    VARCHAR2(6)  NOT NULL,
    CONSTRAINT Refund_RefundID_PK  PRIMARY KEY (RefundID),
    CONSTRAINT Refund_DefectID_FK  FOREIGN KEY (DefectID)  REFERENCES Defect(DefectID),
    CONSTRAINT Refund_PaymentID_FK FOREIGN KEY (PaymentID) REFERENCES Payment(PaymentID),
    CONSTRAINT Refund_Amount_CHK   CHECK (RefundAmount > 0),
    CONSTRAINT Refund_Status_CHK   CHECK (RefundStatus IN ('Processed', 'Pending'))
);

-- FIX: RefundAmount = SellingPrice of defective product only
-- R01: P09 SellingPrice = 3300 (not full O04 total of 6500)
-- R02: P06 SellingPrice = 7800 (O06 had only P06 so same)
-- R03: P03 SellingPrice = 3500 (not full O15 total of 13500)
-- R04: P08 SellingPrice = 4000 (not full O14 total of 8000 — O14 had 2x P08)
-- R05: P06 SellingPrice = 7800 (O11 had P06 and P07 — refund only for P06)
INSERT INTO Refund VALUES ('R01', TO_DATE('14-05-2024','DD-MM-YYYY'), 3300, 'Processed', 'DF01', 'PM04');
INSERT INTO Refund VALUES ('R02', TO_DATE('15-05-2024','DD-MM-YYYY'), 7800, 'Processed', 'DF02', 'PM06');
INSERT INTO Refund VALUES ('R03', TO_DATE('24-05-2024','DD-MM-YYYY'), 3500, 'Pending',   'DF03', 'PM15');
INSERT INTO Refund VALUES ('R04', TO_DATE('26-05-2024','DD-MM-YYYY'), 4000, 'Pending',   'DF04', 'PM14');
INSERT INTO Refund VALUES ('R05', TO_DATE('28-05-2024','DD-MM-YYYY'), 7800, 'Pending',   'DF05', 'PM11');

COMMIT;


-- ============================================================
-- VERIFICATION QUERIES
-- ============================================================

SELECT * FROM Supplier;
SELECT * FROM Customer;
SELECT * FROM Product;
SELECT * FROM ProductStitched;
SELECT * FROM ProductUnstitched;
SELECT * FROM PaymentMethodDetail;
SELECT * FROM JOrder;
SELECT * FROM OrderProduct;
SELECT * FROM Delivery;
SELECT * FROM Payment;
SELECT * FROM Defect;
SELECT * FROM Refund;


-- ============================================================
-- USEFUL JOIN QUERIES
-- ============================================================

-- Get CustomerID from Payment (since CustomerID removed from Payment)
SELECT P.PaymentID, P.PaymentMethod, J.CustomerID
FROM Payment P, JOrder J
WHERE P.OrderID = J.OrderID;

-- Get AccountUsed from Payment (since AccountUsed removed from Payment)
SELECT P.PaymentID, P.PaymentMethod, PM.AccountUsed
FROM Payment P, PaymentMethodDetail PM
WHERE P.PaymentMethod = PM.PaymentMethod;

-- Get RefundAccount for any refund
SELECT R.RefundID, R.RefundAmount, PM.AccountUsed
FROM Refund R, Payment P, PaymentMethodDetail PM
WHERE R.PaymentID = P.PaymentID
AND   P.PaymentMethod = PM.PaymentMethod;

-- Get StitchedSize for any stitched product
SELECT P.ProductID, P.ProductName, PS.StitchedSize
FROM Product P, ProductStitched PS
WHERE P.ProductID = PS.ProductID;

-- Get UnstitchedPieces for any unstitched product
SELECT P.ProductID, P.ProductName, PU.UnstitchedPieces
FROM Product P, ProductUnstitched PU
WHERE P.ProductID = PU.ProductID;


-- ============================================================
-- END OF SCRIPT
-- ============================================================
