# Objective 2: Cost & coverage insights
-- Your next objective is to analyze payer coverage, top procedures by frequency and cost, and average claim costs by payer.


-- (1) How many encounters had zero payer coverage, and what percentage of total encounters does this represent?
select count(*) as zero_payer_coverage from encounters 
where PAYER_COVERAGE = 0;

select avg(case when payer_coverage = 0 then 1 else 0 end) * 100 as zero_payer
    from encounters;

-- (2) What are the top 10 most frequent procedures performed and the average base cost for each?
select * from encounters;
select * from procedures;

select code, description, 
 count(*) as num_procedures from procedures
group by code, description
order by 3 desc
limit 10;

select code, description, 
 count(*), avg(BASE_COST) as num_procedures from procedures
group by code, description
order by 3 desc
limit 10;



-- (3) What are the top 10 procedures with the highest average base cost and the number of times they were performed?
SELECT 
    code, description, AVG(base_cost), COUNT(*)
FROM
    procedures
GROUP BY code , description
ORDER BY 3 DESC
LIMIT 10;


-- What is the average total claim cost for encounters, broken down by payer?
select  p.NAME, round(avg(e.TOTAL_CLAIM_COST), 2) as `average total claim`
from encounters e
left join payers p
on e.PAYER = p.Id
group by p.NAME
order by 2 desc;
