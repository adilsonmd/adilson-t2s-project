package br.com.t2s;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.google.gson.Gson;

import br.com.t2s.models.Conteiner;
import br.com.t2s.models.ConteinerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ConteinerServlet
 */
@WebServlet("/ConteinerServlet")
public class ConteinerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public ConteinerServlet() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		// https://www.baeldung.com/servlet-json-response
		
		if(request.getParameter("delete") != null && request.getParameter("delete").isBlank() == false)
		{
			doDelete(request, response);
			return;
		}
		
		PrintWriter out = response.getWriter();
	
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
		List<Conteiner> conteinerList;
		
		try {
			conteinerList = ConteinerDAO.listAll(request.getSession().getAttribute("username").toString());
			
			// https://search.maven.org/artifact/com.google.code.gson/gson/2.8.6/jar
			// https://sites.google.com/site/gson/gson-user-guide
			Gson gson = new Gson();
			String jsonObject = gson.toJson(conteinerList);	
			out.print(jsonObject);			
		} catch(Exception ex)
		{
			System.out.println(ex.getMessage());
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		
		String cliente = request.getParameter("cliente");
		String numeroConteiner = request.getParameter("numero_conteiner");
		String tipoConteiner = request.getParameter("tipo_conteiner");
		String statusConteiner = request.getParameter("status_conteiner");
		String categoriaConteiner = request.getParameter("categoria_conteiner");
					
		Conteiner conteiner = new Conteiner();
		try {
			conteiner.setCliente(cliente);
			conteiner.setNumero_conteiner(numeroConteiner);
			conteiner.setTipo_conteiner(Integer.parseInt(tipoConteiner));
			conteiner.setStatus_conteiner(statusConteiner);
			conteiner.setCategoria_conteiner(categoriaConteiner);
			
		} catch(Exception ex)
		{
			out.println("Erro de conversão");
		}
		
		try {
			int status = ConteinerDAO.insert(conteiner);
			
			if(status>0)
			{
				out.print("Sucesso");
				response.sendRedirect(request.getContextPath() + "/conteiner.jsp");
			}
			else {
				
				out.print("Erro");
			}
			
		} catch(Exception ex)
		{
			out.print("{\"message\":\"" + ex.getMessage() + "\"}");
		}
	}

	
	@Override
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int idDeletar = 0;
		
		try {
			idDeletar = Integer.parseInt(request.getParameter("delete"));
		} catch(Exception ex)
		{
			System.out.println("Erro de conversão");
		}
		if(idDeletar > 0) {
			int status = ConteinerDAO.delete(idDeletar);
			
			if(status>0)
			{
				System.out.print("Sucesso");
				response.sendRedirect(request.getContextPath() + "/conteiner.jsp");
			}
			else {
				
				System.out.print("Erro");
			}
		}
	}

	
}
