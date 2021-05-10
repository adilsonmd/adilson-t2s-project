<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="partials/header.jsp"%>

<% 
	if(session.getAttribute("user-logged-in") != "true") {
		response.sendRedirect("./error_page.jsp");	
	}

	String url = "jdbc:postgresql://172.31.56.85:5432/t2s";
	String dbUsername = "postgres";
	String dbPassword = "ad123";

	try{
		Connection conn = DriverManager.getConnection(url,
			dbUsername,
			dbPassword);
	
		String sql = "SELECT * FROM tb_conteiner LIMIT 100";
		
		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery(sql);
	%>
<div class="container">
<h1>Lista de Contêiner</h1>
<table class="table">
<thead>
	<tr>
		<th scope="col">ID</th>
		<th scope="col">Cliente</th>
		<th scope="col">Num. Contêiner</th>
		<th scope="col">Tipo</th>
		<th scope="col">Status</th>
		<th scope="col">Categoria</th>
	</tr>
</thead>
<tbody>
<% while(rs.next()) { %>
<tr>
	<td><% out.println(rs.getInt("id_conteiner")); %></td>
	<td><% out.println(rs.getString("cliente")); %></td>
	<td><% out.println(rs.getString("numero_conteiner")); %></td>
	<td><% out.println(rs.getInt("tipo_conteiner")); %></td>
	<td><% out.println(rs.getString("status_conteiner")); %></td>
	<td><% out.println(rs.getString("categoria_conteiner")); %></td>
</tr>
<% } // END WHILE
	rs.close();
	st.close();
	conn.close();
	} catch(SQLException ex)
	{
		ex.printStackTrace();
	}
%>
</tbody>
</table>
</div>
<%@ include file="partials/footer.jsp"%>
