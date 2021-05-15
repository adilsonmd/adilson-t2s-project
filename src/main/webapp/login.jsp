<%@page import="com.google.gson.Gson"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="partials/header.jsp" %>

<div class="container">

<h1>Login</h1>
<div class="row">
    <div class="col-3"></div>
    
    <div class="col-6 border border-3 p-3">
	<form method="POST" action="./login_validation.jsp">
		<div class="mb-3">
			<label for="email" class="form-label">Email de acesso:</label>
			<input type="text" id="email" name="email" 
			required="required" maxlength="255" 
			class="form-control">
		</div>
			
		<div class="mb-3">	
			<label for="password" class="form-label">Senha:</label>
			<input type="password" id="password" name="password" 
			required="required" maxlength="255" 
			class="form-control">
		</div>
		<div class="mb-3">	
			<button type="submit" class="btn btn-primary text-white">Entrar</button>
		</div>
		<div class="mb-3">
			<a href="./cadastro_usuario.jsp">Cadastrar</a>
		</div>
	</form>
	</div>
	</div>
	<div class="col-3"></div>
</div>
<%@ include file="partials/footer.jsp" %>