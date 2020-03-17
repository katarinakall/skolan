--
-- Delete from database skolan.
-- By mos for course "XXX".
-- 2017-12-27
--

--
-- Delete rows from table
--
DELETE FROM larare WHERE fornamn = 'Hagrid';

--
-- Radera alla som jobbar på avdelningen DIPT (3 rader).
--
DELETE FROM larare WHERE avdelning = 'DIPT';


--
-- Radera alla som har en lön, men begränsa antalet rader som får raderas till
--2 (LIMIT) (2 rader påverkas).
--
DELETE FROM larare WHERE lon IS NOT NULL LIMIT 2;

--
-- Radera samtliga återstående lärare.
--
DELETE FROM larare;
