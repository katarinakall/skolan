-- Deletes user if user exists
DROP USER IF EXISTS 'dbwebb'@'%';

--Create user 'dbwebb' with a backward compatible password algorithm
-- and the password 'password'
CREATE USER 'dbwebb'@'%'
IDENTIFIED
WITH mysql_native_password -- Only MySQL > 8.0.4
BY 'password'
;

--Gives user 'dbwebb' all privilegies on the database.
GRANT ALL PRIVILEGES
ON *.*
TO 'dbwebb'@'%'
WITH GRANT OPTION
;
