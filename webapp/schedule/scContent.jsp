<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<c:set var="newLine" value="\n" scope="page"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <%@ include file="/include/bs4.jsp" %>
    <style>
    	th {background-color: #ccc}
    </style>
    <script>
    	'use strict';
    	
    </script>
</head>
<body>
<p><br></p>
<div class="container">
	<h2>일정 내역보기(${vo.ymd})</h2>
	<br>
	<table class="table table-bordered">
		<tr>
			<th>작성자</th>
			<td>${vo.mid}</td>
		</tr>
		<tr>
			<th>분류</th>
			<td>${vo.part}</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${fn:replace(vo.content, newLine, "<br>")}</td>
		</tr>
		<tr>
			<td colspan="2" class="text-center">
				<input type="button" value="창닫기" onclick="window.close()"/>
			</td>
		</tr>
	</table>
</div>
</body>
</html>