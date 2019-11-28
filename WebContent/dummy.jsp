<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Insert title here</title>
	<table>
            <tr>
                <td>
                    <button type="button" onclick="connect();" >Connect</button>
                </td>
            </tr>
            <tr>
<!--                 <td> -->
<!--                     <textarea readonly="true" rows="10" cols="80" id="log"></textarea> -->
<!--                 </td> -->
            </tr>
            <tr>
                <td>
                    <button type="button" onclick="send();" >Would you like to see tips from bloomberg</button>
                </td>
            </tr>
            <tr>
            	<td>
            		<div id = "log"></div>
            	</td>
            </tr>
        </table>
    </body>

    <script src="websocket.js"></script>
</head>

</html>
