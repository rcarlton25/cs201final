<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<br>See script tag for buySell

<form method="GET" action="signup">
<br>Username <br>
<input type="text" id="username" name="username"> <br>
Password <br>
<input type="text" id="password" name="password"> <br>
Confirm Password<br>
<input type="text" name="confirmPassword"><br>
<input class="button" id="sign" type="submit" value="signup">
</form>

<form method="GET" action="login">
<br>Username <br>
<input type="text" id="username" name="username"> <br>
Password <br>
<input type="text" id="password" name="password"> <br>
<input class="button" id="sign" type="submit" value="login">
</form>

<br><a href="logOut">logOut</a>

<input type="text" value="<%= session.getAttribute("inFav") %>" />

<script>
	var ticker = "jpm";
	var ar = "a";
	var q = new XMLHttpRequest();
	q.open("GET", "addFav?ticker=" + ticker
			+ "&ar=" + ar, false);
	q.send();
	
	var tickertwo = "jpm";
	var arq = "q";
	var query = new XMLHttpRequest();
	query.open("GET", "addFav?ticker=" + ticker
			+ "&ar=" + ar, false);
	query.send();
	
	/*
	var tt = "jpm";
	var art = "r";
	var qq = new XMLHttpRequest();
	qq.open("GET", "addFav?ticker=" + tt
			+"&ar=" + art, false);
	qq.send();
	*/
	
	
	/*
	//Code for trial buySell
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
	y.send();*/
	
</script>

</body>
</html>