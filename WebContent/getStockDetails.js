function viewDetails(result){
	let symbol = result.id;
	let url = "https://api.worldtradingdata.com/api/v1/stock?symbol=" + symbol + "&api_token=BLj5qqwiK1mbeAy32nSMUNDbrJaTiNoFTBm89tEHpJx3IZ9ysAnETDUdK2rv";
	$.get(url, function(response){
		
		let stock = response.data[0];
     	let stockDataJSON = {};
     	
     	stockDataJSON["name"] = stock.name;
     	stockDataJSON["ticker"] = stock.symbol;
     	stockDataJSON["price"] = stock.price;
		stockDataJSON["isGreen"] = parseFloat(stock.day_change) > 0 ? true : false;
     	stockDataJSON["cap"] = stock.market_cap;
     	stockDataJSON["yearlyHigh"] = stock["52_week_high"];
     	stockDataJSON["yearlyLow"] = stock["52_week_low"];
     	stockDataJSON["exchange"] = stock.stock_exchange_short;
     	
     	localStorage["stockDataJSON"] = JSON.stringify(stockDataJSON);
    	
		window.location.href = "stockDetails.jsp";
	});
}    