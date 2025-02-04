-- ISSUE #1: 13.2% of USERS ARE NOT FOUND IN OUR USERS DATASET. THIS COULD BE A NON-ISSUE, IF WE WERE ONLY PROVIDED WITH A RANDOM SUBSET OF THE FULL USERS DATABASE. 
select
count(distinct a._id)
from `sandbox.receipts` as a 
left join `sandbox.users` as b 
on a.userId = b._id
where b._id is  null;

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
