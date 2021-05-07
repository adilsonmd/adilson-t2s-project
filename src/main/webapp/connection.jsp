<%@page import="java.io.PrintWriter"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
	out.println("<h2>tb_conteiner</h2>");
	//AppSecrets secrets = new AppSecrets();
	// URL para o IP publico
	//String url = "jdbc:postgresql://100.24.74.6:5432/t2s";
	
	// URL para o IP privado
	String url = "jdbc:postgresql://172.31.56.85:5432/t2s";
	
	String dbUsername = "postgres";
	String dbPassword = "ad123";

	try{
	Connection conn = DriverManager.getConnection(url,dbUsername,dbPassword);
	
	String sql = "SELECT * FROM tb_conteiner;";
	
	Statement st = conn.createStatement(); 
	ResultSet rs = st.executeQuery(sql); 
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
	rs.close();
	st.close();
	
	out.println("<h2>tb_movimentacao</h2>\n");
} 
catch(SQLException ex) {
	ex.printStackTrace();	
}

%>