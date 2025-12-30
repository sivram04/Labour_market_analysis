USE labor_market_analytics;
GO

SELECT TABLE_NAME, COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE COLUMN_NAME LIKE '%National_Employment_Matrix_code%'
ORDER BY TABLE_NAME;

SELECT TOP (100)
    -- Core occupation identifiers
    p._2024_National_Employment_Matrix_code  AS occupation_code,
    p._2024_National_Employment_Matrix_title AS occupation_title,
    p.Occupation_type,

    -- Projections
    p.Employment_2024,
    p.Employment_2034,
    p.Employment_change_numeric_2024_34,
    p.Employment_change_percent_2024_34,
    p.Occupational_openings_2024_34_annual_average,
    p.Median_annual_wage_dollars_2024_1,

    -- Skills
    s.Top_highest_skill,
    s.Second_highest_skill,
    s.Third_highest_skill,

    -- Separations
    o.Labor_force_exits_2024_34_annual_average,
    o.Occupational_transfers_2024_34_annual_average,
    o.Total_occupational_separations_2024_34_annual_average,

    -- Metadata
    m.National_Employment_Matrix_link

INTO dbo.Combined_Occupational_Data
FROM dbo.occupational_projections AS p
LEFT JOIN dbo.industry_occupation_matrix AS m
    ON p._2024_National_Employment_Matrix_code = m._2024_National_Employment_Matrix_code
LEFT JOIN dbo.occupational_skills AS s
    ON p._2024_National_Employment_Matrix_code = s._2024_National_Employment_Matrix_code
LEFT JOIN dbo.occupational_openings_and_separations AS o
    ON p._2024_National_Employment_Matrix_code = o._2024_National_Employment_Matrix_code;



    SELECT TOP (100)
    p.*,
    m.*,
    s.*,
    o.*
FROM dbo.occupational_projections AS p
LEFT JOIN dbo.industry_occupation_matrix AS m
    ON p.[_2024_National_Employment_Matrix_code] = m.[_2024_National_Employment_Matrix_code]
LEFT JOIN dbo.occupational_skills AS s
    ON p.[_2024_National_Employment_Matrix_code] = s.[_2024_National_Employment_Matrix_code]
LEFT JOIN dbo.occupational_openings_and_separations AS o
    ON p.[_2024_National_Employment_Matrix_code] = o.[_2024_National_Employment_Matrix_code];



    IF OBJECT_ID('dbo.Combined_Occupational_Data', 'U') IS NOT NULL
    DROP TABLE dbo.Combined_Occupational_Data;

    SELECT
    -- keep ONE copy of the key columns
    p._2024_National_Employment_Matrix_code  AS occupation_code,
    p._2024_National_Employment_Matrix_title AS occupation_title,
    p.Occupation_type                        AS occupation_type,

    -- add the main data you want (examples)
    p.Employment_2024,
    p.Employment_2034,
    p.Employment_change_percent_2024_34,
    p.Occupational_openings_2024_34_annual_average,
    p.Median_annual_wage_dollars_2024_1,

    -- skills
    s.Top_highest_skill,
    s.Second_highest_skill,
    s.Third_highest_skill,

    -- separations
    o.Total_occupational_separations_2024_34_annual_average,

    -- link
    m.National_Employment_Matrix_link

INTO dbo.Combined_Occupational_Data
FROM dbo.occupational_projections AS p
LEFT JOIN dbo.industry_occupation_matrix AS m
    ON p._2024_National_Employment_Matrix_code = m._2024_National_Employment_Matrix_code
LEFT JOIN dbo.occupational_skills AS s
    ON p._2024_National_Employment_Matrix_code = s._2024_National_Employment_Matrix_code
LEFT JOIN dbo.occupational_openings_and_separations AS o
    ON p._2024_National_Employment_Matrix_code = o._2024_National_Employment_Matrix_code;

    SELECT COUNT(*) AS rows
FROM dbo.Combined_Occupational_Data;


Select * From combined_Occupational_Data


DELETE
FROM dbo.Combined_Occupational_Data
WHERE occupation_type IS NULL;

