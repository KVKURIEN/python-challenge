
import sys
import os
import subprocess
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

# dependencies
from flask import render_template, jsonify, redirect, abort, url_for
from StockX_App import app, db
from MongoDB_RecursiveCSVParser import MongoDB_RecursiveCSVParser


@app.route("/")
def index():
    """Return the homepage."""
    flag = MongoDB_RecursiveCSVParser.load_csv()
    return render_template("index.html")

@app.route("/bar")
def bar():
    return render_template("bar.html")    

@app.route("/sankey")
def sankey():
    return render_template("sankey.html")

@app.route("/secret")
def secret():
    return render_template("secret.html")

# @app.route("/load")
# def mongo_csv_load():
#     flag = MongoDB_RecursiveCSVParser.load_csv()
#     if (not flag): abort(405)
#     return ('csv files loaded into MongoDB')


@app.route("/bardata")
def getbardata():
    sneakers = db.cleanedup_sneaker.find()
    print(sneakers)
    sneakerList = []
    for sneaker in sneakers:
        print(sneaker)
        sneakerItem = {
            'brand':sneaker['Brand'],
            'category':sneaker['Category'],
            'price_premium':sneaker['Price_Premium']        
        }
        sneakerList.append(sneakerItem)
    return jsonify({'sneakerList': sneakerList})

@app.route("/bubble")
def bubble_chart():
    """Go to bubble chart page"""
    return render_template("bubble.html")

@app.route("/bubbledata")
def getbubbledata():

    sneakers = db.sneaker_bubble.find()

    sneakerList = []
    for sneaker in sneakers:
        print(sneaker)
        sneakerItem = {
            'brand':sneaker['Brand'],
            'color':sneaker['Color'],
            'retailPrice':sneaker['Retail_Price ($)'],
            'avgSalePrice':sneaker['Avg_Sale_Price ($)'],
            'noSales':sneaker['Number_of_Sales']
          
        }
        sneakerList.append(sneakerItem)
    return jsonify({'sneakerList': sneakerList})   

@app.route("/project-limitations")
def project_limitations():
    return render_template("project_limitations.html")    

if __name__ == "__main__":
    app.run(debug=True)