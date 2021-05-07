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
		<label for="username" class="form-label">Nome de usuário</label>
		<input type="text" id="username" name="username" class="form-control">
	</div>
		
	<div class="mb-3">	
		<label for="password" class="form-label">Senha</label>
		<input type="password" id="password" name="password" class="form-control">
	</div>
	<div class="mb-3">	
		<button type="submit" class="btn btn-primary">Entrar</button>
	</div>
	</form>
	</div>
	</div>
	<div class="col-3"></div>
</div>
<%@ include file="partials/footer.jsp" %>