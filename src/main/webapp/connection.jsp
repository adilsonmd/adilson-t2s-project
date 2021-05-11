<!-- https://stackoverflow.com/questions/15839335/using-for-loop-inside-of-a-jsp  -->

<%@page import="java.io.PrintWriter"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ include file="partials/header.jsp" %>

<div class="container">
	<div id="app">
		<table class="table">
		<thead>
			<tr>
				<th scope="col">ID</th>
				<th scope="col">Cliente</th>
				<th scope="col">Num. Contêiner</th>
				<th scope="col">Tipo</th>
				<th scope="col">Status</th>
				<th scope="col">Categoria</th>
			</tr>
		</thead>
		<tbody>
			<tr v-for="conteiner in conteiners" :key="conteiner.id_conteiner">
				<td>{{ conteiner.id_conteiner }}</td>
				<td>{{ conteiner.cliente }}</td>
				<td>{{ conteiner.numero_conteiner }}</td>
				<td>{{ conteiner.tipo_conteiner }}</td>
				<td>{{ conteiner.status_conteiner }}</td>
				<td>{{ conteiner.categoria_conteiner }}</td>
			</tr>
		</tbody>
		</table>
	</div>
</div> <!-- END div.container -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<script>
var app = new Vue({
	el: '#app',
	data () {
	    return {
	      conteiners: null
	    }
	  },
	mounted(){
		axios
		.get('http://localhost:8080/adilson-t2s-project/ConteinerServlet')
		.then(response => this.conteiners = response.data);
	}
});
</script>

<%@ include file="partials/footer.jsp" %>