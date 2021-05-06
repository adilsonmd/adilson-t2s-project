
public class AppSecrets {
	// CHANGE
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
