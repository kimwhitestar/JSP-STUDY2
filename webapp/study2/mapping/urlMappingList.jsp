<%--@ include file="/include/memberCheck.jsp" --%>
<%@ page import="study.database.LoginVO"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<%
	List<LoginVO> vos = (List<LoginVO>)request.getAttribute("vos");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <%@ include file="/include/bs4.jsp" %>
    <style></style>
    <script>
    	'use strict';
    	
    </script>
</head>
<body>
    <%@ include file="/include/header_home.jsp" %>
    <%@ include file="/include/nav.jsp" %>
<p><br></p>
<div class="text-center container">
	<h2>전체 회원 목록</h2>
	<table>
			<tr>
				<th>번호</th><th>아이디</th><th>성명</th><th>포인트</th><th>최종방문일</th><th>방문횟수</th>
			</tr>
<%	for (LoginVO vo : vos) { %>
			<tr>
				<td><%=vo.getIdx()%></td>
				<td><%=vo.getMid()%></td>
				<td><%=vo.getName()%></td>
				<td><%=vo.getPoint()%></td>
				<td><%=vo.getLastDate()%></td>
				<td><%=vo.getvCount()%></td>
			</tr>
<% } %>
			<tr><td colspan="6" class="p-0"></td></tr>
	</table>
  <p><br></p>
  <p class="text-center"><a href='${ctxPath}/urlMapping.um' class="btn btn-success form-control">돌아가기</a></p>
</div>
    <%@ include file="/include/footer.jsp" %>
</body>
</html>