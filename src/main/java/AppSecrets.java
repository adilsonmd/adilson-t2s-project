
public class AppSecrets {
	// URL para o IP publico
	//String url = "jdbc:postgresql://100.24.74.6:5432/t2s";
	
	// URL para o IP privado
	String url = "jdbc:postgresql://172.31.56.85:5432/t2s";
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
