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

<div class="container">
	<div id="app">
		<h1>Contêineres</h1>
		<form class="inline" action="./ConteinerServlet" method="POST">
			<div class="row">
				<div class="col-3">
					<select name="cliente" v-model="cliente" class="form-select">
						<option value="null" selected disabled>Usuário</option>
						<option value="<%= session.getAttribute("username") %>">
							<%= session.getAttribute("username") %>
						</option>
					</select>
				</div>
				<div class="col-3">
					<input type="text" class="form-control" placeholder="Num. Conteiner"
					name="numero_conteiner" v-model="numero_conteiner" 
					maxlength="11" required/>
				</div>
				<div class="col">
					<select class="form-select" 
					name="tipo_conteiner" v-model.number="tipo_conteiner" required>
						<option value="null" selected disabled>Tipo</option>
						<option>20</option>
						<option>40</option>
					</select>
				</div>
				<div class="col">
					<select class="form-select" 
					name="status_conteiner" v-model="status_conteiner" required>
						<option value="null" selected disabled>Status</option>
						<option value="CHEIO">Cheio</option>
						<option value="VAZIO">Vazio</option>
					</select>
				</div>
				<div class="col-2">
					<select class="form-select" 
					name="categoria_conteiner" v-model="categoria_conteiner" required>
						<option value="null" selected disabled>Categoria</option>
						<option value="IMPORTACAO">Importação</option>
						<option value="EXPORTACAO">Exportação</option>
					</select>
				</div>
				<div class="col">
					<button type="submit" class="btn btn-secondary" id="btn_insert_conteiner">+</button>
				</div>
			</div>
		</form>
		
		<table class="table mt-1">
		<thead>
			<tr>
				<th scope="col">ID</th>
				<th scope="col">Cliente</th>
				<th scope="col">Num. Contêiner</th>
				<th scope="col">Tipo</th>
				<th scope="col">Status</th>
				<th scope="col">Categoria</th>
				<th scope="col">Ações</th>
			</tr>
		</thead>
		<tbody>
			<tr v-for="conteiner, index in conteiners" :key="conteiner.id_conteiner">
				<td>{{ conteiner.id_conteiner }}</td>
				<td>{{ conteiner.cliente }}</td>
				<td>{{ conteiner.numero_conteiner }}</td>
				<td>{{ conteiner.tipo_conteiner }}</td>
				<td>{{ conteiner.status_conteiner }}</td>
				<td>{{ conteiner.categoria_conteiner }}</td>
				<td>
				<div class="row">
					<div class="col">
						<form method="GET" action="./conteiner_update.jsp">
							<input type="hidden" name="update" :value="conteiner.id_conteiner"/>
							<button class="btn btn-secondary" :id="'btnUpdate' + conteiner.id_conteiner">*</button>
						</form>
					</div>
					<div class="col">
						<form method="DELETE" action="./ConteinerServlet"> 
							<input type="hidden" name="delete" :value="conteiner.id_conteiner"/>
							<button class="btn btn-secondary" :id="'btnDelete' + conteiner.id_conteiner">-</button>
						</form>
					</div>
				</div>
				</td>
			</tr>
		</tbody>
		</table>
		
	<div>
		<p v-if="error == true">Erro ao conectar</p>
	</div>
</div> <!--  END div.app  -->
</div> <!-- END div.container -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<script>
var app = new Vue({
	el: '#app',
	data() {
	   return {
	    error: false,
	    conteiners: null,
    	cliente: null,
    	numero_conteiner: null,
    	tipo_conteiner: null,
    	status_conteiner: null,
    	categoria_conteiner: null 
    	}
	},
	mounted(){
		axios
		.get('./ConteinerServlet')
		.then(response => this.conteiners = response.data)
		.catch(function(error){
			console.error(error);	
		});
	}
});
</script>

<%@ include file="partials/footer.jsp" %>
