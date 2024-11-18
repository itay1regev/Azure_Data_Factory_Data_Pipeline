use Hospital_DB;
GO

CREATE OR ALTER PROCEDURE CreateAndPopulatePeopleTable
AS
BEGIN
	BEGIN
	DROP TABLE IF EXISTS People;
	END;

	CREATE TABLE People (
		PersonID INT,
		FirstName CHAR(20),
		LastName CHAR(20),
		Age FLOAT(20)
	);


	INSERT INTO People
		VALUES  (1, 'Desirae','Leonard', 25),
				(2, 'Desirae','David', 29) ;

END;
GO

