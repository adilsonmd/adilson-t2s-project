package br.com.t2s.models;

import java.util.UUID;

public class Conteiner {
	private UUID ID;
	private int id_conteiner;
	private String cliente;
	private String numero_conteiner;
	private int tipo_conteiner;
	private String status_conteiner;
	private String categoria_conteiner;
	
	public UUID getID()
	{
		return ID;
	}
	public void setID()
	{
		this.ID = UUID.randomUUID();
	}
	
	public int getId_conteiner() {
		return id_conteiner;
	}
	public void setId_conteiner(int id_conteiner) {
		this.id_conteiner = id_conteiner;
	}
	public String getCliente() {
		return cliente;
	}
	public void setCliente(String cliente) {
		this.cliente = cliente;
	}
	public String getNumero_conteiner() {
		return numero_conteiner;
	}
	public void setNumero_conteiner(String numero_conteiner) {
		this.numero_conteiner = numero_conteiner;
	}
	public int getTipo_conteiner() {
		return tipo_conteiner;
	}
	public void setTipo_conteiner(int tipo_conteiner) {
		this.tipo_conteiner = tipo_conteiner;
	}
	public String getStatus_conteiner() {
		return status_conteiner;
	}
	public void setStatus_conteiner(String status_conteiner) {
		this.status_conteiner = status_conteiner;
	}
	public String getCategoria_conteiner() {
		return categoria_conteiner;
	}
	public void setCategoria_conteiner(String categoria_conteiner) {
		this.categoria_conteiner = categoria_conteiner;
	}

}
