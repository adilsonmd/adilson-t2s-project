<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="javax.swing.text.DateFormatter"%>
<%@page import="br.com.t2s.models.Movimentacao"%>
<%@page import="java.sql.PreparedStatement"%>
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
Movimentacao movimentacao = new Movimentacao();

try{	
	idUpdate = Integer.parseInt(request.getParameter("update"));
	
	
	Connection conn;
	try {
		
		String url = "jdbc:postgresql://172.31.56.85:5432/t2s";
		String dbUsername = "postgres";
		String dbPassword = "ad123";
		
 		conn = DriverManager.getConnection(url, dbUsername, dbPassword);
 		
 		String SQL = "SELECT id_movimentacao, tipo_movimentacao, data_inicio, data_fim,\r\n"
				+ "id_conteiner,\r\n"
				+ "(SELECT numero_conteiner FROM tb_conteiner \r\n"
				+ " WHERE tb_movimentacao.id_conteiner = tb_conteiner.id_conteiner)\r\n"
				+ "AS numero_conteiner\r\n"
				+ "FROM tb_movimentacao\r\n"
				+ "WHERE id_movimentacao=?";
 		
		PreparedStatement ps = conn.prepareStatement(SQL);
		ps.setInt(1, idUpdate);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next())
		{
			movimentacao.setId(rs.getInt(1));
			movimentacao.setTipo_movimentacao(rs.getString(2));
			movimentacao.setDataInicio(rs.getString(3));
			movimentacao.setDataFim(rs.getString(4));
			movimentacao.setId_conteiner(rs.getInt(5));
			movimentacao.setNumero_conteiner(rs.getString(6));
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
<h1>Editar registro - Movimentação</h1>
<form method="POST" action="./MovimentacaoServlet" id="app">
	<input type="hidden" name="update" value="<%= movimentacao.getId() %>"/>
	<div class="mb-2">
		<input type="text" class="form-control" 
		 disabled value="<%= movimentacao.getNumero_conteiner() %>">
		 
		 <input type="hidden" name="id_conteiner" value="<%= movimentacao.getId_conteiner() %>">
	</div>
	<div class="mb-2">
		<select name="tipo_movimentacao" class="form-select">
			<option value="<%= movimentacao.getTipo_movimentacao() %>" hidden selected><%= movimentacao.getTipo_movimentacao() %></option>
			<option>Embarque</option>
			<option>Descarga</option>
			<option>Gate In</option>
			<option>Gate out</option>
			<option>Posicionamento Pilha</option>
			<option>Pesagem</option>
			<option>Scanner</option>
		</select>
	</div>
	<div class="col-3">
	<% 
	String dataI = movimentacao.getDataInicio().substring(0, movimentacao.getDataInicio().indexOf(" "));
	String horaI = movimentacao.getDataInicio().substring(movimentacao.getDataInicio().indexOf(" ")+1,
															movimentacao.getDataInicio().length()-6);
	String dataF = movimentacao.getDataFim().substring(0, movimentacao.getDataFim().indexOf(" "));
	String horaF = movimentacao.getDataFim().substring(movimentacao.getDataFim().indexOf(" ")+1,
			movimentacao.getDataFim().length()-6);

	System.out.println("dataI: " + dataI);
	System.out.println("horaI: " + horaI);
	System.out.println("dataF: " + dataF);
	System.out.println("horaI: " + horaI);
	
	%>
		<input type="date" name="data_inicio" value="<%= dataI %>" required class="form-control" />
		<input type="time" name="hora_inicio" value="<%= horaI %>" required class="form-control" />
	</div>
	<div class="col-3">
		<input type="date" name="data_fim" value="<%= dataF %>" required class="form-control" />
		<input type="time" name="hora_fim" value="<%= horaF %>" required class="form-control" />
	</div>
	<div class="mb-2">
		<a href="./conteiner.jsp" class="btn">Voltar</a> 
		
		<button type="submit" class="btn btn-primary">Alterar</button>
	</div>
</form>

</div>
<%@ include file="partials/footer.jsp"%>