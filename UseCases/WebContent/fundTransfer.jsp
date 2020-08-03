<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Random"%>
<%@page import="java.sql.Timestamp"%>
<%
String driver = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost/";
String database = "onlinebank";
String userid = "root";
String password = "Pass@1234";
float currentBalance=0.0f;
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
PreparedStatement ps=null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Fund Transfer Page</title>
</head>
<body>
<h1>Fund Transfer Page</h1>

<br />
<br />

<%
try{
connection = DriverManager.getConnection(connectionUrl+database, userid, password);
statement=connection.createStatement();

int accNum = Integer.parseInt(request.getParameter("acount_number"));
int amount = Integer.parseInt(request.getParameter("amount"));
String transaction_type = request.getParameter("transaction_type");

Date date=new Date();
Random r=new Random();
int transactionid=9999999;
int ran= 1000000000 + r.nextInt(transactionid);
System.out.println("randon int : "+ran);
statement=connection.createStatement();
long time=date.getTime();
Timestamp ts=new Timestamp(time);
String newDate=String.valueOf(ts);
int account_number=673309817;

String sql ="select account_balance from account_details";
resultSet = statement.executeQuery(sql);
while(resultSet.next()){

  currentBalance= Float.parseFloat(resultSet.getString("account_balance"));
  System.out.println("Current Balance:"+currentBalance);
}
int i=statement.executeUpdate("insert into transaction_details(transaction_id,account_id,transaction_type,amount,transaction_date) values ('"+ran+"','"+accNum+"','"+transaction_type+"','"+amount+"','"+newDate+"')");
String sqlUpdate="Update account_details set account_balance=? where account_no="+account_number;
ps=connection.prepareStatement(sqlUpdate);
float amountTrans=(float)amount;
float newBalance=currentBalance-amountTrans;
ps.setFloat(1, newBalance);

int j=ps.executeUpdate();
if(j>0){
	System.out.println("Updated successfully");
	session.setAttribute("message","Transaction completed successfully");
	String contextPath = request.getContextPath();
	int serverPort = request.getServerPort();
	
	response.sendRedirect("http://localhost:"+serverPort+"/"+contextPath+"/accountSummary.jsp");
	
}
connection.close();
} catch (Exception e) {
e.printStackTrace();
}
%>
</body>
</html>