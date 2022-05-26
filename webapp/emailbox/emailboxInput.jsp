<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <%@ include file="/include/bs4.jsp" %>
    <style></style>
    <script>
    	'use strict';
    	function checkemailboxInput() {
    		let receiveId = myForm.receiveId.value;
    		let title = myForm.title.value;
    		let content = myForm.content.value;
    		
    		if ('' == receiveId) {
    			alert('받는 사람 아이디 입력');
    			myForm.receiveId.focus();
    		}
    		else if ('' == title) {
    			alert('제목 입력');
    			myForm.title.focus();
    		}
    		else if ('' == content) {
    			alert('내용 입력');
    			myForm.content.focus();
    		}
    		else {
    			myForm.submit();
    		}
    	}
    </script>
</head>
<body>
<p><br></p>
<div class="container">
	<h3>메세지 작성</h3>
	<p><br></p>
	<form name="myForm" method="post" action="emailboxInputOk.m">
		<table class="table table-bordered">
			<tr>
				<th>보내는 사람</th>
				<td><input type="text" name="sendId" value="${sMid}" readonly class="form-control" /></td>
			</tr>
			<tr>
				<th>받는 사람</th>
				<td>
					<c:if test="${empty param.receiveId}"><input type="text" name="receiveId" class="form-control" placeholder="받는사람 아이디 입력" /></c:if>
					<c:if test="${!empty param.receiveId}"><input type="text" name="receiveId" class="form-control" readonly /></c:if>
				</td>
			</tr>
			<tr>
				<th>메세지 제목</th>
				<td><input type="text" name="title" class="form-control" placeholder="제목 입력" /></td>
			</tr>
			<tr>
				<th>메세지 내용</th>
				<td><textarea name="content" class="form-control" ></textarea></td>
			</tr>
			<tr>
				<td colspan="2" class="text-center">
					<input type="button" value="메세지 전송" onclick="checkemailboxInput()" class="btn btn-success" />
					<input type="reset" value="다시쓰기" class="btn btn-secondary" />
					<input type="button" value="돌아가기" onclick="/emailboxList.m" class="btn btn-info" />
				</td>
			</tr>
			<tr>
				<th>보내는 사람</th>
				<td></td>
			</tr>
		</table>
	</form>
</div>
<p><br></p>
</body>
</html>