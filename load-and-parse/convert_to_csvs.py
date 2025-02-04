import pandas as pd
import os
from datetime import datetime, timezone
from google.cloud import bigquery

# Initialize BigQuery client
client = bigquery.Client(project='plasma-yeti-449518-t7')

# set up some basic file params
inputdir = "raw/"
files = ["brands.json"
        , "users.json" 
        , "receipts.json"
         ]

# In production, these would be be secret variables. 
project_id = "plasma-yeti-449518-t7"
dataset_id = "sandbox"

def convert_to_csv(file):  
    '''This function reads in a JSON file, un-nests a specified set of arrays
    and re-exports the transformed file as a csv.
    This is done only for ease of querying.'''
    filepath = inputdir + file
    cleanname, ext = os.path.splitext(file)
    outputfilename = "converted/" + cleanname + "_output.csv"
    df = pd.read_json(filepath, lines=True)

    table_id = cleanname
    table_full_id = f"{project_id}.{dataset_id}.{table_id}"
    print(table_full_id)

    # Unnest some of the ID and date arrays, to make easier to query in SQL. 
    # If productionizing, I would make more modular and efficient.
    df['_id'] = df['_id'].apply(lambda x: x['$oid'])

    # Loop through all the date columns, unnest, and convert to UTC
    datecols = ['lastLogin', 'createdDate', 'createDate', 'dateScanned',
                'finishedDate', 'modifyDate', 'pointsAwardedDate',
                'purchaseDate']
    for c in datecols:
        if c in df.columns:
            df[c] = df[c].apply(lambda x: x['$date'] if isinstance(x, dict) and '$date' in x else x)
            df[c] = pd.to_datetime(df[c], unit='ms', utc=True)

    # strip out the special character $, for ease of loading to BQ
    df.columns = [col.replace('$', '_') for col in df.columns]
    # for purposes of this exercise, remove the cpg column and rewardsReceiptItemList
    df = df.drop([col for col in ['cpg', 'rewardsReceiptItemList'] if col in df.columns], axis=1, errors='ignore')

    # Upload DataFrame to BigQuery
    job = client.load_table_from_dataframe(df, table_full_id)
    job.result()
    print(f"Successfully loaded {df.shape[0]} rows into {table_full_id}.")

    # export as a CSV
    df.to_csv(outputfilename, encoding="utf-8", index=False)


def main():
    for f in files:
        convert_to_csv(f)


if __name__ == "__main__":
    main()
