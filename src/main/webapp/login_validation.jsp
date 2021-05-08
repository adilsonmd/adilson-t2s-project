<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ include file="partials/header.jsp" %>
<p>Carregando...</p>
<p>Bem-vindo, <strong><%= request.getParameter("username") %></strong></p>
<%
	session.setAttribute("user-logged-in", "true");
	session.setAttribute("username", request.getParameter("username"));
	
	response.sendRedirect("./dashboard.jsp");
%>
<%@ include file="partials/footer.jsp" %>
