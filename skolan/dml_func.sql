--Skriv en SELECT-sats som skriver ut förnamn + efternamn + avdelning i samma
--kolumn enligt följande struktur: förnamn efternamn (avdelning).
SELECT CONCAT_WS(' ', fornamn, efternamn, CONCAT('(', avdelning, ')'))
FROM larare
;

--Gör om samma sak men skriv ut avdelningens namn med små bokstäver och begränsa
--utskriften till 3 rader
SELECT CONCAT_WS(' ', fornamn, efternamn, LCASE(CONCAT('(', avdelning, ')')))
FROM larare
LIMIT 3
;

--Skriv en SELECT-sats som endast visar dagens datum.
SELECT DATE(NOW())
;

--Gör en SELECT-sats som visar samtliga lärare, deras födelseår samt dagens datum och klockslag.
SELECT fornamn, fodd, DATE(NOW()), TIME(NOW())
FROM larare
;


--Skriv en SELECT-sats som beräknar lärarens ålder, sortera rapporten för att visa vem som är äldst och yngst
SELECT fornamn, fodd, TIMESTAMPDIFF(YEAR, fodd, DATE(NOW())) as 'Alder'
FROM larare
ORDER BY Alder DESC
;


--Visa de lärare som är födda på 40-talet.
SELECT fornamn, fodd
FROM larare
WHERE YEAR(fodd) >= 1940 AND YEAR(fodd) < 1950
