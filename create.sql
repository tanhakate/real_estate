SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

-- Table structure for table `Agent`

CREATE TABLE `Agent` (
  `id` int(11) NOT NULL,
  `first_name` text NOT NULL,
  `last_name` text NOT NULL,
  `email` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `Commission`

CREATE TABLE `Commission` (
  `id` int(11) NOT NULL,
  `agent_id` int(11) NOT NULL,
  `commission` int(11) NOT NULL,
  `sale_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `House`
-- All relevant details are captured such as: seller details, # of bedrooms, # of bathrooms
-- listing price, zip code, date of listing, listing estate agent, and appropriate office 

CREATE TABLE `House` (
  `id` int(11) NOT NULL,
  `house_name` int(11) NOT NULL,
  `office_id` int(11) NOT NULL,
  `agent_id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `num_bedrooms` int(11) NOT NULL,
  `num_bathrooms` int(11) NOT NULL,
  `listing_price` int(11) NOT NULL,
  `listing_date` date NOT NULL,
  `zipcode` int(20) NOT NULL,
  `sold` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `Office`

CREATE TABLE `Office` (
  `id` int(11) NOT NULL,
  `zipcode` int(11) NOT NULL,
  `address` text NOT NULL,
  `email` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- Table structure for table `Person`

CREATE TABLE `Person` (
  `id` int(11) NOT NULL,
  `type` varchar(20) NOT NULL,
  `first_name` text NOT NULL,
  `last_name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `sale`
-- All appropriate details are captured e.g.
-- buyer details, sale price, date of sale, the selling estate agent

CREATE TABLE `sale` (
  `id` int(11) NOT NULL,
  `house_id` int(11) NOT NULL,
  `buyer_id` int(11) NOT NULL,
  `agent_id` int(11) NOT NULL,
  `sale_price` int(11) NOT NULL,
  `sale_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `summary_table`
-- The summary table contains the sum and average of all prices sold that month 
-- The date is set to the first day of the month 
-- when the query to update the summary table is done. 

CREATE TABLE `summary_table` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `total_price` int(11) NOT NULL,
  `average_price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- Indexes for table `Agent`
--
ALTER TABLE `Agent`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Commission`
--
ALTER TABLE `Commission`
  ADD PRIMARY KEY (`id`),
  ADD KEY `agent_commission` (`agent_id`),
  ADD KEY `sale_commission` (`sale_id`);

--
-- Indexes for table `House`
--
ALTER TABLE `House`
  ADD PRIMARY KEY (`id`),
  ADD KEY `agent_house` (`agent_id`),
  ADD KEY `office_house` (`office_id`),
  ADD KEY `seller_house` (`seller_id`);

--
-- Indexes for table `Office`
--
ALTER TABLE `Office`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Person`
--
ALTER TABLE `Person`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sale`
--
ALTER TABLE `sale`
  ADD PRIMARY KEY (`id`),
  ADD KEY `house_sale` (`house_id`),
  ADD KEY `buyer_sale` (`buyer_id`),
  ADD KEY `agent_sale` (`agent_id`);

--
-- Indexes for table `summary_table`
--
ALTER TABLE `summary_table`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for table `Agent`
--
ALTER TABLE `Agent`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `Commission`
--
ALTER TABLE `Commission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `House`
--
ALTER TABLE `House`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `Office`
--
ALTER TABLE `Office`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `Person`
--
ALTER TABLE `Person`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `sale`
--
ALTER TABLE `sale`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `summary_table`
--
ALTER TABLE `summary_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;


-- Constraints for table `Commission`
--
ALTER TABLE `Commission`
  ADD CONSTRAINT `agent_commission` FOREIGN KEY (`agent_id`) REFERENCES `Agent` (`id`),
  ADD CONSTRAINT `sale_commission` FOREIGN KEY (`sale_id`) REFERENCES `sale` (`id`);

--
-- Constraints for table `House`
--
ALTER TABLE `House`
  ADD CONSTRAINT `agent_house` FOREIGN KEY (`agent_id`) REFERENCES `Agent` (`id`),
  ADD CONSTRAINT `office_house` FOREIGN KEY (`office_id`) REFERENCES `Office` (`id`),
  ADD CONSTRAINT `seller_house` FOREIGN KEY (`seller_id`) REFERENCES `Person` (`id`);

--
-- Constraints for table `sale`
--
ALTER TABLE `sale`
  ADD CONSTRAINT `agent_sale` FOREIGN KEY (`agent_id`) REFERENCES `Agent` (`id`),
  ADD CONSTRAINT `buyer_sale` FOREIGN KEY (`buyer_id`) REFERENCES `Person` (`id`),
  ADD CONSTRAINT `house_sale` FOREIGN KEY (`house_id`) REFERENCES `House` (`id`);
COMMIT;


