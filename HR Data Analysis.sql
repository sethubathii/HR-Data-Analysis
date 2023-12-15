use [HR Data Analysis];

--1.Attrition Analysis:
-- What is the overall attrition rate in the company?

SELECT
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    COUNT(*) AS TotalEmployees,
    CAST(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS DECIMAL) / COUNT(*) * 100 AS AttritionRate
FROM ['HR data$'];

-- Is there a -significant difference in attrition rates between different age bands or departments?

SELECT
    [CF_age band],
    Department,
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    COUNT(*) AS TotalEmployees,
    CAST(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS DECIMAL) / COUNT(*) * 100 AS AttritionRate
FROM ['HR data$']
GROUP BY [CF_age band], Department;

-- Does the presence of overtime have any correlation with attrition?

SELECT
    [Over Time],
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    COUNT(*) AS TotalEmployees,
    CAST(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS DECIMAL) / COUNT(*) * 100 AS AttritionRate
FROM ['HR data$']
GROUP BY [Over Time];

--2. Employee Demographics:
-- What is the gender distribution among employees?

SELECT
    Gender,
    COUNT(*) AS TotalEmployees,
    CAST(COUNT(*) AS DECIMAL) / (SELECT COUNT(*) FROM ['HR data$']) * 100 AS GenderPercentage
FROM ['HR data$']
GROUP BY Gender;

-- Are there any differences in attrition rates based on education fields or levels?
SELECT
    [Education Field],
    [Education],
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    COUNT(*) AS TotalEmployees,
    CAST(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS DECIMAL) / COUNT(*) * 100 AS AttritionRate
FROM ['HR data$']
GROUP BY [Education Field], [Education];

--3. Job Role Analysis:
-- Which job roles have the highest and lowest attrition rates?

WITH JobRoleAttrition AS (
    SELECT
        [Job Role],
        COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS AttritionCount,
        COUNT(*) AS TotalEmployees,
        CAST(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS DECIMAL) / COUNT(*) * 100 AS AttritionRate
    FROM ['HR data$']
    GROUP BY [Job Role]
)

SELECT
    [Job Role],
    AttritionCount,
    TotalEmployees,
    AttritionRate
FROM JobRoleAttrition
ORDER BY AttritionRate DESC;

-- Do certain job roles require more training compared to others, and does that affect attrition?

WITH TrainingComparison AS (
    SELECT
        [Job Role],
        AVG([Training Times Last Year]) AS AvgTrainingTimes,
        COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS AttritionCount,
        COUNT(*) AS TotalEmployees,
        CAST(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS DECIMAL) / COUNT(*) * 100 AS AttritionRate
    FROM ['HR data$']
    GROUP BY [Job Role]
)

SELECT
    TC.[Job Role],
    TC.AvgTrainingTimes,
    TC.AttritionCount,
    TC.TotalEmployees,
    TC.AttritionRate
FROM TrainingComparison TC
ORDER BY TC.AvgTrainingTimes DESC;

--4. Employee Performance and Satisfaction:
--Is there a relationship between performance ratings and attrition rates?

SELECT
    [Performance Rating],
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    COUNT(*) AS TotalEmployees,
    CAST(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS DECIMAL) / COUNT(*) * 100 AS AttritionRate
FROM ['HR data$']
GROUP BY [Performance Rating];

--How does employee satisfaction (environment satisfaction, job satisfaction, relationship satisfaction) impact attrition?

SELECT
    [Environment Satisfaction],
    [Job Satisfaction],
    [Relationship Satisfaction],
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    COUNT(*) AS TotalEmployees,
    CAST(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS DECIMAL) / COUNT(*) * 100 AS AttritionRate
FROM ['HR data$']
GROUP BY [Environment Satisfaction], [Job Satisfaction], [Relationship Satisfaction];

--5. Work-Life Balance and Employee Tenure:
--Does work-life balance impact the number of years an employee stays with the company?

-- Work-life balance impact on employee tenure
SELECT
    [Work Life Balance],
    AVG([Years At Company]) AS AvgYearsAtCompany
FROM ['HR data$']
GROUP BY [Work Life Balance];

--Is there any correlation between the total working years and attrition rates?

