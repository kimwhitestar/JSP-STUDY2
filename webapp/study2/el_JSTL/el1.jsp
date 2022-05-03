<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>el1.jsp</title>
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
	<h2>EL(Expression Language)</h2>
	<hr/>
	<p>
		<b>용도 : 사용자가 값(변수/수식/객체)을 전송 후 담아줄 용도로 사용한다</b>
		<b>표기법 : </b>$에 {변수 or 값 or 수식 or 객체명 or 제어문 } 붙여서 표기<br>
	</p>
	<hr/>
<%
	//폼태그를 통해서 넘어온 값들을 변수로 받음(request.getParameter("atom"))
	String atom = "Seoul"; 
	String name = "홍길동";
	int su1 = 100, su2 = 200;
	pageContext.setAttribute("atom", atom);
	pageContext.setAttribute("name", name);
	pageContext.setAttribute("su1", su1);
%>
	<h2>스클립틀릿과 표현식을 이용한 출력</h2>
	atom = <%= atom%><br>
	name = <%= name%><br>
	su1 = <%= su1%><br>
	su2 = <%= su2%><br><br>
	<h2>EL을 이용한 출력1(param을 이용한 출력 : 앞 jsp에서 폼태그를 Get방식으로 넘긴자료를 받을때)</h2>
	atom = ${param.atom}<br>
	name = ${param.name}<br>
	su1 = ${param.su1}<br>
	su2 = ${param.su2}<br>
	<h2>EL을 이용한 출력2(저장소를 이용한 출력)</h2>
	<p>저장소의 종류</p>
	<ol>
		<li>application : 전역변수</li>
		<li>session : 브라우저생성과 소멸</li>
		<li>pageContext : 현페이지</li>
		<li>request : 요청시</li>
	</ol>
	atom = ${atom}<br>
	name = ${name}<br>
	su1 = ${su1}<br>
	su2 = ${su2}<br>
	<hr/>
	<h2>Form에 의한 값의 전달</h2>
	<div>
		<form name="myForm" method="post" action="el2.st">
			<p>아이디 : <input type="text" name="mid" value="tester2"/></p>
			<p>비밀번호 : <input type="password" name="pwd" value="1234"/></p>
			<p>성명 : <input type="text" name="name" value="테스터2"/></p>
			<p>취미
				<input type="checkbox" name="hobby" value="낚시" checked/>낚시&nbsp;
				<input type="checkbox" name="hobby" value="수영" checked/>수영&nbsp;
				<input type="checkbox" name="hobby" value="바둑" checked/>바둑&nbsp;
			</p>
			<p><input type="hidden" name="idx" value="1234"/></p>
			<p><input type="submit" name="값전송연습" class="btn btn-secondary"/></p>
		</form>
	</div>
	
</div>

    <%@ include file="/include/footer.jsp" %>
</body>
</html>