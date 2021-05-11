package br.com.t2s.models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import br.com.t2s.BaseConnection;

public class ConteinerDAO {
	
	public static int insert(Conteiner conteiner)
	{
		int status = 0;
		
		try {
			Connection conn = BaseConnection.createConnection(); 
			String SQL = "INSERT INTO tb_conteiner(\r\n"
					+ "	id_conteiner, cliente, numero_conteiner, tipo_conteiner, status_conteiner, categoria_conteiner)\r\n"
					+ "	VALUES (?, ?, ?, ?, ?, ?);";
			
			PreparedStatement ps =  conn.prepareStatement(SQL);
			ps.setInt(1, conteiner.getId_conteiner());
			ps.setString(2, conteiner.getCliente());
			ps.setString(3, conteiner.getNumero_conteiner());
			ps.setInt(4, conteiner.getTipo_conteiner());
			ps.setString(5, conteiner.getStatus_conteiner());
			ps.setString(6, conteiner.getCategoria_conteiner());
			
			status = ps.executeUpdate();
			
			ps.close();
			conn.close();
			
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
		return status;
	}
	
	public static List<Conteiner> listAll()
	{
		List<Conteiner> all_conteiners = new ArrayList<Conteiner>();
		
		Connection conn;
		try {
			conn = BaseConnection.createConnection();
			String SQL = "SELECT \r\n"
					+ "	id_conteiner, cliente, numero_conteiner, tipo_conteiner, status_conteiner, categoria_conteiner\r\n"
					+ "	FROM tb_conteiner;";
			
			Statement st = conn.createStatement();
			ResultSet result = st.executeQuery(SQL);
			while(result.next()) {
				Conteiner conteinerTemp = new Conteiner();
				conteinerTemp.setId_conteiner(result.getInt("id_conteiner"));
				conteinerTemp.setCliente(result.getString("cliente"));
				conteinerTemp.setNumero_conteiner(result.getString("numero_conteiner"));
				conteinerTemp.setTipo_conteiner(result.getInt("tipo_conteiner"));
				conteinerTemp.setStatus_conteiner(result.getString("status_conteiner"));
				conteinerTemp.setCategoria_conteiner(result.getString("categoria_conteiner"));
				
				all_conteiners.add(conteinerTemp);
			}
			
			result.close();
			st.close();
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return all_conteiners;
	}
}
