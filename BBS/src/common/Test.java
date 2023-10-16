
package common;

import bbs.Bbs;
import bbs.BbsDAO;

import java.util.ArrayList;

public class Test {
	
	//test BbsDAO.getList메소드
	public static void main(String[] args) {
		BbsDAO bbsDAO = new BbsDAO();
		
		int pageNum =1;
		System.out.println("pageNum =" + pageNum);
		
		ArrayList<Bbs> list = bbsDAO.getList(pageNum);
		
		for(Bbs bbs : list){
			
			System.out.println(bbs.toString());
		}
	
		if(bbsDAO.nextPage(pageNum + 1)){
			System.out.println("다음");
			pageNum=2;
			System.out.println("pageNum =" + pageNum);
		}
		
		list = bbsDAO.getList(pageNum);
		for(int i = 0; i < list.size(); i++){
			System.out.println(list.get(i).toString());
		}
	
		if(pageNum !=1){
			System.out.println("pageNum =" + pageNum);
			System.out.println("이전");
		}
		
		Bbs bbs = bbsDAO.getBbs(14);
		
		System.out.println(bbs.toString());
		
	}
}
