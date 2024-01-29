-- Create pizza_restaurant schema
CREATE SCHEMA `pizza_restaurant`;

-- Create tables
CREATE TABLE customers  (
	`customer_id` INT NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(150) NOT NULL,
	`phone_number` VARCHAR(30),
	PRIMARY KEY(`customer_id`));
        
CREATE TABLE orders(
	`order_item_id` INT NOT NULL AUTO_INCREMENT,
    `order_number` INT NOT NULL,
    `order_date/time` DATETIME,
    `pizza_type` VARCHAR(50),
    `quantity` INT NOT NULL,
    `customer_id` INT NOT NULL,
    PRIMARY KEY(order_item_id),
    FOREIGN KEY (customer_id) REFERENCES `customers`(customer_id));      
    
CREATE TABLE pizzas(
	`type` VARCHAR(50),
	`price` DECIMAL(5,2),
	PRIMARY KEY(`type`));
    
CREATE TABLE `orders_pizzas` (
	`order_item_id` INT NOT NULL,
    `type` VARCHAR(40),
    FOREIGN KEY(order_item_id) REFERENCES orders(order_item_id),
    FOREIGN KEY(`type`) REFERENCES pizzas(`type`));
    
-- Populate Data
INSERT INTO `customers`(`name`, `phone_number`)
VALUES('Trevor Page', '226-555-4982'),
	  ('John Doe', '555-555-9489');
      
INSERT INTO `Pizzas`(`type`, `price`)
VALUES('Pepperoni & Cheese', 7.99),
	  ('Vegetarian', 9.99),
      ('Meat Lovers', 14.99),
      ('Hawaiian', 12.99);
      
INSERT INTO `orders`(`order_number`, `order_date/time`, `pizza_type`, `quantity`, `customer_id`)
VALUES(1, '2014-09-10 09:47:00', 'Pepperoni & Cheese', 1, 1),
	  (1, '2014-09-10 09:47:00', 'Meat Lovers', 1, 1),
      (2, '2014-09-10 13:20:00', 'Vegetarian', 1, 2),
      (2, '2014-09-10 13:20:00', 'Meat Lovers', 2, 2),
      (3, '2014-09-10 09:47:00', 'Meat Lovers', 1, 1),
	  (3, '2014-09-10 09:47:00', 'Hawaiian', 1, 1);
            
INSERT INTO `orders_pizzas`(`order_item_id`, `type`)
VALUES(1, 'Pepperoni & Cheese'),
	  (2, 'Meat Lovers'),
	  (3, 'Vegetarian'),
	  (4, 'Meat Lovers'),
	  (5, 'Meat Lovers'),
	  (6, 'Hawaiian');
            
-- Q3	
SELECT `order_number`, `name`, `phone_number`, `order_date/time`, `pizza_type`, `quantity`
FROM orders o
JOIN customers c ON c.`customer_id` = o.`customer_id`
ORDER BY `order_number`;

-- Q4/ 
SELECT `name`, `order_date/time`, SUM(p.price * o.quantity) AS `grand_total`
FROM customers c
JOIN orders o ON c.`customer_id` = o.`customer_id`
JOIN orders_pizzas op ON op.`order_item_id` = o.`order_item_id`
JOIN pizzas p ON op.`type` = p.`type`
GROUP BY `name`;

-- Q5
SELECT `name`, `order_date/time`, SUM(o.quantity * p.price) AS `grand_total`
FROM customers c 
JOIN orders o ON c.`customer_id` = o.`customer_id`
JOIN orders_pizzas op ON o.`order_item_id` = op.`order_item_id`
JOIN pizzas p ON p.`type` = op.`type`
GROUP BY `order_number`
ORDER BY `order_date/time`;
