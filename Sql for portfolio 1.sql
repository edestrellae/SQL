-- 1: what are the customers names, orders IDs, shipping adresses,
-- shipping countries, and order dates for orders shipped to customers in the USA?

Select Customers.cust_name, Orders.order_num, customers.cust_address, 
Orders.order_date, Customers.cust_country
from customers join orders
on orders.cust_id=customers.cust_id
where cust_country='USA';

-- 2: What products sold by the toy company have a unit price more than $5 but less than $10?
select prod_price, prod_name
from products
where prod_price > 5 and prod_price < 10;

SELECT prod_name, prod_price
  FROM Products
  WHERE prod_price BETWEEN 5.01 AND 9.99;

-- 3: How many customers does the toy company have in each country in which they do business? 
select distinct cust_country, count(*) as Number 
from customers
group by cust_country;

-- 4: How many of the toy company's customers have "John" in their contact name? 
-- show the individual count for all variations of "John".

select cust_contact, count(*) as number
from customers 
where cust_contact like '%John%'
group by cust_contact;


-- 5: How many of the toy company's customers, whose names do not start with 'M', have "John" in their contact name? 
-- show the individual count for all variations "John". 

select cust_contact, count(*) As number 
from customers
where cust_contact LIKE '%John' and cust_contact Not like 'M%'
group by cust_contact;
  
  -- 6: What is the total price for each order listed in the toy company's database? 

select order_num, sum(quantity*item_price) as total_price
from orderitems
group by order_num;
-- equation 


-- 7: include the customer ID and contact name for each order that is totaled in the previous query. 
-- sort the output by customer ID

select orderitems.order_num, sum(orderitems.quantity*orderitems.item_price) as total_price, -- there are 2 joins so we are connecting three tables
customers.cust_name, orders.cust_id
from orders join orderitems
on orders.order_num = orderitems.order_num
join customers on orders.cust_id = customers.cust_id
group by order_num; 

-- 8: include the contact name of the customer for each order, sorted by the contact name.



-- 9: What are the total quantitites ordered for each product? 
select prod_id, sum(quantity) as total_quantitiy
from orderitems
group by prod_id;


-- 10: What are the names and contact emails of customers who have placed more than one order?
select customers.cust_name, customers.cust_email
from customers join orders
on customers.cust_id = orders.cust_id
group by customers.cust_name, customers.cust_email
 HAVING COUNT(Orders.order_num) > 1;

-- you are bringing variables from one table, and then joining it with anotehr one, remember to use group by. HAVING COUNT



-- 11: What are the names of the vendors and the number of products
-- each vendor supplies?
select vendors.vend_name, count(products.prod_id) as product_count
from vendors join products
on vendors.vend_id = products.vend_id
group by vendors.vend_name;
-- count, join

-- 12: Which customers have placed orders in 2012? Provide their names and order dates.
select customers.cust_name, orders.order_date
from customers join orders
on customers.cust_id = orders.cust_id
where year(Orders.order_date) = 2012;

-- 13: What are the product names and descriptions for all products with a price greater than $10?
select prod_name, prod_desc
from products
where prod_price > 10;

-- 14: What is the average order value for each customer?
-- customers and orderitems., use avg(function)

-- 15: List the products and their respective vendor names.
select products.prod_id, vendors.vend_name
from products join vendors
on products.vend_id = vendors.vend_id;

-- 16: Find the most expensive product sold by each vendor.
select products.prod_name, max(products.prod_price) as max_price, vendors.vend_name
from vendors join products
ON Vendors.vend_id = Products.vend_id
  GROUP BY Vendors.vend_name, products.prod_name
  ORDER BY max_price DESC;

-- 17: How many orders were placed in each month of 2012?
select month(order_date) as order_month, count(*) as order_count
from orders
where year(order_date) = 2012
group by month(order_date)
order by month(order_date);



-- 18: What are the names and total spending of customers who have spent more than $100 on orders?
select customers.cust_name, sum(orderitems.quantity*orderitems.item_price) as total_spent
from customers join orders
on customers.cust_id = orders.cust_id
  JOIN OrderItems ON Orders.order_num = OrderItems.order_num
  GROUP BY Customers.cust_name
  HAVING total_spent > 100;
  
