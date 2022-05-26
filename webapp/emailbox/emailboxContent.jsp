<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<c:set var="newLine" value="\n" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>emailboxContent.jsp</title>
    <%@ include file="/include/bs4.jsp" %>
    <style></style>
    <script>
    	'use strict';
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
				<td>${vo.sendId}</td>
			</tr>
			<tr>
				<th>받는 사람</th>
				<td>${vo.receiveId}</td>
			</tr>
			<tr>
				<th>메세지 제목</th>
				<td>${vo.title}</td>
			</tr>
			<tr>
				<th>메세지 내용</th>
				<td>${fn:replace(vo.content, newLine, '<br>')}</td>
			</tr>
			<tr>
				<td colspan="2" class="text-center">
					<c:if test="${11 == param.mFlg}">
						<input type="button" value="답장쓰기" onclick="location.href='emailboxMain.m?mSw=0&nFlg=11';" class="btn btn-success" />&nbsp;
					</c:if>
					<input type="button" value="휴지통으로" onclick="location.href='emailboxGabegeOk.m?idx=${vo.idx}&mSw=${param.mFlg}';" class="btn btn-success" />
					<input type="button" value="돌아가기" onclick="location.href='emailboxMain.m?mSw=1&nFlg=11';" class="btn btn-info" />
				</td>
			</tr>
		</table>
	</form>
</div>
<p><br></p>
</body>
</html>