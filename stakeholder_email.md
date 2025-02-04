Dear Jane Doe, 

Hello! I hope you are doing well. Over the past week, I have been evaluating the new data sources provided to us, which are related to our brand inventory, users, and receipts. I hope to integrate these new data sources into our existing infrastructure, to enable improved decision-making and reporting, but first I have a series of questions that I think your team is suited to answer! I appreciate your time in advance and am happy to schedule a meeting to talk through any of these if useful.    

### Initial Questions & Clarifications
* Were the datasets provided a complete picture of our users, brands, and receipts, or rather, a subset?
* Should all purchased products be associated with a unique barcode? Are there any products that should not have a barcode?
* Should all products be associated with PartnerProduct and/or MetaBrite information?
* Should Fetch Staff members have user accounts or only consumers?
* Should Users be unique across purchases?
* Do "brands" refer to individual products, or rather, to a type of product manufactured by a particular company under a particular name?
* Are consumers allowed to return products, and if so, will we receive that data?
* How are Brand and Category Codes assigned?
  
The answer to these questions will help me to understand the "grain" of our data. Essentially, these answers will help me ensure that I am making the proper assumptions when engineering our transformation pipelines. 

### Data Quality Concerns
Upon receipt of this data, I reviewed the uniqueness, missingness, and contextual cohesion among key columns and identified a few areas of concern. Some of your answers to my questions in the prior section may illuminate why these issues exist, but others may require deeper investigation on my part. Regardless, it would be helpful for me to have both front-end and back-end access to the tooling that generated the provided data. 

* Many products are missing a barcode or are assigned duplicative barcodes. Resultingly, we are not able to uniquely track product performance. 
* Brand Codes appear to be manually assigned, as many have human-generated errors and many are missing. This inhibits our ability to compare brand performance.
* User IDs are not currently unique, meaning that we are not able to correctly track unique customer behavior.
* Category Codes appear to be manually assigned and are frequently blank. Therefore, we are not able to correctly track consumer behavior by category.

### Scale & Optimization Planning
Looking to the future, it is critical that I design data infrastructure that will scale performantly and can adapt to changes over time. Therefore, could you answer the following questions? The answers will dictate how I am able to optimize our data assets.

* Will barcodes change over time?
* Will prices stay the same over time?
* Will all products be assigned to MetaBrite information  or just a small subset?

### Current Scale Concerns
After evaluating the current data structure, I have the following concerns regarding our ability to scale. Ideally, after receiving the answers to my above questions, I can propose a new data model to account for these concerns, as well as the quality issues mentioned previously. 

* When items are removed from inventory, they no longer correctly surface in our data (instead, resulting in a description of "DELETED ITEM"). This diminishes our ability to track performance over time.
* Category and Brand codes appear to be currently manually assigned. This has resulted in large amounts of missingness and human error. I would instead reccomend algorithmic assignment, and using a numeric category system
* Since individual products do not seem to be assigned to stable, unique numeric identifiers, I anticipate long-term reporting to be an issue. As our inventory grows larger, it is imperative that we can track the performance of unique, individual products over time.


Thank you for your time, and I look forward to further discussions! Please let me know if you have any questions.

Thanks,
Faith
