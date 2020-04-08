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
	6) To query from the database, open the query.sql file and execute each command manually which returns all the expected results with the dummy data.
	
I used phpmyadmin to create the database for the project. Phpmyadmin is a web administrator tool which can be used to design a database, and it has a in-built visualization relationships between tables. The current design of the database is as follows: 

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

2) Since it's a real estate company, we have to store the contact details of each its offices in the 'Office' table. Every time a house is listed on the market, we want to capture relevant details such as # of bedrooms, # of bathrooms, listing price, zipcode, etc in the 'House' table. Since each House is sold by one of the company's offices, the 'House' table contains a foreign key reference to the 'Office' table. In addition, each house is sold by a real estate agent, who can work with multiple offices. Therefore, the 'House' table contains a foreign key reference to the agent id in the 'Agent' table, as well as a seller id in the 'Person' table. Each office has a seller which only sells houses listed by the particular office, but the agent can work with multiple offices. In the 'Person' table, a type column specifies whether the person is a seller or a buyer. When a house is sold, there is a new entry in the 'sale' table, which contains the buyer id, agent id and a house id that references the listing on the 'House' table. 

3) 

The tables are guaranteed to be in first normalization form: where all the entries are atomic and no repeating groups exist (i.e. the Agents-Offices table helps to fix the complexity of many-to-many relationship, making no repeating groups occur)

2) The tables are guaranteed to be in second normalization form: it is already in first normal form and all non-key attributes are fully functional dependent on the primary key: Every table except the Agents_Offices table only contains 1 primary key, which mean it's automatically in the 2nd form. The Agents_Offices table has no non-key attributes, hence, all non-key attributes are fully functional dependent on the primary keys.

3) The tables are guaranteed to be in the third normalization form: it is already in the 2nd form and there is no transitive functional dependency. (i.e. The major possible issue is the commission, as if we include the commission in the Transactions table, we will have the price depends on the ListingID, and the commision depends on the price -> the commision is transitively dependent on the ListingID via the price. We have resolve this by creating a function outside and only calculate when needed. 
However, we must be conscious that if the commission formula changed, we need to modify the comission functions and include the filter: if we change the policy after 2019/01/01: 
if querying the date of the transaction < datetime.datetime(2019,1,1): implement former commission formula else: implement the new commission formula
