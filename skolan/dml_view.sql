--Skapa en vy “v_larare” som innehåller samtliga kolumner från tabellen Lärare
--inklusive en ny kolumn med lärarens ålder

-- Deletes view if view exists
DROP VIEW IF EXISTS v_larare
;

-- Skapa vyn
CREATE VIEW v_larare AS
SELECT *, TIMESTAMPDIFF(YEAR, fodd, DATE(NOW())) AS 'Alder'
FROM larare
;


--Gör en SELECT-sats mot vyn som beräknar medelåldern på respektive avdelning.
--Visa avdelningens namn och medelålder sorterad på medelåldern
SELECT avdelning, ROUND(AVG(Alder)) AS 'Snittålder'
FROM v_larare
GROUP BY avdelning
ORDER BY Snittålder DESC
;
