create database Project
select  * from tele_customer_churn 

--Check for duplicate values
select customerID, count(customerID) as duplicate_values
from tele_customer_churn 
group by customerID 
having count(customerID)>1 

--Check for null values
with a as(
		  select case SeniorCitizen
		              when 0 then 'SeniorCitizen' else 'SeniorCitizen' end as columnname,
                 case SeniorCitizen when null then 1 else 0 end as null_count
		  from tele_customer_churn),
a1 as (
	   select columnname, sum(null_count) as null_count
	   from a 
	   group by columnname),
 b as(
		  select case tenure
		              when 0 then 'tenure' else 'tenure' end as columnname,
                 case tenure when null then 1 else 0 end as null_count
		  from tele_customer_churn),
b1 as (
	   select columnname, sum(null_count) as null_count
	   from b 
	   group by columnname),
 c as(
		  select case MonthlyCharges
		              when 0 then 'MonthlyCharges' else 'MonthlyCharges' end as columnname,
                 case MonthlyCharges when null then 1 else 0 end as null_count
		  from tele_customer_churn),
c1 as (
	   select columnname, sum(null_count) as null_count
	   from c 
	   group by columnname),
d as(
		  select case TotalCharges
		              when 0 then 'TotalCharges' else 'TotalCharges' end as columnname,
                 case TotalCharges when null then 1 else 0 end as null_count
		  from tele_customer_churn),
d1 as (
	   select columnname, sum(null_count) as null_count
	   from d 
	   group by columnname),
e as(
		  select case churn
		              when 0 then 'churn' else 'churn' end as columnname,
                 case TotalCharges when null then 1 else 0 end as null_count
		  from tele_customer_churn),
e1 as (
	   select columnname, sum(null_count) as null_count
	   from e
	   group by columnname)
select * from a1 
union
select * from b1 
union 
select * from c1 
union
select * from d1 
union 
select * from e1

--Customer churn rate based on gender
with a as (
			select gender, count(churn) as churned_customer 
		    from tele_customer_churn 
			where churn = 1
			group by gender),
b as (
			select gender, count(churn) as totalcustomer
		    from tele_customer_churn 
			group by gender)
select b.gender, b.totalcustomer, a.churned_customer, CAST(ROUND((a.churned_customer*1.0/ b.totalcustomer) * 100, 2) AS DECIMAL(9, 2)) as churnrate
from a 
inner join b 
on a.gender = b.gender 

--Senior citizen
with a as (
			select SeniorCitizen, count(churn) as churned_customer 
		    from tele_customer_churn 
			where churn = 1
			group by SeniorCitizen),
b as (
			select SeniorCitizen, count(churn) as totalcustomer
		    from tele_customer_churn 
			group by SeniorCitizen),
c as (
			select SeniorCitizen, sum(TotalCharges) as totalcharges 
		    from tele_customer_churn 
			where churn = 1
			group by SeniorCitizen)
select case a.SeniorCitizen 
       when 1 then 'senior'
	   else 'non-senior'
	   end as SeniorCitizen,
       b.totalcustomer,
	   a.churned_customer, 
	   c.totalcharges,
	   CAST(ROUND((a.churned_customer*1.0/ b.totalcustomer) * 100, 2) AS DECIMAL(9, 2)) as churnrate
from a 
inner join b 
on a.SeniorCitizen = b.SeniorCitizen
inner join c 
on a.SeniorCitizen = c.SeniorCitizen

--Partner
with a as (
			select Partner, count(churn) as churned_customer 
		    from tele_customer_churn 
			where churn = 1
			group by Partner),
b as (
			select Partner, count(churn) as totalcustomer
		    from tele_customer_churn 
			group by Partner)
select case a.Partner 
       when 1 then 'Yes'
	   else 'No'
	   end as Partner,
       b.totalcustomer,
	   a.churned_customer, 
	   CAST(ROUND((a.churned_customer*1.0/ b.totalcustomer) * 100, 2) AS DECIMAL(9, 2)) as churnrate
from a 
inner join b 
on a.Partner = b.Partner 

--Tenure
with a as(
		  select 
		  case 
		  when tenure>0 and tenure<=12 then '0-12'
		  when tenure>12 and tenure<=24 then '12-24'
		  when tenure>24 and tenure<=36 then '24-36'
		  when tenure>36 and tenure<=48 then '36-48'
		  when tenure>48 and tenure<=60 then '48-60'
		  else '60+' 
		  end as tenurerange, 
		  tenure,
		  churn
		  from tele_customer_churn),
b as (
			select tenurerange, count(churn) as churned_customer 
		    from a
			where churn = 1
			group by tenurerange),
c as (
			select tenurerange, count(churn) as totalcustomer
		    from a
			group by tenurerange)
select 
       b.tenurerange,
	   b.churned_customer,
	   c.totalcustomer,
	   CAST(ROUND((b.churned_customer*1.0/ c.totalcustomer) * 100, 2) AS DECIMAL(9, 2)) as churnrate
from b
inner join c
on b.tenurerange = c.tenurerange 
order by b.tenurerange

--PhoneService
with a as (
			select PhoneService, count(churn) as churned_customer 
		    from tele_customer_churn 
			where churn = 1
			group by PhoneService),
b as (
			select PhoneService, count(churn) as totalcustomer
		    from tele_customer_churn 
			group by PhoneService)
select case a.PhoneService 
       when 1 then 'Yes'
	   else 'No'
	   end as PhoneService,
       b.totalcustomer,
	   a.churned_customer, 
	   CAST(ROUND((a.churned_customer*1.0/ b.totalcustomer) * 100, 2) AS DECIMAL(9, 2)) as churnrate
from a 
inner join b 
on a.PhoneService = b.PhoneService