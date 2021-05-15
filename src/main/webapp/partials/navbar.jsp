<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="./index.jsp">T2S</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" 
            data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" 
            aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
      	<% if(session.getAttribute("user-logged-in") == "true") { %>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="./dashboard.jsp">Home</a>
        </li>
        <% } else { %>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="./index.jsp">Home</a>
        </li>
        <% } %>
        <li class="nav-item">
          <a class="nav-link" href="./sobre.jsp">Sobre</a>
        </li>
        <% if(session.getAttribute("user-logged-in") == "true") { %>
          <li class="nav-item">
            <a class="nav-link disabled text-light">Olá, <%= session.getAttribute("username") %></a>
          </li>
          
          <li class="nav-item">
          	<a class="nav-link" href="./logout.jsp">Sair</a>
       	  </li>
        <% } else { %>
	        <li class="nav-item">
	          <a class="nav-link" href="./login.jsp">Login</a>
	        </li>
        <% } %>
        </div>
      </ul>
  </div>
</nav>