<% 
if(session.getAttribute("user-logged-in") != "true") {
	response.sendRedirect("./error_page.jsp");	
}
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="partials/header.jsp"%>

<div class="container">

	<h1>Dashboard</h1>
	<div class="border">
		<a href="./conteiner.jsp">
		Listar conteiner
		</a>
	</div>
</div>
<%@ include file="partials/footer.jsp"%>
