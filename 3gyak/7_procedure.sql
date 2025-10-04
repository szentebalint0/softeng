CREATE OR ALTER PROCEDURE dating.RegisterParticipant
    @MemberID INT,
    @EventID INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Sex CHAR(1);

    -- Ellenőrizzük a tag nemét
    SELECT @Sex = Sex
    FROM dating.MEMBER
    WHERE MemberID = @MemberID;

    IF @Sex IS NULL
    BEGIN
        RAISERROR('A megadott MemberID nem létezik.', 16, 1);
        RETURN;
    END

    -- Megszámoljuk hány férfi/nő van már regisztrálva az eseményre
    DECLARE @CurrentCount INT;

    SELECT @CurrentCount = COUNT(*)
    FROM dating.PARTICIPANT p
    JOIN dating.MEMBER m ON p.MemberID = m.MemberID
    WHERE p.EventID = @EventID
      AND m.Sex = @Sex;

    -- Ha elérte a limitet
    IF (@CurrentCount >= 7)
    BEGIN
        RAISERROR('Nem lehet több mint 7 %s ezen az eseményen.', 16, 1) 
                  --CASE WHEN @Sex = 'M' THEN 'férfi' ELSE 'nő' END);
        RETURN;
    END

    -- Ha még nincs bent, regisztráljuk
    IF EXISTS (SELECT 1 FROM dating.PARTICIPANT 
               WHERE MemberID = @MemberID AND EventID = @EventID)
    BEGIN
        RAISERROR('Ez a tag már regisztrált erre az eseményre.', 16, 1);
        RETURN;
    END

    INSERT INTO dating.PARTICIPANT (MemberID, EventID, RegistrationDate)
    VALUES (@MemberID, @EventID, SYSUTCDATETIME());
END
