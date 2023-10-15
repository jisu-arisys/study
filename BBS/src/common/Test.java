
package common;

import java.util.ArrayList;

import bbs.Bbs;
import bbs.BbsDAO;

public class Test {
	
	//test BbsDAO.getList메소드
	public static void main(String[] args) {
		BbsDAO bbsDAO = new BbsDAO();
		
		ArrayList<Bbs> list = bbsDAO.getList(1);
		
		for(Bbs bbs : list){
			
			System.out.println(bbs.toString());
			
		}
		
		for(int i = 0; i < list.size(); i++){
			System.out.println(list.get(i).toString());
		}
	}

}
