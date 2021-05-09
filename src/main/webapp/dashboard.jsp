<% 
if(session.getAttribute("user-logged-in") != "true") {
	response.sendRedirect("./error_page.jsp");	
}
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="partials/header.jsp"%>

<div class="container">
<table>
<thead>
	<tr>
		<th scope="col">ID</th>
		<th scope="col">Cliente</th>
		<th scope="col">Num. Contêiner</th>
	</tr>
</thead>

</table>
<%
out.println("Dashboard");
%>
</div>
<%@ include file="partials/footer.jsp"%>
