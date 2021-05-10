<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<% 
if (session.getAttribute("user-logged-in") == "true"){
	response.sendRedirect("./dashboard");
}
%>

<%@ include file="partials/header.jsp" %>

<div class="container">
	<div class="row">
		<div class="col-3"></div>
	  	<div class="col-6 border border-3 p-3">
	  	
		<form action="./cadastro_validation.jsp" method="POST">
			<div class="mb-3">
				<label for="nome" class="form-label">Nome de usuário</label>
				<input type="text" id="nome" name="nome" 
				required="required" class="form-control"
				maxlength="255">
			</div>

			<div class="mb-3">
				<label for="email" class="form-label">Email</label>
				<input type="text" id="email" name="email" 
				required="required" class="form-control"
				maxlength="255">
			</div>
			<div class="mb-3">	
				<label for="password" class="form-label">Senha</label>
				<input type="password" id="password" name="password" 
						required="required" class="form-control"
						maxlength="255">
			</div>
			<div class="mb-3">	
				<label for="password_confirmation" class="form-label">Confirmação de Senha</label>
				<input type="password" id="password_confirmation" name="password_confirmation"
				       required="required" class="form-control"
				       maxlength="255">
			</div>
			<button type="submit" class="btn btn-primary">Criar</button>
		</form>
	</div>
</div>
</div>
<%@ include file="partials/footer.jsp" %>