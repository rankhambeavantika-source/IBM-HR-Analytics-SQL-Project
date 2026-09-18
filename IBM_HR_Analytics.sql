sql
-- =====================================================================
-- EMPLOYEE ATTRITION ANALYSIS
-- =====================================================================
-- Dataset: Employee Attrition Analysis - 2,000 Employees
-- Database: MySQL / MariaDB
-- Goal: Analyze employee attrition and identify high-risk employee
--       segments for HR retention analysis.
-- =====================================================================


-- =====================================================================
-- 1. DATABASE SETUP
-- =====================================================================

CREATE DATABASE IF NOT EXISTS employee_db;

USE employee_db;

SHOW DATABASES;

SHOW TABLES;


-- =====================================================================
-- 2. CHECK TABLE STRUCTURE
-- =====================================================================

DESCRIBE employees;

-- Preview data
SELECT *
FROM employees
LIMIT 10;


-- =====================================================================
-- 3. BASIC DATA QUALITY CHECKS
-- =====================================================================

-- Total number of employees
SELECT COUNT(*) AS total_employees
FROM employees;


-- Check NULL values in important columns
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN EmployeeID IS NULL THEN 1 ELSE 0 END) AS employeeid_nulls,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS age_nulls,
    SUM(CASE WHEN Attrition IS NULL THEN 1 ELSE 0 END) AS attrition_nulls,
    SUM(CASE WHEN Department IS NULL THEN 1 ELSE 0 END) AS department_nulls,
    SUM(CASE WHEN JobRole IS NULL THEN 1 ELSE 0 END) AS jobrole_nulls,
    SUM(CASE WHEN MonthlyIncome IS NULL THEN 1 ELSE 0 END) AS income_nulls,
    SUM(CASE WHEN OverTime IS NULL THEN 1 ELSE 0 END) AS overtime_nulls,
    SUM(CASE WHEN YearsAtCompany IS NULL THEN 1 ELSE 0 END) AS tenure_nulls
FROM employees;


-- Check duplicate Employee IDs
SELECT
    EmployeeID,
    COUNT(*) AS duplicate_count
FROM employees
GROUP BY EmployeeID
HAVING COUNT(*) > 1;


-- Check unique values of important categorical columns

SELECT DISTINCT Attrition
FROM employees;

SELECT DISTINCT Department
FROM employees;

SELECT DISTINCT JobRole
FROM employees;

SELECT DISTINCT OverTime
FROM employees;

SELECT DISTINCT BusinessTravel
FROM employees;

SELECT DISTINCT MaritalStatus
FROM employees;


-- =====================================================================
-- 4. OVERALL ATTRITION ANALYSIS
-- =====================================================================

-- Total employees, employees who left and stayed

SELECT
    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    SUM(
        CASE
            WHEN Attrition = 'No' THEN 1
            ELSE 0
        END
    ) AS employees_stayed,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees;


-- Attrition distribution

SELECT
    Attrition,
    COUNT(*) AS employee_count,

    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM employees),
        2
    ) AS percentage
FROM employees
GROUP BY Attrition;


-- =====================================================================
-- 5. ATTRITION BY DEMOGRAPHICS
-- =====================================================================

-- 5.1 Gender

SELECT
    Gender,
    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY Gender
ORDER BY attrition_rate DESC;


-- 5.2 Age bands

SELECT
    CASE
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS age_band,

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY age_band

ORDER BY attrition_rate DESC;


-- 5.3 Marital Status

SELECT
    MaritalStatus,
    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY MaritalStatus

ORDER BY attrition_rate DESC;


-- 5.4 Education Field

SELECT
    EducationField,
    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY EducationField

ORDER BY attrition_rate DESC;


-- 5.5 Education Level

SELECT
    Education,
    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY Education

ORDER BY attrition_rate DESC;


-- 5.6 Distance from Home

SELECT
    CASE
        WHEN DistanceFromHome <= 5 THEN '0-5 km'
        WHEN DistanceFromHome BETWEEN 6 AND 10 THEN '6-10 km'
        WHEN DistanceFromHome BETWEEN 11 AND 20 THEN '11-20 km'
        ELSE '21+ km'
    END AS distance_band,

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY distance_band

ORDER BY attrition_rate DESC;


-- =====================================================================
-- 6. ATTRITION BY JOB FACTORS
-- =====================================================================

-- 6.1 Department

SELECT
    Department,
    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY Department

