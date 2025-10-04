--Write test data

-- Tagok
INSERT INTO dating.MEMBER (Name, Sex, Email)
VALUES 
    (N'Anna Kovács', 'F', N'anna.kovacs@example.com'),
    (N'Béla Nagy', 'M', N'bela.nagy@example.com'),
    (N'Csilla Tóth', 'F', N'csilla.toth@example.com'),
    (N'Dávid Szabó', 'M', N'david.szabo@example.com');

-- Események
INSERT INTO dating.EVENT (Address, EventDate)
VALUES
    (N'Budapest, Andrássy út 10.', '2025-10-10 18:00:00'),
    (N'Debrecen, Piac utca 5.', '2025-11-15 19:00:00');

-- Résztvevők (mindegyik tag regisztrál az első eseményre, páran a másodikra is)
INSERT INTO dating.PARTICIPANT (MemberID, EventID, RegistrationDate)
VALUES
    (1, 1, SYSUTCDATETIME()),
    (2, 1, SYSUTCDATETIME()),
    (3, 1, SYSUTCDATETIME()),
    (4, 1, SYSUTCDATETIME()),

    (1, 2, SYSUTCDATETIME()),
    (2, 2, SYSUTCDATETIME());

-- Szívek (HEART)
-- Anna ad szívet Bélának az első eseményen
INSERT INTO dating.HEART (FromMemberFk, ToMemberFk, HeartGiven, EventID)
VALUES (1, 2, 1, 1);

-- Béla nem ad vissza szívet Annának az első eseményen
INSERT INTO dating.HEART (FromMemberFk, ToMemberFk, HeartGiven, EventID)
VALUES (2, 1, 0, 1);

-- Csilla ad szívet Dávidnak a második eseményen
INSERT INTO dating.HEART (FromMemberFk, ToMemberFk, HeartGiven, EventID)
VALUES (3, 4, 1, 2);
