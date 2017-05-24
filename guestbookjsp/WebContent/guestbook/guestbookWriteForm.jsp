<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function checkGuestbookWrite(){
	if(document.guestbookWriteForm.subject.value=="")
		alert("제목을 입력하세요");
	else if(document.guestbookWriteForm.content.value=="")
		alert("내용을 입력하세요");
	else
		document.guestbookWriteForm.submit();
}
</script>
</head>
<body>
<h3>방명록</h3>
	<form name="guestbookWriteForm" method="post" action="guestbookWrite.jsp">
		<table border="1" cellpadding="3" cellspacing="0">
			<tr>
				<td>작성자</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input type="text" name="email"></td>
			</tr>
			<tr>
				<td>홈페이지</td>
				<td><input type="text" name="homepage"></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="subject"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea rows="15" cols="50" name="content"></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="button" onclick="javascript:checkGuestbookWrite()" value="글작성">
					<input type="reset" value="다시작성">
					<input type="button" onclick="javascript:location.href='guestbookList.jsp?pg=1'" value="글목록">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>