ORDER BY attrition_rate DESC;


-- 6.2 Job Role

SELECT
    JobRole,
    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY JobRole

ORDER BY attrition_rate DESC;


-- 6.3 Job Level

SELECT
    JobLevel,
    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY JobLevel

ORDER BY JobLevel;


-- 6.4 Overtime

SELECT
    OverTime,
    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY OverTime

ORDER BY attrition_rate DESC;


-- 6.5 Business Travel

SELECT
    BusinessTravel,
    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY BusinessTravel

ORDER BY attrition_rate DESC;


-- 6.6 Job Satisfaction

SELECT
    JobSatisfaction,
    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY JobSatisfaction

ORDER BY JobSatisfaction;


-- 6.7 Environment Satisfaction

SELECT
    EnvironmentSatisfaction,
    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY EnvironmentSatisfaction

ORDER BY EnvironmentSatisfaction;


-- 6.8 Work-Life Balance

SELECT
    WorkLifeBalance,
    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY WorkLifeBalance

ORDER BY WorkLifeBalance;


-- =====================================================================
-- 7. COMPENSATION & TENURE
-- =====================================================================

-- 7.1 Income bands

SELECT
    CASE
        WHEN MonthlyIncome < 3000 THEN 'Low Income'
        WHEN MonthlyIncome BETWEEN 3000 AND 6000 THEN 'Medium Income'
        ELSE 'High Income'
    END AS income_band,

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY income_band

ORDER BY attrition_rate DESC;


-- 7.2 Years at Company

SELECT
    CASE
        WHEN YearsAtCompany BETWEEN 0 AND 2 THEN '0-2 Years'
        WHEN YearsAtCompany BETWEEN 3 AND 5 THEN '3-5 Years'
        WHEN YearsAtCompany BETWEEN 6 AND 10 THEN '6-10 Years'
        ELSE '11+ Years'
    END AS tenure_band,

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY tenure_band

ORDER BY attrition_rate DESC;


-- 7.3 Years with Current Manager

SELECT
    CASE
        WHEN YearsWithCurrManager <= 2 THEN '0-2 Years'
        WHEN YearsWithCurrManager BETWEEN 3 AND 5 THEN '3-5 Years'
        WHEN YearsWithCurrManager BETWEEN 6 AND 10 THEN '6-10 Years'
        ELSE '11+ Years'
    END AS manager_tenure_band,

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY manager_tenure_band

ORDER BY attrition_rate DESC;


-- =====================================================================
-- 8. PERFORMANCE & EMPLOYEE ENGAGEMENT
-- =====================================================================

-- 8.1 Performance Rating

SELECT
    PerformanceRating,
    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY PerformanceRating

ORDER BY PerformanceRating;


-- 8.2 Engagement Score

SELECT
    CASE
        WHEN EngagementScore < 2.5 THEN 'Low Engagement'
        WHEN EngagementScore < 3.5 THEN 'Medium Engagement'
        ELSE 'High Engagement'
    END AS engagement_band,

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY engagement_band

ORDER BY attrition_rate DESC;


-- 8.3 Absenteeism

SELECT
    CASE
        WHEN AbsenteeismDays <= 3 THEN 'Low Absenteeism'
        WHEN AbsenteeismDays <= 7 THEN 'Medium Absenteeism'
        ELSE 'High Absenteeism'
    END AS absenteeism_band,

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY absenteeism_band

ORDER BY attrition_rate DESC;


-- 8.4 Promotion Due

SELECT
    PromotionDue,
    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY PromotionDue

ORDER BY attrition_rate DESC;


-- =====================================================================
-- 9. NUMERICAL SUMMARY
-- =====================================================================

-- Monthly Income

SELECT
    Attrition,
    COUNT(*) AS employee_count,
    ROUND(AVG(MonthlyIncome), 2) AS average_income,
    MIN(MonthlyIncome) AS minimum_income,
    MAX(MonthlyIncome) AS maximum_income,
    ROUND(STDDEV_SAMP(MonthlyIncome), 2) AS income_stddev

FROM employees

GROUP BY Attrition;


-- Years at Company

SELECT
    Attrition,
    COUNT(*) AS employee_count,
    ROUND(AVG(YearsAtCompany), 2) AS average_years,
    MIN(YearsAtCompany) AS minimum_years,
    MAX(YearsAtCompany) AS maximum_years,
    ROUND(STDDEV_SAMP(YearsAtCompany), 2) AS years_stddev

