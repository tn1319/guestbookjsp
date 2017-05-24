<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="guestbook.dao.GuestbookDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="guestbook.bean.GuestbookDTO"%>
    
<%
//데이터 가져오기
int pg=Integer.parseInt(request.getParameter("pg"));


//페이징처리 - 1페이지당 3개씩
int endNum=pg*3;
int startNum=endNum-2;


GuestbookDAO dao=GuestbookDAO.getInstance();
ArrayList<GuestbookDTO> list=dao.guestbookList(startNum,endNum);
int totalPage=(dao.pageNum()+2)/3;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<center>
<%for(int i=1;i<=totalPage;i++){ 
	if(pg==i){%>
		<a href="guestbookList.jsp?pg=<%=i %>" style="color:red; font-weight: bold;">[<%=i %>]</a>
	<%}
	else{%>
		<a href="guestbookList.jsp?pg=<%=i %>" style="color:black; text-decoration: none;">[<%=i %>]</a>
	<%}
} %></center><br>
<%if(list!=null){ %>
	<%for(GuestbookDTO data : list) {%>
		<table border="1" cellpadding="3" cellspacing="0" width="100%">
			<tr>
				<th>작성자</th>
				<td><%=data.getName() %></td>
				<th>작성일</th>
				<td><%=data.getLogtime() %></td>
			</tr>
				<th>이메일</th>
				<td colspan="3"><%=data.getEmail() %></td>
			<tr>
				<th>홈페이지</th>
				<td colspan="3"><a href="<%=data.getHomepage() %>"><%=data.getHomepage() %></a></td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3"><%=data.getSubject() %></td>
			</tr>
			<tr>
				<td colspan="4" height="300px"><pre><%=data.getContent() %></pre></td>
			</tr>
		</table>
	<%} %>
<%} %>
</body>
</html>