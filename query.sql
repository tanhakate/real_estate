-- 0. Update summary table 

Insert into summary_table(date, average_price, total_price)
Select G.date as date, avg(G.sale_price) as average_price, sum(G.sale_price) as total_price from
(SELECT sale_date, sale_price, "2020-03-01" as date
FROM sale) as G
where G.sale_date >= "2020-03-01" and G.sale_date < "2020-04-01";

-- 1. Find the top 5 offices with the most sales for that month.

-- The query creates a new table called V, by joining on office ID from House table with Office table
-- and counts how many houses were sold in each office. 
-- Then, the V table is joined with sale on House ID and creates table X
-- Filter the data in X table by a hard-coded month range which in our case is March 2020. 
-- In the completed application, this would come from the front-end or the user interface. 
-- Order X descending count and then return the top 5 offices



SELECT
    X.office_id,
    X.email,
    X.zipcode,
    X.count
FROM
    (
    SELECT
        office_id,
        V.zipcode,
        V.count,
        V.address,
        V.email,
        sale_date
    FROM
        sale
    JOIN(
        SELECT
            H.id AS house_id,
            office_id,
            Office.zipcode,
            Office.address,
            Office.email,
            COUNT(office_id) AS COUNT
        FROM
            Office
        LEFT JOIN House H ON
            Office.id = H.office_id
        GROUP BY
            office_id
        ORDER BY
            COUNT
        DESC
    ) V
ON
    V.house_id = sale.house_id
) AS X
WHERE
    X.sale_date >= "2020-03-01" AND X.sale_date < "2020-04-01"
ORDER BY
    X.count
DESC
LIMIT 5;


-- 2. Find the top 5 estate agents who have sold the most that month (include their contact details and their sales details so that it is easy contact them and congratulate them)

-- The query creates a new table called C, by joining on agent ID from Agent table with sale table
-- and counts how many houses were sold by each agent. 
-- Filter the data in C table by a hard-coded month range which in our case is March 2020. 
-- In the completed application, this would come from the front-end or the user interface. 
-- Order C descending count and then return the top 5 agents

SELECT C.id, 
       C.first_name, 
       C.last_name, 
       C.email, 
       C.count,
       C.total_price_sold
FROM   (SELECT A.id, 
               A.first_name, 
               A.last_name, 
               A.email, 
               s.sale_date,
        sum(s.sale_price) as total_price_sold,
               Count(A.id) AS count 
        FROM   Agent AS A 
               JOIN sale s 
                 ON A.id = s.agent_id 
        GROUP  BY A.id) AS C 
WHERE  C.sale_date >= "2020-03-01" 
       AND C.sale_date < "2020-04-01" 
ORDER  BY C.count DESC 
LIMIT  5 

-- 3. For that month, calculate the commission that each estate agent must receive and store the results in a separate table.
--  and then group by. delete sale id from the commission table and run it 


--  From the sale table, the command will take certain data  (id, agent_id and sale_price) based on a hard-coded date range, which in our case is March 2020. 
-- It will give a table S. 
-- From that S table, it will take the a commission from the sale_price and it will entry the data into the commission table. 
-- Case conditionals were used to specify a different commission rate based on sale price, as specified by the assignment instructions. 


INSERT INTO Commission 
            (sale_id, 
             agent_id, 
             Commission) 
SELECT id  AS sale_id, 
       agent_id, 
       CASE 
         WHEN sale_price < 100000 THEN sale_price * .10 
         WHEN sale_price >= 100000 
              AND sale_price < 200000 THEN sale_price * .075 
         WHEN sale_price >= 200000 
              AND sale_price < 500000 THEN sale_price * .06 
         WHEN sale_price >= 500000 
              AND sale_price < 1000000 THEN sale_price * .05 
         ELSE sale_price * .04 
       END AS Commission 
FROM   (SELECT id, 
               agent_id, 
               Sum(sale_price) AS sale_price 
        FROM   sale 
        WHERE  sale_date >= "2020-03-01" 
               AND sale_date < "2020-04-01" 
        GROUP  BY agent_id) AS S 
GROUP  BY S.agent_id; 

-- 4. For all houses that were sold that month, calculate the average number of days that the house was on the market.
-- Join the sale table and House table on house id, extract the date of listing and the date of sale and find the difference, which is stored as DaysBetween. 
-- This is stored as a new table T. 
-- From the T table, the command will take  data based on a hard-coded date range, which in our case is March 2020 and find the average date difference between sale date and listing date,
-- which is essentially the average number of days a house was on the market for that date range. 


SELECT AVG(daysbetween) 
FROM   (SELECT sale.house_id, 
               sale.sale_date, 
               Datediff(sale.sale_date, House.listing_date) AS DaysBetween 
        FROM   House 
               INNER JOIN sale 
                       ON House.id = sale.house_id) AS T 
WHERE  T.sale_date >= "2020-03-01" 
       AND T.sale_date < "2020-04-01" 


-- 5. For all houses that were sold that month, calculate the average selling price
-- Extract sale_date and sale_price from the sale table as a new table G, calculate the average sale_price from G based on a 
-- a hard-coded date range, which in our case is March 2020. 

SELECT AVG(G.sale_price) 
FROM   (SELECT sale_date, 
               sale_price 
        FROM   sale) AS G 
WHERE  G.sale_date >= "2020-03-01" 
       AND G.sale_date < "2020-04-01" 

-- 6. For all houses that were sold that month, find the zip codes with the top 5 average sales prices.
-- Sale table and house table joined to create a W table based on house ID. Then, we take the zipcode and average sales price for all houses sold in that zipcode. 

SELECT W.zipcode, 
       W.average 
FROM   (SELECT s.house_id, 
               Sum(s.sale_price)                    AS sale_price, 
               Count(h.zipcode), 
               Sum(s.sale_price) / Count(h.zipcode) AS average, 
               s.sale_date, 
               h.zipcode 
        FROM   sale s 
               JOIN House h 
                 ON s.house_id = h.id 
        GROUP  BY h.zipcode) AS W 
WHERE  W.sale_date >= "2020-03-01" 
       AND W.sale_date < "2020-04-01" 
ORDER  BY W.sale_price DESC 
