<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>			<%--DAO 클래스 사용--%>
<%@ page import="java.io.PrintWriter" %>	<%--문자열을 출력 클래스 사용--%>
<% request.setCharacterEncoding("UTF-8"); %> <%--인코딩 방식을 설정--%>
<jsp:useBean id="user" class="user.User" scope="page" /> <%--자바 빈 등록 = 객체 생성--%>
<jsp:setProperty name="user" property="userID" /> <%--join.jsp에서 받아온 정보로 객체 값 변경 --%>
<jsp:setProperty name="user" property="userPassword" /> <%--join.jsp에서 받아온 정보로 객체 값 변경 --%>
<jsp:setProperty name="user" property="userName" /> <%--join.jsp에서 받아온 정보로 객체 값 변경 --%>
<jsp:setProperty name="user" property="userGender" /> <%--join.jsp에서 받아온 정보로 객체 값 변경 --%>
<jsp:setProperty name="user" property="userEmail" /> <%--join.jsp에서 받아온 정보로 객체 값 변경 --%>

<!DOCTYPE html>
<html>
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bulletin Board System</title>
</head>
<body>
	
	<%//JSP 페이지에서 사용되는 서버 측 코드를 나타내는 태그입니다. 
	  //이러한 태그를 스크립트릿(scriptlet)은 
	  //JSP 컨테이너가 코드를 처리한 뒤 HTML로 렌더링해 클라이언트에게 전달합니다.
	  //따라서 클라이언트의 브라우저는 아래 코드를 포함하지 않습니다.
		//유효성 검사
		if(user.getUserID()==null 
			|| user.getUserPassword()==null 
			|| user.getUserName()==null 
			|| user.getUserGender()==null 
			|| user.getUserEmail()==null 
			){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alret('입력이 안된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		//java 함수를 실행
		UserDAO userDAO = new UserDAO();
		int result = userDAO.join(user);
		
		//회원가입 성공시
		if(result > 0){
			session.setAttribute("userID", user.getUserID());	
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		//회원가입 실패시
		else if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("console.log('result:" + result+ "');");						
			script.println("alert('이미 존재하는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		//회원가입 실패 기타사유
		else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("console.log('result:" + result+ "');");						
			script.println("alert('회원가입에 실패하였습니다. 고객센터에 문의해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		} 
		
	%>
</body>
</html>