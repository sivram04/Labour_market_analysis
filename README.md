

# Labor Market Demand & Pay Analysis

## 1. Project Overview
This project analyzes U.S. labor market dynamics using public employment projection data from the U.S. Bureau of Labor Statistics (BLS). The objective is to understand how employment demand, growth, and compensation are evolving across occupations and to identify where labor market opportunities are most concentrated.

Rather than focusing only on dashboard creation, this analysis emphasizes analytical framing, data preparation, and insight generation. The project follows a structured approach that moves from a macro-level labor market overview to a detailed occupation-level demand and pay analysis.

---

## 2. Data Source
All data used in this project comes from the **U.S. Bureau of Labor Statistics (BLS)** Employment Projections program (2024–2034).

**Source:**  
https://www.bls.gov/emp

The datasets include:
- Occupational employment levels and projections
- Annual average job openings
- Employment growth (numeric and percentage)
- Median annual wage information

These datasets are publicly available and widely used for workforce planning, economic analysis, and policy research.

---

## 3. Problem Statement & Analytical Goal
The labor market consists of thousands of occupations with varying levels of demand, growth, and compensation. High job availability does not always align with high wages, and strong wage levels may exist in roles with limited openings.

This project was designed to answer the following analytical questions:
- How is the labor market evolving in terms of overall employment demand and compensation?
- Which occupations exhibit the highest job demand and the highest pay?
- Where do trade-offs exist between job availability and compensation?

By answering these questions, the analysis aims to support data-driven decisions related to careers, workforce development, and economic planning.

---

## 4. Data Preparation & Engineering (SQL)
The raw BLS data was provided in multiple Excel files with varying structures and formatting issues. To prepare the data for analysis:

- Files were converted and imported into SQL Server
- Data quality issues such as extra header rows, inconsistent data types, and formatting anomalies were resolved
- Multiple tables were joined using occupational classification codes
- A combined occupational dataset was created as a SQL view to ensure reproducibility and transparency

The SQL scripts used for data preparation and joining are included in the repository.

---

## 5. Data Modeling & Measures (Power BI)
The prepared dataset was imported into Power BI for analysis. Instead of relying on raw columns, analytical measures were created using DAX to support consistent and flexible evaluation.

Key measures include:
- Total annual job openings
- Total number of occupations
- Employment growth (numeric and percentage)
- Average and median wage metrics
- Opportunity-focused indicators combining demand and growth

This approach allows the analysis to scale and adapt as filters or groupings change.

---

## 6. Analysis Structure
The analysis is presented through two complementary views:

### Labor Market Overview
This section provides a macro-level perspective on the labor market by examining total job openings, employment growth, and wage levels across all occupations. It establishes baseline context for understanding whether employment opportunities are expanding or contracting and how compensation is distributed.

### Demand & Pay Analysis by Occupation
This section focuses on occupation-level demand and compensation by comparing annual job openings and median wages. It highlights occupations with high demand, high pay, and the trade-offs between availability and compensation, helping identify roles with strong opportunity potential.

---

## 7. Key Insights
- Labor market demand and wage levels vary significantly across occupations
- High demand does not always correspond to high compensation
- Some occupations combine strong demand with competitive wages, representing strong opportunity roles
- A macro-to-micro analytical approach provides clearer insight than occupation-level analysis alone

---

## 8. Tools & Skills Demonstrated
- **SQL:** Data cleaning, joins, views, data validation
- **Power BI:** Data modeling, DAX measure development, dashboard design
- **Analytics:** Labor market analysis, KPI design, analytical storytelling

---

## 9. Real-World Applications
This analysis can be applied in several real-world contexts, including:
- Workforce planning and talent strategy
- Career and education guidance
- Labor market and economic analysis
- Policy and planning support

---


## 10. Limitations & Future Enhancements
- The analysis is based on national-level data and does not include geographic segmentation
- Future work could incorporate regional trends, time-series analysis, or industry-level breakdowns
- Additional indicators such as education or skill requirements could further enrich the analysis

---

## 12. Conclusion
This project demonstrates an end-to-end analytical workflow, from raw data preparation in SQL to insight-driven analysis and storytelling in Power BI. It highlights how labor market data can be structured and analyzed to support informed, data-driven decisions.