FROM employees

GROUP BY Attrition;


-- Total Working Years

SELECT
    Attrition,
    COUNT(*) AS employee_count,
    ROUND(AVG(TotalWorkingYears), 2) AS average_working_years,
    MIN(TotalWorkingYears) AS minimum_working_years,
    MAX(TotalWorkingYears) AS maximum_working_years,
    ROUND(STDDEV_SAMP(TotalWorkingYears), 2) AS working_years_stddev

FROM employees

GROUP BY Attrition;


-- =====================================================================
-- 10. CROSS-TAB ANALYSIS
-- =====================================================================

-- Overtime vs Attrition

SELECT
    OverTime,
    Attrition,
    COUNT(*) AS employee_count

FROM employees

GROUP BY OverTime, Attrition

ORDER BY OverTime, Attrition;


-- Department vs Attrition

SELECT
    Department,
    Attrition,
    COUNT(*) AS employee_count

FROM employees

GROUP BY Department, Attrition

ORDER BY Department, Attrition;


-- Job Role vs Attrition

SELECT
    JobRole,
    Attrition,
    COUNT(*) AS employee_count

FROM employees

GROUP BY JobRole, Attrition

ORDER BY JobRole, Attrition;


-- =====================================================================
-- 11. TWO-FACTOR ANALYSIS
-- =====================================================================

-- Overtime + Job Level

SELECT
    OverTime,
    JobLevel,

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY OverTime, JobLevel

ORDER BY attrition_rate DESC;


-- Overtime + Job Satisfaction

SELECT
    OverTime,
    JobSatisfaction,

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY OverTime, JobSatisfaction

ORDER BY attrition_rate DESC;


-- Department + Overtime

SELECT
    Department,
    OverTime,

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY Department, OverTime

ORDER BY attrition_rate DESC;


-- =====================================================================
-- 12. THREE-FACTOR ANALYSIS
-- =====================================================================

-- Department + Overtime + Job Level

SELECT
    Department,
    OverTime,
    JobLevel,

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY
    Department,
    OverTime,
    JobLevel

HAVING COUNT(*) >= 10

ORDER BY attrition_rate DESC;


-- =====================================================================
-- 13. HIGH-RISK EMPLOYEE SEGMENTS
-- =====================================================================

-- Combine overtime, job level, income and tenure

SELECT

    OverTime,
    JobLevel,

    CASE
        WHEN MonthlyIncome < 5000 THEN 'Low Income'
        WHEN MonthlyIncome < 10000 THEN 'Medium Income'
        ELSE 'High Income'
    END AS income_band,

    CASE
        WHEN YearsAtCompany <= 2 THEN '0-2 Years'
        WHEN YearsAtCompany <= 5 THEN '3-5 Years'
        ELSE '6+ Years'
    END AS tenure_band,

    COUNT(*) AS employee_count,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY
    OverTime,
    JobLevel,
    income_band,
    tenure_band

HAVING COUNT(*) >= 10

ORDER BY attrition_rate DESC;


-- =====================================================================
-- 14. TOP 10 HIGH-RISK SEGMENTS
-- =====================================================================

SELECT *

FROM
(
    SELECT

        OverTime,
        JobLevel,

        CASE
            WHEN MonthlyIncome < 5000 THEN 'Low Income'
            WHEN MonthlyIncome < 10000 THEN 'Medium Income'
            ELSE 'High Income'
        END AS income_band,

        CASE
            WHEN YearsAtCompany <= 2 THEN '0-2 Years'
            WHEN YearsAtCompany <= 5 THEN '3-5 Years'
            ELSE '6+ Years'
        END AS tenure_band,

        COUNT(*) AS employee_count,

        SUM(
            CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) AS employees_left,

        ROUND(
            SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
            * 100.0 / COUNT(*),
            2
        ) AS attrition_rate

    FROM employees

    GROUP BY
        OverTime,
        JobLevel,
        income_band,
        tenure_band

    HAVING COUNT(*) >= 10

) AS risk_segments

ORDER BY attrition_rate DESC

LIMIT 10;


-- =====================================================================
-- 15. EMPLOYEES WITH MULTIPLE RISK FACTORS
-- =====================================================================

SELECT
    EmployeeID,
    Age,
    Department,
    JobRole,
    JobLevel,
    MonthlyIncome,
    OverTime,
    JobSatisfaction,
    EngagementScore,
    AbsenteeismDays,
    YearsAtCompany,
    PromotionDue,
    Attrition

