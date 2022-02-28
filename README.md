# Final_Project-Group1
Shared Repository for Rutgers Bootcamp Final Project

# Deliverable 1: Presentation
 
## Topic: Life Expectancy and Happiness Around The World

## Why We Chose This Topic:

After much deliberation and consideration of various datasets, sources, and general topics, we’ve decided to explore life expectancy as well as a variety of related factors encompassing health, society, economics, and geography on an international scale. As a team, we’ve been drawn mainly to datasets relating to geography and geopolitics, as such topics are ripe for interesting visualizations of broad and specific international trends. We’ve ultimately decided to explore life expectancy and the factors that might influence it as these datasets are relatively manageable and direct while still offering wide potential for feature analysis, visualizations, and unique insights.

## Data Sources:

Our main dataset, Life Expectancy data from the World Bank, is the baseline for which we are building and expanding our project. Using this dataset to guide us, we have also brought in a wide variety of features from more extensive or specific additional databases, listed in detail in the following document: 
[Source_References.xlsx](https://github.com/Ryan-Fried/Final_Project-Group1/files/8149293/Source_References.xlsx)

To study the correlation between life expectancy and happiness we will be using this dataset:
https://www.kaggle.com/unsdsn/world-happiness

## What Questions Do We Hope to Answer?

- We intend to explore the relationship between life expectancy and the various features that effect that metric. In doing so we are asking which factors, if any, have the most significant influence on life expectancy, and which of these factors are closely correlated with each other. For example, we are particularly interested in examining the relationship between life expectancy and Happiness Score.
- We will attempt to predict life expectancy using these various factors. Additionally, we will attempt to predict the development status of a country using life expectancy and the other related factors. 
- We will use the process of clustering to explore the relationships, similarities, and differences between countries as would be determined by these factors.
- Essentially, we hope that by posing these questions and performing this analysis, we might be able to determine which factors carry the most weight in influenceing each other, with life expectancy as our central focus. As this data represents reality, it may also serve real world applications. If a country were to strive to improve life expectancy, or evolve any one of these metrics, our project may shed some light on the most direct and effective ways of doing so and improving the lives of its citizens.

## Communication Protocols?

The team is mainly communicating via Slack. Additionally, we have been and plan to meet continually on Zoom, both in and out of class time. We've broken down the duties each week according to the suggestion of the module. These roles are as follows: 
- Person 1 (Douglas)
  - Week 1 - Identify Tools and Tech
  - Week 2 - Machine Learning
  - Week 3 - GitHub
  - Week 4 - ReadMe
- Person 2 (Aparna)
  - Week 1 - SQL DB Framework
  - Week 2 - Dashboard Ideas
  - Week 3 - Dashboard Build
  - Week 4 - GitHub - Verify and Finalize
- Person 3 (Dhanushree)
  - Week 1 - Machine Learning
  - Week 2 - DB Connections Loading
  - Week 3 - Testing Model
  - Week 4 - Dashboard Fine-Tuning
- Person 4 (Ryan)
  - Week 1 - GitHub
  - Week 2 - Visualization Ideas
  - Week 3 - Presentation
  - Week 4 - Helping Other Team Members

## Tools and Tech

Outline of the workflow we plan to impliment for our project:
![Prog_Design (2)](https://user-images.githubusercontent.com/91569387/155899322-5182f176-2b76-49e0-8232-71a2c3780d84.png)

### Data Cleaning and Analysis
- R - Cleaning, preparing, and performing statistical analysis on data
- Python - Used to connect to our database, perform the ETL process, and implement our Machine Learning models
### Database Storage
- PostgreSQL - Database - This is our ERD layout of how our database will be structured:
![ERD_Draft](https://user-images.githubusercontent.com/91569387/155905655-44a11d79-ee0f-46cc-a857-560a903547fc.png)
### Machine Learning
- SciKitLearn - Machine Learning Library
- Multiple Linear Regression - to be used to predict life expectancy
- RandomForest - used to predict the development status of countries
- KMeans Clustering - used to cluster countries
- Jupyter Notebook - will be used to conduct machine learning analysis
### Dashboard
- Tableau - Visualization focused dashboard

### AWS - Cloud server
