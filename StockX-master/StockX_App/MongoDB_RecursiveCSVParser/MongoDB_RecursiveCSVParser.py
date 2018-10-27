import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..')))

from StockX_App import app, db
from pprint import pprint
import os, glob

DirectoryPath =  os.path.join(os.getcwd(), app.config['CSV_FOLDER_PATH'], app.config['CSV_FILE_PATH'])
# print (DirectoryPath)

def load_csv(drop = True):
    print(os.getcwd(), DirectoryPath)
    if (drop): db.command("dropDatabase")
    try:
        for root, dirs, files in os.walk(DirectoryPath):
            for file in files:
                with open(os.path.join(DirectoryPath, file), 'r') as f:
                    CollectionName = file.rstrip('.csv')
                    Collection = db[CollectionName]
                    CSV_Headers = f.readline()
                    header = CSV_Headers.strip().split(',')
                    next(f)
                    for line in f:
                        lines = line.strip().split(',')
                        row = {k:v for k,v in zip(header, lines)}
                        id = Collection.insert_one(row).inserted_id
                    cursor = Collection.find({}).limit(1)
                    for document in cursor:
                        print(f'\nDisplay 1 Document from Collection:\n{"-"*35}')
                        pprint(document)
                        print(f'\n')
        return True
    except Exception as e:
        print(e)
        return False


if __name__ == "__main__":
    load_csv()