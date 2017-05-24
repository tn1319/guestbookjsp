<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="guestbook.bean.GuestbookDTO"%>
<%@page import="guestbook.dao.GuestbookDAO"%>    
<%    
request.setCharacterEncoding("UTF-8");
String name=request.getParameter("name");
String email=request.getParameter("email");
String homepage=request.getParameter("homepage");
String subject=request.getParameter("subject");
String content=request.getParameter("content");

GuestbookDTO dto=new GuestbookDTO();
dto.setName(name);
dto.setEmail(email);
dto.setHomepage(homepage);
dto.setSubject(subject);
dto.setContent(content);


GuestbookDAO dao=GuestbookDAO.getInstance();
dao.guestbookWrite(dto);
    
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
작성하신 글을 저장하였습니다<br><br>
<a href="guestbookList.jsp">글목록</a><br><br>
<input type="button" value="글목록" onclick="javascript:location.href='guestbookList.jsp?pg=1'">
</body>
</html>