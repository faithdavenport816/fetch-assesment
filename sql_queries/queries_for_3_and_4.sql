-- SQL SYNTAX: BIGQUERY
-- This query will output the average spend and total purchased items by rewardsReceiptStatus. I am making the assumption that "Accepted" from the exam statement, is equal to "FINSHED" in the data.
with final as (SELECT
    rewardsReceiptStatus
    , avg(totalSpent) as total_spend
    , sum(purchasedItemCount) as n_items
FROM Receipts
WHERE
    rewardsReceiptStatus in ('FINISHED', 'REJECTED')
    group by 1)

select * from final;