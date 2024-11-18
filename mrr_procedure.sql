USE DWH;
GO

CREATE OR ALTER PROCEDURE CreateAndPopulatePeopleTable
AS
BEGIN
    -- Ensure idempotency: Drop the table if it exists
	-- Checks if the table mrr.People exists 
	-- (U specifies user tables).
    IF OBJECT_ID('mrr.People', 'U') IS NOT NULL
    BEGIN
        DROP TABLE mrr.People;
    END;

    -- Create the table
    CREATE TABLE mrr.People (
        PersonID INT,
        FirstName CHAR(20),
        LastName CHAR(20),
        Age FLOAT(20)
    );

	-- insert values into the table
	INSERT INTO mrr.People (PersonID, FirstName, LastName, Age)
	SELECT PersonID, FirstName, LastName, Age
	FROM dbo.src_people;

END;
GO


EXEC CreateAndPopulatePeopleTable

