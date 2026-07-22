# Objective 1_Encounters overview
-- Your first objective is to become familiar with the encounters table by slicing the data by years, encounter class and encounter length.
select * from encounters;

-- (1) How many total encounters occurred each year?
select year(start), 
count(*) as total_encounters from encounters
group by year(start)
order by 1;
-- we dont have all the information for 2022

-- (2) For each year, what percentage of all encounters belonged to each encounter class (ambulatory, outpatient, wellness, urgent care, emergency, and inpatient)?
select year(start), count(*) as total,
		round(avg(CASE WHEN ENCOUNTERCLASS = 'ambulatory' then 1 else 0 end) * 100, 1) as percent_ambulance ,
        round(avg(CASE WHEN ENCOUNTERCLASS = 'outpatient' then 1 else 0 end) * 100 , 1) as percent_outpatient,
        round(avg(CASE WHEN ENCOUNTERCLASS = 'wellness' then 1 else 0 end) * 100, 1) as percent_wellness,
        round(avg(CASE WHEN ENCOUNTERCLASS = 'urgentcare' then 1 else 0 end) * 100, 1) as percent_urgent_care,
        round(avg(CASE WHEN ENCOUNTERCLASS = 'emergency' then 1 else 0 end) * 100, 1) as percent_emergency ,
       round(avg(CASE WHEN ENCOUNTERCLASS = 'inpatient' then 1 else 0 end) * 100, 1) as percent_inpatient
from encounters
group by year(start)
order by 1;

-- just doing it for myself
select year(start), count(*),
		sum(CASE WHEN ENCOUNTERCLASS = 'ambulatory' then 1 else 0 end)  as percent_ambulance ,
        sum(CASE WHEN ENCOUNTERCLASS = 'outpatient' then 1 else 0 end) as percent_outpatient,
        sum(CASE WHEN ENCOUNTERCLASS = 'wellness' then 1 else 0 end) as percent_wellness,
        sum(CASE WHEN ENCOUNTERCLASS = 'urgentcare' then 1 else 0 end)  as percent_urgent_care,
        sum(CASE WHEN ENCOUNTERCLASS = 'emergency' then 1 else 0 end) as percent_emergency ,
        sum(CASE WHEN ENCOUNTERCLASS = 'inpatient' then 1 else 0 end)  as percent_inpatient
from encounters
group by year(start)
order by 1;

-- (3) What percentage of encounters were over 24 hours versus under 24 hours?
select avg(case when timediff >= 24 then 1 else 0 end) * 100 as over_24_hours,
		avg(case when timediff < 24 then 1 else 0 end) * 100 as under_24_hours
 from (
	select timestampdiff(hour, start, stop) as timediff from encounters
  ) t ;