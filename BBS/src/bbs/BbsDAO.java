package bbs;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.logging.Logger;

import common.Connecting;

public class BbsDAO extends Connecting{
	
	private static final Logger logger = Logger.getLogger(BbsDAO.class.getName());
	//메소드간 마찰이 일어나지 않도록 메소드 내에서 변수 선언
	//public PreparedStatement pstmt;
    public ResultSet rs;

	public BbsDAO(){
		super();
		if(conn ==null){
			logger.info("fail create connect");
		}		
	}
	
	/**현재시간 출력*/
	public String getDate(){
		String sql = "select now()";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				return rs.getString(1);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "ResulEmpty";
	}
	
	/**작성될 다음 게시글 번호 조회*/
	public int getNext(){
		String sql = "select bbsID From bbs Order by bbsID desc";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				return rs.getInt(1) + 1;
			}else{
				
				//첫번째 게시물
				logger.info("fisrt");
				return 1;
			}
			
			
		} catch (Exception e) {
			logger.info("error" + e);
		}
		
		return DatabaseError;
	}
	
	/**글 저장*/
	public int writeAction(String bbsTitle, String userID, String bbsContent){
		
		String sql ="Insert Into bbs values(?,?,?,?,?,?)";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,getNext());
			pstmt.setString(2,bbsTitle);
			pstmt.setString(3,userID);
			pstmt.setString(4,getDate());
			pstmt.setString(5,bbsContent);
			pstmt.setInt(6,1);
			
			int row = pstmt.executeUpdate();

			if(row>0){
				return DatabaseSuccess;
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return DatabaseError;
		
	}
	
	public ArrayList<Bbs> getList (int pageNum){
//		String test ="select * from bbs where bbsID < 10 and bbsAvailable = 1 order by bbsID desc limit 5";
		String sql = "Select * from bbs where bbsId < ? And bbsAvailable = 1 Order by bbsID desc Limit 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		
		int load = getNext() - (pageNum -1)*10;
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, load);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				Bbs bbs = new Bbs(rs.getInt(1), rs.getString(2), rs.getString(3), 
						rs.getTimestamp(4), rs.getString(5), rs.getInt(6));
				list.add(bbs);
			}
			
		} catch (Exception e) {
		}
		
		return list;
	}
	public Boolean nextPage(int pageNum){
		String sql = "Select * from bbs where bbsId < ? And bbsAvailable = 1";
		
		//2page 11 -(1*5) = 6
		//1page 11 - (0*5) = 11 ~ limit 5
		
		int load = getNext() - (pageNum -1)*10;
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, load);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				return true;
			}
			
		} catch (Exception e) {
		}
		
		return false;
	}
	
	public Bbs getBbs(int bbsID) {
		String sql = "Select * From bbs where bbsID = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return new Bbs(rs.getInt(1), rs.getString(2), rs.getString(3), 
						rs.getTimestamp(4), rs.getString(5), rs.getInt(6));			
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		
		return null;
	}
	
	public int updateAction(int bbsID, String bbsTitle, String bbsContent){
		
		String sql ="Update bbs Set bbsTitle = ? And bbsContent = ? Where bbsID = ? )";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,bbsTitle);
			pstmt.setString(2,bbsContent);
			pstmt.setInt(3,bbsID);
			
			if(pstmt.executeUpdate() > 0) {
				return DatabaseSuccess;
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return DatabaseError;
		
	}
	
	public int deleteAction(int bbsID) {
		
		String sql ="Update bbs Set Available = 0 Where bbsID = ? )";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,bbsID);
			
			if(pstmt.executeUpdate() > 0) {
				return DatabaseSuccess;
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return DatabaseError;
		
	}
	
	

}
