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
			System.out.println("Create connection [ConteinerDAO]");
			
			Connection conn = BaseConnection.createConnection(); 
			
			String SQL = "INSERT INTO tb_conteiner(\r\n"
					+ "	cliente, numero_conteiner, tipo_conteiner, status_conteiner, categoria_conteiner)\r\n"
					+ "	VALUES (?, ?, ?, ?, ?);";
			
			System.out.println("Criando Statemente... [ConteinerDAO]");
			PreparedStatement ps =  conn.prepareStatement(SQL);
			ps.setString(1, conteiner.getCliente());
			ps.setString(2, conteiner.getNumero_conteiner());
			ps.setInt(3, conteiner.getTipo_conteiner());
			ps.setString(4, conteiner.getStatus_conteiner());
			ps.setString(5, conteiner.getCategoria_conteiner());
			
			System.out.println("Executar comandos... [ConteinerDAO]");
			status = ps.executeUpdate();
			
			ps.close();
			conn.close();
			
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
		System.out.println("Retornando sucesso... [ConteinerDAO]");
		return status;
	}
	
	public static Conteiner listOne(int id) {
		Conteiner conteiner = new Conteiner();
		
		Connection conn;
		try {
			conn = BaseConnection.createConnection();
			String SQL = "SELECT * FROM tb_conteiner WHERE id_conteiner = ?";
			PreparedStatement ps = conn.prepareStatement(SQL);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next())
			{
				conteiner.setId_conteiner(rs.getInt(1));
				conteiner.setCliente(rs.getString(2));
				conteiner.setNumero_conteiner(rs.getString(3));
				conteiner.setTipo_conteiner(rs.getInt(4));
				conteiner.setStatus_conteiner(rs.getString(5));
				conteiner.setCategoria_conteiner(rs.getString(6));
			}
			
		} catch (Exception ex) {
			System.out.println("Erro ao listar um");
			System.out.println(ex.getMessage());
		}
		return conteiner;
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
	
	public static List<Conteiner> listAll(String email)
	{
		List<Conteiner> all_conteiners = new ArrayList<Conteiner>();
		
		Connection conn;
		try {
			conn = BaseConnection.createConnection();
			String SQL = "SELECT \r\n"
					+ "	id_conteiner, cliente, numero_conteiner, tipo_conteiner, status_conteiner, categoria_conteiner\r\n"
					+ "	FROM tb_conteiner WHERE cliente = ?;";
			
			PreparedStatement ps = conn.prepareStatement(SQL);
			ps.setString(1, email);
			ResultSet result = ps.executeQuery();
			
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
			ps.close();
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return all_conteiners;
	}
	
	public static int delete(int id)
	{
		int status = 0;
		
		Connection conn;
		try {
			conn = BaseConnection.createConnection();
			String SQL = "DELETE FROM tb_conteiner WHERE id_conteiner = ?";
			
			PreparedStatement ps = conn.prepareStatement(SQL);
			ps.setInt(1, id);
			status = ps.executeUpdate();
			
			if(status > 0)
			{
				System.out.println("Deletado com sucesso");
			}
			else {
				System.out.println("Falha ao deletar");
			}
			
		} catch (Exception ex) {
			
		}
		return status;
	}
	
	public static int update(int id, Conteiner conteiner)
	{
		int status = 0;
		
		Connection conn;
		try {
			conn = BaseConnection.createConnection();
			
			String SQL = "UPDATE tb_conteiner\r\n"
					+ "SET cliente=?, numero_conteiner=?, tipo_conteiner=?, status_conteiner=?, categoria_conteiner=?\r\n"
					+ "WHERE id_conteiner = ?";
			
			PreparedStatement ps = conn.prepareStatement(SQL);
			ps.setString(1, conteiner.getCliente());
			ps.setString(2, conteiner.getNumero_conteiner());
			ps.setInt(3, conteiner.getTipo_conteiner());
			ps.setString(4, conteiner.getStatus_conteiner());
			ps.setString(5, conteiner.getCategoria_conteiner());
			ps.setInt(6, id);
			
			status = ps.executeUpdate();
			
			if(status > 0)
			{
				System.out.println("Atualizado com sucesso");
			}
			else {
				System.out.println("Falha ao update");
			}
			
		} catch (Exception ex) {
			System.out.println("Erro [ConteinerDAO update]");
			System.out.println(ex.getMessage());
		}
		return status;
	}
}
