🏏 ODI Cricket Data Analysis using SQL

This project demonstrates SQL data management and analysis using an ODI (One Day International) Cricket dataset.
It includes data cleaning, transformation, and analytical queries to explore player performances across batting, bowling, and match statistics.

📘 Project Overview

The aim of this project is to clean, modify, and analyze a cricket dataset using SQL queries.
It covers a variety of database operations such as:

Creating and loading data tables

Data cleaning and formatting

Performing UPDATE, DELETE, and ALTER operations

Running analytical queries for insights

⚙️ Steps Performed
🧹 1. Data Cleaning

Removed incomplete or invalid records

Standardized text and numeric columns (strike_rate, average, etc.)

Handled inconsistent data formats

🧱 2. Database Setup

Created a database retail_db and table odi_cricket_data

Loaded data from a CSV file using LOAD DATA INFILE command

Defined appropriate data types for each column

🧩 3. SQL Operations

UPDATE → Modified statistics such as strike rate, average, and total runs

DELETE → Removed records of retired or inactive players

ALTER → Adjusted column properties to handle data inconsistencies

INSERT → Added new player data entries

📊 4. Data Analysis Queries

Categorized players based on:

Role (Batter, Bowler, All-Rounder)

Total Runs (Legend, Great Player, Average Player, Newcomer)

Wickets Taken (Elite, Experienced, Developing, etc.)

Matches Won and Player of the Match Awards

Retrieved:

Top 10 batsmen by total runs

Top 10 bowlers by total wickets

Classification of players by match impact

🧰 Tools & Technologies

Database: MySQL

Language: SQL

Environment: MySQL Workbench / Command Line / MyCompiler

📂 Files Included

odi dataset.sql → Main SQL script containing all database commands

ODI_data.csv → Dataset file (to be placed in the upload directory for MySQL)

README.md → Project documentation

🏁 Key Learnings

Data cleaning and preprocessing in SQL

Query-based player performance analysis

Using conditional logic (CASE statements) for data classification

Mastery of core SQL operations: INSERT, UPDATE, DELETE, and SELECT
