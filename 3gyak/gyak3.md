# 3. gyakorlat feladatok

## Database diagram

``` mermaid
erDiagram
    MEMBER 

    EVENT 

    PARTICIPANT 
    
    HEART 

    MEMBER ||--o{ PARTICIPANT : "attends"
    EVENT ||--o{ PARTICIPANT : "includes"
    MEMBER ||--o{ HEART : "gives"
    MEMBER ||--o{ HEART : "receives"
    EVENT ||--o{ HEART : "related to"

```

## SQL code
``` sql
CREATE TABLE dating.MEMBER (
    MemberID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Sex CHAR(1) NOT NULL CHECK (Sex IN ('F', 'M')),
    Email NVARCHAR(100)
);

CREATE TABLE dating.EVENT (
    EventID INT IDENTITY PRIMARY KEY,
    Address NVARCHAR(100) NOT NULL,
    EventDate DATETIME2 NOT NULL
);

CREATE TABLE dating.PARTICIPANT (
    MemberID INT NOT NULL,
    EventID INT NOT NULL,
    RegistrationDate DATETIME2 NOT NULL,
    PRIMARY KEY (MemberID, EventID),
    FOREIGN KEY (MemberID) REFERENCES dating.MEMBER(MemberID),
    FOREIGN KEY (EventID) REFERENCES dating.EVENT(EventID)
);

CREATE TABLE dating.HEART (
    FromMemberFk INT NOT NULL,
    ToMemberFk INT NOT NULL,
    HeartGiven BIT NOT NULL,
    EventID INT NOT NULL,
    PRIMARY KEY (FromMemberFk, ToMemberFk, EventID),
    FOREIGN KEY (FromMemberFk) REFERENCES dating.MEMBER(MemberID),
    FOREIGN KEY (ToMemberFk) REFERENCES dating.MEMBER(MemberID),
    FOREIGN KEY (EventID) REFERENCES dating.EVENT(EventID)
);
```

## ER diagram with fields, constraints

``` mermaid
erDiagram
    MEMBER {
        INT MemberID PK
        NVARCHAR Name "NOT NULL"
        CHAR(1) Sex "F: Female, M: Male" 
        NVARCHAR(100) Email
    }
    EVENT {
        INT EventID PK
        NVARCHAR Address "NOT NULL"
        DATETIME2 EventDate "NOT NULL"
    }
    PARTICIPANT {
        INT MemberID FK "NOT NULL"
        INT EventID FK "NOT NULL"
        DATETIME2 RegistrationDate "NOT NULL"
    }
    HEART {
        INT FromMemberFk Fk,Pk
        INT ToMemberFk Fk,Pk
        BIT HeartGiven "0: no match, 1: match"
        INT EventID FK "NOT NULL"
    }

    MEMBER ||--o{ PARTICIPANT : "attends"
    EVENT ||--o{ PARTICIPANT : "includes"
    MEMBER ||--o{ HEART : "gives"
    MEMBER ||--o{ HEART : "recieves"
    EVENT ||--o{ HEART : "related to"
```
