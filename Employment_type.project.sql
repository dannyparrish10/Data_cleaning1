-- Which work type has better productivity score on average ?
-- On average which type of employment work the most hours. 
-- What is the average well being for remote workers and in-office workers?
-- Does working more hours leads to lower Well Being Score?
-- Does working more hour leads to higher productivity score?
-- What is the optimal work hoours per week for high well being score.
-- Q1)
SELECT Employment_Type, AVG(Productivity_Score) AS AVG_Productivity_score 
FROM Productivity_anaysis.remote_work_productivity
GROUP BY Employment_Type;
-- On Average Remote employment have Higher productivity score 
-- Q2) 
SELECT Employment_Type, AVG(Hours_Worked_Per_Week) AS Average_Hours_per_week
FROM Productivity_anaysis.remote_work_productivity
GROUP BY Employment_Type;
-- In-Office Employment work more hours 
-- Q3)
SELECT 
	AVG( CASE WHEN Employment_Type = "Remote" THEN Well_Being_Score END) AS AVG_Remote_well_being,
	AVG( CASE WHEN Employment_Type = "In-Office" THEN Well_Being_Score END) AS AVG_In_office_well_being
FROM Productivity_anaysis.remote_work_productivity
WHERE Hours_Worked_Per_Week > 40;
-- on average for the employees that work >40 hours, remore employees have higher welll being score.

SELECT COUNT(Employment_Type), Employment_Type
FROM Productivity_anaysis.remote_work_productivity
WHERE Hours_Worked_Per_Week >40
GROUP BY Employment_Type;
-- may need to check standard variation for this. 
-- Q4)
SELECT Hours_Worked_Per_Week,AVG(Well_Being_Score) AS AVERAGE_Well_being_score
FROM Productivity_anaysis.remote_work_productivity
GROUP BY Hours_Worked_Per_Week
ORDER BY Hours_Worked_Per_Week DESC;
-- Graphing might give a better answer for this question 
-- Q5)
SELECT Hours_Worked_Per_Week,AVG(Productivity_Score) AS AVERAGE_Productivity_Score
FROM Productivity_anaysis.remote_work_productivity
GROUP BY Hours_Worked_Per_Week
ORDER BY Hours_Worked_Per_Week DESC;
-- Better version of the query above 
SELECT 
	CASE 
    WHEN Hours_Worked_Per_Week < 20 THEN " Less then 20"
    WHEN Hours_Worked_Per_Week BETWEEN 20 and 39 THEN " Bettwen 20 and 39" 
    ELSE  '40 or more'
    END AS Hour_Category,
    AVG(Productivity_Score) AS Average_Productivity_Score
FROM 
   Productivity_anaysis.remote_work_productivity
GROUP BY 
    Hour_Category
ORDER BY 
    Hour_Category;
-- Q6)
SELECT 
	CASE 
    WHEN Hours_Worked_Per_Week < 20 THEN "less than 20"
    WHEN Hours_Worked_Per_Week BETWEEN 20 and 39 THEN " 20-39" 
    ELSE '40 or more'
    END AS Hours_category, 
    AVG(Well_Being_Score) AS average_well_being_Score
FROM 
Productivity_anaysis.remote_work_productivity
GROUP BY 
    Hours_category
ORDER BY 
    Hours_category;