import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnection {

	private String urlJdbc;
	private String username;
	private String password; 
	private Connection connection;
	
	public DbConnection(String url, String user, String pass) {
		this.urlJdbc = url;
		this.username = user;
		this.password = pass;
	}
	
	public Connection createConnection() throws SQLException {
		return DriverManager.getConnection(urlJdbc, username, password);
	}
	
	public void closeConnection(Connection connection) throws SQLException
	{
		connection.close();
	}
	
	
}
