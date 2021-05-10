<%@page import="java.security.NoSuchAlgorithmException"%>
<%@page import="java.security.MessageDigest"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="java.sql.*" %>
<%@ include file="partials/header.jsp" %>
<p>Carregando...</p>
<%

	String email = request.getParameter("email");
	String password = request.getParameter("password");
	String nome_cliente = "";
	
	String generatedPassword = null;
	try {
	   MessageDigest md = MessageDigest.getInstance("SHA2");
	   md.update(password.getBytes());
	   
	   byte[] resultByteArray = md.digest();
	   
	   StringBuilder sb = new StringBuilder();
	   for (byte b : resultByteArray)
	   {
	  	 sb.append(String.format("%02x", b));
	   }
	   generatedPassword = sb.toString();
	} 
	catch (NoSuchAlgorithmException e) 
	{
	   e.printStackTrace();
	}
	
	// comparar com a senha do banco
	try{
	
		String url = "jdbc:postgresql://172.31.56.85:5432/t2s";
 		String dbUsername = "postgres";
 		String dbPassword = "ad123";
 		
 		Connection conn = DriverManager.getConnection(url, dbUsername, dbPassword);
		String sql = "SELECT email_cliente, nome_cliente FROM tb_cliente WHERE email_cliente = ? AND senha = ?";
		
		PreparedStatement st = conn.prepareStatement(sql);
		st.setString(1, email);
		st.setString(2, generatedPassword);
		
		ResultSet rs = st.executeQuery();
		while(rs.next())
		{
			out.println(rs.getString("email_cliente"));
			out.println(rs.getString("nome_cliente"));
			nome_cliente = rs.getString("nome_cliente");
		}
		
		rs.close();
		st.close();
		conn.close();
	} catch (SQLException ex) {
		ex.printStackTrace();
	}
	
	session.setAttribute("user-logged-in", "true");
	session.setAttribute("username", nome_cliente);
	
	response.sendRedirect("./dashboard.jsp");
%>
<%@ include file="partials/footer.jsp" %>
