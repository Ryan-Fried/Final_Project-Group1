CREATE VIEW indicators AS
	SELECT c.ctry_cd AS country_code,
		c.ctry_desc AS country,
		c.region,
		c.status,
		i.year,
		i.ind_cd AS indicator,
		i.ind_value AS value
	   FROM country c
		 JOIN infect_ctrl_prevent i ON i.ctry_cd = c.ctry_cd
	UNION
	 SELECT c.ctry_cd AS country_code,
		c.ctry_desc AS country,
		c.region,
		c.status,
		d.year,
		d.ind_cd AS indicator,
		d.ind_value AS value
	   FROM country c
		 JOIN disease d ON d.ctry_cd = c.ctry_cd
	UNION
	 SELECT c.ctry_cd AS country_code,
		c.ctry_desc AS country,
		c.region,
		c.status,
		h.year,
		h.ind_cd AS indicator,
		h.ind_value AS value
	   FROM country c
		 JOIN human_development h ON h.ctry_cd = c.ctry_cd
	UNION
	 SELECT c.ctry_cd AS country_code,
		c.ctry_desc AS country,
		c.region,
		c.status,
		s.year,
		s.ind_cd AS indicator,
		s.ind_value AS value
	   FROM country c
		 JOIN substance_abuse s ON s.ctry_cd = c.ctry_cd
	UNION
	 SELECT c.ctry_cd AS country_code,
		c.ctry_desc AS country,
		c.region,
		c.status,
		sd.year,
		sd.ind_cd AS indicator,
		sd.ind_value AS value
	   FROM country c
		 JOIN social_determinants sd ON sd.ctry_cd = c.ctry_cd;