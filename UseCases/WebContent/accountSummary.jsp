<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
String driver = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost/";
String database = "onlinebank";
String userid = "root";
String password = "Pass@1234";
try 
{
Class.forName(driver);
} catch (ClassNotFoundException e) 
{
e.printStackTrace();
}
Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Account Summary</title>
</head>
<body>
<h1>Account Summary</h1>

<%
try{
connection = DriverManager.getConnection(connectionUrl+database, userid, password);
statement=connection.createStatement();
String sql ="select account_balance from account_details";
resultSet = statement.executeQuery(sql);
while(resultSet.next()){
%>

<i>Account balance : <strong><%= resultSet.getString("account_balance")%></strong><br></i>

<%
}
connection.close();
} catch (Exception e) {
e.printStackTrace();
}
%>
<br />
<table border="1">
<tr>
<td>Transaction Id</td>
<td>Account Id</td>
<td>Transaction_type</td>
<td>Amount</td>
<td>Transaction Date</td>
</tr>
<%
try{
connection = DriverManager.getConnection(connectionUrl+database, userid, password);
statement=connection.createStatement();
String sql ="select * from transaction_details ORDER BY transaction_date DESC LIMIT 5;";
resultSet = statement.executeQuery(sql);
while(resultSet.next()){
%>
<tr>
<td><%=resultSet.getString("transaction_id") %></td>
<td><%=resultSet.getString("account_id") %></td>
<td><%=resultSet.getString("transaction_type") %></td>
<td><%=resultSet.getString("amount") %></td>
<td><%=resultSet.getString("transaction_date") %></td>

</tr>
<%
}
connection.close();
} catch (Exception e) {
e.printStackTrace();
}
%>
</table>
<br />
<form action="button.jsp">
<input type="button" value="Fund Transfer" name="Fund Transfer"  style="background-color:blue;padding:10px;border-color:pink;color:white" onclick = "javascript:document.forms[0].action = 'fundtransfer.html'; document.forms[0].submit();"/>
</form>
</body>
</html>