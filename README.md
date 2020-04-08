# Real Estate Database 

## Component files:

README.md: describes the database
create.sql: creates the database with SQL
insert_data.py: inserts dummy data into the tables
query.sql: contains queries which updates the tables


## How to run the code:

Install MySQL using the following link: https://dev.mysql.com/doc/mysql-osx-excerpt/5.7/en/osx-installation.html

	1) Run on Terminal: mysql -u root -p
	2) Then, create a new database: CREATE DATABASE real_estate;
	3) To work with the database: USE real_estate
	4) Create the tables: SOURCE create.sql 
	5) Add dummy data: SOURCE insert.sql
	6) To query from the database, open the query.sql file and execute each command manually which returns all the expected results with the dummy data.
	
I used phpMyAdmin to create the database for the project. phpMyAdmin is an open-source web administrator tool which can be used to design a database, and it has an in-built visualization tool to show the relationships between tables. I used mySQL with phpMyAdmin to deepen my understanding of SQL (so that it is independent of the programming language used for the software application). 

The current design of the database is as follows: 

![alt text](https://raw.githubusercontent.com/tanhakate/real_estate/master/real_estate_design.png)

## There are 7 tables:

Agent: contains agent name and contact email, with a unique ID for each. 

House: contains all required information about a house that's listed on the market, with a uniqueID for each house and has foreign key references to the office, seller and agent which is responsible for the house. 

Office: contains office contact information and a unique id for each office. 

Person: contains the information of buyers and sellers, with a unique id for each. type column is used to specify whether a person is a buyer or a seller. 

sale: contains all the required information once a sale is made, such as sale_date and sale_price, and has foreign key references to the listing id in the House table, agent id and buyer id. 

Commission: stores the total commision for each agent and is updated by manually running a query after the sales are inserted in the sale table. It has foreign key references to the agent id and the sale id. 

summary_table: contains columns to store the total price and average price of all houses sold within a specified time range. It is updated by manually running a query. 

## A few reasonings for the design of the table:

1) The scenario is to build a database system for a real estate company. The company has multiple offices, where each office sells houses in a specific area, with the help of a real estate agent. Each office has a seller and a real estate agent, but one agent can work with multiple offices. 

2) Since it's a real estate company, we have to store the contact details of each its offices in the `Office` table. Every time a house is listed on the market, we want to capture relevant details such as # of bedrooms, # of bathrooms, listing price, zipcode, etc in the `House` table. Since each house is sold by one of the company's offices, the `House` table contains a foreign key reference to the `Office` table. In addition, each house is sold by a real estate agent, who can work with multiple offices. Therefore, the `House` table contains a foreign key reference to the agent id in the `Agent` table, as well as a seller id in the `Person` table. Each office has a seller which only sells houses listed by the particular office, but the agent can work with multiple offices. In the `Person` table, a type column specifies whether the person is a seller or a buyer. When a house is sold, there is a new entry in the `sale` table, which contains the buyer id, agent id and a house id that references the listing on the `House` table. 

3) The tables are in first normal form as each attribute (column) of a table holds a single, atomic value. There is no redundant data in any column of the tables. For example, each agent can make multiple sales, so they are entitled to multiple commissions. If we entered all the commisions in the `Agent` table, it would violate 1NF, so instead we have a `Commission`table where the commission from each sale is registered as distinct even for the same agent. 

The tables are guaranteed in second normal form because it is already in 1NF form and all non-key columns depend on the primary key. In other words, all tables contains 1 primary key. For example, `Agent` table has the agent's data with its own ID and `sale` table has sale-related data where each listed sale has its own ID. So, there is no redundancy. 

The tables are guaranteed in the third normalization form because it is already in 2nd form and there is no transitive functional dependency. For example, we could have included sale data in the `Agent` table, but each agent can make multiple sales so there would be data redundancy where the non-key column doesn't depend on the primary key of agent ID. So, we have two separate tables: `Agent` table and `sale` table, each of which has its own primary key. 

Ultimately, the database follows 3NF design. 

All the primary keys are indexed, so that it is faster to search the database. Right now, the data was entered manually. 

For a transaction, when there is a new entry in the `sale` table, the `House` table's sold column must be updated so that it shows as sold (i.e. '1' instead of '0'). 

```SQL
START TRANSACTION;
INSERT INTO `sale` (`id`, `house_id`, `buyer_id`, `agent_id`, `sale_price`, `sale_date`) VALUES
(28, 1, 11, 7, 678099, '2020-02-04');
UPDATE `House` SET `sold` = '1' WHERE `House`.`id` = 1;
COMMIT;

```
Suppose, we are selling a house of ID 1, so we have to set the sold colum for the house with ID 1 as 1. This should have for all the entries in the sell table. 
