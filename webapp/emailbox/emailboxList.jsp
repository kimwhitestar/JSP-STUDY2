<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>emailboxList.jsp</title>
    <%@ include file="/include/bs4.jsp" %>
    <style></style>
    <script>
    	'use strict';
    	//setTimeout("location.reload()", 1000*5);//5초 간격 새로고침
     </script>
</head>
<body>
<p><br></p>
<div class="container">
	<table class="table table-hover">
		<tr class="">
			<th>번호</th>
			<th>제목</th>
			<th>날짜</th>
		</tr>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<tr>
				<td>${vo.idx}</td>
				<td>${vo.title}</td>
				<td>${vo.receiveDate}</td>
			</tr>
		</c:forEach>
	</table>
</div>
</body>
</html>