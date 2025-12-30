CREATE DATABASE SLA;

USE SLA;

SELECT * FROM OPS_DATA;

--- Identifying Processes with the Highest SLA Breaches

select process_name,
count(*) as sla_breach_count
from OPS_DATA
where actual_completion_hours > sla_hours
group by process_name
order by sla_breach_count desc;

--- Measuring Process Efficiency Using Success Rate

select process_name,
round(avg(success_cases * 1.0 / total_cases), 2) as average_success_rate
from OPS_DATA
group by process_name
order by average_success_rate desc;

--- Analyzing Overall Daily Workload Trends

select date,
sum(total_cases) as daily_volume
from OPS_DATA
group by date
order by date;

--- Calculating SLA Breach Percentage by Process

select process_name,
round(sum(case
			when actual_completion_hours > sla_hours then 1
			else 0
		end
		) * 100.0 / count(*),
		2
	) as sla_breach_percentage
from OPS_DATA
group by process_name
order by sla_breach_percentage desc;
