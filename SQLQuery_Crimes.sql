SELECT TOP (1000) [Territory]
      ,[Region]
      ,[Int_community]
      ,[Municipality]
      ,[Year]
      ,[Total]
      ,[C_persons]
      ,[C_patrimony]
      ,[C_life_society]
      ,[C_State]
      ,[C_sundry_leg]
  FROM [Crime in Portugal - Security Company].[dbo].[Crime_Pt]

  SELECT 
TABLE_CATALOG,
TABLE_SCHEMA,
TABLE_NAME, 
COLUMN_NAME, 
DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS


-- The company wants to see Total Crimes Values in Portugal since 2011 and how it changes over the years

Select Sum(Total) as Total_Crimes, AVG(Total) as Avg_Crimes
From [Crime in Portugal - Security Company].[dbo].[Crime_Pt]


Select Region, SUM(Total) AS Sum_Crimes_per_Region, round(AVG(Total), 2) AS AVG_Crimes_per_Region
From[Crime in Portugal - Security Company].[dbo].[Crime_Pt]
Group by Region
Order by AVG(Total) desc

Select Year, Sum(Total) as Total_Crimes_Year, round(AVG(Total), 2) as Avg_Crimes_Year
From [Crime in Portugal - Security Company].[dbo].[Crime_Pt]
Group by Year

-- The Avg_crimes doesn't seem to be correct, it seems to be too low

With Table_avg as(
Select Year, Sum(Total) as total, SUM(C_patrimony) as sumpatrimony
From [Crime in Portugal - Security Company].[dbo].[Crime_Pt]
Group by Year)

Select round(avg(total), 2) as avg_crimes, round(avg(sumpatrimony), 2) as avg_crimes_patrimony
From Table_avg

-- I'd like to create a table with the correct values so I can use it latter on my report

Create Table Updated_Crime_Average (
Avg_Total decimal(8, 2),
Avg_Patrimony decimal(8, 2))

Insert into Updated_Crime_Average Values
(348254.72, 189197.11)

Select *
From Updated_Crime_Average

-- However It is also important to see how Crime has evolved over the years, especially in AM Lisbon, Norte and Algarve (Main areas the company wants to open)

Select Region, Year, SUM(Total) AS Sum_Crimes_per_Region, round(AVG(Total), 2) AS AVG_Crimes_per_Region
From[Crime in Portugal - Security Company].[dbo].[Crime_Pt]
Group by Region, Year
Order by AVG(Total) desc

Select Region, Year, SUM(Total) AS Sum_Crimes_per_Region, round(AVG(Total), 2) AS AVG_Crimes_per_Region
From[Crime in Portugal - Security Company].[dbo].[Crime_Pt]
Where Region In ('Norte', 'AM Lisboa', 'Algarve')
Group by Region, Year
Order by AVG(Total) desc


--Knowing the values for all the crimes is important but the company works with security alarms for houses, so they're interested in looking at the crimes against patrimony and after 2015

Select SUM(C_patrimony)
From [Crime in Portugal - Security Company].[dbo].[Crime_Pt]

Select Region, SUM(C_patrimony) AS Sum_Crimes_patrimony, round(AVG(C_patrimony), 2) AS AVG_Crimes_patrimony
From[Crime in Portugal - Security Company].[dbo].[Crime_Pt]
Where Region In ('Norte', 'AM Lisboa', 'Algarve')
Group by Region
Order by AVG(Total) desc


Select Region, Year, SUM(C_patrimony) AS Sum_Crimes_patrimony, round(AVG(C_patrimony), 2) AS AVG_Crimes_patrimony
From[Crime in Portugal - Security Company].[dbo].[Crime_Pt]
Where Region In ('Norte', 'AM Lisboa', 'Algarve')
Group by Region, Year
Having Year>=2015
Order by AVG(Total) desc

Select Region, Year, SUM(C_patrimony) AS Sum_Crimes_patrimony, round(AVG(C_patrimony), 2) AS AVG_Crimes_patrimony
From[Crime in Portugal - Security Company].[dbo].[Crime_Pt]
Where Region In ('Norte', 'AM Lisboa', 'Algarve')
Group by Region, Year
Having Year=2019
Order by AVG(Total) desc

-- The previous values where relative to AM Lisboa, Norte and Algarve, the locations the company whishes to open. Nonetheless, where are the locations with most crime and crime against patrimony

Select Region, 
Municipality,  
C_patrimony,
Total
From [Crime in Portugal - Security Company].[dbo].[Crime_Pt]
Where Year=2019
Order by C_patrimony desc

-- From all these values from the previous query which are the Top 10 Municipalities with most crimes against patrimony
With Crimes_2019 AS
(Select Region, 
Municipality,  
C_patrimony,
Total
From [Crime in Portugal - Security Company].[dbo].[Crime_Pt]
Where Year=2019)

Select Top 10 *
From Crimes_2019
Order by C_patrimony desc

