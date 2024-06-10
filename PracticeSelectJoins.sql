
CREATE TABLE Area (
	id_area INT IDENTITY(1,1) PRIMARY KEY,
	name_area VARCHAR(255)
)
GO

CREATE TABLE Professor (
	id INT IDENTITY (1,1),
	name_professor VARCHAR(255),
	id_area INT,
	FOREIGN KEY (id_area) REFERENCES Area (id_area)

)
GO

INSERT INTO Area 
	(name_area)
VALUES
	('Civil'),
	('System'),
	('Mechatronics')
GO

INSERT INTO Professor
	(name_professor, id_area)
VALUES
	('Angel Garcia', 2),
	('Andrea Diaz', 1),
	('Rafael Perez', 3),
	('Alberto Molina', 2)
GO



ALTER TABLE Professor
ADD 
	age INT NULL;


UPDATE Professor
SET age = 
	CASE
		WHEN name_professor = 'Angel Garcia' THEN 34
		WHEN name_professor = 'Andrea Diaz' THEN 36
		WHEN name_professor = 'Rafael Perez' THEN 40
		WHEN name_professor = 'Alberto Molina' THEN 55
	END;


INSERT INTO Professor
	(name_professor, age)
VALUES
	('Hernesto', 63),
	('Bertolomeo', 80)



SELECT * 
FROM 
	Professor
	LEFT OUTER Join Area
		ON Professor.id_area = Area.id_area
;

INSERT INTO Area
	(name_area)
VALUES
	('Medicine'),
	('Theology')
;

SELECT 
	* 
FROM
	Professor
	FULL JOIN Area
		ON Professor.id_area = Area.id_area
;


SELECT * FROM Area WHERE name_area LIKE '%ys%'



SELECT 
	* 
FROM
	Professor
	INNER JOIN Area
		ON Professor.id_area = Area.id_area

WHERE Area.name_area = 'System' OR Area.name_area = 'Mechatronics'
;


SELECT 
	Area.name_area, COUNT(Professor.id) AS Number_Professor_Area
FROM
	Professor
	RIGHT JOIN Area
		ON Professor.id_area = Area.id_area

GROUP BY (Area.name_area)
ORDER BY (Number_Professor_Area) DESC
;


SELECT 
	Area.name_area, MAX(Professor.age) AS Max_Age
FROM
	Professor
	RIGHT JOIN Area
		ON Professor.id_area = Area.id_area

GROUP BY 
	(Area.name_area)

HAVING  
	AVG (Professor.age) >= 40

ORDER BY 
	(Max_Age) DESC, 
	(Area.name_area) ASC
;

SELECT * FROM dbo.View_1 
ORDER BY Number_Professor_Area DESC