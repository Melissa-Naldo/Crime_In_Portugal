SELECT TOP (1000) [Territory]
      ,[Region]
      ,[Intermunicipality]
      ,[Municipality]
      ,[Year]
      ,[Crime_type]
      ,[Occurences]
  FROM [Portugal_Crime].[dbo].[dbo].[Crime Data]

  -- I want to look at the characteristics of my data
    SELECT 
TABLE_CATALOG,
TABLE_SCHEMA,
TABLE_NAME, 
COLUMN_NAME, 
DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS

-------- I'm going to find the sum and averages of my occurences and see how they change durnig the years and in the different regions

---- The whole data
Select Sum(Occurences) as Total_Crimes, round(AVG(Occurences), 2) as Avg_Crimes
From [dbo].[Crime Data]

Select Region, SUM(Occurences) AS Sum_Crimes_per_Region, round(AVG(Occurences), 2) AS AVG_Crimes_per_Region
From [dbo].[Crime Data]
Group by Region
Order by AVG(Occurences) desc


Select Year, Sum(Occurences) as Total_Crimes_Year
From [dbo].[Crime Data]
Group by Year
Order by Sum(Occurences) desc

-- I want to understand the percentage of change in crime rate durinf these years
Select Year, Sum(Occurences) as Total_Crimes_Year, lag(Sum(Occurences)) Over (Order by Year) as Pre_Year_Crime, ((((Sum(Occurences))-(lag(Sum(Occurences)) OVER (Order by Year)))/(lag(Sum(Occurences)) OVER (Order by Year)))*100) as Percentage_Difference
From [dbo].[Crime Data]
Group by Year
Order by Year

Select Year, Sum(Occurences) as Total_Crimes_Year, lag(Sum(Occurences)) Over (Order by Year) as Pre_Year_Crime, ((((Sum(Occurences))-(lag(Sum(Occurences)) OVER (Order by Year)))/(lag(Sum(Occurences)) OVER (Order by Year)))*100) as Percentage_Difference
From [dbo].[Crime Data]
Where Year in (2011, 2016, 2017, 2019)
Group by Year
Order by Year

-- How have the total crimes evolved over the years in the different regions
Select Region, Year, SUM(Occurences) AS Sum_Crimes_per_Region, Rank() OVER (Order by SUM(Occurences) desc) as Rank 
From [dbo].[Crime Data]
Group by Region, Year
Order by Sum(Occurences) desc

-- However It is important for the company too take a careful look at the amount of crimes in AM Lisbon, Norte and Algarve (Main areas the company wants to open). Plus, I hadded the Centro given the information that Centro was the third location with most crimes
Select Region, Year, SUM(Occurences) AS Sum_Crimes_per_Region, round(AVG(Occurences), 2) AS AVG_Crimes
From [dbo].[Crime Data]
Where Region In ('Norte', 'AM Lisboa', 'Algarve', 'Centro')
Group by Region, Year
Order by Sum(Occurences) desc

---- Having taken a look at the total crimes, I can now take a closer look at the patrimony crimes

Select Crime_type, Sum(Occurences) as Total_Patrimony_Crimes, round(AVG(Occurences), 2) as Avg_Crimes
From [dbo].[Crime Data]
Group by Crime_type


-- How does the patrimony crimes evolve over the years?
Select Year, Sum(Occurences) as Total_Patrimony_Crimes, round(AVG(Occurences), 2) as Avg_Crimes
From [dbo].[Crime Data]
Where Crime_type = ' Crimes against patrimony '
Group by Year
Order by Total_Patrimony_Crimes desc

-- I want to understand the different crime rates over the years in percentages
Select Year, Sum(Occurences) as Total_Patrimony_Crimes, (lag(Sum(Occurences)) OVER (Order by Year)) as Pre_Year_TotalCrime, ((((Sum(Occurences))-(lag(Sum(Occurences)) OVER (Order by Year)))/(lag(Sum(Occurences)) OVER (Order by Year)))*100) as Percentage_Difference
From [dbo].[Crime Data]
Where Crime_type = ' Crimes against patrimony '
Group by Year
Order by Year 

Select Year, Sum(Occurences) as Total_Patrimony_Crimes, (lag(Sum(Occurences)) OVER (Order by Year)) as Pre_Year_TotalCrime, ((((Sum(Occurences))-(lag(Sum(Occurences)) OVER (Order by Year)))/(lag(Sum(Occurences)) OVER (Order by Year)))*100) as Percentage_Difference
From [dbo].[Crime Data]
Where Crime_type = ' Crimes against patrimony ' and Year in (2011, 2019)
Group by Year
Order by Year

