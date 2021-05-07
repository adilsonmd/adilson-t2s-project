<%@page import="java.io.PrintWriter"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UFT-8" pageEncoding="ISO-8859-1"%>

<%@ include file="partials/header.jsp" %>
<div class="container">
<%
	out.println("<h2>tb_conteiner</h2>");
	//AppSecrets secrets = new AppSecrets();
	// URL para o IP publico

	String url = "jdbc:postgresql://100.24.74.6:5432/t2s";
	
	// URL para o IP privado
	//String url = "jdbc:postgresql://172.31.56.85:5432/t2s";
	//String url = "jdbc:postgresql://localhost:5432/t2s";
	String dbUsername = "postgres";
	String dbPassword = "ad123";

	try{
	Connection conn = DriverManager.getConnection(
			url,
			dbUsername,
			dbPassword);
	
	String sql = "SELECT * FROM tb_conteiner;";
	
	Statement st = conn.createStatement(); 
	ResultSet rs = st.executeQuery(sql); 
	out.println("id_conteiner | ");
	out.println("cliente | ");
	out.println("numero_conteiner | ");
	out.println("tipo_conteiner | ");
	out.println("status_conteiner | ");
	out.println("categoria_conteiner");
	out.println("<br>");
	
	while(rs.next())
	{
		out.println(rs.getInt("id_conteiner"));
		out.println(rs.getString("cliente"));
		out.println(rs.getString("numero_conteiner"));
		out.println(rs.getInt("tipo_conteiner"));
		out.println(rs.getString("status_conteiner"));
		out.println(rs.getString("categoria_conteiner"));
		out.println("<br>\n");
	}
	
	// ====== TABELA MOVIMENTACAO ===========
	out.println("<h2>tb_movimentacao</h2>\n");
	// outra table 
	sql = "SELECT "+
			"id_movimentacao, "+
			"(SELECT desc_tipo_movimentacao "+
			  "FROM tb_tipo_movimentacao "+
			  "WHERE tb_movimentacao.tipo_movimentacao_id = tb_tipo_movimentacao.id_tipo_movimentacao"+
			") AS tipo_movimentacao, "+
			"data_inicio, "+
			"data_fim "+
			"FROM tb_movimentacao;";
	//out.println(sql);
	
	out.println("id_movimentacao | ");
	out.println("tipo_movimentacao | ");
	out.println("data_inicio | ");
	out.println("data_fim");
	out.println("<br>");
	
	
	st = conn.createStatement(); 
	rs = st.executeQuery(sql); 
	
	while(rs.next())
	{
		out.println(rs.getInt("id_movimentacao"));
		out.println(rs.getString("tipo_movimentacao"));
		out.println(rs.getDate("data_inicio"));
		out.println(rs.getDate("data_fim"));
		out.println("<br>\n");
	}
	
	rs.close();
	st.close();
	
	conn.close();
} 
catch(SQLException ex) {
	out.println(ex.getMessage());
}

%>
</div> <!-- END div.container -->
