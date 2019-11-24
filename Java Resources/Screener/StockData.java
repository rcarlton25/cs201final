package Screener;

public class StockData {
	public String symbol;
	public String name;
	public String price;
//	public Double 52_week_high;
//	public Double 52_week_low;
	public String market_cap;
	
	public String getSymbol() {
		return this.symbol;
	}
	public String getName() {
		return this.name;
	}
	public String getPrice() {
		return this.price;
	}
	public String getMarketCap() {
		return this.market_cap;
	}
}