🎬 Netflix Movies & TV Shows – End-to-End Data Analysis Project

A complete real-world ETL + SQL + Python project using the Netflix Kaggle dataset.
This project demonstrates data collection, cleaning, transformation, SQL database design, analysis, and visualization.

📌 Project Overview

The goal of this project is to analyze trends in Netflix content—genres, ratings, countries, directors, content growth, and more.
This was done by:

Cleaning raw Netflix data using Python

Normalizing it into multiple tables using MySQL

Running advanced SQL analysis queries

Visualizing insights using Matplotlib

This project follows a real data engineering workflow similar to how analytics teams handle raw datasets.

📁 Project Structure
Netflix_project/
│
├── data/
│   ├── Netflix Dataset.csv
│   ├── cleaned_netflix.csv
│
├── notebooks/
│   ├── 01_data_exploration.ipynb
│   ├── 02_sql_tasks.ipynb
│   ├── 03_visualization.ipynb
│
├── sql/
│   ├── create_tables.sql
│   ├── analysis_queries.sql
│
├── images/
│   ├── top_genres.png
│   ├── content_trend.png
│   ├── countries_content.png
│   ├── adult_content_ratio.png
│   ├── genre_by_year.png
│
└── README.md

🧾 Dataset Description

Source: Kaggle — Netflix Movies and TV Shows Dataset
Size: ~8800 rows
Columns include:

show_id

type (Movie / TV Show)

title

director

cast

country

date_added

release_year

rating

duration

listed_in (genres)

description

🧹 Data Cleaning & Preprocessing (Python)

📒 File: 01_data_exploration.ipynb

✔ Key Cleaning Steps Performed:
1. Loaded the dataset

Checked shape, data types, missing values, and duplicates.

2. Cleaned column names

Converted to lowercase, replaced spaces with underscores.

3. Removed duplicate rows
4. Filled missing values
director → 'Unknown'  
cast → 'Unknown'  
country → 'Unknown'  
rating → 'Not Rated'

5. Cleaned the release_date column

Converted messy text dates into proper datetime

Invalid dates converted to NaT

Remaining missing dates filled with "unknown"

6. Saved the cleaned file
cleaned_netflix.csv


This file was used for SQL loading and normalization.

🧱 Database Design & Normalization (3NF)

📄 File: sql/create_tables.sql

To remove redundancy and create a relational model, the dataset was normalized into 5 tables:

📌 1. directors
director_id | director_name

📌 2. countries
country_id | country_name

📌 3. genres
genre_id | genre_name

📌 4. netflix_shows
show_id | title | type | director_id | country_id | release_date | rating | duration | description

📌 5. show_genres (many-to-many bridge)
show_id | genre_id


This schema fully supports SQL joins, analytics, and dashboarding.

🚚 ETL: Loading Data into MySQL
✔ Loaded cleaned data into temporary table:
LOAD DATA LOCAL INFILE 'cleaned_netflix.csv'
INTO TABLE netflix
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 ROWS;

✔ Inserted genres using Python

Extracted unique genres automatically and added to MySQL.

✔ Created show–genre mappings

Split multi-value genre strings and inserted into show_genres.

🧠 SQL Analysis (10 Queries)

📄 sql/analysis_queries.sql
📒 02_sql_tasks.ipynb

The project includes 10 meaningful insights using SQL joins, grouping, filtering, ranking, and window functions.

### 🔹 Core Analysis

1.Top 10 Most Popular Genres
→ Finds most dominant genres on Netflix.

2.Directors Working Across Multiple Genres
→ Shows versatile directors with diverse portfolios.

3.Top Countries with Highest Genre Variety
→ Measures content diversity by region.

4.Most Common Rating for Each Genre
→ Uses window functions to identify top ratings category-wise.

5.Directors with Highest Average Movie Duration
→ Finds directors known for longer films.

🔹 Advanced Analysis

6.Content Growth Trend Over Years
→ Shows how Netflix production expanded annually.

7.Top 10 Countries Producing Most Content
→ Identifies the biggest content creators globally.

8.Top Directors by Total Number of Shows
→ Uses GROUP_CONCAT to list content categories.

9.Adult Content Ratio by Country
→ Calculates % of adult-rated (TV-MA/R/NC-17) titles per country.

10.Most Popular Genre Each Year
→ Uses CTE + RANK() to track yearly genre trends.

These queries represent real, business-driven insights used in analytics teams.

📊 Data Visualization (Python – Matplotlib)

📒 03_visualization.ipynb

1️⃣ Top 10 Most Popular Genres

2️⃣ Content Growth Trend Over the Years

3️⃣ Top 10 Countries Producing Netflix Content

4️⃣ Adult Content Ratio by Country

5️⃣ Genre Popularity by Year

🧠 Insights & Findings

📌 International Movies, Dramas, and Comedies dominate the Netflix library
📌 USA & India are the top content producers
📌 TV-MA is the most common rating across genres
📌 Spain, Brazil & Mexico have the highest adult-content ratio
📌 Netflix content production skyrocketed after 2016
📌 Genre trends vary by year, showing streaming audience evolution

🛠 Tech Stack Used

Python (Pandas, Matplotlib, Seaborn)

MySQL

SQLAlchemy

Jupyter Notebook

ETL Pipeline

Data Visualization

🚀 How to Run This Project
1. Install requirements
pip install pandas numpy matplotlib seaborn sqlalchemy mysql-connector-python

2. Import SQL schema
source sql/create_tables.sql;

3. Load cleaned CSV
LOAD DATA LOCAL INFILE 'cleaned_netflix.csv'
INTO TABLE netflix
IGNORE 1 ROWS;

4. Run Python notebooks in order

01_data_exploration.ipynb

02_sql_tasks.ipynb

03_visualization.ipynb

🔮 Future Enhancements

Build a full Streamlit dashboard

Add a recommendation engine

Use Plotly for interactive visuals

Automate ETL using Airflow

Try cloud hosting (AWS RDS + EC2)


