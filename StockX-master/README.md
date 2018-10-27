# StockX

## Overview of Contents:
* `ShoeURLs` folder - contains the list of shoe URL's we manually pulled from StockX to feed into the python scraper files in the `Scrapers` folder. 

* `Scrapers` folder - contains the Python files that scraped the StockX website for our data. They generated our csv files.

* `StockX_App` folder - contains our actual application setup.

  * `MongoDB_RecursiveCSVParser` folder
    * `CSV_Files` folder - contains the csv files that will be loaded into MongoDB collections to feed our visuals.
    * `MongoDB_RecursiveCSVParse` file - this python file will parse through provided directory and recursively load the csv files found in the `CSV_Files` folder into MongoDB collections in `StockX_DB` database.
    
  * `static` folder - contains our `CSS`, `JavaScript`, static images (`img`), and additional formatting files (`vendor`) for the Sanky chart.
  
  * `templates` folder - contains our html files for the home page (`index.html`), charts (`bar.html, bubble.html, sankey.html`), and project limitations (`project_limitations.html`) displayed on our website.
  
  * `__init__` file - initializes MongoDB in Flask.
  
  * `settings` file - the MongoDB settings for our application.
  
  * `app` file - our flask application. Contains all the routes of our website. <br>
  	__**This is the only file you have to run to initialize our site**.__

# Instructions:

1. Initialize MongoDB locally.
2. Run `StockX > StockX_App > app.py` file.
