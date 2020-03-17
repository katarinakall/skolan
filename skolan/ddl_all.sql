USE skolan;

SET NAMES 'utf8';

-- Drop tables in order to avoid FK constraint
DROP TABLE IF EXISTS kurstillfalle;
DROP TABLE IF EXISTS kurs;
DROP TABLE IF EXISTS larare;
SHOW WARNINGS;
--
-- Create table: larare
--
DROP TABLE IF EXISTS larare;
CREATE TABLE larare
(
    akronym CHAR(3),
    avdelning CHAR(4),
    fornamn VARCHAR(20),
    efternamn VARCHAR(20),
    kon CHAR(1),
    lon INT,
    fodd DATE,
    kompetens INT DEFAULT 1 NOT NULL,

    PRIMARY KEY (akronym)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

CREATE TABLE `kurs`
(
    `kod` CHAR(6) NOT NULL,
    `namn` VARCHAR(40),
    `poang` FLOAT,
    `niva` CHAR(3),

    PRIMARY KEY(`kod`)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

CREATE TABLE `kurstillfalle`
(
    `id` INT AUTO_INCREMENT NOT NULL,
    `kurskod` CHAR(6) NOT NULL,
    `kursansvarig` CHAR(3) NOT NULL,
    `lasperiod` INT NOT NULL,

    PRIMARY KEY(`id`),
    FOREIGN KEY (kurskod) REFERENCES kurs(kod),
    FOREIGN KEY (kursansvarig) REFERENCES larare(akronym)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

--
-- Make copy of table
--
DROP TABLE IF EXISTS larare_pre;
CREATE TABLE larare_pre LIKE larare;
INSERT INTO larare_pre SELECT * FROM larare;

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

--
-- JOIN
--
SELECT
    l.akronym,
    l.lon,
    l.kompetens,
    p.lon AS "pre-lon",
    p.kompetens AS "pre-kompetens"
FROM larare AS l
    JOIN larare_pre AS p
        ON l.akronym = p.akronym
ORDER BY akronym
;

-- Deletes view if view exists
DROP VIEW IF EXISTS v_lonerevision
;

CREATE VIEW v_lonerevision AS
SELECT
    l.akronym,
    l.fornamn,
    l.efternamn,
    p.lon AS 'pre',
    l.lon AS 'nu',
    l.lon-p.lon AS 'diff',
    ROUND((((l.lon-p.lon)/p.lon) * 100), 2) AS 'proc',
    IF((((l.lon-p.lon)/p.lon) * 100) >= 3, 'ok', 'nok') AS 'mini',
    p.kompetens AS 'prekomp',
    l.kompetens AS 'nukomp',
    l.kompetens - p.kompetens AS 'diffkomp'
FROM larare AS l
JOIN larare_pre AS p
ON l.akronym = p.akronym
ORDER BY proc DESC
;
