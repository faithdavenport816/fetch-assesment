## Faith Davenport, Analytics Engineering Fetch Assessment Submission

### Prompt #1: ER Diagram
* ER Diagram can be found [here](https://github.com/faithdavenport816/fetch-assesment/blob/main/Fetch-ER-diagram.png).


### Prompt #2: SQL Queries Answering Business Questions
I composed SQL to answer questions 3-6 based on my proposed data model from prompt #1. I used BigQuery Syntax.
* [Questions 3 & 4](https://github.com/faithdavenport816/fetch-assesment/blob/main/sql_queries/queries_for_3_and_4.sql)
* [Questions 5 & 6](https://github.com/faithdavenport816/fetch-assesment/blob/main/sql_queries/queries_for_5_and_6.sql)

### Prompt #3: Data Quality Assessment Queries
I composed SQL (BigQuery syntax) to identify data quality issues with the provided data. I assessed each dataset individually, and a summary of all identified issues can be found directly in the comments of each SQL file. I also provided queries related to "non-issues" to demonstrate the types of issues I was searching for / to demonstrate how I evaluate new data sources. 
* [Users](https://github.com/faithdavenport816/fetch-assesment/blob/main/data_quality_assesment/users_assesment.sql)
* [Brands](https://github.com/faithdavenport816/fetch-assesment/blob/main/data_quality_assesment/brands_assesment.sql)
* [Receipts](https://github.com/faithdavenport816/fetch-assesment/blob/main/data_quality_assesment/receipts_assesment.sql)

### Prompt #4: Stakeholder Email
* Stakeholder email can be found [here](https://github.com/faithdavenport816/fetch-assesment/blob/main/stakeholder_email.md).

### Additional Notes
* For ease of querying, I wrote a [python script](https://github.com/faithdavenport816/fetch-assesment/blob/main/load-and-parse/convert_to_csvs.py) to clean and load my data to BigQuery.
