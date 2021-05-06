<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login - Adilson T2S Project</title>
</head>
<body>
<h1>Login page</h1>
<form method="POST" action="${ pageContext.request.contextPath }/login_validation.jsp">
	<label for="username">Nome de usuário</label>
	<input type="text" id="username" name="username">
	
	<label for="password">Senha</label>
	<input type="password" id="password" name="password">
	
	<input type="submit" value="Entrar">
</form>
</body>
</html>