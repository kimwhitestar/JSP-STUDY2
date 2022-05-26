<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <%@ include file="/include/bs4.jsp" %>
    <style>
    	#leftWindow {
    		float : left;
    		width : 25%;
    		height : 500px;
    		text-align : center;
    		background-color : #ddd;
    	}
    	#rightWindow {
    		float : left;
    		width : 75%;
    		height : 500px;
    		text-align : left;
    		background-color : #eee;
    		overflow : auto;
    	}
    	#footerTopMargin {
    		clear : both;
    		margin : 10px;
    	}
    	h3 { text-align : center }
    	
    </style>
    <script>
    	'use strict';
    </script>
</head>
<body>
    <%@ include file="/include/header_home.jsp" %>
    <%@ include file="/include/nav.jsp" %>
<p><br></p>
<div class="container">
	<h3>메세지 관리</h3>
	<div>(현재접속자:<font color='red'><%-- ${sMid} --%></font>)</div>
	<div id="leftWindow">
		<p><br></p>
		<p><a href="emailboxMessage.m?mSw=0">메세지작성</a></p>
		<p><a href="emailboxMessage.m?mSw=1&mFlg=11">받은메세지</a></p>
		<p><a href="emailboxMessage.m?mSw=2">새메세지</a></p>
		<p><a href="emailboxMessage.m?mSw=3&mFlg=12">보낸메세지</a></p>
		<p><a href="emailboxMessage.m?mSw=4">수신확인</a></p>
		<p><a href="emailboxMessage.m?mSw=5&mFlg=13">휴지통</a></p>
		<p><a href="javascript:emailboxMessageDeleteAll()">휴지통비우기</a></p>
	</div>
</div>
<div>
	<div id="rightWindow">
		<p><a href="emailboxMessage.m?mSw=0">메세지작성</a></p>
		<p><a href="emailboxMessage.m?mSw=1&mFlg=11">받은메세지</a></p>
		<p><a href="emailboxMessage.m?mSw=2">새메세지</a></p>
		<p><a href="emailboxMessage.m?mSw=3&mFlg=12">보낸메세지</a></p>
		<p><a href="emailboxMessage.m?mSw=4">수신확인</a></p>
		<p><a href="emailboxMessage.m?mSw=5&mFlg=13">휴지통</a></p>
		<p><a href="javascript:emailboxMessageDeleteAll()">휴지통비우기</a></p>
		<br>
		<p>
			<c:if test="${mSw == 0}">
				<h3>메세지 작성</h3>
				<jsp:include page="emailboxInput.jsp" />
			</c:if>
			<c:if test="${mSw == 1}">
				<h3>받은메세지</h3>
				<jsp:include page="emailboxList.jsp" />
			</c:if>
			<c:if test="${mSw == 2}">
				<h3>신규메세지</h3>
				<jsp:include page="emailboxList.jsp" />
			</c:if>
			<c:if test="${mSw == 3}">
				<h3>보낸메세지</h3>
				<jsp:include page="emailboxList.jsp" />
			</c:if>
			<c:if test="${mSw == 4}">
				<h3>수신확인</h3>
				<jsp:include page="emailboxList.jsp" />
			</c:if>
			<c:if test="${mSw == 5}">
				<h3>휴지통</h3>
				<jsp:include page="emailboxList.jsp" />
			</c:if>
			<c:if test="${mSw == 6}">
				<h3>메세지 내용보기</h3>
				<jsp:include page="emailboxContent.jsp" />
			</c:if>
		</p>
	</div>
</div>
<br>
<div id="footerTopMargin">
</div>
<p><br></p>
    <%@ include file="/include/footer.jsp" %>
</body>
</html>