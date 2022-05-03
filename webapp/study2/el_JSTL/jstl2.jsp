<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>jstl2.jsp</title>
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
<div class="container">
	<h2>JSTL ( Function Library )</h2>
	<p>사용법 : $ {fn: 함수명(변수/값.....)}</p>
	<hr/>
<%
				// 0123456789012345678901234
	String atom = "Welcome to My Homepage!!!";
	pageContext.setAttribute("atom", atom);
%>
	<pre>
		atom 변수의 값 : JAVA 함수 / JSTL 함수<br>
		1. atom 변수의 길이 : <%=atom.length() %> / ${fn:length(atom) }
		2. 대문자 변환(toUpperCase()) : <%=atom.toUpperCase()%> / ${fn:toUpperCase(atom)}
		3. 소문자 변환(toLowerCase()) : <%=atom.toLowerCase()%> / ${fn:toLowerCase(atom)}
		4-1. 문자열 추출1(substring()) : <%=atom.substring(0, 3)%> / ${fn:substring(atom, 0, 3)}
		4-2. 문자열 추출2(substring()) : <%=atom.substring(3)%> / ${fn:substring(atom, 3, fn:length(atom))}
		5-1. 특정 문자열의 위치값 찾기(indexOf()) : <%=atom.indexOf("o") %> / ${fn:indexOf(atom, 'o')}
		5-2. atom변수에서 'o'문자의 위치를 모두 출력하시오? 
			<c:set var="cnt" value="0" />
			<c:forEach var="idx" begin="0" end="${fn:length(atom)-1}">
				<c:if test="${'o' == fn:substring(atom,i,i+1)}">
					'o'의 위치값? ${idx}
					<c:set var="cnt" value="${cnt+1}"/>
				</c:if>
			</c:forEach>
			총 'o'문자의 개수 ? ${cnt}
		5-3.atom변수에 기억되어 있는 값 중 뒤에서 처음 만나는 'o'문자의 위치는?
			<%=atom.lastIndexOf('o') %> / 
			<c:forEach var="idx" begin="0" end="${fn:length(atom)-1}">
				<c:if test="${'o' == fn:substring(atom,i,i+1)}">
					'o'의 위치값? ${idx}
					<c:set var="lastIdx" value="idx"/>
				</c:if>
			</c:forEach>
		6. 2번째로 만나는 'o'자의 위치값 ? 
			
		7. 문자열 추출(substringBefore()) /substringAfter())
			: ${fn:substringBefore(atom, 'o') } = 'o'의 앞글자
			: ${fn:substringAfter(atom, 'o') } = 'o'의 뒷글자
	</pre>
</div>
    <%@ include file="/include/footer.jsp" %>
</body>
</html>