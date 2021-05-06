

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ConnectionServlet
 */
@WebServlet("/ConnectionServlet")
public class ConnectionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public ConnectionServlet() {
        // TODO Auto-generated constructor stub
    }


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		// CONFIGURA PARA EXIBIR UMA PÁGINA WEB
		response.setContentType("text/html");
	    PrintWriter out = response.getWriter();
	    String docType =
	            "<!doctype html>";
	    out.println(docType +
	            "<html>\n" +
	            "<head><title>Brabo</title></head>\n" +
	            "<body bgcolor = \"#f0f0f0\">\n" +
	            "<h1 align = \"center\">Teste BD</h1>\n"
	            + "<h2>tb_conteiner</h2>");

	    Connection conn = null;
		try {
			// Class com informaçoes de acesso ao banco
			AppSecrets secret = new AppSecrets();

			conn = DriverManager.getConnection(
					secret.getUrl(),
					secret.getDbUsername(),
					secret.getDbPassword());
			
			String sql = "SELECT * FROM tb_conteiner;";
			
			Statement st = conn.createStatement(); 
			ResultSet rs = st.executeQuery(sql); 
			while(rs.next())
			{
				out.println(rs.getInt("id_conteiner"));
				out.println(rs.getString("cliente"));
				out.println(rs.getString("numero_conteiner"));
				out.println(rs.getInt("tipo_conteiner"));
				out.println(rs.getString("status_conteiner"));
				out.println(rs.getString("categoria_conteiner"));
				out.println("<br>\n");
			}
			rs.close();
			st.close();
			
			out.println("<h2>tb_movimentacao</h2>\n");
		} 
		catch(SQLException ex) {
			ex.printStackTrace(out);	
		}
		
		
		
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
}
