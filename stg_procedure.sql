USE DWH;
GO

CREATE OR ALTER PROCEDURE PopulateStgPeopleTable
AS
BEGIN
    -- Ensure idempotency: Drop the table if it exists
	-- U specifies user tables
    IF OBJECT_ID('stg.People', 'U') IS NOT NULL
    BEGIN
        DROP TABLE stg.People;
    END;

    -- Create the stg.People table
    CREATE TABLE stg.People (
        PersonID INT,
        FirstName CHAR(20),
        LastName CHAR(20),
        Age FLOAT(20)
    );

    -- Insert data into stg.People by selecting from mrr.People
    INSERT INTO stg.People (PersonID, FirstName, LastName, Age)
    SELECT
        PersonID,
        FirstName,
        LastName,
        max(MRR.Age) AS Average_Age
    FROM
        mrr.People AS MRR
    WHERE
        MRR.FirstName IS NOT NULL
        AND MRR.LastName IS NOT NULL
    GROUP BY
        PersonID, FirstName, LastName;
END;
GO


EXEC PopulateStgPeopleTable
