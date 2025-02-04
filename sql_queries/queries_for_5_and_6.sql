-- SQL SYNTAX: BIGQUERY
-- This query will output the top brands for total spend and total transactions among users who were created in the past 6 months.
with 
    users_created_last_six as (
        SELECT
            userID
        FROM Users
        WHERE 
            -- user created within the last 6 months
            TIMESTAMP_MILLIS(createdDate) >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 6 MONTH)
)

, purchases_narrowed as (
    select 
        brandID
        , SUM(p.finalPrice) AS spend
    -- for the purpose of this query, I am assumming that purchasing multiples of the same items counts as a seperate transaction.
        , SUM(p.quantityPurchased) AS quantity
    from Purchases as p 
    left join Receipts as r 
        on p.receiptID = r.receiptID
    left join users_created_last_six as u 
        on r.userID = u.userID
    where 
        -- narrow to only purchases that occured via users that were created in the last six months
        u.userID is not null
    group by p.brandID
)

, final as (
    select 
        brandID
        , 'TOP_SPEND' as metric 
    from purchases_narrowed
    -- allow ties
    QUALIFY RANK() OVER (ORDER BY spend DESC) = 1

union all 

    select 
    brandID
    , 'TOP_TRANSACTIONS' as metric
    from purchases_narrowed
    -- allow ties
    QUALIFY RANK() OVER (ORDER BY quantity DESC) = 1
)

select * from final;