var url = "/bubbledata";
function buildPlot() {
                
    d3.json(url).then(function(response) {

        console.log(response)
                              
        var sneakers = response.sneakerList;
                
        console.log(sneakers)
    
        var trace = {
            mode: "markers",
            type: "scatter",
            x: sneakers.map(sneaker => sneaker.retailPrice),
            y: sneakers.map(sneaker => sneaker.avgSalePrice), 
            hovertext: sneakers.map(sneaker => sneaker.brand),
            marker: {
                size: sneakers.map(sneaker => sneaker.noSales),
                color: sneakers.map(sneaker => sneaker.color),
                sizemode:'area',
                sizeref: 2.* Math.max(...sneakers.map(sneaker => sneaker.noSales))/(30.**2),
                sizemin:4
                }
            };
                
        var data = [trace];
                
        var layout = {
            title: "Price Premium and Popularity by Color",
            xaxis: {title: "Retail Price ($)"},
            yaxis: {title: "Average Sale Price ($)"},
            hovermode: "closest"
            };
                
        Plotly.plot("bubble", data, layout);
              
        });

    }
buildPlot();