FROM employees

WHERE
    OverTime = 'Yes'
    AND JobSatisfaction <= 2
    AND EngagementScore < 3
    AND YearsAtCompany <= 2

ORDER BY
    EngagementScore ASC,
    JobSatisfaction ASC;


-- =====================================================================
-- 16. LOW-INCOME EMPLOYEES WITH OVERTIME
-- =====================================================================

SELECT
    EmployeeID,
    Department,
    JobRole,
    JobLevel,
    MonthlyIncome,
    OverTime,
    YearsAtCompany,
    Attrition

FROM employees

WHERE
    MonthlyIncome < 5000
    AND OverTime = 'Yes'

ORDER BY MonthlyIncome;


-- =====================================================================
-- 17. EMPLOYEES DUE FOR PROMOTION WHO LEFT
-- =====================================================================

SELECT
    EmployeeID,
    Department,
    JobRole,
    JobLevel,
    YearsAtCompany,
    YearsSinceLastPromotion,
    MonthlyIncome,
    PromotionDue,
    Attrition

FROM employees

WHERE
    PromotionDue = 'Yes'
    AND Attrition = 'Yes'

ORDER BY YearsSinceLastPromotion DESC;


-- =====================================================================
-- 18. HIGH ABSENTEEISM + ATTRITION
-- =====================================================================

SELECT
    EmployeeID,
    Department,
    JobRole,
    AbsenteeismDays,
    EngagementScore,
    JobSatisfaction,
    OverTime,
    Attrition

FROM employees

WHERE
    AbsenteeismDays > 10
    AND Attrition = 'Yes'

ORDER BY AbsenteeismDays DESC;


-- =====================================================================
-- 19. TOP JOB ROLES BY ATTRITION RATE
-- =====================================================================

SELECT
    JobRole,
    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY JobRole

HAVING COUNT(*) >= 20

ORDER BY attrition_rate DESC;


-- =====================================================================
-- 20. DEPARTMENT + JOB ROLE ANALYSIS
-- =====================================================================

SELECT
    Department,
    JobRole,

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY
    Department,
    JobRole

HAVING COUNT(*) >= 10

ORDER BY attrition_rate DESC;


-- =====================================================================
-- 21. WINDOW FUNCTIONS
-- =====================================================================

-- Rank job roles by attrition rate

WITH role_attrition AS
(
    SELECT
        JobRole,
        COUNT(*) AS total_employees,

        SUM(
            CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) AS employees_left,

        ROUND(
            SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
            * 100.0 / COUNT(*),
            2
        ) AS attrition_rate

    FROM employees

    GROUP BY JobRole
)

SELECT
    JobRole,
    total_employees,
    employees_left,
    attrition_rate,

    RANK() OVER (
        ORDER BY attrition_rate DESC
    ) AS attrition_rank

FROM role_attrition;


-- =====================================================================
-- 22. DEPARTMENT RANKING
-- =====================================================================

WITH department_attrition AS
(
    SELECT
        Department,
        COUNT(*) AS total_employees,

        SUM(
            CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) AS employees_left,

        ROUND(
            SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
            * 100.0 / COUNT(*),
            2
        ) AS attrition_rate

    FROM employees

    GROUP BY Department
)

SELECT
    Department,
    total_employees,
    employees_left,
    attrition_rate,

    DENSE_RANK() OVER (
        ORDER BY attrition_rate DESC
    ) AS department_rank

FROM department_attrition;


-- =====================================================================
-- 23. TOP 5 EMPLOYEES BY RISK SCORE
-- =====================================================================

SELECT
    EmployeeID,
    Department,
    JobRole,
    JobLevel,
    MonthlyIncome,
    OverTime,
    JobSatisfaction,
    EngagementScore,
    AbsenteeismDays,
    YearsAtCompany,

    (
        CASE WHEN OverTime = 'Yes' THEN 3 ELSE 0 END
        +
        CASE WHEN JobSatisfaction <= 2 THEN 2 ELSE 0 END
        +
        CASE WHEN EngagementScore < 3 THEN 2 ELSE 0 END
        +
        CASE WHEN MonthlyIncome < 5000 THEN 1 ELSE 0 END
        +
        CASE WHEN YearsAtCompany <= 2 THEN 1 ELSE 0 END
        +
        CASE WHEN AbsenteeismDays > 10 THEN 1 ELSE 0 END
        +
        CASE WHEN PromotionDue = 'Yes' THEN 1 ELSE 0 END
    ) AS risk_score,

    Attrition

