create database Project2;
show databases;
use project2;
show tables;
desc updated_healthcare;
/*question 1  total patients*/
select count(`Patient ID`) as total_patients FROM UPDATED_HEALTHCARE;

/*question 2*/
select count(`Doctor ID`) as total_doctors FROM UPDATED_HEALTHCARE;

/*question 4 average age of doctors*/
select avg(age) as avg_age from UPDATED_HEALTHCARE;

/*top 5 diagonis cases*/
select diagnosis,count(*) as total_cases
from UPDATED_HEALTHCARE
group by diagnosis
order by  total_cases desc
limit 5;

/*question 6 follow up rate*/
SELECT 
    (COUNT(DISTINCT CASE 
        WHEN visit_count > 1 THEN `Patient ID` 
    END) * 100.0) 
    / COUNT(DISTINCT `Patient ID`) AS follow_up_rate
FROM (
    SELECT `Patient ID`, COUNT(*) AS visit_count
    FROM Updated_healthcare
    GROUP BY `Patient ID`
) t;

/* top 10 doctors by revenue*/
select `doctor id`,`full name`,
		sum(`Patient paid ($)`)as total_revenue
        from Updated_healthcare
        group by `Doctor id`,`full name`
        order by total_revenue desc
        limit 10;

/*avg visit duration*/
select `doctor id`,avg(`visit duration (mins)`) as avg_visit
    from Updated_healthcare
    group by `doctor id`
    order by avg_visit desc
    limit 10;

/* department distribution*/
select 
	`department name`,count(`doctor id`) as total_doctors
from Updated_healthcare
group by `department name`;

/*completion rate */
SELECT 
    `doctor id`,
    ROUND(
        SUM(CASE WHEN `visit status` = 'completed' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
    2) AS completion_rate
FROM Updated_healthcare
GROUP BY `doctor id`;

/* Doctors by speciality*/
SELECT 
    Specialty,
    COUNT(`Doctor ID`) AS total_doctors
FROM updated_healthcare
GROUP BY Specialty
ORDER BY total_doctors DESC;
        