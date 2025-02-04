-- ISSUE #1: PRIMARY KEY IS NON-UNIQUE. 353 (71%) of rows are associated with a duplicated ID. Some duplicates occur as many as 20 times.
select _id, count(*) from sandbox.users group by 1 having count(*) > 1 order by 2 desc;

-- ISSUE #2: ROLE IS SOMETIMES EQUAL TO FETCH-STAFF, CONTRADICTING THE DATA DICTIONARY, WHICH STATES THAT IT SHOULD BE HARDCODED TO CONSUMER.
select role, count(*) from sandbox.users group by 1;

-- ISSUE #3: SIGNIFICANT MISSINGNESS (11.3%) IN THE STATE COLUMN, MAY INDICATE AN ISSUE WITH DATA CAPTURE.
select state, count(*) from sandbox.users group by 1;

-- NON-ISSUE: created dates are always before lastLogin.
select * from sandbox.users where createdDate > lastLogin;

-- NON-ISSUE: dates within a reasonable range
select min(createdDate), max(createdDate), min(lastLogin), max(lastLogin) from sandbox.users;