USE DWH;
GO

CREATE OR ALTER PROCEDURE UpsertDwhPeople
AS
BEGIN
    -- Ensure idempotency: Drop the table if it exists
	-- U specifies user tables
    IF OBJECT_ID('dwh.People', 'U') IS NOT NULL
    BEGIN
        DROP TABLE dwh.People;
    END;

    -- Create the dwh.People table
    CREATE TABLE dwh.People (
        PersonID INT,
        FirstName CHAR(20),
        LastName CHAR(20),
        Age FLOAT(20)
    );

    -- Perform UPSERT operation using MERGE
    MERGE dwh.People AS DWH
    USING stg.People AS STG
    ON DWH.PersonID = STG.PersonID
    WHEN MATCHED THEN
        UPDATE SET
            DWH.PersonID = STG.PersonID,
            DWH.FirstName = STG.FirstName,
            DWH.LastName = STG.LastName,
            DWH.Age = STG.Age
    WHEN NOT MATCHED THEN
        INSERT (
            PersonID,
            FirstName, 
            LastName,
            Age
        )
        VALUES (
            STG.PersonID,
            STG.FirstName,
            STG.LastName,
            STG.Age
        );
END;
GO

EXEC UpsertDwhPeople