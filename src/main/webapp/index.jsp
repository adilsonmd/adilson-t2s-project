<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
   
<%
if(session.getAttribute("user-logged-in") == "true") {
	response.sendRedirect("./dashboard.jsp");	
}
%> 
<%@ include file="partials/header.jsp" %>

<div class="container-fluid">
	<div class="row">
				
			<div class="col-12 bg-dark p-3">
				<img class="img-fluid"
				src="./assets/logo_t2s.png" alt="Logo T2S" width="300">
				
				<h1 class="d-block text-white">Controle de Contêineres</h1>
			</div>
			
			<h3 class="mt-3">Tenha controle de todas as movimentações de seus Contêineres. </h2>

		</div>
	
</div>

<%@ include file="partials/footer.jsp" %>