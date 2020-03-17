--
-- Setup a user, create a database and grant access for the user
-- to the database.
--

-- CREATE DATABASE skolan, but only if it does not exists;
CREATE DATABASE IF NOT EXISTS skolan;

-- Select skolan as your database
USE skolan;

-- -- Delete the database
-- DROP DATABASE skolan;
--
-- -- Show existing databases
-- SHOW DATABASES;

-- -- Show databases named someting like *skolan*
-- SHOW DATABASES LIKE "%skolan%";

-- Deletes user if user exists
 DROP USER IF EXISTS 'user'@'%';

-- Create the user 'user' with a backward compatible password algorithm
-- and the password 'pass'
CREATE USER IF NOT EXISTS 'user'@'%'
    IDENTIFIED WITH mysql_native_password
    BY 'pass'
;

---- Create the user 'user' with a backward compatible password algorithm
---- and the password 'pass'
--CREATE USER IF NOT EXISTS 'user'@'%'
--    IDENTIFIED
--    BY 'pass'
--;

-- Grant the user all privilegies on the database.
GRANT ALL PRIVILEGES
    ON skolan.*
    TO 'user'@'%'
;

-- -- ge fulla rättigheter till databasen "skolan"
-- -- när användaren loggar in från maskinen "localhost"
-- GRANT ALL ON skolan.* TO user@localhost IDENTIFIED BY 'pass';

-- Visa vad en användare kan göra mot vilken databas.
SHOW GRANTS FOR 'user'@'%';

-- -- Visa för nuvarande användare
-- SHOW GRANTS FOR CURRENT_USER;
