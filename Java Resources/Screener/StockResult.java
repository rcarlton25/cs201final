package Screener;

public class StockResult {
	public int symbols_requested;
	public int symbols_returned;
	public StockData[] data;
	
	public int getSymbolsRequested() {
		return this.symbols_requested;
	}
	public int getSymbolsReturned() {
		return this.symbols_returned;
	}
	public StockData[] getStockData() {
		return this.data;
	}
}