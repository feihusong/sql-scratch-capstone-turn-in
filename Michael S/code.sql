 select question, count(*) from survey
group by 1;

SELECT *
FROM quiz
LIMIT 5;

SELECT *
FROM home_try_on
LIMIT 5;

SELECT *
FROM purchase
LIMIT 5;

select distinct quiz.user_id, 
home_try_on.user_id is not null as 'is_home_try_on'
, home_try_on.number_of_pairs, 
purchase.user_id is not null as 'is_purchase'
from quiz
left join home_try_on on home_try_on.user_id = quiz.user_id
left join purchase on purchase.user_id = quiz.user_id
limit 10;

WITH funnels AS (
select distinct quiz.user_id, 
home_try_on.user_id is not null as 'is_home_try_on'
, home_try_on.number_of_pairs, 
purchase.user_id is not null as 'is_purchase'
from quiz
left join home_try_on on home_try_on.user_id = quiz.user_id
left join purchase on purchase.user_id = quiz.user_id
)
 
SELECT number_of_pairs, count(*) as 'quizzed',
count(case 
when is_home_try_on= 1 then user_id
      else null      
end) as 'is_home_try_on',
round(100.0*count(case 
when is_purchase = 1 then user_id
      else null      
end)/count(case 
when is_home_try_on= 1 then user_id
      else null      
end),2) as 'is_purchase%'
from funnels
group by 1;

