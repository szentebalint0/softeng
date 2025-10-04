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