-- =========================================
-- Dataset Validation: Total Row Count
-- Purpose: Confirm the combined dataset was created successfully
-- =========================================
SELECT COUNT(*) AS combined_rows
FROM dbo.Combined_Occupational_Data;


-- =========================================
-- Data Quality Check: Duplicate Occupation Codes
-- Purpose: Ensure one row per occupation (no duplication after joins)
-- =========================================
SELECT occupation_code, COUNT(*) AS cnt
FROM dbo.Combined_Occupational_Data
GROUP BY occupation_code
HAVING COUNT(*) > 1
ORDER BY cnt DESC;


-- =========================================
-- Data Completeness Assessment
-- Purpose: Measure missing values in key analytical columns
-- =========================================
SELECT
  SUM(CASE WHEN Top_highest_skill IS NULL THEN 1 ELSE 0 END) AS missing_skill_rows,
  SUM(CASE WHEN Total_occupational_separations_2024_34_annual_average IS NULL THEN 1 ELSE 0 END) AS missing_separation_rows,
  COUNT(*) AS total_rows
FROM dbo.Combined_Occupational_Data;


-- =========================================
-- Growth Analysis: Fastest-Growing Occupations (Percentage)
-- Purpose: Identify occupations with the highest projected growth rate (2024–2034)
-- =========================================
SELECT TOP (25)
  occupation_title,
  Employment_2024,
  Employment_2034,
  Employment_change_percent_2024_34
FROM dbo.Combined_Occupational_Data
WHERE Employment_change_percent_2024_34 IS NOT NULL
ORDER BY Employment_change_percent_2024_34 DESC;


-- =========================================
-- Demand Analysis: Occupations with Highest Annual Openings
-- Purpose: Identify roles with the greatest workforce demand
-- =========================================
SELECT TOP (25)
  occupation_title,
  Occupational_openings_2024_34_annual_average,
  Median_annual_wage_dollars_2024_1
FROM dbo.Combined_Occupational_Data
WHERE Occupational_openings_2024_34_annual_average IS NOT NULL
ORDER BY Occupational_openings_2024_34_annual_average DESC;


-- =========================================
-- Opportunity Analysis: High Demand + High Pay + Growth
-- Purpose: Identify high-opportunity occupations combining demand, pay, and growth
-- =========================================
SELECT TOP (25)
  occupation_title,
  Median_annual_wage_dollars_2024_1,
  Occupational_openings_2024_34_annual_average,
  Employment_change_percent_2024_34
FROM dbo.Combined_Occupational_Data
WHERE
  Median_annual_wage_dollars_2024_1 IS NOT NULL
  AND Occupational_openings_2024_34_annual_average IS NOT NULL
  AND Employment_change_percent_2024_34 IS NOT NULL
ORDER BY
  Occupational_openings_2024_34_annual_average DESC,
  Median_annual_wage_dollars_2024_1 DESC;


-- =========================================
-- Skills Intelligence: Most Common Top Skills
-- Purpose: Identify skills most frequently required across occupations
-- =========================================
SELECT TOP (20)
  Top_highest_skill,
  COUNT(*) AS occupation_count
FROM dbo.Combined_Occupational_Data
WHERE Top_highest_skill IS NOT NULL
GROUP BY Top_highest_skill
ORDER BY occupation_count DESC;


-- =========================================
-- Skills & Pay Analysis: Highest-Paying Skills
-- Purpose: Evaluate average wages associated with top skills
-- =========================================
SELECT TOP (25)
  Top_highest_skill,
  AVG(CAST(Median_annual_wage_dollars_2024_1 AS float)) AS avg_wage
FROM dbo.Combined_Occupational_Data
WHERE Top_highest_skill IS NOT NULL
  AND Median_annual_wage_dollars_2024_1 IS NOT NULL
GROUP BY Top_highest_skill
ORDER BY avg_wage DESC;


-- =========================================
-- Growth Analysis: Largest Job Creators (Numeric Gr


select * from Combined_Occupational_Data

