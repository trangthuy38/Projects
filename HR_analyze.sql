select * from hr_rmp

--Attrition by Gender
with a as (
			select Gender, count(Attrition) as Attrition
		    from hr_rmp
			where Attrition = 1
			group by Gender),
b as (
			select Gender, count(Attrition) as Total_Employees
		    from hr_rmp
			group by Gender)
select b.Gender, b.Total_Employees, a.Attrition, CAST(ROUND((a.Attrition*1.0/ b.Total_Employees) * 100, 2) AS DECIMAL(9, 2)) as Attrition_Rate
from a 
inner join b 
on a.Gender = b.Gender 

--Attrition by Business Travel
with a as (
			select BusinessTravel, count(Attrition) as Attrition
		    from hr_rmp
			where Attrition = 1
			group by BusinessTravel),
b as (
			select BusinessTravel, count(Attrition) as Total_Employees
		    from hr_rmp 
			group by BusinessTravel),
c as (
			select BusinessTravel, avg(MonthlyIncome) as Avg_MonthlyIncome 
		    from hr_rmp
			where Attrition = 1
			group by BusinessTravel)
select a.BusinessTravel,
	   c.Avg_MonthlyIncome,
       b.Total_Employees,
	   a.Attrition, 
	   CAST(ROUND((a.Attrition*1.0/ b.Total_Employees) * 100, 2) AS DECIMAL(9, 2)) as Attrtion_Rate
from a 
inner join b 
on a.BusinessTravel = b.BusinessTravel
inner join c 
on a.BusinessTravel = c.BusinessTravel

--Attrition by Age 
with a as(
		  select 
		  case 
		  when Age>0 and Age<=20 then '20-'
		  when Age>20 and Age<=30 then '20-30'
		  when Age>30 and Age<=40 then '30-40'
		  when Age>40 and Age<=50 then '40-50'
		  else '50+' 
		  end as AgeGroup, 
		  Age,
		  Attrition
		  from hr_rmp),
b as (
			select AgeGroup, count(Attrition) as Attrition
		    from a
			where Attrition = 1
			group by AgeGroup),
c as (
			select AgeGroup, count(Attrition) as Total_Employees
		    from a
			group by AgeGroup)
select 
       b.AgeGroup,
	   c.Total_Employees,
	   b.Attrition,
	   CAST(ROUND((b.Attrition*1.0/ c.Total_Employees) * 100, 2) AS DECIMAL(9, 2)) as churnrate
from b
inner join c
on b.AgeGroup = c.AgeGroup 
order by b.AgeGroup

--Attrition by Department 
with a as (
			select Department, count(Attrition) as Attrition
		    from hr_rmp
			where Attrition = 1
			group by Department),
b as (
			select Department, count(Attrition) as Total_Employees
		    from hr_rmp
			group by Department)
select b.Department, b.Total_Employees, a.Attrition, CAST(ROUND((a.Attrition*1.0/ b.Total_Employees) * 100, 2) AS DECIMAL(9, 2)) as Attrition_Rate
from a 
inner join b 
on a.Department = b.Department

--Attrition by Job Role
with a as (
			select JobRole, count(Attrition) as Attrition
		    from hr_rmp
			where Attrition = 1
			group by JobRole),
b as (
			select JobRole, count(Attrition) as Total_Employees
		    from hr_rmp 
			group by JobRole),
c as (
			select JobRole, avg(MonthlyIncome) as Avg_MonthlyIncome 
		    from hr_rmp
			where Attrition = 1
			group by JobRole)
select a.JobRole,
	   c.Avg_MonthlyIncome,
       b.Total_Employees,
	   a.Attrition, 
	   CAST(ROUND((a.Attrition*1.0/ b.Total_Employees) * 100, 2) AS DECIMAL(9, 2)) as Attrtion_Rate
from a 
inner join b 
on a.JobRole = b.JobRole
inner join c 
on a.JobRole = c.JobRole

--Attrition by Environment Satisfaction
with a as (
			select EnvironmentSatisfaction, count(Attrition) as Attrition
		    from hr_rmp
			where Attrition = 1
			group by EnvironmentSatisfaction),
b as (
			select EnvironmentSatisfaction, count(Attrition) as Total_Employees
		    from hr_rmp
			group by EnvironmentSatisfaction)
select b.EnvironmentSatisfaction, b.Total_Employees, a.Attrition, CAST(ROUND((a.Attrition*1.0/ b.Total_Employees) * 100, 2) AS DECIMAL(9, 2)) as Attrition_Rate
from a 
inner join b 
on a.EnvironmentSatisfaction = b.EnvironmentSatisfaction

--Attrition by Marital Status and Gender
with a as (
			select MaritalStatus, Gender, count(Attrition) as Attrition
		    from hr_rmp
			where Attrition = 1
			group by MaritalStatus, Gender),
b as (
			select MaritalStatus, Gender, count(Attrition) as Total_Employees
		    from hr_rmp
			group by MaritalStatus, Gender)
select b.MaritalStatus, b.Gender, b.Total_Employees, a.Attrition, CAST(ROUND((a.Attrition*1.0/ b.Total_Employees) * 100, 2) AS DECIMAL(9, 2)) as Attrition_Rate
from a 
inner join b 
on a.MaritalStatus = b.MaritalStatus and a.Gender=b.Gender

--Attrition by Education Field
with a as (
			select EducationField, count(Attrition) as Attrition
		    from hr_rmp
			where Attrition = 1
			group by EducationField),
b as (
			select EducationField, count(Attrition) as Total_Employees
		    from hr_rmp
			group by EducationField)
select b.EducationField, b.Total_Employees, a.Attrition, CAST(ROUND((a.Attrition*1.0/ b.Total_Employees) * 100, 2) AS DECIMAL(9, 2)) as Attrition_Rate
from a 
inner join b 
on a.EducationField = b.EducationField 

--Attrition by Education 
with a as (
			select Education, count(Attrition) as Attrition
		    from hr_rmp
			where Attrition = 1
			group by Education),
b as (
			select Education, count(Attrition) as Total_Employees
		    from hr_rmp
			group by Education)
select b.Education, b.Total_Employees, a.Attrition, CAST(ROUND((a.Attrition*1.0/ b.Total_Employees) * 100, 2) AS DECIMAL(9, 2)) as Attrition_Rate
from a 
inner join b 
on a.Education = b.Education 

