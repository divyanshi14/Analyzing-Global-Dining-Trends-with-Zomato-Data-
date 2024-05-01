SELECT * FROM zomato

-- 1. What is the distribution of restaurant ratings?

SELECT CASE
           WHEN [Aggregate rating] BETWEEN 1 AND 1.9 THEN '1 - 1.9'
		   WHEN [Aggregate rating] BETWEEN 2 AND 2.9 THEN '2 - 2.9'
		   WHEN [Aggregate rating] BETWEEN 3 AND 3.9 THEN '3 - 3.9'
		   WHEN [Aggregate rating] BETWEEN 4 AND 4.9 THEN '4 - 4.9'
		   ELSE '0'
	   END AS Ratings,
	   COUNT(*) AS Rating_Count
FROM zomato
GROUP BY CASE
           WHEN [Aggregate rating] BETWEEN 1 AND 1.9 THEN '1 - 1.9'
		   WHEN [Aggregate rating] BETWEEN 2 AND 2.9 THEN '2 - 2.9'
		   WHEN [Aggregate rating] BETWEEN 3 AND 3.9 THEN '3 - 3.9'
		   WHEN [Aggregate rating] BETWEEN 4 AND 4.9 THEN '4 - 4.9'
		   ELSE '0'
	   END



-- 2. How many restaurants offer online delivery?

SELECT COUNT(*) AS Number_of_restaurents_offer_online_delivery
FROM zomato
WHERE [Has Online delivery] = 'Yes'



-- 3. What is the average amount for two across different cities?

SELECT City, AVG([Average Cost for two]) AS Average_amount_for_two 
FROM zomato
GROUP BY City
ORDER BY Average_amount_for_two



-- 4. Identify the top 5 cuisines available across restaurants.

SELECT TOP 5 Individual_Cuisine 
FROM zomato
GROUP BY Individual_Cuisine
ORDER BY COUNT(*) DESC



-- 5. Compare the number of restaurants that allow table booking versus those that do not.

SELECT COUNT(CASE WHEN [Has Table booking] = 'Yes' THEN 1 END)  number_of_restaurants_have_table_booking,
       COUNT(CASE WHEN [Has Table booking] = 'No' THEN 1 END)  number_of_restaurants_do_not_have_table_booking
FROM zomato



-- 6. What are the most common restaurant names?

SELECT TOP 10 [Restaurant Name]
FROM zomato
GROUP BY [Restaurant Name]
ORDER BY COUNT(*) DESC



-- 7. How many unique cities are represented in the dataset?

SELECT COUNT(DISTINCT City) AS number_of_unique_cities
FROM zomato



-- 8. Identify the top 5 restaurants with the highest number of votes.

SELECT TOP 5 [Restaurant Name] 
FROM zomato
ORDER BY Votes DESC



-- 9. How do restaurant ratings vary between restaurants that offer online delivery and those that do not?

SELECT
(SELECT AVG([Aggregate rating]) FROM zomato WHERE [Has Online delivery] = 'Yes') AS average_restaurant_rating_offering_online_delivery,
(SELECT AVG([Aggregate rating]) FROM zomato WHERE [Has Online delivery] = 'No') AS average_restaurant_rating_not_offering_online_delivery



-- 10. Analyze the effect of having a table booking option on the aggregate rating.

SELECT
(SELECT AVG([Aggregate rating]) FROM zomato WHERE [Has Table booking] = 'Yes') AS average_restaurant_rating_offering_table_booking,
(SELECT AVG([Aggregate rating]) FROM zomato WHERE [Has Table booking] = 'No') AS average_restaurant_rating_not_offering_table_booking



-- 11. Determine the top 3 cities with the highest average restaurant rating.

SELECT TOP 3 City AS cities_with_highest_average_restaurant_rating
FROM zomato
GROUP BY City
ORDER BY AVG([Aggregate rating]) DESC



-- 12. Assess the distribution of restaurants across different price ranges in a specific city.

SELECT [Price range], COUNT([Restaurant ID]) AS number_of_restaurants
FROM zomato
WHERE City = 'Noida'
GROUP BY [Price range]
ORDER BY [Price range]



-- 13. Identify trends in restaurant ratings over different price ranges.

SELECT [Price range], AVG([Aggregate rating]) AS average_restaurant_rating 
FROM zomato
GROUP BY [Price range]
ORDER BY [Price range]



-- 14. What is the relationship between price range and average rating?

WITH table1 AS
(SELECT [Rating color], COUNT([Price range]) AS 'Price range-1'
 FROM zomato
 WHERE [Price range] = 1
 GROUP BY [Rating color]),

table2 AS
(SELECT [Rating color], COUNT([Price range]) AS 'Price range-2'
 FROM zomato
 WHERE [Price range] = 2
 GROUP BY [Rating color]),

table3 AS
(SELECT [Rating color], COUNT([Price range]) AS 'Price range-3'
 FROM zomato
 WHERE [Price range] = 3
 GROUP BY [Rating color]),

table4 AS
(SELECT [Rating color], COUNT([Price range]) AS 'Price range-4'
 FROM zomato
 WHERE [Price range] = 4
 GROUP BY [Rating color])

 SELECT table1.[Rating color], table1.[Price range-1], table2.[Price range-2], table3.[Price range-3], table4.[Price range-4]
 FROM table1
 LEFT JOIN table2 ON table1.[Rating color] = table2.[Rating color] 
 LEFT JOIN table3 ON table2.[Rating color] = table3.[Rating color] 
 LEFT JOIN table4 ON table3.[Rating color] = table4.[Rating color] 