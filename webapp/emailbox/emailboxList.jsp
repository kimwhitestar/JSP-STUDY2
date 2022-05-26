<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
    	//4setTimeout("location.reload()", 1000*5);//5초 간격 새로고침
     </script>
</head>
<body>
<p><br></p>
<div class="container">
	<table class="table table-hover">
		<tr class="">
			<th>번호</th>
			<th><!-- mSw 1:받은메세지 2:신규메세지 3:보낸메세지 4:수신확인 5:휴지통 6:상세보기 -->
				<c:if test="${1 == mSw || 2 == mSw || 5 == mSw}">보낸사람</c:if>
				<c:if test="${3 == mSw || 4 == mSw}">받은사람</c:if>
			</th>
			<th>제목</th>
			<th>
				<c:if test="${1 == mSw || 2 == mSw || 5 == mSw}">보낸날짜/확인날짜</c:if>
				<c:if test="${3 == mSw || 4 == mSw}">받은날짜</c:if>
			</th>
		</tr>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<tr>
				<td>${vo.idx}</td>
				<td>
					<c:if test="${1 == mSw || 2 == mSw || 5 == mSw}">${vo.sendId}</c:if>
					<c:if test="${3 == mSw || 4 == mSw}">${vo.receiveId}</c:if>
				</td>
				<td>
					<a href="emailboxMessage?mSw=6&idx=${vo.idx}&mFlg=${param.mFlg}">${vo.title}</a>
					&nbsp;<c:if test="${'n' == vo.receiveSw}"><font color="red">new</font></c:if>
				</td>
				<td>
					<c:if test="${24 > vo.nReceiveDate}">${fn:substring(vo.receiveDate, 11, 19)}</c:if>
					<c:if test="${24 <= vo.nReceiveDate}">${fn:substring(vo.receiveDate, 0, 19)}</c:if>
				</td>
			</tr>
		</c:forEach>
	</table>
</div>
</body>
</html>