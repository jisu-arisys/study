
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
		
		int pageNum =1;
		System.out.println("pageNum =" + pageNum);
	
		if(bbsDAO.nextPage(pageNum + 1)){
			System.out.println("다음");
			pageNum=2;
			System.out.println("pageNum =" + pageNum);
		}
	
		if(pageNum !=1){
			System.out.println("pageNum =" + pageNum);
			System.out.println("이전");
			
		}
	}
}
