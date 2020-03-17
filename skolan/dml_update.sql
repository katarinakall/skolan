--
-- Update a column value
--
UPDATE larare SET lon = 30000 WHERE akronym = 'gyl';

-- Sets salery to 30000 if akronym is 'gyl' or 'ala'
UPDATE larare
    SET
        lon = 30000
    WHERE
        akronym = 'gyl'
        OR akronym = 'ala'
;

-- Sets salery to 30000 if akronym is 'gyl' or 'ala'
UPDATE larare
    SET
        lon = 30000
    WHERE
        akronym IN ('gyl', 'ala')
;

--Updates salery where it is null
UPDATE larare
    SET
        lon = 30000
    WHERE
        lon IS NULL
;

-- Sums salery for all teachers
SELECT SUM(lon) AS 'Lönesumma', SUM(kompetens) AS Kompetens FROM larare;

-- Shows a table of teachers orderd by decending salery
SELECT akronym, avdelning, fornamn, kon, lon, kompetens
FROM larare
ORDER BY lon DESC;
