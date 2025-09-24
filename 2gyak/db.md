# Database documentation
## Model

```mermaid
erDiagram

Customer {
    INT CustomerSk PK "auto_inceremnt"
    NVARCHAR(100) Name
    NVARCHAR(100) ContactPerson
    NVARCHAR(50) TaxNumber
    NVARCHAR(20) PhoneNumber
    NVARCHAR(100) Email
    NVARCHAR(200) BillingAddress
    BIT IsCompany
}

Product {
    INT ProductSk PK
    CHAR(16) EAN
    NVARCHAR(50) ProductName
    NVARCHAR(MAX) Description
    DECIMAL NetPrice
    DECIMAL VatPercent
    DECIMAL GrossPrice
    INT CategoryFk FK
}

Category {
    INT CategorySk PK
    NVARCHAR(50) CategoryName
    INT ParentCategoryFk FK
}

ProductPriceHistory {
    INT ProductPriceHistorySk PK
    INT ProductFk FK
    DECIMAL NetPrice
    DECIMAL VatPercent
    DATETIME2 ChangeDateUTC
}

Order {
    INT OrderSk PK
    INT CustomerFk FK 
    DATETIME2 OrderDate
    BIT IsCancelled
}

OrderDetail {
    INT OrderDetailSk PK
    INT OrderFk FK
    INT ProductFk FK
    INT Quantity
    DECIMAL NetPrice
    DECIMAL VatPercent
    INT AddressFk 
}

Address{
    INT AddressSk Pk
    INT CustomerFk
    INT PostCode
    NVARCHAR(50) City
    NVARCHAR(50) Street
    NVARCHAR(10) Detail  
}



%% ===== Kapcsolatok =====

Customer ||--o{ Order : "places"

Order ||--|{ OrderDetail : "contains"

OrderDetail }o--|| Product : "refers to"

Product ||--o{ ProductPriceHistory : "has price history"

Product }o--|| Category : "belongs to"

Category ||--o{ Category : "sub-category"

Customer ||--o{ Address : "has"

Address ||--o{ OrderDetail : "refers to"
```

## Database table creation code
``` sql
USE webshop;
GO
CREATE TABLE Customer (
    CustomerSk INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    ContactPerson NVARCHAR(100),
    TaxNumber NVARCHAR(50),
    PhoneNumber NVARCHAR(20),
    Email NVARCHAR(100) NOT NULL UNIQUE,
    BillingAddress NVARCHAR(200) NOT NULL,
    IsCompany BIT
);

CREATE TABLE Category (
    CategorySk INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(50) NOT NULL,
    ParentCategoryFk INT NULL REFERENCES Category(CategorySk)
);

CREATE TABLE Product (
    ProductSk INT IDENTITY(1,1) PRIMARY KEY,
    EAN CHAR(16),
    ProductName NVARCHAR(50) NOT NULL,
    Description NVARCHAR(MAX),
    NetPrice DECIMAL(18,2) NOT NULL CHECK (NetPrice >= 0),
    VatPercent INT NOT NULL CHECK (VatPercent BETWEEN 0 AND 100),
    GrossPrice DECIMAL(18,2) NOT NULL CHECK (GrossPrice >= 0),
    Stock INT NOT NULL CHECK (Stock >= 0),
    CategoryFk INT NOT NULL REFERENCES Category(CategorySk)
);

CREATE TABLE ProductPriceHistory (
    ProductPriceHistorySk INT IDENTITY(1,1) PRIMARY KEY,
    ProductFk INT NOT NULL REFERENCES Product(ProductSk),
    NetPrice DECIMAL(18,2) NOT NULL CHECK (NetPrice >= 0),
    VatPercent INT NOT NULL CHECK (VatPercent BETWEEN 0 AND 100),
    ChangeDateUTC DATETIME2 NOT NULL
);

CREATE TABLE Address (
    AddressSk INT IDENTITY(1,1) PRIMARY KEY,
    CustomerFk INT NOT NULL REFERENCES Customer(CustomerSk),
    PostCode INT NOT NULL,
    City NVARCHAR(50) NOT NULL,
    Street NVARCHAR(50) NOT NULL,
    Detail NVARCHAR(10) NOT NULL
);

CREATE TABLE [Order] (
    OrderSk INT IDENTITY(1,1) PRIMARY KEY,
    CustomerFk INT NOT NULL REFERENCES Customer(CustomerSk),
    OrderDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    DiscountPercent INT NOT NULL DEFAULT 0 CHECK (DiscountPercent BETWEEN 0 AND 100),
    TotalAmount DECIMAL(18,2) NULL,
    IsCancelled BIT
);

CREATE TABLE OrderDetail (
    OrderDetailSk INT IDENTITY(1,1) PRIMARY KEY,
    OrderFk INT NOT NULL REFERENCES [Order](OrderSk),
    ProductFk INT NOT NULL REFERENCES Product(ProductSk),
    Quantity INT NOT NULL CHECK (Quantity >= 0),
    NetPrice DECIMAL(18,2) NOT NULL CHECK (NetPrice >= 0),
    VatPercent INT NOT NULL CHECK (VatPercent BETWEEN 0 AND 100),
    AddressFk INT NOT NULL REFERENCES Address(AddressSk)
);
```

## Category hierarchy


``` mermaid
graph TD
    A[Products]
    A --> B[Electronics]
    A --> C[Clothing]
    A --> D[Home & Garden]

    B --> E[Mobile Phones]
    B --> F[Laptops]
    B --> G[Cameras]

    C --> H[Men's Clothing]
    C --> I[Women's Clothing]
    C --> J[Accessories]

    D --> K[Furniture]
    D --> L[Kitchenware]
    D --> M[Gardening Tools]
```