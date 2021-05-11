package br.com.t2s;

public class AppSecrets {
	// String url = "jdbc:postgresql://172.31.56.85:5432/t2s";
	private final String url = "jdbc:postgresql://localhost:5432/t2s";
	private final String dbUsername = "postgres";
	private final String dbPassword = "ad123";
	
	
	public String getUrl()
	{
		return url;
	}
	public String getDbUsername()
	{
		return dbUsername;
	}
	public String getDbPassword()
	{
		return dbPassword;
	}
}
