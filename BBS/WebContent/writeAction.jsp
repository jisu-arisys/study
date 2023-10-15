<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>			
<%@ page import="java.io.PrintWriter" %>    
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
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
		
		//유효성 검사
		if(bbs.getBbsTitle() == null 
			||bbs.getBbsContent() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 항목이 있습니다.');");
			script.println("history.back();");
			script.println("</script>");
		}
		
		BbsDAO bbsDAO = new BbsDAO();
		
		//저장 구현
		int result = bbsDAO.writeAction(bbs.getBbsTitle(), userID, bbs.getBbsContent());
		if(result > 0 ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");			
		}
		if(result < 0 ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('저장에 실패하였습니다.');");
			script.println("history.back();");
			script.println("</script>");			
		}
	%>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="bootstrap_v3.3/js/bootstrap.js"></script>
	
</body>
</html>