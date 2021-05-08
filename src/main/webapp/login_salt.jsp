<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
String sql = "SELECT * FROM tb_cliente WHERE email_cliente = 'adilson@gmailcom'";
String url = "jdbc:postgresql://localhost:5432/t2s";
String dbUsername = "postgres";
String dbPassword = "ad123";

Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
Statement st = con.createStatement();
ResultSet rs = st.executeQuery(sql);

String email = "";
String nome = "";
String senha = "";
String salt  = "";

while(rs.next())
{
	email = rs.getString(1);
	nome = rs.getString(2);
	senha = rs.getString(3);
	salt = rs.getString(4);
}



%>