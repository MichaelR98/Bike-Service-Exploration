-- What is the breakdown of customers based on gender?
-- 27% of customers are female and 73% are male
SELECT gender, COUNT(gender) AS num_of_customers
FROM Combined_Trips
WHERE gender IS NOT NULL
GROUP BY gender


-- gender breakdown where we look at how many men and women are subscribers

SELECT gender, COUNT(gender) AS num_of_customers, usertype
FROM Combined_Trips
WHERE gender IS NOT NULL
GROUP BY gender, usertype
ORDER BY num_of_customers


--adding trip length we see that nonsubscribers use the service the most often and have much longer trip durations
-- we see that the demographics that use the bikes more use it for less time, indicating that it is likely that subscribers use the service for work
SELECT gender, usertype, COUNT(gender) AS num_of_customers, AVG(tripduration) AS trip_len_in_seconds
FROM Combined_Trips
WHERE gender IS NOT NULL
GROUP BY gender, usertype
ORDER BY trip_len_in_seconds desc


-- Here we can see that young men who are subscribers are the most common users 
SELECT COUNT(birthyear) AS num_of_customers, (2019 - birthyear) AS cust_age, gender, usertype,
CASE 
	WHEN birthyear > 1984 THEN 'young'
	ELSE 'old'
END AS age_group
FROM Combined_Trips
WHERE gender IS NOT NULL AND birthyear > 1946
GROUP BY birthyear, usertype, gender
ORDER BY num_of_customers desc

-- Comparing the number of total trips of subs vs non-subs
SELECT count(trip_id) AS count_of_trips_by_subs
FROM Combined_Trips
WHERE usertype = 'subscriber' 

SELECT count(trip_id) AS count_of_trips_by_nonsubs 
FROM Combined_Trips
WHERE usertype <> 'subscriber' -- total trips = 1,752,629 (25.17% of trips are non subs and 74.83% are subs)


-- Comparing the trip duration of subs vs non-subs
SELECT sum(tripduration) AS subs_total_trip_duration  
FROM Combined_Trips
WHERE usertype = 'subscriber' 


SELECT sum(tripduration) AS non_subs_total_trip_duration  
FROM Combined_Trips
WHERE usertype <> 'subscriber' -- total duration = 1,678,064,030 seconds (59.57% of trip duration is non subs and 40.43% are subs)

-- in summary: the avg customers is on the younger side, a male, is a subscriber and uses the service for work. 
-- If the goal is to expand the user base to different demographics the appeal of the bikes are fun should be focused on
-- The most common users view the service as a utlity for work or travel to specific destination as opposed to fun

