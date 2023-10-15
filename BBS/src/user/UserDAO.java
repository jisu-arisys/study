package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Logger;

import common.Connecting;


public class UserDAO extends Connecting{
    private static final Logger logger = Logger.getLogger(UserDAO.class.getName());

	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO(){
		super();
		if(conn ==null){
			logger.info("fail create connect");
		}		
	}
	
	public int login(String userID, String userPassword){
		String sql = "Select userPassword From user Where userID = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			
			if(rs.next()){ 
				if(rs.getString(1).equals(userPassword)){
					return DatabaseSuccess;
				}
				
				else{
					return DatabaseDisMatch;
				}
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}

		return DatabaseError;
	}
	
	public int join(User user){
		if(checkExist("userID", user.getUserID()) == DatabaseDuplication){
			return DatabaseDuplication;
		}
		
		String sql = "Insert Into user Values (?,?,?,?,?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			
			if(pstmt.executeUpdate()==1){ 
				return DatabaseSuccess;
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return DatabaseError;
	}
	
	public int checkExist(String coulmnName, String data){
//		String exSQL = "Select userID From user Where userID = ?";
		String sql = "Select " + coulmnName + " From user Where " + coulmnName + " = ?";
		logger.info("동적 쿼리문 " + sql);
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, data);
			
			if(pstmt.executeQuery(sql).next()){
				return DatabaseDuplication;
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return DatabaseSuccess;
	}
	
	
	
	

}
