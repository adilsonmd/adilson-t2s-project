package br.com.t2s;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class BaseConnection {
	private static AppSecrets secrets = new AppSecrets();
	
	public static Connection createConnection() throws SQLException {
		return DriverManager.getConnection(
				secrets.getUrl(),
				secrets.getDbUsername(),
				secrets.getDbPassword());
		
	}
	
}
