# Crime In Portugal: A Data Analysis for a Security Company

## Project links
* [The Crime_Report](https://github.com/Melissa-Naldo/Crime_In_Portugal/blob/main/Crimes_Pt_Report.docx) for this analysis contains every process I did to finish the goal of this project;
* [The original dataset](https://github.com/Melissa-Naldo/Crime_In_Portugal/blob/main/portugal_crime_2011-2019%20-%20Raw.xlsx);
* [The cleaned dataset](https://github.com/Melissa-Naldo/Crime_In_Portugal/blob/main/portugal_crime_2011-2019_Organized.xlsx);
* [The SQL queries](https://github.com/Melissa-Naldo/Crime_In_Portugal/blob/main/SQL_Crime.sql);
* [The Power BI report](https://github.com/Melissa-Naldo/Crime_In_Portugal/blob/main/Crime_Report.pbix).

## Introduction:

In an increasingly interconnected world, security has become a top priority for both individuals and businesses. For a company in the security alarm industry, gaining insights into the local crime landscape is crucial. This project is driven by the necessity for a security alarm company to understand the crime situation in Portugal as it establishes their presence in this Mediterranean country. The company's vision extends to three major cities—Lisbon, Porto, and Algarve—where they intend to open offices. However, they question whether these are the optimal locations to open the new offices?

### Dataset

![Regions of Portugal](https://github.com/Melissa-Naldo/Crime_In_Portugal/blob/main/Images/Figure%201.png)

Figure 1 - Regions of Portugal.

To achieve this goal, I used a [Kaggle dataset](https://www.kaggle.com/datasets/sameerkulkarni91/portugal-crime-statistics-20112019?select=portugal_consolidated_2011-2019.xlsx) that has the registered number of crimes in the country of Portugal by different locations and from the year 2011 to the 2019.

The dataset, sourced from Kaggle, provides a comprehensive overview of crime statistics in Portugal spanning from 2011 to 2019. This comprehensive dataset comprises of 166 columns and 312 rows, it offers a wealth of data points that paint a detailed picture of crime across different regions (figure 1). The columns are Territory, Region, Intermunicipallity, Municipallity and the subsequent columns are the number of crimes committed separated by different type of crimes and years (figure 2). The first four are text datatype values and the rest are numbers type. 

![Original dataset in github](https://github.com/Melissa-Naldo/Crime_In_Portugal/blob/main/Images/Figure%202.png)

Figure 2 - Original dataset.

### List of questions

  This analysis is guided by a set of pertinent questions that aims to uncover the underlying patterns in crime data and inform the company's strategic decisions:
* I.	How many crimes were reported in Portugal from 2011 to 2019?
* II.	What is the extent of crimes against patrimony within the same period?
* III.	How do crime rates vary across regions, and what is the average crime rate in each region?
* IV.	How has crime evolved over the years?
* V.	What are the top 10 municipalities with the highest crime rates?
* VI.	What are the top 3 locations to open the offices that would be most beneficial for the company?

## Conclusion
The objective of this project was to determine the optimal regions in Portugal for a home alarm security company to establish its first offices. With a focus on three major cities—Lisbon (AM Lisboa), Porto (Norte), and Algarve—the analysis delved into understanding the general crime condition of Portugal and, more specifically, crimes against patrimony (house-related crimes).
  
After my analysis process, we could see that between 2011 and 2019 there were 3 206 681 crimes report with an average of 356 298 per year. Of all those crimes, more than half were crimes against patrimony with a value of 1 702 774 and this crime category had an average of 189 197 crimes per year. The overall crime had a decrease 19.5% from 2011 to 2016, still in the following years an increase in crime of 0.35% took place. However, the crime against patrimony had a significant decrease of 25.86%, in spite of the increase of total crime from 2016 to 2019. 
 
Focusing even more on my different regions, I know that the ones with most crime and crime against patrimony are AM Lisboa, Norte, Algarve and Centro. The following figure represents the crime values of these different regions:
 
![- Comparison of total crime and crimes against patrimony between the top 4 regions.](https://github.com/Melissa-Naldo/Crime_In_Portugal/blob/main/Images/Figure%2018.png)

Figure 18 - Comparison of total crime and crimes against patrimony between the top 4 regions.
	
If we focus on our average values, then we would rate Lisbon as the main location to open the offices and then Algarve and Norte. This would exclude the Centro region which has a significantly higher total crime value than Algarve, in spite of that we know that Algarve is significantly smaller with only 16 municipalities in comparison to Centro with 100 municipalities. 
  
Going even further into this analysis by taking a closer look at the municipalities, it’s known that the top 10 municipalities with most crime belong to AM Lisboa and Porto. As for the Algarve region, the municipality with most crime is ranked number 12 on the list of municipalities with most crime against patrimony.  
 
Based on the analysis, AM Lisboa, followed by Norte and Algarve, emerges as the most favourable locations for opening offices. These locations would be most beneficial because they exhibit the highest average crime values. While the analysis points towards specific regions, it's crucial to adapt recommendations based on real-time data, local policies, and the evolving nature of crime. A comprehensive understanding of the population dynamics would further refine the evaluation.

# Crime_in_Portugal_Dashboard
![Crime in Portugal](https://github.com/Melissa-Naldo/Crime_In_Portugal/blob/main/Images/Figure%209.png)

![Top 10 Locations](https://github.com/Melissa-Naldo/Crime_In_Portugal/blob/main/Images/Figure%2010.png)

