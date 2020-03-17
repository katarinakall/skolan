-- Add column to table
ALTER TABLE larare ADD COLUMN kompetens INT;

-- Ta bort kolumn
ALTER TABLE larare DROP COLUMN kompetens;

-- Add column to table with default value and constraint that kompetens can nor be null
ALTER TABLE larare ADD COLUMN kompetens INT NOT NULL DEFAULT 1;
