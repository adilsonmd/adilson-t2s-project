<!--  https://br.vuejs.org/v2/examples/commits.html  -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="partials/header.jsp"%>
<div class="container">
	<div id="demo">
		<h1>Commits</h1>
		<table class="table">
		<thead>
			<th>SHA</th>
			<th>Mensagem</th>
			<th>Autor</th>
			<th>Data</th>
		</thead>
		<tbody>
			<tr v-for="record in commits">
				<td>
					<a :href="record.html_url" target="_blank" class="commit">{{ record.sha.slice(0, 7) }}</a>
				</td>
				
				<td>
					<span class="message">{{ record.commit.message | truncate }}</span>
				</td>
				
				<td>
					<span class="author">
					<a :href="record.author.html_url" target="_blank"
			              >{{ record.commit.author.name }}</a></span>
		        </td>
				<td>
					<span class="date">{{ record.commit.author.date | formatDate }}</span>
				</td>
			</tr>
		</tbody>
		</table>
	</div>
</div>
    <script>
      var apiURL =
        //"https://api.github.com/repos/vuejs/vue/commits?per_page=3&sha=";
      "https://api.github.com/repos/adilsonmd/adilson-t2s-project/commits"

      /**
       * Actual demo
       */

      var demo = new Vue({
        el: "#demo",

        data: {
          branches: ["master"],
          currentBranch: "master",
          commits: null
        },

        created: function() {
          this.fetchData();
        },

        watch: {
          currentBranch: "fetchData"
        },

        filters: {
          truncate: function(v) {
            var newline = v.indexOf("\n");
            return newline > 0 ? v.slice(0, newline) : v;
          },
          formatDate: function(v) {
            return v.replace(/T|Z/g, " ");
          }
        },

        methods: {
          fetchData: function() {
            var xhr = new XMLHttpRequest();
            var self = this;
            xhr.open("GET", apiURL);
            xhr.onload = function() {
              self.commits = JSON.parse(xhr.responseText);
              console.log(self.commits[0].html_url);
            };
            xhr.send();
          }
        }
      });
    </script>
</div>
<%@ include file="partials/footer.jsp"%>