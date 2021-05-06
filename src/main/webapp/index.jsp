<%@ page import="javax.naming.Context"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Adilson project - T2S</title>
</head>
<body>
<h1><%= "Hello world, JSP!" %></h1>
<a href="login.jsp">Login</a>
<p>${pageContext.request.contextPath}</p>
</body>
</html>