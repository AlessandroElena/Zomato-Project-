create database Zomato;
use zomato;

#3.Find the Numbers of Resturants based on City and Country.
select countryname,city,count(restaurantid) as no_of_restaurant from zomato
innner join country
on countrycode=countryid
group by countryname,city;

/*2. Build a Calendar Table using the Column Datekey
  Add all the below Columns in the Calendar Table using the Formulas.
   A.Year
   B.Monthno
   C.Monthfullname
   D.Quarter(Q1,Q2,Q3,Q4)
   E. YearMonth ( YYYY-MMM)
   F. Weekdayno
   G.Weekdayname
   H.FinancialMOnth ( April = FM1, May= FM2  …. March = FM12)
   I. Financial Quarter ( Quarters based on Financial Month)*/

UPDATE Zomato SET Datekey_Opening = REPLACE(Datekey_Opening, '_', '/') 
WHERE Datekey_Opening LIKE '%_%';
 Set SQL_SAFE_UPDATES=0;
 
select Datekey_Opening,
        year(Datekey_Opening) as Year,
        month(Datekey_Opening) as Month,
        day(Datekey_Opening) as Day,
        Quarter(Datekey_Opening) as Quarter,
        monthname(Datekey_Opening) as Monthname,
        concat(year(Datekey_Opening) , '-',month(Datekey_Opening)) as YearMonth,
        weekday(Datekey_Opening) as Weekdayno,
        dayname(Datekey_Opening) as Dayname,
        
case when monthname(datekey_opening) in ('January' ,'February' ,'March' )then 'Q1'
     when monthname(datekey_opening) in ('April' ,'May' ,'June' )then 'Q2'
     when monthname(datekey_opening) in ('July' ,'August' ,'September' )then 'Q3'
else  'Q4' end as quarters,

case when monthname(datekey_opening)='January' then 'FM9' 
when monthname(datekey_opening)='January' then 'FM10'
when monthname(datekey_opening)='February' then 'FM11'
when monthname(datekey_opening)='March' then 'FM12'
when monthname(datekey_opening)='April'then'FM1'
when monthname(datekey_opening)='May' then 'FM2'
when monthname(datekey_opening)='June' then 'FM3'
when monthname(datekey_opening)='July' then 'FM4'
when monthname(datekey_opening)='August' then 'FM5'
when monthname(datekey_opening)='September' then 'FM6'
when monthname(datekey_opening)='October' then 'FM7'
when monthname(datekey_opening)='November' then 'FM8'
when monthname(datekey_opening)='December'then 'FM9'
end Financial_months
from zomato;

#4.Numbers of Resturants opening based on Year , Quarter , Month,

select year(datekey_opening)year,quarter(datekey_opening)quarter,monthname(datekey_opening)monthname,count(restaurantid)as no_of_restaurants 
from Zomato group by year(datekey_opening),quarter(datekey_opening),monthname(datekey_opening) 
order by year(datekey_opening),quarter(datekey_opening),monthname(datekey_opening) ;

/*select year(datekey_opening)year, count(restaurantid)no_of_restaurants from zomato
group by year(datekey_opening)
order by year(datekey_opening) desc;

select quarter(datekey_opening)Quarter, count(restaurantid)no_of_restaurants from zomato
group by quarter(datekey_opening)
order by quarter(datekey_opening);

select monthname(datekey_opening)monthname, count(restaurantid)no_of_restaurants from zomato
group by monthname(datekey_opening);*/

#5. Count of Resturants based on Average Ratings
 select rating as Rating_range,  count(restaurantid) as Restaurant_count from zomato
 where rating is not null
 group by rating_range
 order by rating_range;

#Create buckets based on Average Price of reasonable size and find out how many resturants falls in each buckets
select distinct(price_range) from zomato;
select distinct(Average_cost_for_two) from zomato
order by Average_cost_for_two desc;
select case when price_range=1 then "0-500"
            when price_range=2 then "500-6000"
			when price_range=3 then "6000-30000" 
		    when price_range=4 then ">30000" 
             end As Buckets,
             count(restaurantid) from zomato
             group by Buckets
             order by Buckets;

#7.Percentage of Resturants based on "Has_Online_delivery"
select has_online_delivery,concat(round(count(Has_Online_delivery)/100),"%") percentage 
from zomato 
group by has_online_delivery;

#8.Percentage of Resturants based on "Has_Table_booking"

select Has_Table_booking,concat(round(count(Has_Table_booking)/100,2),"%") percentage 
from zomato 
group by Has_Table_booking;




