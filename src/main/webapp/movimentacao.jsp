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

int idConteiner = Integer.parseInt(request.getParameter("id_conteiner"));
String numeroConteiner = request.getParameter("numero_conteiner");
%>

<div class="container">
	<div id="app">
		<h1>Movimentações</h1>
		<form class="inline" action="./MovimentacaoServlet" method="POST">
			<div class="row">
			<input type="hidden" name="id_conteiner" value="<%= idConteiner %>"/>
				<div class="col-2">
					<select name="numero_conteiner" required class="form-select">
						<option selected hidden>Num. Contêiner</option>
						<option value="<%= numeroConteiner %>">
							<%= numeroConteiner %>
						</option>
					</select>
				</div>
				<div class="col-3">
					<select class="form-select" 
					name="tipo_movimentacao" required>
						<option value="" selected disabled>Tipo</option>
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
					<input type="date" name="data_inicio" required class="form-control" />
					<input type="time" name="hora_inicio" required class="form-control" />
				</div>
				<div class="col-3">
					<input type="date" name="data_fim" required class="form-control" />
					<input type="time" name="hora_fim" required class="form-control" />
				</div>
				<div class="col">
					<button type="submit" class="btn btn-secondary" id="btn_insert_movimentacao">+</button>
				</div>
			</div>
		</form>
		
		<table class="table mt-1">
		<thead>
			<tr>
				<th scope="col">ID</th>
				<th scope="col">Num. Contêiner</th>
				<th scope="col">Tipo de Movimentação</th>
				<th scope="col">Data Início</th>
				<th scope="col">Data Fim</th>
				<th scope="col">Ações</th>
			</tr>
		</thead>
		<tbody>
			<tr v-for="movimentacao, index in movimentacoes" :key="movimentacao.id">
				<td>{{ movimentacao.id }}</td>
				<td>{{ movimentacao.numero_conteiner }}</td>
				<td>{{ movimentacao.tipo_movimentacao }}</td>
				<td>{{ movimentacao.dataInicio }}</td>
				<td>{{ movimentacao.dataFim }}</td>
				<td>
				<div class="row">
					<div class="col">
						<form method="GET" action="./movimentacao_update.jsp">
							<input type="hidden" name="update" :value="movimentacao.id"/>
							<button class="btn btn-secondary" :id="'btnUpdate' + movimentacao.id_movimentacao">*</button>
						</form>
					</div>
					<div class="col">
						<form method="DELETE" action="./MovimentacaoServlet"> 
							<input type="hidden" name="delete" :value="movimentacao.id"/>
							<input type="hidden" name="id_conteiner" value="<%= idConteiner %>">
							<button class="btn btn-secondary" :id="'btnDelete' + movimentacao.id_movimentacao">-</button>
						</form>
					</div>
				</div>
				</td>
			</tr>
		</tbody>
		</table>
		
</div> <!--  END div.app  -->
</div> <!-- END div.container -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>
var app = new Vue({
	el: '#app',
	data() {
	   return {
		    movimentacoes: null,
			id_conteiner: null,
			numero_conteiner: null,
			tipo_movimentacao: null,
			data_inicio: null,
			hora_inicio: null,
			data_fim:null,
			hora_fim:null
    	}
	},
	mounted(){
		axios
		.get('<%= request.getContextPath() %>/MovimentacaoServlet?id_conteiner=<%= idConteiner %>')
		.then(response => this.movimentacoes = response.data)
		.catch(function(error){
			console.error(error);	
		});
	}
});
</script>

<%@ include file="partials/footer.jsp" %>
