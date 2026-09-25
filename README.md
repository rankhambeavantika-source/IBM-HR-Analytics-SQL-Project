# 👥 IBM HR Analytics | Employee Attrition Analysis | SQL

**Turning employee-level HR data into actionable workforce insights using SQL to understand attrition, compensation, experience, and employee characteristics.**

---

## 📌 Business Problem

Organizations collect large amounts of employee data, but raw HR data alone does not clearly explain **where employee attrition is concentrated or which workforce groups show different attrition patterns**.

HR teams need answers to questions such as:

* What is the overall employee attrition rate?
* Which departments and job roles have higher attrition?
* Is overtime associated with higher employee turnover?
* How does income differ between employees who stay and those who leave?
* Does employee tenure show different attrition patterns?
* Which employee groups require further investigation?

**This project uses SQL to transform raw employee data into structured workforce analysis that can support HR reporting and retention-focused investigation.**

---

## 🎯 What I Did

1. **Explored and validated the employee dataset** by checking employee records, table structure, NULL values, duplicates, and important field consistency.

2. **Analyzed employee attrition** across departments, job roles, gender, age groups, overtime, income levels, and experience.

3. **Performed salary and workforce analysis** using aggregate functions to compare income across departments and job roles.

4. **Analyzed employee experience** using years at company, years in current role, years since last promotion, and years with current manager.

5. **Applied advanced SQL techniques** including subqueries, joins, `CASE WHEN`, conditional aggregation, ranking, and window functions to answer business-focused questions.

---

## 📊 Key Findings

The analysis identified several measurable patterns in the IBM HR dataset:

* **Overall attrition:** 237 of 1,470 employees were recorded as having left the organization, representing approximately **16.12% attrition**.

* **Department variation:** Attrition patterns differed across departments, with Sales at **20.63%**, HR at **19.05%**, and Research & Development at **13.84%**.

* **Overtime pattern:** Employees working overtime showed a **30.53% attrition rate**, compared with **10.44%** among employees not working overtime.

* **Income pattern:** Employees who left had a lower average monthly income (**4,787**) than employees who stayed (**6,833**) in the dataset.

* **Tenure pattern:** Employees with **0–2 years** at the company showed a higher attrition rate (**29.82%**) compared with employees with **11+ years** (**8.13%**).

* **Job-role variation:** Attrition differed substantially across job roles. Sales Representatives recorded **39.76%**, while Research Directors recorded **2.50%** in the dataset.

* **Combined employee pattern:** Among employees with **low income and 0–2 years of tenure**, 61.54% were recorded as having left. This highlights a workforce segment that may warrant deeper investigation.

> **Important:** These findings describe patterns and associations in the IBM HR dataset. They should not be interpreted as proof that any individual factor directly causes employee attrition.

---

## 🧭 Business Questions & How This Analysis Helps

| Business Question                                            | SQL Analysis                                                            | Business Use                                                                          |
| ------------------------------------------------------------ | ----------------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| **What is the overall attrition rate?**                      | Calculated total employees, attrition count, and attrition percentage.  | Establishes a baseline metric for monitoring employee turnover.                       |
| **Which departments have higher attrition?**                 | Grouped employees by department and calculated attrition rates.         | Helps HR identify departments requiring further retention analysis.                   |
| **Which job roles show higher attrition?**                   | Compared attrition across individual job roles.                         | Helps identify roles where turnover patterns deserve further investigation.           |
| **Is overtime associated with attrition?**                   | Compared attrition between overtime and non-overtime employees.         | Helps HR investigate whether workload patterns are associated with employee turnover. |
| **How does income relate to attrition patterns?**            | Compared average and grouped income across attrition categories.        | Provides visibility into compensation patterns among employees who stayed or left.    |
| **How does tenure relate to attrition?**                     | Created tenure groups and calculated attrition by experience level.     | Helps identify employee experience groups with different turnover patterns.           |
| **Which roles have higher average income?**                  | Calculated average income by job role using aggregation.                | Helps HR understand compensation differences across roles.                            |
| **How does job satisfaction vary?**                          | Compared satisfaction levels across departments and employee groups.    | Provides an additional workforce dimension for HR analysis.                           |
| **Which employee groups show different attrition patterns?** | Combined income, tenure, overtime, department, and job-role attributes. | Helps HR identify workforce segments for deeper analysis.                             |
| **How can multiple employee factors be analyzed together?**  | Used joins, subqueries, conditional aggregation, and window functions.  | Demonstrates how SQL can support multi-dimensional workforce analysis.                |

---

## 💼 How This Project Helps the Business

The analysis provides HR teams with a structured way to understand employee turnover patterns.

It can help businesses:

* **Monitor workforce attrition** using measurable KPIs.
* **Identify departments and roles** with different attrition patterns.
* **Understand employee turnover across tenure groups.**
* **Compare compensation patterns** across employees and job roles.
* **Investigate overtime and workload-related patterns.**
* **Segment employees** based on multiple workforce characteristics.
* **Prioritize areas for deeper HR investigation** using data rather than relying only on assumptions.
* **Support workforce reporting** by converting raw employee records into meaningful analytical metrics.

### 🎯 Business Outcome

**The project transforms raw employee data into structured HR insights that help identify where attrition is concentrated, understand workforce characteristics, and highlight employee segments that may require further investigation.**

---

## 🛠 Tools & Technologies

* **MySQL / MariaDB** — SQL analysis, filtering, aggregation, joins, subqueries, ranking
* **MySQL Workbench** — Query development and analysis
* **SQL** — Business analysis and workforce segmentation
* **GitHub** — Project documentation and version control

---

## 📈 SQL Skills Demonstrated

**SQL Fundamentals**

* `SELECT`
* `WHERE`
* `ORDER BY`
* `GROUP BY`
* `HAVING`
* `DISTINCT`

**Data Analysis**

* `COUNT`
* `SUM`
* `AVG`
* `MIN`
* `MAX`
* Conditional aggregation
* Data segmentation
* Percentage calculations

**Advanced SQL**

* `CASE WHEN`
* Subqueries
* Joins
* Window functions
* Ranking
* Multi-condition analysis

**Data Quality**

* NULL-value checks
* Duplicate checks
* Data validation
* Consistency checks

---

## 📂 Repository Structure

```text
IBM-HR-Analytics-SQL-Project/
│
├── README.md
└── IBM_HR_Analytics.sql
```

---

## 📌 Dataset

**IBM HR Analytics Employee Attrition & Performance Dataset**

The dataset contains employee-level information including:

* Age
* Gender
* Department
* Job Role
* Monthly Income
* Job Satisfaction
* Job Level
* Years at Company
* Years in Current Role
* Years Since Last Promotion
* Years With Current Manager
* Overtime
* Business Travel
* Education
* Marital Status
* Attrition

---

👨‍💻 About Me
Avantika Rankhambe
📧 rankhambeavantika@gmail.com











---

⭐ **If you find this project useful, consider starring the repository!**
