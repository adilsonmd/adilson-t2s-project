<%@page import="java.sql.*"%>
<%@page import="java.security.NoSuchAlgorithmException"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="javax.crypto.SecretKeyFactory"%>
<%@page import="javax.crypto.spec.PBEKeySpec"%>
<%@page import="java.security.spec.KeySpec"%>
<%@page import="java.security.SecureRandom"%>

<%@page import="br.com.t2s.BaseConnection"%>
<%@page import="br.com.t2s.AppSecrets"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%
	String nome = request.getParameter("nome");
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	
	// GERANDO SENHA HASH
	
	//https://www.baeldung.com/java-password-hashing
	//https://howtodoinjava.com/java/java-security/how-to-generate-secure-password-hash-md5-sha-pbkdf2-bcrypt-examples/
	
	// METODO DE HASH facil
	// https://www.youtube.com/watch?v=qSTZVlo2lr0
	
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
   
 	try {
 		BaseConnection baseCon = new BaseConnection();
 		Connection conn = baseCon.createConnection();
	     
	    PreparedStatement st = conn.prepareStatement("INSERT INTO tb_cliente (email_cliente, nome_cliente, senha) VALUES (?, ?, ?)");
	    st.setString(1, email);
	    st.setString(2, nome);
	    st.setString(3, generatedPassword);
	    
	    boolean done = st.execute();
	    
	 	if(done) {
	 		System.out.println(done);
	 	}
	 	else {
	 		System.out.println("ERRO AO SALVAR");
	 	}
	 	st.close();
	 	conn.close();
 	} catch (SQLException ex) {
 		ex.printStackTrace();
 	}
	System.out.println("Nome: " + nome);
	System.out.println("Email: " + email);
	System.out.println("Password: " +password);
	System.out.println("Hash: " + generatedPassword);
	
	response.sendRedirect("./login.jsp");
	
%>
