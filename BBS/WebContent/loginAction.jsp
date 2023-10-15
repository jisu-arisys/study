<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--DAO 클래스 사용--%>
<%@ page import="user.UserDAO" %>			
<%@ page import="java.io.PrintWriter" %>	
<% request.setCharacterEncoding("UTF-8"); %> 
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" /> 
<jsp:setProperty name="user" property="userPassword" /> 

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bulletin Board System</title>
</head>
<body>
	<%	
		//로그인 여부 확인
		String userID = null;
		if(session.getAttribute("userID")!= null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID != null){ 
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.');");
			script.println("location.href = 'main.jsp';");
			script.println("</script>");
		}
		
		//java 함수를 실행
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		
		
		//로그인 성공시
		if(result == 1){
			session.setAttribute("userID", user.getUserID());	
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp';");
			script.println("</script>");
		}
		//로그인 실패시
		else if(result < 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");			
			script.println("console.log('result:" + result+ "');");						
			script.println("alert('로그인 중 오류가 발생했습니다.');");
			script.println("history.back();");
			script.println("</script>");
		}
	%>
</body>
</html>