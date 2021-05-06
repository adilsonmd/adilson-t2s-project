<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String url = "jdbc:postgresql://localhost:5432//t2s";
String username="postgres";
String password="ad123";


try {
	Connection conn = DriverManager.getConnection(url, username, password);
	String sql = "SELECT * FROM tb_conteiner MAX 100;";
	
	Statement st = conn.createStatement(); 
	ResultSet rs = st.executeQuery(sql); 
	while(rs.next())
	{
		out.println("Banco rodando");
		out.println(rs.getString(1));
	}
	rs.close();
	st.close();
	
} catch(SQLException ex)
{
	out.println(ex.getMessage());
}
%>