# Real Estate Database 

## Components: files:

README.md: describes the database
create.py: creates the database with SQL
insert.py: inserts dummy data into the tables
query.py: contains queries which updates the tables


## How to run the code:

Install MySQL using the following link: https://dev.mysql.com/doc/mysql-osx-excerpt/5.7/en/osx-installation.html

	1) Run on Terminal: mysql -u root -p
	2) Then, create a new database: CREATE DATABASE real_estate;
	3) To work with the database: USE real_estate
	4) Create the tables: SOURCE create.sql 
	5) Add dummy data: SOURCE insert.sql
	6) To query from the database, open the query.sql file and execute the commands manually


## There are 7 tables:

Agent: contains agent name and contact email, with a unique ID for each 
Commission: stores the total commision for each agent. It has foreign key constraints to the agent and the sale. 
House: contains all required information a house that's listed on the market, with a uniqueID for each house and has foreign key references to the office, buyer and agent which is responsible for the house. 
Office: contains office contact information information and a unique id for each office. 
Person: contains the information of buyers and sellers, with a unique id for each. type column is used to specify whether a person is a buyer or a seller. 
sale: contains all the required information once a sale is made, such as sale_date, and has foreign key references to the listing id, agent id and buyer id. 
summary_table: contains columns to store the total price and average price of house sold within a specified time range 

## A few reasonings for the design of the table:

1) The tables are guaranteed to be in first normalization form: where all the entries are atomic and no repeating groups exist (i.e. the Agents-Offices table helps to fix the complexity of many-to-many relationship, making no repeating groups occur)

2) The tables are guaranteed to be in second normalization form: it is already in first normal form and all non-key attributes are fully functional dependent on the primary key: Every table except the Agents_Offices table only contains 1 primary key, which mean it's automatically in the 2nd form. The Agents_Offices table has no non-key attributes, hence, all non-key attributes are fully functional dependent on the primary keys.

3) The tables are guaranteed to be in the third normalization form: it is already in the 2nd form and there is no transitive functional dependency. (i.e. The major possible issue is the commission, as if we include the commission in the Transactions table, we will have the price depends on the ListingID, and the commision depends on the price -> the commision is transitively dependent on the ListingID via the price. We have resolve this by creating a function outside and only calculate when needed. 
However, we must be conscious that if the commission formula changed, we need to modify the comission functions and include the filter: if we change the policy after 2019/01/01: 
if querying the date of the transaction < datetime.datetime(2019,1,1): implement former commission formula else: implement the new commission formula