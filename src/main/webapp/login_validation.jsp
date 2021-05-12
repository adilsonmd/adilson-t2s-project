<%@page import="jakarta.websocket.SendHandler"%>
<%@page import="java.security.NoSuchAlgorithmException"%>
<%@page import="java.security.MessageDigest"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="java.sql.*" %>
<%@ include file="partials/header.jsp" %>

<p>Carregando...</p>
<%
	boolean loggedIn = false;
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	
	String generatedPassword = null;
	try {
	   MessageDigest md = MessageDigest.getInstance("SHA");
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
		
		//String url = "jdbc:postgresql://100.24.74.6:5432/t2s";
		
		// URL para o IP privado
		//String url = "jdbc:postgresql://172.31.56.85:5432/t2s";
		String url = "jdbc:postgresql://localhost:5432/t2s";
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
			if(rs.getString("email_cliente") != null){
				loggedIn = true;
				System.out.println(rs.getString(1));
				System.out.println(rs.getString(2));
				System.out.println(password);
				System.out.println(generatedPassword);
			}
		}
		
		if(loggedIn == true){
			session.setAttribute("user-logged-in", "true");
			session.setAttribute("username", request.getParameter("email"));
			
			response.sendRedirect("./dashboard.jsp");		
		}
		else {
			response.sendRedirect("./login.jsp");
		}
		
		rs.close();
		st.close();
		conn.close();
	} catch (SQLException ex) { %>
	
	<a href="index.jsp">Tente novamente</a>
	
	<% 
		out.println(ex.getMessage());
		ex.printStackTrace();
	}
	
%>
<%@ include file="partials/footer.jsp" %>
