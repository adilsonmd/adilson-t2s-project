package br.com.t2s;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.google.gson.Gson;

import br.com.t2s.models.Conteiner;
import br.com.t2s.models.ConteinerDAO;
import br.com.t2s.models.Movimentacao;
import br.com.t2s.models.MovimentacaoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MovimentacaoServlet
 */
@WebServlet("/MovimentacaoServlet")
public class MovimentacaoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public MovimentacaoServlet() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if(request.getParameter("delete") != null && request.getParameter("delete").isBlank() == false)
		{
			doDelete(request, response);
			return;
		}
		
		PrintWriter out = response.getWriter();
	
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
		List<Movimentacao> movimentacaoList;
		
		try {
			int idConteiner = Integer.parseInt(request.getParameter("id_conteiner"));
			
			movimentacaoList = MovimentacaoDAO.listAll(idConteiner);
			
			// https://search.maven.org/artifact/com.google.code.gson/gson/2.8.6/jar
			// https://sites.google.com/site/gson/gson-user-guide
			Gson gson = new Gson();
			String jsonObject = gson.toJson(movimentacaoList);	
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
		
		if(request.getParameter("update") != null && request.getParameter("update").isBlank() == false) {
			doPut(request, response);
			return;
		}
		
		PrintWriter out = response.getWriter();
		
		int idConteiner = Integer.parseInt(request.getParameter("id_conteiner"));
		String numeroConteiner = request.getParameter("numero_conteiner");
		String tipoMovimentacao = request.getParameter("tipo_movimentacao");
		String dataInicioStr = request.getParameter("data_inicio");
		String horaInicioStr = request.getParameter("hora_inicio");
		String dataFimStr = request.getParameter("data_fim");
		String horaFimStr = request.getParameter("hora_fim");
		
					
		Movimentacao movimentacao = new Movimentacao();
		try {
			movimentacao.setTipo_movimentacao(tipoMovimentacao);
			movimentacao.setDataInicio(dataInicioStr + " " + horaInicioStr+":00");
			movimentacao.setDataFim(dataFimStr + " " + horaFimStr+":00");
			movimentacao.setId_conteiner(idConteiner);
			movimentacao.setNumero_conteiner(numeroConteiner);
			
		} catch(Exception ex)
		{
			out.println("Erro de conversão");
		}
		
		try {
			int status = MovimentacaoDAO.insert(movimentacao);
			
			if(status>0)
			{
				out.print("Sucesso");
				response.sendRedirect(request.getContextPath() +
						"/movimentacao.jsp?id_conteiner=" + idConteiner + "&numero_conteiner=" + numeroConteiner);
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
		int idConteiner = 0;
		
		try {
			idDeletar = Integer.parseInt(request.getParameter("delete"));
			idConteiner = Integer.parseInt(request.getParameter("id_conteiner"));
		} catch(Exception ex)
		{
			System.out.println("Erro de conversão");
		}
		if(idDeletar > 0) {
			int status = MovimentacaoDAO.delete(idDeletar);
			
			if(status>0)
			{
				System.out.print("Sucesso");
				response.sendRedirect(request.getContextPath() + "/movimentacao.jsp?id_conteiner=" + idConteiner );
			}
			else {
				
				System.out.print("Erro [doDelete MovimentacaoServlet]");
			}
		}
	}

	@Override
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		int idUpdate = 0;
		Movimentacao movimentacao = new Movimentacao();
		
		try {
			int idConteiner = Integer.parseInt(request.getParameter("id_conteiner"));

			String dataInicioStr = request.getParameter("data_inicio");
			String horaInicioStr = request.getParameter("hora_inicio");
			String dataFimStr = request.getParameter("data_fim");
			String horaFimStr = request.getParameter("hora_fim");
			
			idUpdate = Integer.parseInt(request.getParameter("update"));
			
			movimentacao.setTipo_movimentacao(request.getParameter("tipo_movimentacao"));
			movimentacao.setDataInicio(dataInicioStr + " " + horaInicioStr + ":00");
			movimentacao.setDataFim(dataFimStr + " " + horaFimStr + ":00");
			movimentacao.setId_conteiner(idConteiner);
			movimentacao.setNumero_conteiner(request.getParameter("numero_conteiner"));
			
			System.out.println("Data inicio [MovimentacaoServlet]: " + movimentacao.getDataInicio());
			System.out.println("Data fim [MovimentacaoServlet]: " + movimentacao.getDataFim());
			
		} catch(Exception ex) {
			System.out.println("Erro de conversão");
		}
		
		if(idUpdate > 0) {
			int status = MovimentacaoDAO.update(idUpdate, movimentacao);
			
			if(status>0)
			{
				System.out.print("Sucesso");
				response.sendRedirect(request.getContextPath() + "/conteiner.jsp");
			}
			else {
				
				System.out.print("Erro [doPut MovimentacaoServlet]");
			}
		}
	}
}
