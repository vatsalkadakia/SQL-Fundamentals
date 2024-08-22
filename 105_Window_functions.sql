--WINDOW FUNCTIONS--
----------------------------------------------------
--WINDOW FUNCTION
select 
 *,
 sum(sales_cost) over (partition by transaction_id) as transaction_total_sales
 
from
 grocery_db.transactions;
 

select *, sum(sales_cost) over (partition by transaction_id) as transaction_total_sales,
          sales_cost / sum(sales_cost) over (partition by transaction_id) as transaction_sales_percentage
from grocery_db.transactions;

-- ROW NUMBER & RANK

select
 *,
 row_number() over (partition by transaction_id, transaction_date) as transaction_number
 
from
 grocery_db.transactions;
 
--reference
/*
ROW NUMBER WILL GIVE A UNIQUE VALUE TO EACH ROW OF DATA IN THE SET EVEN IF THERE ARE TIES IN THE 'ORDER BY' LOGIC

100m time  output
 10s         1
 10s         2 
 10s         3
 11s         4
 12s         5
 

  RANK
 will give ties the same value, then skip to the next value in terms of number of rows it has seen
 

100m time  output
 10s         1
 10s         1 
 10s         1
 11s         4
 12s         5 
 
DENSE RANK
will do the same as RANK but will go to the next number in the sequence after any ties

100m time  output
 10s         1
 10s         1 
 10s         1
 11s         2
 12s         3
 
*/


--NTILE - for deciles/percentiles etc

select
 customer_id, customer_loyalty_score,
 ntile(3) over (order by customer_loyalty_score desc) as loyalty_category,
 ntile(10) over (order by customer_loyalty_score desc) as loyalty_category2
  
from
 grocery_db.loyalty_scores; 
