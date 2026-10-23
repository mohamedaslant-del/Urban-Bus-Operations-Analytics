USE bus_operations_analytics;

SELECT
    Trip_Status,
    COUNT(*) AS Total_Trips,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM bus_trips), 2)
        AS Percentage
FROM bus_trips
GROUP BY Trip_Status
ORDER BY Total_Trips DESC;

SELECT
    Route_ID,
    Route_Name,
    COUNT(*) AS Total_Trips,
    SUM(Passenger_Count) AS Total_Passengers,
    ROUND(AVG(Occupancy_Pct), 2) AS Avg_Occupancy_Pct
FROM bus_trips
WHERE Trip_Status != 'Cancelled'
GROUP BY Route_ID, Route_Name
ORDER BY Total_Passengers DESC;


SELECT
    Route_ID,
    Route_Name,
    COUNT(*) AS Total_Trips,
    SUM(Ticket_Revenue_INR) AS Total_Revenue_INR,
    ROUND(AVG(Ticket_Revenue_INR), 2) AS Avg_Revenue_Per_Trip
FROM bus_trips
WHERE Trip_Status != 'Cancelled'
GROUP BY Route_ID, Route_Name
ORDER BY Total_Revenue_INR DESC;


SELECT
    Route_ID,
    Route_Name,
    COUNT(*) AS Total_Trips,
    ROUND(AVG(Delay_Minutes), 2) AS Avg_Delay_Minutes,
    SUM(CASE
        WHEN Delay_Minutes > 0 THEN 1
        ELSE 0
    END) AS Delayed_Trips
FROM bus_trips
WHERE Trip_Status != 'Cancelled'
GROUP BY Route_ID, Route_Name
ORDER BY Avg_Delay_Minutes DESC;


SELECT
    Route_ID,
    Route_Name,
    COUNT(*) AS Total_Trips,
    SUM(CASE
        WHEN Delay_Minutes > 0 THEN 1
        ELSE 0
    END) AS Delayed_Trips,
    ROUND(
        SUM(CASE WHEN Delay_Minutes > 0 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Delay_Percentage
FROM bus_trips
WHERE Trip_Status != 'Cancelled'
GROUP BY Route_ID, Route_Name
ORDER BY Delay_Percentage DESC;


SELECT
    HOUR(Scheduled_Departure) AS Departure_Hour,
    COUNT(*) AS Total_Trips,
    SUM(CASE
        WHEN Delay_Minutes > 0 THEN 1
        ELSE 0
    END) AS Delayed_Trips,
    ROUND(AVG(Delay_Minutes), 2) AS Avg_Delay_Minutes,
    ROUND(
        SUM(CASE WHEN Delay_Minutes > 0 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Delay_Percentage
FROM bus_trips
WHERE Trip_Status != 'Cancelled'
GROUP BY HOUR(Scheduled_Departure)
ORDER BY Delay_Percentage DESC;


SELECT
    COUNT(*) AS Total_Trips,
    SUM(CASE
        WHEN Trip_Status = 'On Time' THEN 1
        ELSE 0
    END) AS On_Time_Trips,
    SUM(CASE
        WHEN Trip_Status = 'Delayed' THEN 1
        ELSE 0
    END) AS Delayed_Trips,
    SUM(CASE
        WHEN Trip_Status = 'Cancelled' THEN 1
        ELSE 0
    END) AS Cancelled_Trips,
    ROUND(AVG(Delay_Minutes), 2) AS Avg_Delay_Minutes,
    SUM(Ticket_Revenue_INR) AS Total_Revenue_INR,
    ROUND(AVG(Occupancy_Pct), 2) AS Avg_Occupancy_Pct
FROM bus_trips;