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
				
		<v-data-table :headers="tb_headers" :items="movimentacoes" :items-per-page="5"
			class="elevation-1">
				
			<template v-slot:[`item.actions`]="{ item }">
			<div class="row">
			<div class="col">
				<form action="./movimentacao_update.jsp" method="PUT" :id="'editForm'+item.id">
					<input type="hidden" name="update" :value="item.id">
		            <button type="submit"><v-icon>mdi-pencil</v-icon></button>
				</form>
				</div>
				<div class="col">
				<form action="./MovimentacaoServlet" method="DELETE" :id="'deleteForm'+item.id">
					<input type="hidden" name="delete" :value="item.id">
		            <button type="submit"><v-icon>mdi-delete</v-icon></button>
				</form>
				</div>
				</div>
	          </template>
		</v-data-table>
		
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
		    movimentacoes: [],
		    tb_headers: [
		    	{text:'ID', value: 'id', sortable: true},
		    	{text:'Num. Contêiner', value: 'numero_conteiner', sortable: true},
		    	{text: 'Tipo de movimentação', value: 'tipo_movimentacao', sortable: true},
		    	{text: 'Data início', value: 'dataInicio', sortable: true},
		    	{text: 'Data Fim', value: 'dataFim', sortable: true},
		    	{text: 'Ações', value: 'actions', sortable: false}
		    ],
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
