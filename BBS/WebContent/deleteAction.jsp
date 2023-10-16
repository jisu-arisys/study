<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>    
<%@ page import="bbs.Bbs" %>			
<%@ page import="bbs.BbsDAO" %>			
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<%	
		//기존 로그인 정보 불러오기
		String userID = null;
		if(session.getAttribute("userID")!=null){ 
			userID = (String) session.getAttribute("userID");			
		}
		
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 안되어 있습니다. 로그인 페이지로 이동합니다.')");
			script.println("lacation.href = 'login.jsp'");
			script.println("</script>");
		}
		

		//게시글 번호 확인
		int bbsID = 0;		
		if(request.getParmeter("bbsID")!=null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID == 0 ){	
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("lacation.href = 'bbs.jsp'");
			script.println("</script>");
		}
		//게시글 불러오기
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		
		//작성자 확인
		if(!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("lacation.href = 'bbs.jsp'");
			script.println("</script>");
		}
		
		BbsDAO bbsDAO = new BbsDAO();
		
		//삭제 구현
		int result = bbsDAO.deleteAction(bbsID);
		if(result > 0 ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");			
		}
		if(result < 0 ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('삭제에 실패하였습니다.');");
			script.println("history.back();");
			script.println("</script>");			
		}
	%>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="bootstrap_v3.3/js/bootstrap.js"></script>
	
</body>
</html>