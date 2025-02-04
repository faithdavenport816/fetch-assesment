-- ISSUE #1: 13.2% of USERS ARE NOT FOUND IN OUR USERS DATASET. THIS COULD BE A NON-ISSUE, IF WE WERE ONLY PROVIDED WITH A RANDOM SUBSET OF THE FULL USERS DATABASE. 
select
count(distinct a._id)
from `sandbox.receipts` as a 
left join `sandbox.users` as b 
on a.userId = b._id
where b._id is  null;

-- ISSUE #2: 98% of BARCODES ARE INVALID (NOT FOUND ON THE BRANDS FILE) OR NULL. THEREFORE, THERE ISN'T A CLEAR WAY TO UNIQUELY IDENTIFY ITEMS.
with purchases 
as (select * from `sandbox.receipts`, UNNEST(rewardsReceiptItemList) as item
)
SELECT 
count(*) as total_purchases
, sum(case when a.barcode is null then 1 else 0 end) as missing_barcode
, sum(case when b.barcode is null then 1 else 0 end) as invalid_barcode
from purchases as a 
left join sandbox.brands as b 
on a.barcode = cast(b.barcode as string);


-- ISSUE #3: 91% of BRANDCODES ARE INVALID (NOT FOUND ON THE BRANDS FILE) OR NULL.
with purchases 
as (select * from `sandbox.receipts`, UNNEST(rewardsReceiptItemList) as item
)
SELECT 
count(*) as total_purchases
, sum(case when a.brandCode is null then 1 else 0 end) as missing_brandcode
, sum(case when b.brandCode is null then 1 else 0 end) as invalid_brandcode
from purchases as a 
left join sandbox.brands as b 
on a.brandCode = cast(b.brandCode as string);

# ISSUE #4: THERE ARE 40 INSTANCES WHERE THE QUANTITY OF ITEMS PURCHASES DOES NOT MATCH BETWEEN THE purchasedItemCount COLUMN, AND THE summed quantityPurchased COLUMN. 

with base as (
SELECT _id, max(purchasedItemCount) as purchased_item_count, sum(quantityPurchased) as quantity_purchased
FROM 
  `sandbox.receipts`, UNNEST(rewardsReceiptItemList) as item
group by 1)
select * from base where purchases_item_count <> quantity_purchased;


-- NON-ISSUE: PRIMARY KEY IS UNIQUE.
select _id, count(*) from `sandbox.receipts` group by 1 order by 2 desc;

-- NON-ISSUE: DATES HAVE CONTEXTUAL COHESION
select *
from `sandbox.receipts` 
where 
  dateScanned < createDate
  or modifyDate < createDate
  or finishedDate < createDate;

-- NON-ISSUE: CREATEDATE KEY IS NON NULL.
select count(*) from `sandbox.receipts` where createDate is  null;

-- NON-ISSUE: NO FINISHED RECEIPTS ARE MISSING A FINISHED DATE
select rewardsReceiptStatus, count(*) from `sandbox.receipts` where finishedDate is  null group by 1;

-- NON-ISSUE: RECORDS ARE MISSING POINTS AWARDED DATE DESPITE EARNING POINTS, BUT ONLY WHEN RECEIPTS ARE FLAGGED OR REJECTED
select rewardsReceiptStatus, COUNT(*) from `sandbox.receipts` where pointsAwardedDate is null and pointsEarned > 0 GROUP BY 1;
