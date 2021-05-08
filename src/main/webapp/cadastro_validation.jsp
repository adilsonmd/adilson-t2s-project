<%@page import="java.sql.*"%>
<%@page import="java.security.NoSuchAlgorithmException"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="javax.crypto.SecretKeyFactory"%>
<%@page import="javax.crypto.spec.PBEKeySpec"%>
<%@page import="java.security.spec.KeySpec"%>
<%@page import="java.security.SecureRandom"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%
	String nome = request.getParameter("nome");
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	
	// GERANDO SENHA HASH
	
	//https://www.baeldung.com/java-password-hashing
	//https://howtodoinjava.com/java/java-security/how-to-generate-secure-password-hash-md5-sha-pbkdf2-bcrypt-examples/
	
	// Salt
	SecureRandom random = new SecureRandom();
	byte[] salt = new byte[16];
	random.nextBytes(salt);
	StringBuilder sb = new StringBuilder();
    for(int i=0; i< salt.length ;i++)
    {
        sb.append(Integer.toString((salt[i] & 0xff) + 0x100, 16).substring(1));
    }
	String generatedSalt = sb.toString();
	
// 	KeySpec spec = new PBEKeySpec(password.toCharArray(), salt, 65536, 128);
// 	SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
	
// 	byte[] hash = factory.generateSecret(spec).getEncoded();
	
	 String generatedPassword = null;
     try {
         MessageDigest md = MessageDigest.getInstance("SHA-256");
         md.update(salt);
         byte[] bytes = md.digest(password.getBytes());
         sb = new StringBuilder();
         for(int i=0; i< bytes.length ;i++)
         {
             sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
         }
         generatedPassword = sb.toString();
     } 
    catch (NoSuchAlgorithmException e) 
    {
        e.printStackTrace();
    }
    String url = "jdbc:postgresql://localhost:5432/t2s";
 	String dbUsername = "postgres";
 	String dbPassword = "ad123";
 	
 	try {
 	
	    Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
	     
	    PreparedStatement st = con.prepareStatement("INSERT INTO tb_cliente (email_cliente, nome_cliente, senha, senha_salt) VALUES (?, ?, ?, ?)");
	    st.setString(1, email);
	    st.setString(2, nome);
	    st.setString(3, generatedPassword);
	    st.setString(4, generatedSalt);
	    
	    boolean done = st.execute();
	    
	 	if(done) {
	 		System.out.println(done);
	 	}
	 	else {
	 		System.out.println("ERRO AO SALVAR");
	 	}
 	} catch (SQLException ex) {
 		ex.printStackTrace();
 	}
	System.out.println("Nome: " + nome);
	System.out.println("Email: " + email);
	System.out.println("Password: " +password);
	System.out.println("Hash: " + generatedPassword);
	System.out.println("Salt: " + generatedSalt);
	
%>
