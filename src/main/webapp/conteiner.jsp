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
					<select name="cliente" v-model="cliente" class="form-select" required>
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
		
		<v-data-table :headers="tb_headers" :items="conteiners" :items-per-page="5"
			class="elevation-1">
			<template v-slot:[`item.numero_conteiner`]="{ item }">
				<a :href="'./movimentacao.jsp?id_conteiner=' + item.id_conteiner + '&numero_conteiner=' + item.numero_conteiner">
				{{ item.numero_conteiner }}
				</a>
			</template>
			
			<template v-slot:[`item.actions`]="{ item }">
			<div class="row">
			<div class="col">
				<form action="./conteiner_update.jsp" method="PUT" :id="'editForm'+item.id_conteiner">
					<input type="hidden" name="update" :value="item.id_conteiner">
		            <button type="submit"><v-icon>mdi-pencil</v-icon></button>
				</form>
				</div>
				<div class="col">
				<form action="./ConteinerServlet" method="DELETE" :id="'deleteForm'+item.id_conteiner">
					<input type="hidden" name="delete" :value="item.id_conteiner">
		            <button type="submit"><v-icon>mdi-delete</v-icon></button>
				</form>
				</div>
				</div>
	          </template>
		</v-data-table>
	<div>
		<p v-if="error == true">Erro ao conectar</p>
	</div>
</div> <!--  END div.app  -->
</div> <!-- END div.container -->
<script src="https://cdn.jsdelivr.net/npm/vue@2/dist/vue.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vuetify@2.x/dist/vuetify.js"></script>
  
<script>
var app = new Vue({
	el: '#app',
	vuetify: new Vuetify(),
	
	data() {
	   return {
	    conteiners: [],
	    tb_headers: [
	    	{text: 'ID', value: 'id_conteiner', sortable: true},
	    	{text: 'Cliente', value: 'cliente', sortable: true},
	    	{text: 'Num. Contêiner', value: 'numero_conteiner', sortable: true},
	    	{text: 'Tipo', value: 'tipo_conteiner', sortable: true},
	    	{text: 'Status', value: 'status_conteiner', sortable: true},
	    	{text: 'Categoria', value: 'categoria_conteiner', sortable: true},
	    	{text: 'Ações', value: 'actions', sortable: false}
	    ],
	    
	    error: false,
    	cliente: null,
    	numero_conteiner: null,
    	tipo_conteiner: null,
    	status_conteiner: null,
    	categoria_conteiner: null 
    	}
	},
	methods: {
		deleteConteiner: function(id)
		{
			if(confirm("Você deseja deletar esse registro?"))
			{
				console.log("deletando: " + id)
			
			}
			else {
				console.log("cancelado: " + id)		
			}
		},
		
		editConteiner: function(id)
		{
			console.log("editando: " + id)
		}
	},
	mounted(){
		axios
		.get('<%= request.getContextPath() %>/ConteinerServlet')
		.then(response => this.conteiners = response.data)
		.catch(function(error){
			console.error(error);	
		});
	}
});
</script>

<%@ include file="partials/footer.jsp" %>
