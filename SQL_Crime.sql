SELECT TOP (1000) [Territory]
      ,[Region]
      ,[Intermunicipality]
      ,[Municipality]
      ,[Year]
      ,[Crime_type]
      ,[Occurences]
  FROM [Portugal_Crime].[dbo].[Security Company Crime Dataset]

  -- I want to look at the characteristics of my data
    SELECT 
TABLE_CATALOG,
TABLE_SCHEMA,
TABLE_NAME, 
COLUMN_NAME, 
DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS

-- The company wants to see total crimes values and the total crimes agains patrimony values in Portugal since 2011 and how it changes over the years

Select Sum(Occurences) as Total_Crimes, round(AVG(Occurences), 2) as Avg_Crimes
From [dbo].[Crime Data]

Select Crime_type, Sum(Occurences) as Total_Crimes, round(AVG(Occurences), 2) as Avg_Crimes
From [dbo].[Crime Data]
Group by Crime_type

Select Region, SUM(Occurences) AS Sum_Crimes_per_Region, round(AVG(Occurences), 2) AS AVG_Crimes_per_Region
From [dbo].[Crime Data]
Group by Region
Order by AVG(Occurences) desc

Select Year, Sum(Occurences) as Total_Crimes_Year, round(AVG(Occurences), 2) as Avg_Crimes_Year
From [dbo].[Crime Data]
Group by Year

-- The average value of crimes is extremely low, so I'm going to use the values from my last query to try and understand the real value of my average

With Total_crime_avg as(Select 
Year, 
Sum(Occurences) as total
From [dbo].[Crime Data]
Group by Year
)

Select round(avg(total), 2) as avg_crimes
From Total_crime_avg

With Patrimony_crime_avg as (Select 
Year, 
Sum(Occurences) as total
From [dbo].[Crime Data]
Where Crime_type = ' Crimes against patrimony '
Group by Year
)

Select round(avg(total), 2) as avg_patrimony_crimes
From Patrimony_crime_avg


Select Region, SUM(Occurences) AS Sum_Crimes_per_Region, round((SUM(Occurences)/9), 2)  AS AVG_Crimes_per_Region_per_Year
From [dbo].[Crime Data]
Where Crime_type = ' Crimes against patrimony '
Group by Region
Order by (SUM(Occurences)/9) desc


-- I'd like to create a table with the correct values so I can use it latter on my report

Create Table Updated_Crime_Average (
Avg_Total decimal(8, 2),
Avg_Patrimony decimal(8, 2))

Insert into Updated_Crime_Average Values
(348254.72, 189197.11)

Select *
From Updated_Crime_Average


-- However It is also important to see how Crime has evolved over the years, especially in AM Lisbon, Norte and Algarve (Main areas the company wants to open)

Select Region, Year, SUM(Occurences) AS Sum_Crimes_per_Region, round(AVG(Occurences), 2) AS AVG_Crimes_per_Region
From [dbo].[Crime Data]
Group by Region, Year
Order by Avg(Occurences) desc

Select Region, Year, SUM(Occurences) AS Sum_Crimes_per_Region, round(AVG(Occurences), 2) AS AVG_Crimes_per_Region
From [dbo].[Crime Data]
Where Region In ('Norte', 'AM Lisboa', 'Algarve', 'Centro') -- I hadded Centro because in the previous queries it presented itsel as a possible location for the company to open
Group by Region, Year
Order by Sum(Occurences) desc



--Knowing the values for all the crimes is important but the company works with security alarms for houses, so they're interested in looking at the crimes against patrimony and after 2015


Select Region, Year, SUM(Occurences) AS Sum_Patrimony_Crimes, round(AVG(Occurences), 2) AS AVG_Crimes_patrimony
From [dbo].[Crime Data]
Where Crime_type = ' Crimes against patrimony '
Group by Region, Year
Having Year>=2015 AND  Region In ('Norte', 'AM Lisboa', 'Algarve', 'Centro')
Order by AVG(Occurences) desc

-- I would like to create a table for the total and average patrimony crimes per region. However, for this one I used a different strategy to create the table (manually created it in the object explorer and then edited the top 200 rows)

Select Region, SUM(Occurences) AS Sum_Patrimony_Crimes, round(AVG(Occurences), 2) AS AVG_Crimes_patrimony
From [dbo].[Crime Data]
Where Crime_type = ' Crimes against patrimony '
Group by Region
Order by AVG(Occurences) desc


-- The previous values where relative to the regions. However, where are the locations (municipalities) with most crime and crime against patrimony in 2019

Select Year,
Region, 
Municipality,  
Occurences
From [dbo].[Crime Data]
Where Crime_type = ' Crimes against patrimony 'AND Year=2019
Order by Occurences desc


-- From all these values from the previous query which are the Top 10 Municipalities with most crimes against patrimony
With Crimes_2019 AS
(Select Year,
Region, 
Municipality,  
Occurences
From [dbo].[Crime Data]
Where Crime_type = ' Crimes against patrimony 'AND Year=2019)

Select Top 10 *
From Crimes_2019
Order by Occurences desc