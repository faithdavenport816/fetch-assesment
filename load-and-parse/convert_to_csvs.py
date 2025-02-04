import pandas as pd
import os
from datetime import datetime, timezone


# set up some basic file params
inputdir = "raw/"
files = ["brands.json", "users.json", "receipts.json"]


def convert_to_csv(file):  
    '''This function reads in a JSON file, un-nests a specified set of arrays
    and re-exports the transformed file as a csv.
    This is done only for ease of querying.'''
    filepath = inputdir + file
    cleanname, ext = os.path.splitext(file)
    outputfilename = "converted/" + cleanname + "_output.csv"
    df = pd.read_json(filepath, lines=True)

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
            
    # export as a CSV
    df.to_csv(outputfilename, encoding="utf-8", index=False)


def main():
    for f in files:
        convert_to_csv(f)


if __name__ == "__main__":
    main()
