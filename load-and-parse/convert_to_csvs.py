import pandas as pd
import os

# set up some basic file params
inputdir = "raw/"
files = ["brands.json", "users.json", "receipts.json"]


def convert_to_csv(file):
    filepath = inputdir + file
    cleanname, ext = os.path.splitext(file)
    outputfilename = "converted/" + cleanname + "_output.csv"
    df = pd.read_json(filepath, lines=True)
    df.to_csv(outputfilename, encoding="utf-8", index=False)


def main():
    for f in files:
        convert_to_csv(f)


if __name__ == "__main__":
    main()
