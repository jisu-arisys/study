package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Logger;

public class Connecting {
    private static final Logger logger = Logger.getLogger(Connecting.class.getName());

    public Connection conn;
	
	public final int DatabaseError = -2;
	public final int DatabaseDuplication = -1;
	public final int DatabaseDisMatch = 0;
	public final int DatabaseSuccess = 1;
	public final String ResulEmpty = "ResulEmpty";
	
	public Connecting(){
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?useSSL=false";
			String dbID = "root";
			String dbPW = "mysql";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPW);
		} catch (ClassNotFoundException | SQLException e) {
		}		
	}
	

}