-- How do they change depending on the region?
Select Region, Sum(Occurences) as Total_Patrimony_Crimes, round(AVG(Occurences), 2) as Avg_Patrimony_Crimes
From [dbo].[Crime Data]
Where Crime_type = ' Crimes against patrimony '
Group by Region
Order by SUM(Occurences) desc


Select Region, Year, SUM(Occurences) AS Sum_Patrimony_Crimes, round(AVG(Occurences), 2) AS AVG_Crimes_patrimony
From [dbo].[Crime Data]
Where Crime_type = ' Crimes against patrimony '
Group by Region, Year
Having  Region In ('Norte', 'AM Lisboa', 'Algarve', 'Centro')
Order by Sum(Occurences) desc

-- The previous values where relative to the regions. However, where are the locations (municipalities) with most crime and crime against patrimony in 2019?

Select Year,
Region, 
Municipality,  
Occurences,
Rank() Over (order by Occurences desc) as Rank
From [dbo].[Crime Data]
Where Crime_type = ' Crimes against patrimony 'AND Year=2019
Order by Occurences desc

-- From all these values from the previous query which are the Top 10 Municipalities with most crimes against patrimony
Select Top(10) Year,
Region, 
Municipality,  
Occurences
From [dbo].[Crime Data]
Where Crime_type = ' Crimes against patrimony 'AND Year=2019
Order by Occurences desc


-------- Correct average - after performing the previous queries It is possible to understand that my average values are incorrect. This part of my SQL queries is going to be dedicated to correcting those averages

----Total- The average value of crimes is extremely low, so I'm going to use the values from my last query to try and understand the real value of my total crime average 

--Correcting the overall average
With Total_crime_avg as(Select 
Year, 
Sum(Occurences) as total
From [dbo].[Crime Data]
Group by Year
)

Select round(avg(total), 2) as avg_crimes_per_year
From Total_crime_avg

-- Correcting the average per Region
Select Region, Count(Distinct(Municipality)) as Nº_municipalities, SUM(Occurences) AS Sum_Crimes, round((SUM(Occurences)/Count(Distinct(Municipality))), 2)  AS AVG_Crimes
From [dbo].[Crime Data]
Group by Region
Order by round((SUM(Occurences)/Count(Distinct(Municipality))), 2) desc


-----Patrimony - I'm going to do the same correction but focused on my patrimony crime

--Correcting the overall patrimony crime average
With Patrimony_crime_avg as (Select 
Year, 
Sum(Occurences) as total
From [dbo].[Crime Data]
Where Crime_type = ' Crimes against patrimony '
Group by Year
)

Select round(avg(total), 2) as avg_patrimony_crimes
From Patrimony_crime_avg

--Correcting my overall average per region
Select Region, Count(Distinct(Municipality)) as Nº_municipalities, SUM(Occurences) AS Sum_Crimes, round((SUM(Occurences)/Count(Distinct(Municipality))), 2)  AS AVG_Crimes
From [dbo].[Crime Data]
Where Crime_type = ' Crimes against patrimony '
Group by Region
Order by round((SUM(Occurences)/Count(Distinct(Municipality))), 2) desc


-- Correcting the average per region and year
Select Year, Region,  Count(Distinct(Municipality)) as Nº_municipalities, SUM(Occurences) AS Sum_Patrimony_Crimes, round((SUM(Occurences)/Count(Distinct(Municipality))), 2)  AS AVG_Patrimony_Crimes
From [dbo].[Crime Data]
Where Crime_type = ' Crimes against patrimony '
Group by Region, Year
Having  Region In ('Norte', 'AM Lisboa', 'Algarve', 'Centro')
Order by round((SUM(Occurences)/Count(Distinct(Municipality))), 2) desc


--------Creating tables with information I would like to use in the future for my visualization 

-- I'd like to create a table with the correct AVG values for my total crime and patrimony crime so I can use it latter on my report

Create Table Updated_Crime_Average (
Avg_Total decimal(8, 2),
Avg_Patrimony decimal(8, 2))

Insert into Updated_Crime_Average Values
(348254.72, 189197.11)

Select *
From Updated_Crime_Average

-- I would like to create a table for the total and average patrimony crimes per region. However, for this one I used a different strategy to create the table (manually created it in the object explorer and then edited the top 200 rows)
