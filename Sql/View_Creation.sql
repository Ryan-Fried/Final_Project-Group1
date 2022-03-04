DROP VIEW indicators;

CREATE VIEW indicators AS
SELECT c.ctry_cd AS Country_Code,
	   c.ctry_desc AS Country,
	   c.status AS Status,
	   i.year AS Year,
	   i.ind_cd AS Indicator,
	   i.ind_value AS Value	
FROM country AS c
INNER JOIN infect_ctrl_prevent AS i
ON i.ctry_cd= c.ctry_cd
UNION
SELECT c.ctry_cd AS Country_Code,
	   c.ctry_desc AS Country,
	   c.status AS Status,
	   d.year AS Year,
	   d.ind_cd AS Indicator,
	   d.ind_value AS Value	 
FROM country AS c
INNER JOIN disease AS d
ON d.ctry_cd= c.ctry_cd
UNION
SELECT c.ctry_cd AS Country_Code,
	   c.ctry_desc AS Country,
	   c.status AS Status,
	   h.year AS Year,
	   h.ind_cd AS Indicator,
	   h.ind_value AS Value	 
FROM country AS c
INNER JOIN human_development AS h
ON h.ctry_cd= c.ctry_cd
UNION
SELECT c.ctry_cd AS Country_Code,
	   c.ctry_desc AS Country,
	   c.status AS Status,
	   s.year AS Year,
	   s.ind_cd AS Indicator,
	   s.ind_value AS Value	
FROM country AS c
INNER JOIN substance_abuse AS s
ON s.ctry_cd= c.ctry_cd
UNION
SELECT c.ctry_cd AS Country_Code,
	   c.ctry_desc AS Country,
	   c.status AS Status,
	   sd.year AS Year,
	   sd.ind_cd AS Indicator,
	   sd.ind_value AS Value	 
FROM country AS c
INNER JOIN social_determinants AS sd
ON sd.ctry_cd= c.ctry_cd;

select * from indicators;

