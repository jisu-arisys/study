package bbs;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class Bbs {
	
	private int bbsID;
	private String bbsTitle;
	private String userID;
	private Timestamp bbsDate;
	private String bbsContent;
	private int bbsAvailable;
	
	public Bbs() {
	}

	public Bbs(int bbsID, String bbsTitle, String userID, Timestamp bbsDate, 
			String bbsContent, int bbsAvailable) {
		
		
		this.bbsID = bbsID;
		this.bbsTitle = bbsTitle;
		this.userID = userID;
		this.bbsDate = bbsDate;
		this.bbsContent = bbsContent;
		this.bbsAvailable = bbsAvailable;
		
	}


	public int getBbsID() {
		return bbsID;
	}

	public void setBbsID(int bbsID) {
		this.bbsID = bbsID;
	}

	public String getBbsTitle() {
		return bbsTitle;
	}

	public void setBbsTitle(String bbsTitle) {
		this.bbsTitle = bbsTitle;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public Timestamp getBbsDate() {
		return bbsDate;
	}

	public void setBbsDate(Timestamp bbsDate) {
		this.bbsDate = bbsDate;
	}

	public String getBbsContent() {
		return bbsContent;
	}

	public void setBbsContent(String bbsContent) {
		this.bbsContent = bbsContent;
	}

	public int getBbsAvailable() {
		return bbsAvailable;
	}

	public void setBbsAvailable(int bbsAvailable) {
		this.bbsAvailable = bbsAvailable;
	}
	
	
	//날짜 포맷팅 메소드
	//2023-10-15 10시 17분
	public String getBbsDateString() {
		return this.bbsDate.toString().substring(0,11) + " "
					+this.bbsDate.toString().substring(11,13) + "시 "
					+this.bbsDate.toString().substring(14,16) + "분";
	}

	@Override
	public String toString() {
		return "Bbs [bbsID=" + bbsID + ", bbsTitle=" + bbsTitle + ", userID=" + userID + ", bbsDate=" + bbsDate
				+ ", bbsContent=" + bbsContent + ", bbsAvailable=" + bbsAvailable + "]";
	}
	
	

	
	

	
}
