package br.com.t2s.models;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDateTime;

public class Movimentacao {
	
	private int id;
	private String tipo_movimentacao;
	private String dataInicio;
	private String dataFim;
	private int id_conteiner;
	private String numero_conteiner;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNumero_conteiner() {
		return numero_conteiner;
	}
	public void setNumero_conteiner(String numero_conteiner) {
		this.numero_conteiner = numero_conteiner;
	}
	public int getId_conteiner()
	{
		return id_conteiner;
	}
	public void setId_conteiner(int id_conteiner) {
		this.id_conteiner = id_conteiner;
	}
	public String getTipo_movimentacao() {
		return tipo_movimentacao;
	}
	public void setTipo_movimentacao(String tipo_movimentacao) {
		this.tipo_movimentacao = tipo_movimentacao;
	}
	public String getDataInicio() {
		return dataInicio;
	}
	public void setDataInicio(String dataInicio) {
		this.dataInicio = dataInicio;
	}
	public String getDataFim() {
		return dataFim;
	}
	public void setDataFim(String dataFim) {
		this.dataFim = dataFim;
	}	
}
