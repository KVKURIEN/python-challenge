var url = "/bardata";
function buildPlot() {
                
    d3.json(url).then(function(response) {

        console.log(response)
                              
        var sneakers = response.sneakerList;
                
        console.log(sneakers)
    
        var trace = {
            type: "bar",
            x: sneakers.map(sneaker => sneaker.category),
            y: sneakers.map(sneaker => sneaker.price_premium), 
            hovertext: sneakers.map(sneaker => sneaker.brand)
            };
                
        var data = [trace];
                
        var layout = {
            title: "Price Premium of Sneaker Models",
            xaxis: {title: "Model of Sneaker"},
            yaxis: {title: "Price Premium (%)"},
            hovermode: "closest"
            };
                
        Plotly.plot("bar", data, layout);
              
        });

    }
buildPlot();
