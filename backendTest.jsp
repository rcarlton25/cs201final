<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<script>

	var ticker = "tjx";
	var bs = "b";
	var shares = 2;
	var price = 12.34;
	var x = new XMLHttpRequest();
	x.open("GET", "buySell?ticker=" + ticker 
			+ "&bs=" + bs
			+ "&shares=" + shares
			+ "&price=" + price , false);
	x.send();
	
	bs = "s";
	shares = 1;
	price = 13;
	var y = new XMLHttpRequest();
	y.open("GET", "buySell?ticker=" + ticker 
			+ "&bs=" + bs
			+ "&shares=" + shares
			+ "&price=" + price , false);
	y.send();
</script>

</body>
</html>