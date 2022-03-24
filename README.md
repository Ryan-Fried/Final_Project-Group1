## Topic: Life Expectancy and Related Factors

The following information and as well as images and further elaboration can be found in our presentation: [Google Slides Presentation](https://docs.google.com/presentation/d/1JxmIoD-Dh8Wg0N47L849nC_RK8qWd1ZbPwPxcmV6JiQ/edit?usp=sharing)

## Why We Chose This Topic:

After much deliberation and consideration of various datasets, sources, and general topics, we’ve decided to explore life expectancy as well as a variety of related factors encompassing health, society, economics, and geography on an international scale. As a team, we’ve been drawn mainly to datasets relating to geography and geopolitics, as such topics are ripe for interesting visualizations of broad and specific international trends. We’ve ultimately decided to explore life expectancy and the factors that might influence it as these datasets are relatively manageable and direct while still offering wide potential for feature analysis, visualizations, and unique insights.

## Data Sources:

Our main dataset, Life Expectancy data from the World Bank, is the baseline for which we are building and expanding our project. Using this dataset to guide us, we have also brought in a wide variety of features from more extensive or specific additional databases, listed in detail in the following document: 
[Source_References.xlsx](https://github.com/Ryan-Fried/Final_Project-Group1/files/8149293/Source_References.xlsx)

To study the correlation between life expectancy and happiness we will be using this dataset:
[World Happiness Report- Kaggle](https://www.kaggle.com/unsdsn/world-happiness)

## What Questions Do We Hope to Answer?

- What is the relationship between life expectancy and some development, socio-economic and health factors?
- Can we predict life expectancy using some of the development, socio-economic and health factors?
- Can we predict development status of a country using some of the same indicators?
- What is the relationship between life expectancy and the happiness score? Can we predict happiness based on life expectancy?
 - How do the countries cluster based on the available indicators?
 - How does life expectancy look like around the world?

## Project Design
Outline of the workflow we have implemented for our project:
![Project Design](https://github.com/Ryan-Fried/Final_Project-Group1/blob/main/Images/Prog_Design.png)

## ETL
File: [ETL](https://github.com/Ryan-Fried/Final_Project-Group1/blob/ccce2ee579de991f37b3af4be9cd54204bbee535/ETL/Data_ETL.Rmd)

Language: R<br />
Libraries used: tidyverse, dplyr, naniar, TSImpute, Countrycoder, RPostgres

### The Process
- For each dataset, dropped unwanted columns, tranformed to long format, subsetted data to required timeframe
- Missing data: Filtered to countries with 80% data, interpolated missing values
- Merged data into one of 5 categories and converted to long format
- Published to database

## Database Structure
![ERD_Final](https://github.com/Ryan-Fried/Final_Project-Group1/blob/main/Sql/ERD_Final.PNG)

## EDA
File: [Exploratory Analysis](https://github.com/Ryan-Fried/Final_Project-Group1/blob/ccce2ee579de991f37b3af4be9cd54204bbee535/EDA/Data_EDA.Rmd)

Language: R, Python<br />
Libraries used:<br />
  R: tidyverse, RPostgres, DataExplorer<br />
  Python: pandas, matplotlib, seaborn

### Analysis
- Joined all data using unions and join and stored in view
- Retrieved data from database, converted to wide format and profiled the data
- Dropped columns to improve data quality based on profile report
- Performed statistical analysis on the data
- Plotted correlation matrix, scatter plots and distribution plots using matplotlib and seaborn

## Life Expectancy and Happiness
File: [Happiness Study](https://github.com/Ryan-Fried/Final_Project-Group1/blob/ccce2ee579de991f37b3af4be9cd54204bbee535/HAPS_LE_Regression/HAPS_LE_regression_Ryan.ipynb)

Language: Python<br />
Libraries used: pandas, matplotlib, seaborn, sklearn, sqlalchemy

### Analysis
- Retrieved data from database and converted to wide format
- Studied relationship between life expectancy and happiness using scatter plots, regression plot and correlation value
- Created a model to predict happiness score based on life expectancy

## Machine Learning
File: [Predictive Analysis](https://github.com/Ryan-Fried/Final_Project-Group1/blob/ccce2ee579de991f37b3af4be9cd54204bbee535/Machine%20Learning/Predictive_Analysis.ipynb)

Language: Python<br />
Libraries used: pandas, matplotlib, sklearn

Objectives:
- Predict life expectancy using Multiple Linear Regression
- Predict the status of a country using Random Forest Classification
- Study clusters in data using KMeans Clustering

### Predicting Life Expectancy
Algorithm: Multiple Linear Regression

_Preprocessing:_ ETL in R>Dropped NAs> Dropped description columns

_Feature Engineering and Selection:_ Data profiling and statistical analysis> Dropped columns based on insufficient data and low p-value> Set Life expectancy as Y and remaining 11 indicators as X features

_Training and Testing:_ Split the data into training and testing> Normalized the data using MinMaxScaler> Trained the model using training dataset> Predicted the data using testing dataset

**R2 Score:** 0.995<br />
**Mean Residual Error:** 0.462<br />
**Training Score:** 0.994<br />
**Testing Score:** 0.995<br />
**Intercept**: 58.169<br />

Result: The high R2 score, testing score and low mean residual error indicate that the model is a well performing model

Why this model?:
- Life expectancy is continuous variable requiring the use of a regression model
- Multiple features were involved, requiring the use of multiple linear regression

### Predicting Status
Algorithm: Random Forest Classifier

_Preprocessing:_ ETL in R>Dropped NAs> Dropped all description columns except status

_Feature Engineering and Selection:_ Set Status as target and all other indicators as X features

_Training and Testing:_ Split the data into training and testing> Normalized the data using MinMaxScaler> Trained the model using training dataset> Predicted the data using testing dataset> Studied accuracy score, confusion matrix and classification report> Studied feature importance

**Accuracy Score:** 1.00<br />
**True Positive:** 56<br />
**False Positive:** 0<br />
**True Negative:** 499<br />
**False Negative:** 0<br />

Result: Random Forest Classifier resulted in a accuracy score of 1, indicating that the model performed well 

Why this model?:
- A recommended model for classification data
- Compared to Logistic Regression model, provided better accuracy and is less prone to overfitting


### Studying Clusters
Algorithm: KMeans Clustering

_Preprocessing:_ ETL in R>Dropped NAs> Dropped all description columns except status> Converted status to numeric using OneHotEncoder and merged it to main dataframe> Normalized the data

_Feature Engineering and Selection:_ Dimensionality reduction to 3 using PCA> Calculated elbow curve to determine number of clusters  

_Clustering:_  Performed KMeans clustering and determined group for each dataset> Merged data back to main dataframe> Created hvplot 

**PCA**: 4 components<br /> 
**Explained Variance Ratio:** 0.84<br />
**K clsuters:** 3, based on Elbow curve<br />

Result: 
- Cluster 2 stands out separately and is mainly comprised of countries in the Europe and Central Asia region
- Cluster 0 is mainly comprised of Sub-Saharan Africa

Why this model?:
- Model commonly used for clustering data
- Model is relatively fast, but lacks consistency and repeatability since it starts with a random centre

## Dashboard

[Tableau Dashboard](https://public.tableau.com/app/profile/dhanushree/viz/LifeExpectancy_16478476299440/Main?publish=yes)

