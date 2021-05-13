<%@page import="java.sql.PreparedStatement"%>
<%@page import="br.com.t2s.models.Conteiner"%>
<%@page import="br.com.t2s.models.ConteinerDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<% 
if(session.getAttribute("user-logged-in") != "true") {
	response.sendRedirect("./error_page.jsp");	
}
%>

<%@ include file="partials/header.jsp"%>


<% 
int idUpdate = 0;
Conteiner conteiner = new Conteiner();

try{	
	idUpdate = Integer.parseInt(request.getParameter("update"));
	
	
	Connection conn;
	try {
		
		String url = "jdbc:postgresql://172.31.56.85:5432/t2s";
		String dbUsername = "postgres";
		String dbPassword = "ad123";
		
 		conn = DriverManager.getConnection(url, dbUsername, dbPassword);
 		
		String SQL = "SELECT * FROM tb_conteiner WHERE id_conteiner = ?";
		PreparedStatement ps = conn.prepareStatement(SQL);
		ps.setInt(1, idUpdate);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next())
		{
			conteiner.setId_conteiner(rs.getInt(1));
			conteiner.setCliente(rs.getString(2));
			conteiner.setNumero_conteiner(rs.getString(3));
			conteiner.setTipo_conteiner(rs.getInt(4));
			conteiner.setStatus_conteiner(rs.getString(5));
			conteiner.setCategoria_conteiner(rs.getString(6));
		}
		rs.close();
		ps.close();
		conn.close();
	} catch (Exception ex) {
		System.out.println("Erro ao listar um");
		System.out.println(ex.getMessage());
	}
} catch(Exception ex)
{
	System.out.println("Erro [conteiner_update]");
}

%>
<div class="container">
<h1>Editar registro - Conteiner</h1>
<form method="POST" action="./ConteinerServlet" id="app">
	<input type="hidden" name="update" value="<%= conteiner.getId_conteiner() %>"/>
	<div class="mb-2">
		<input type="text" class="form-control" 
		 disabled value="<%= conteiner.getCliente() %>">
		 
		 <input type="hidden" name="cliente" value="<%= conteiner.getCliente() %>">
	</div>
	<div class="mb-2">
		<input type="text" class="form-control"
		maxlength="11"
		 name="numero_conteiner" value="<%= conteiner.getNumero_conteiner() %>">
	 </div>
	<div class="mb-2">
		<select name="tipo_conteiner" class="form-select">
			<option value="<%= conteiner.getTipo_conteiner() %>" hidden selected><%= conteiner.getTipo_conteiner() %></option>
			<option>20</option>
			<option>40</option>
		</select>
	</div>
	<div class="mb-2">
		<select name="status_conteiner" class="form-select">
			<option value="<%= conteiner.getStatus_conteiner() %>" hidden selected><%= conteiner.getStatus_conteiner() %></option>
			<option>Cheio</option>
			<option>Vazio</option>
		</select>
	</div>
	<div class="mb-2">
		<select name="categoria_conteiner" class="form-select">
			<option value="<%= conteiner.getCategoria_conteiner() %>" hidden selected><%= conteiner.getCategoria_conteiner() %></option>
			<option>Importação</option>
			<option>Exportação</option>
		</select>
	</div>
	<div class="mb-2">
		<button type="submit" class="btn btn-primary">Alterar</button>
	</div>
</form>

</div>
<%@ include file="partials/footer.jsp"%>