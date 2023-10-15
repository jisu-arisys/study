<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="bootstrap_v3.3/css/bootstrap.css">
<title>Bulletin Board System</title>
</head>
<body>
	<%	
		//기존 로그인 정보 불러오기
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID = (String) session.getAttribute("userID");			
		}

		//bbs 페이지 정보 불러오기
		int pageNum = 1;
		if(request.getParameter("pageNum") !=null){
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
	%>
<!-- 		현재페이지 이동 버튼에 class="active"-->
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>				
			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%	//로그인 안된 상태
				if(userID == null){
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" 
						aria-haspopup="true" aria-expanded="false">
						접속하기 <span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<% //로그인된 상태
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" 
							aria-haspopup="true"
							aria-expanded="false">
							회원관리
							<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	
	
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
			//bbs 페이지 목록 출력
					BbsDAO bbsDAO = new BbsDAO();
					ArrayList<Bbs> list = bbsDAO.getList(pageNum);
					for(int i = 0; i<list.size(); i++){
					%>
					<tr>
						<td><%= list.get(i).getBbsID() %></td>
						<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle() %></a></td>
						<td><%=list.get(i).getUserID() %></td>
						<td><%=list.get(i).getBbsDateString() %></td>
					</tr>
					<% 
					}
					%>
					
					<%	
			//data 없을 때
						if(list == null){
					%>
						<tr>
							<td colspan="4" style="text-align: center;">data가 없습니다.</td>
						</tr>	
					<%
						}
					%>			
				</tbody>
			</table>
			<% 
				if(pageNum != 1){
			%>
 				<a href="bbs.jsp?pageNum=<%= pageNum - 1 %>" class="btn btn-success btn-arrow-left">before</a>
			<%
				}
				if(bbsDAO.nextPage(pageNum+1)){
					
			%> 
				<a href="bbs.jsp?pageNum=<%= pageNum + 1 %>" class="btn btn-success btn-arrow-left">after</a>
			<%
				} 
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="bootstrap_v3.3/js/bootstrap.js"></script>
</body>
</html>