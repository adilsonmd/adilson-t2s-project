<%@ page import="javax.naming.Context"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="partials/header.jsp" %>

<div class="container">
	<div class="row">
		<h1><%= "Hello world, JSP!" %></h1>
	</div>
	
	
	<p>${pageContext.request.contextPath}</p>
	<a href="login.jsp">Login</a>
</div>
<%@ include file="partials/footer.jsp" %>