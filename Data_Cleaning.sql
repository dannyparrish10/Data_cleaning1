
-- Handle Missing Values
SET SQL_SAFE_UPDATES = 0;
update Data_Cleaning.dirty_cafe_sales
SET item = CASE
WHEN item = '' AND `Price Per Unit` = 2 THEN  'Coffee'
WHEN item = '' AND `Price Per Unit` = 1.5 THEN 'tea'
WHEN item = '' AND `Price Per Unit` = 4 THEN 'sandwhich'
WHEN item = '' AND `Price Per Unit` = 5 THEN'salad'
WHEN item = '' AND `Price Per Unit` = 3 THEN 'cake'
WHEN item = '' AND `Price Per Unit` = 1 THEN 'cookies' 
else item
END
WHERE item = '';

-- replacing unkown values and error
update Data_Cleaning.dirty_cafe_sales
SET item = CASE
WHEN item = 'UNKNOWN' THEN NULL
WHEN item = 'ERROR' THEN NULL
else item
END;

-- Checking 
SELECT * 
FROM Data_Cleaning.dirty_cafe_sales
WHERE item is NULL;
SELECT * 
FROM Data_Cleaning.dirty_cafe_sales
WHERE item = 'UNKNOWN' or 'ERROR';

UPDATE Data_Cleaning.dirty_cafe_sales
SET `Payment Method` = NULLIF(NULLIF(NULLIF(`Payment Method`, ''), 'UNKNOWN'), 'ERROR');
-- Checking 
SELECT `Payment Method` 
FROM Data_Cleaning.dirty_cafe_sales
WHERE trim(`Payment Method`) = 'UNKNOWN'
 OR trim(`Payment Method`)  = ''
 OR trim(`Payment Method`) = 'ERROR'; 

UPDATE Data_Cleaning.dirty_cafe_sales
SET Location = NULLIF(NULLIF(NULLIF( Location, ''), 'UNKNOWN'), 'ERROR');
-- Checking 
SELECT location
FROM Data_Cleaning.dirty_cafe_sales
WHERE trim(location) = 'UNKNOWN'
 OR trim(location)  = ''
 OR trim(location) = 'ERROR'; 

-- fix Date Consistency
UPDATE Data_Cleaning.dirty_cafe_sales
SET `Transaction Date` = NULLIF(NULLIF(NULLIF(`Transaction Date`, ''), 'UNKNOWN'), 'ERROR'),
`Transaction Date`= CASE WHEN str_to_date(`Transaction Date`,'%Y-%m-%d') IS NOT NULL THEN `Transaction Date`
ELSE  NULL 
END;

-- checking to make sure it worked 

SELECT `Transaction Date`
FROM Data_Cleaning.dirty_cafe_sales
WHERE (`Transaction Date`) = 'UNKNOWN'
 OR (`Transaction Date`)  = ''
 OR (`Transaction Date`) = 'ERROR'; 
 SET SQL_SAFE_UPDATES = 1