SELECT
    [Total Working Years],
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    COUNT(*) AS TotalEmployees,
    CAST(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS DECIMAL) / COUNT(*) * 100 AS AttritionRate
FROM ['HR data$']
GROUP BY [Total Working Years];

--6. Compensation and Attrition:
--Is there a difference in attrition rates based on the distance from home or the daily rate of employees?

SELECT
    [Distance From Home],
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    COUNT(*) AS TotalEmployees,
    CAST(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS DECIMAL) / COUNT(*) * 100 AS AttritionRate
FROM ['HR data$']
GROUP BY [Distance From Home];

-- Attrition rates based on daily rate
SELECT
    [Daily Rate],
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    COUNT(*) AS TotalEmployees,
    CAST(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS DECIMAL) / COUNT(*) * 100 AS AttritionRate
FROM ['HR data$']
GROUP BY [Daily Rate];

--How do monthly income or salary hikes influence attrition?

SELECT
    [Monthly Income],
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    COUNT(*) AS TotalEmployees,
    CAST(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS DECIMAL) / COUNT(*) * 100 AS AttritionRate
FROM ['HR data$']
GROUP BY [Monthly Income];

-- Attrition rates based on salary hike
SELECT
    [Percent Salary Hike],
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    COUNT(*) AS TotalEmployees,
    CAST(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS DECIMAL) / COUNT(*) * 100 AS AttritionRate
FROM ['HR data$']
GROUP BY [Percent Salary Hike];

--7. Promotion and Career Development:
--Are employees who stay longer with the company more likely to get promotions?

SELECT
    AVG(CAST([Years Since Last Promotion] AS DECIMAL)) AS AvgYearsSinceLastPromotion,
    COUNT(CASE WHEN [Years Since Last Promotion] > 0 THEN 1 END) AS PromotedEmployees,
    COUNT(*) AS TotalEmployees,
    CAST(COUNT(CASE WHEN [Years Since Last Promotion] > 0 THEN 1 END) AS DECIMAL) / COUNT(*) * 100 AS PromotionRate
FROM ['HR data$'];

--Does the number of years in the current role affect attrition rates?

SELECT
    [Years In Current Role],
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    COUNT(*) AS TotalEmployees,
    CAST(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS DECIMAL) / COUNT(*) * 100 AS AttritionRate
FROM ['HR data$']
GROUP BY [Years In Current Role];

--8. Departmental Analysis:
--Is there a particular department with consistently high or low attrition rates?

SELECT
    Department,
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    COUNT(*) AS TotalEmployees,
    CAST(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS DECIMAL) / COUNT(*) * 100 AS AttritionRate
FROM ['HR data$']
GROUP BY Department;

--Are there any trends in the relationship between employee education level and department?

SELECT
    Department,
    [Education Field],
    COUNT(*) AS EmployeeCount
FROM ['HR data$']
GROUP BY Department, [Education Field];

--9. Work Environment and Job Satisfaction:
--How does the work environment satisfaction impact job satisfaction and, in turn, attrition?

SELECT
    [Environment Satisfaction],
    [Job Satisfaction],
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    COUNT(*) AS TotalEmployees,
    CAST(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS DECIMAL) / COUNT(*) * 100 AS AttritionRate
FROM ['HR data$']
GROUP BY [Environment Satisfaction], [Job Satisfaction];

-- Is there any relationship between job involvement and attrition?

SELECT
    [Job Involvement],
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    COUNT(*) AS TotalEmployees,
    CAST(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS DECIMAL) / COUNT(*) * 100 AS AttritionRate
FROM ['HR data$']
GROUP BY [Job Involvement];

--10. Performance vs. Education:
--Do employees with higher levels of education perform better or have higher job satisfaction?

SELECT
    [Education],
    AVG([Performance Rating]) AS AvgPerformanceRating,
    COUNT(*) AS TotalEmployees
FROM ['HR data$']
GROUP BY [Education];

--How does the education level affect the number of companies an employee has worked for?

SELECT
    [Education],
    AVG([Num Companies Worked]) AS AvgNumCompaniesWorked,
    COUNT(*) AS TotalEmployees
FROM ['HR data$']
GROUP BY [Education];
