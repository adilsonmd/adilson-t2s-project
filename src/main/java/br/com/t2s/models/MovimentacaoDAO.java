package br.com.t2s.models;

import java.util.List;

import br.com.t2s.BaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

public class MovimentacaoDAO {
		
	public static List<Movimentacao> listAll(int id_conteiner)
	{
		List<Movimentacao> listMovimentacao = new ArrayList<Movimentacao>();
				
		Connection conn = null;
		
		try {
			
			conn = BaseConnection.createConnection();
			//String SQL = "SELECT id_movimentacao, tipo_movimentacao, data_inicio, data_fim, id_conteiner,  "
			//		+ " FROM tb_movimentacao WHERE id_conteiner=?";
			String SQL = "SELECT id_movimentacao, tipo_movimentacao, data_inicio, data_fim,\r\n"
					+ "id_conteiner,\r\n"
					+ "(SELECT numero_conteiner FROM tb_conteiner \r\n"
					+ " WHERE tb_movimentacao.id_conteiner = tb_conteiner.id_conteiner)\r\n"
					+ "AS numero_conteiner\r\n"
					+ "FROM public.tb_movimentacao\r\n"
					+ "WHERE id_conteiner=?";
			PreparedStatement ps = conn.prepareStatement(SQL);
			ps.setInt(1, id_conteiner);
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				Movimentacao movimentacaoTemp = new Movimentacao();
				movimentacaoTemp.setId(rs.getInt(1));
				movimentacaoTemp.setTipo_movimentacao(rs.getString(2));
				movimentacaoTemp.setDataInicio(rs.getString(3));
				movimentacaoTemp.setDataFim(rs.getString(4));
				movimentacaoTemp.setId_conteiner(rs.getInt(5));
				movimentacaoTemp.setNumero_conteiner(rs.getString(6));
				
				listMovimentacao.add(movimentacaoTemp);
			}
			rs.close();
			ps.close();
			conn.close();
			
		} catch (Exception ex) {
			System.out.println("[MovimentacaoDAO - listAll]: " + ex.getMessage());
		}
		
		return listMovimentacao;
	}
	
	public static Movimentacao listOne(int id)
	{
		Movimentacao movimentacao = new Movimentacao();
		
		// TODO implementar select(id)
		
		return movimentacao;
	}
	
	public static int insert(Movimentacao movimentacao)
	{
		int status = 0;
		
		try {
			System.out.println("Create connection [MovimentacaoDAO]");
			
			Connection conn = BaseConnection.createConnection(); 
			
			String SQL = "INSERT INTO tb_movimentacao(\r\n"
					+ "	tipo_movimentacao, data_inicio, data_fim, id_conteiner)\r\n"
					+ "	VALUES (?, ?, ?, ?);";
			
			System.out.println("Criando Statemente... [MovimentacaoDAO]");
			System.out.println("Data: " + movimentacao.getDataInicio());
			
			PreparedStatement ps =  conn.prepareStatement(SQL);
			ps.setString(1, movimentacao.getTipo_movimentacao());
			ps.setTimestamp(2, Timestamp.valueOf(movimentacao.getDataInicio()));
			ps.setTimestamp(3, Timestamp.valueOf(movimentacao.getDataFim()));
			ps.setInt(4, movimentacao.getId_conteiner());
			
			System.out.println("Executar comandos... [MovimentacaoDAO]");
			status = ps.executeUpdate();
			
			ps.close();
			conn.close();
			
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
		System.out.println("Retornando sucesso... [MovimentacaoDAO]");
		return status;
	}
	
	public static int update(int id, Movimentacao movimentacao)
	{
		int status = 0;
		
		try {
			System.out.println("Create connection [MovimentacaoDAO]");
			
			Connection conn = BaseConnection.createConnection(); 
			
			String SQL = "UPDATE tb_movimentacao\r\n"
					+ "	SET tipo_movimentacao=?, data_inicio=?, data_fim=?\r\n"
					+ "	WHERE id_movimentacao = ?;";
			
			System.out.println("Criando Statemente... [MovimentacaoDAO]");
			System.out.println("Data: " + movimentacao.getDataInicio());
			
			PreparedStatement ps =  conn.prepareStatement(SQL);
			ps.setString(1, movimentacao.getTipo_movimentacao());
			ps.setTimestamp(2, Timestamp.valueOf(movimentacao.getDataInicio()));
			ps.setTimestamp(3, Timestamp.valueOf(movimentacao.getDataFim()));
			ps.setInt(4, id);
			
			System.out.println("Executar comandos... [MovimentacaoDAO]");
			status = ps.executeUpdate();
			
			ps.close();
			conn.close();
			
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
		System.out.println("Retornando sucesso... [MovimentacaoDAO]");
		return status;
	}
	
	public static int delete(int id)
	{
		int status = 0;
		
		Connection conn;
		try {
			conn = BaseConnection.createConnection();
			String SQL = "DELETE FROM tb_movimentacao WHERE id_movimentacao = ?";
			
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
}