FROM employees

ORDER BY risk_score DESC

LIMIT 5;


-- =====================================================================
-- 24. RISK LEVEL CLASSIFICATION
-- =====================================================================

SELECT
    EmployeeID,
    Department,
    JobRole,
    Attrition,

    (
        CASE WHEN OverTime = 'Yes' THEN 3 ELSE 0 END
        +
        CASE WHEN JobSatisfaction <= 2 THEN 2 ELSE 0 END
        +
        CASE WHEN EngagementScore < 3 THEN 2 ELSE 0 END
        +
        CASE WHEN MonthlyIncome < 5000 THEN 1 ELSE 0 END
        +
        CASE WHEN YearsAtCompany <= 2 THEN 1 ELSE 0 END
        +
        CASE WHEN AbsenteeismDays > 10 THEN 1 ELSE 0 END
        +
        CASE WHEN PromotionDue = 'Yes' THEN 1 ELSE 0 END
    ) AS risk_score,

    CASE

        WHEN
            (
                CASE WHEN OverTime = 'Yes' THEN 3 ELSE 0 END
                +
                CASE WHEN JobSatisfaction <= 2 THEN 2 ELSE 0 END
                +
                CASE WHEN EngagementScore < 3 THEN 2 ELSE 0 END
                +
                CASE WHEN MonthlyIncome < 5000 THEN 1 ELSE 0 END
                +
                CASE WHEN YearsAtCompany <= 2 THEN 1 ELSE 0 END
                +
                CASE WHEN AbsenteeismDays > 10 THEN 1 ELSE 0 END
                +
                CASE WHEN PromotionDue = 'Yes' THEN 1 ELSE 0 END
            ) >= 7
        THEN 'High Risk'

        WHEN
            (
                CASE WHEN OverTime = 'Yes' THEN 3 ELSE 0 END
                +
                CASE WHEN JobSatisfaction <= 2 THEN 2 ELSE 0 END
                +
                CASE WHEN EngagementScore < 3 THEN 2 ELSE 0 END
                +
                CASE WHEN MonthlyIncome < 5000 THEN 1 ELSE 0 END
                +
                CASE WHEN YearsAtCompany <= 2 THEN 1 ELSE 0 END
                +
                CASE WHEN AbsenteeismDays > 10 THEN 1 ELSE 0 END
                +
                CASE WHEN PromotionDue = 'Yes' THEN 1 ELSE 0 END
            ) >= 4
        THEN 'Medium Risk'

        ELSE 'Low Risk'

    END AS risk_level

FROM employees;


-- =====================================================================
-- 25. RISK LEVEL SUMMARY
-- =====================================================================

WITH employee_risk AS
(
    SELECT

        EmployeeID,

        (
            CASE WHEN OverTime = 'Yes' THEN 3 ELSE 0 END
            +
            CASE WHEN JobSatisfaction <= 2 THEN 2 ELSE 0 END
            +
            CASE WHEN EngagementScore < 3 THEN 2 ELSE 0 END
            +
            CASE WHEN MonthlyIncome < 5000 THEN 1 ELSE 0 END
            +
            CASE WHEN YearsAtCompany <= 2 THEN 1 ELSE 0 END
            +
            CASE WHEN AbsenteeismDays > 10 THEN 1 ELSE 0 END
            +
            CASE WHEN PromotionDue = 'Yes' THEN 1 ELSE 0 END
        ) AS risk_score,

        Attrition

    FROM employees
)

SELECT

    CASE
        WHEN risk_score >= 7 THEN 'High Risk'
        WHEN risk_score >= 4 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_level,

    COUNT(*) AS employee_count,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employee_risk

GROUP BY risk_level

ORDER BY attrition_rate DESC;


-- =====================================================================
-- 26. FINAL HR SUMMARY
-- =====================================================================

SELECT

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS total_attrition,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS overall_attrition_rate,

    ROUND(AVG(MonthlyIncome), 2) AS average_monthly_income,

    ROUND(AVG(YearsAtCompany), 2) AS average_years_at_company,

    ROUND(AVG(EngagementScore), 2) AS average_engagement_score,

    ROUND(AVG(AbsenteeismDays), 2) AS average_absenteeism_days

FROM employees;


-- =====================================================================
-- END OF PROJECT
-- =====================================================================
