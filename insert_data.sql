-- Dumping data for table `Agent`
--

INSERT INTO `Agent` (`id`, `first_name`, `last_name`, `email`) VALUES
(1, 'Graham', 'Chapman', 'g_chapman@gmail.com'),
(2, 'John', 'Cleese', 'j_cleese@gmail.com'),
(3, 'Terry', 'Gilliam', 't_gilliam@gmail.com'),
(4, 'Eric', 'Idle', 'e_idle@gmail.com'),
(5, 'Terry', 'Jones', 't_jones@gmail.com'),
(6, 'Michael', 'Palin', 'm_palin@gmail.com'),
(7, 'Carol', 'Cleveland', 'c_cleveland@gmail.com');

-- Dumping data for table `House`

INSERT INTO `House` (`id`, `house_name`, `office_id`, `agent_id`, `seller_id`, `num_bedrooms`, `num_bathrooms`, `listing_price`, `listing_date`, `zipcode`, `sold`) VALUES
(1, 11, 1, 7, 1, 3, 4, 100000, '2019-03-01', 94103, 0),
(2, 22, 2, 7, 3, 2, 3, 90000, '2020-01-02', 94111, 0),
(3, 33, 3, 6, 4, 3, 4, 210000, '2019-01-02', 46082, 0),
(4, 44, 4, 5, 2, 2, 4, 600000, '2020-02-02', 1233, 0),
(5, 55, 5, 4, 6, 8, 6, 2000000, '2019-12-02', 11312, 0),
(6, 66, 6, 3, 5, 5, 6, 85000, '2019-09-02', 1001, 0),
(7, 77, 7, 2, 8, 3, 6, 500000, '2020-01-03', 2140, 0),
(8, 88, 8, 1, 7, 5, 6, 600000, '2020-01-02', 412109, 0),
(9, 99, 9, 7, 10, 1, 6, 2000000, '2020-01-02', 734107, 0),
(10, 111, 5, 6, 6, 3, 2, 110000, '2020-01-02', 11312, 0),
(11, 222, 2, 5, 3, 4, 7, 700000, '2020-01-02', 94111, 0),
(12, 333, 3, 4, 4, 2, 2, 990000, '2020-01-02', 46082, 0),
(13, 444, 6, 3, 5, 4, 2, 2200000, '2020-01-02', 1001, 0),
(14, 555, 5, 2, 6, 1, 1, 60000, '2020-01-02', 11313, 0);

-- Dumping data for table `Office`
--

INSERT INTO `Office` (`id`, `zipcode`, `address`, `email`) VALUES
(1, 94102, '1412 Market Street, San Francisco', 'office1@micasa.com'),
(2, 94108, '851 California Street, San Francisco', 'office2@micasa.com'),
(3, 46077, '2511 Fawn Bluff Court, Zionsville', 'office3@micasa.com'),
(4, 1230, 'House # 2, Road # 6/A, Sector # 5, Uttara', 'office4@micasa.com'),
(5, 11311, 'Esmeralda 933, Buenos Aires', 'office5@micasa.com'),
(6, 1000, 'Bangladesh University of Engineering and Technology (BUET), Palashi, Dhaka', 'office6@micasa.com'),
(7, 2138, '132 Sowol-ro, Huam-dong, Yongsan-gu, Seoul', 'office7@micasa.com'),
(8, 412108, 'Potsdamer Straße 33, Berlin', 'office8@micasa.com'),
(9, 743104, '204, Mission St, MG Road Area, Puducherry', 'office9@micasa.com'),
(10, 10179, 'Adalbertstraße 58, Berlin', 'office10@micasa.com');


-- Dumping data for table `Person`
--

INSERT INTO `Person` (`id`, `type`, `first_name`, `last_name`) VALUES
(1, 'seller', 'Jingren', 'Wang'),
(2, 'seller', 'Elena', 'Cai'),
(3, 'seller', 'Hiba', 'Oirghi'),
(4, 'seller', 'Mohamed', 'Gad'),
(5, 'seller', 'Ara', 'Mkhoyan'),
(6, 'seller', 'Danyal', 'Naeem'),
(7, 'seller', 'Minh', 'Nguyen'),
(8, 'seller', 'Quang', 'Tran'),
(9, 'seller', 'Arham', 'Hameed'),
(10, 'seller', 'Lucas', 'Araujo'),
(11, 'buyer', 'Kate', 'Tanha'),
(12, 'buyer', 'Rebecca', 'Mqamelo'),
(13, 'buyer', 'Adel', 'Bilalova'),
(14, 'buyer', 'Han', 'Le'),
(15, 'buyer', 'Ella', 'Streng'),
(16, 'buyer', 'Alexander', 'Wu');

-- Dumping data for table `sale`
--

INSERT INTO `sale` (`id`, `house_id`, `buyer_id`, `agent_id`, `sale_price`, `sale_date`) VALUES
(14, 1, 11, 7, 678099, '2020-02-04'),
(15, 2, 12, 7, 1678099, '2020-03-05'),
(16, 3, 11, 6, 178099, '2020-03-06'),
(17, 4, 13, 5, 378099, '2020-03-07'),
(18, 5, 12, 4, 378099, '2020-03-08'),
(19, 6, 14, 3, 178099, '2020-02-09'),
(20, 7, 15, 2, 90099, '2020-03-10'),
(21, 8, 16, 1, 290099, '2020-03-11'),
(22, 9, 11, 7, 390099, '2020-03-12'),
(23, 10, 12, 6, 390099, '2020-03-16'),
(24, 11, 13, 5, 190099, '2020-03-17'),
(25, 12, 14, 4, 790099, '2020-03-18'),
(26, 13, 16, 3, 990099, '2020-03-19'),
(27, 14, 13, 2, 3990099, '2020-03-19');

-- After inserting data into sale table, update the sold column in the House listings table which indicates whether a house was sold or not. 

UPDATE 
     House t1, 
     sale t2
SET 
    t1.sold = '1'
   
WHERE
     t1.id = t2.house_id;


