<%@page import="study.database.LoginVO"%>
<%@page import="java.util.List"%>
<%@page import="study.database.LoginDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>jstl1.jsp</title>
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
	<h2>JSTL(Java Standard Tag Library)</h2>
	<table class="table">
		<tr>
			<th>Core Lib</th>
			<td>http://java.sun.com/jsp/jstl/core</td>
			<td>< c : 태그 ... ></td>
		</tr>
		<tr>
			<th>Fuction Lib</th>
			<td>http://java.sun.com/jsp/jstl/function</td>
			<td>$ { fn : 태그 ... } </td>
		</tr>
		<tr>
			<th>Formatting Lib</th>
			<td>http://java.sun.com/jsp/jstl/fmt</td>
			<td>< fmt : 태그 ... ></td>
		</tr>
		<tr>
			<th>SQL Lib</th>
			<td>http://java.sun.com/jsp/jstl/sql</td>
			<td>< sql : 태그 ... ></td>
		</tr>
	</table>
	<hr/>
	<h2>Core 라이브러리(client영역) : 변수제어(선언/할당), 제어문(조건, 반복문)안에서 변수</h2>
	<p> 변수 선언 : < c :set var="변수명" value="값" /></p>
	<p> 변수 출력 : < c :out value="변수명(el표기법)/ 값" /></p>
	<p> 변수 제거 : < c :remove var="변수명" />설정한 변수를 메모리에서 삭제</p>
	<p> 예외처리 : < c : catch 문장 ... /></p>
	<hr/>
	su1변수에 값 할당 ? <c:set var="su1" value="100"/><br>
	su1변수에 값 출력 ? <c:out value="${su1}"/> == ${ su1 }<br>
	<hr/>
	<h2>JSTL 제어문(Core라이브러리를 사용)</h2>
	<h2>(조건문 : 참일때 수행할 내용만 있음. 거짓은 없다)</h2>
	<p>문법 : <c : if test="$ {조건식}"/>참일때 수행할 내용 </c : if></p>
	<p>일반 비교연산수행시는 '문자'로 비교처리한다. 숫자는 변수명 뒤에 '+0'을 붙인다</p>
	<c:set var="su1" value="500"/>
	<c:set var="su2" value="1000"/>
	su1=${su1}, su=${su2}<br>
	1_1. su1 == su2 : <c:if test="${su1 == su2}">su1과 su2는 같다</c:if><br>
	1_2. su1 != su2 : <c:if test="${su1 != su2}">su1과 su2는 다르다</c:if><br>
	2_1. su1 >= su2 : <c:if test="${su1 >= su2}">su1이 su2보다 크거나 같다</c:if><br>
	2_2. su1 '<=' su2 : <c:if test="${su1 <= su2}">su1이 su2보다 작거나 같다(크지않다)</c:if><br>
	<hr/>
	<p>점수 할당 후 비교(학점구하기)? <c:set var="jumsu" value="85"/></p>
	<c:if test="${jumsu >= 90}"/> <c:set var="grade" value="A"/>
	<c:if test="${jumsu >= 80}"/> <c:set  var="grade" value="B"/>
	<c:if test="${jumsu >= 70}"/> <c:set  var="grade" value="C"/>
	<c:if test="${jumsu >= 60}"/> <c:set  var="grade" value="D"/>
	<c:if test="${jumsu < 60}"/> <c:set  var="grade" value="F"/>
	<p>입력한 점수 : ${jumsu} 의 학점 : ${grade}</p>
	<hr/>
	<p>다중조건 비교 (choose ~ when ~ otherwise)</p>
	<c:choose>
		<c:when test="${jumsu >= 90}"><c:set var="grade" value="A"/></c:when>
		<c:when test="${jumsu >= 80}"><c:set var="grade" value="B"/></c:when>
		<c:when test="${jumsu >= 70}"><c:set var="grade" value="C"/></c:when>
		<c:when test="${jumsu >= 60}"><c:set var="grade" value="D"/></c:when>
		<c:otherwise><c:set var="grade" value="F"/></c:otherwise>
	</c:choose>
	<p>입력한 점수 : ${jumsu} 의 학점 : ${grade}</p>
	<hr/>
	<h2>반복문(forEach문)</h2>
	<p>문법1 : < c : forEach var="변수" items="$ { 배열or객체 }"> 수행할 내용</ c : forEach ></p>
	<p>문법2 : < c : forEach var="변수" begin="초기값" end="최종값" step="증감값" varStatus="index"> 수행할 내용</ c : forEach ></p>
	<p>1.반복문 예</p>
	<c:forEach var="no" begin="1" end="3" step="1"> 
		${no}. 안녕<br>
	</c:forEach>	
	<c:forEach var="no" begin="1" end="3" step="1" varStatus="stat"> 
		${no}. 안녕 / st.first가 1이면(true) ${st.first} / st.last가 3이면(true) ${st.last}<br>
		st.index는 시작의 인덱스부터 ${st.index} / st.count는 현재의 idx ${st.count} 
	</c:forEach>	
	<br><br>
<%
	LoginDAO dao = new LoginDAO();
	List<LoginVO> vos = dao.searchLoginList();
	pageContext.setAttribute("vos", vos);
%>
	<c:forEach var="vo" items="${vos}" varStatus="st" begin="2">
		${st.index}.${st.count} vos.get(2).getMid()...아이디 : ${vo.mid}, 비밀번호 : ${vo.pwd}, 이름 : ${vo.name}<br>
	</c:forEach>
	
	<hr/>
	<p>이중 루핑과 짝수홀수(begin:0 step:2(짝수)/begin:1 step:2(홀수)))</p>
	<!-- i=2,4,8,10,12(짝수) ... -->
	<c:forEach var="i" begin="2" end="8" step="2">
		<!-- i=1,2,3,4,5(정수) ... -->
		<c:forEach var="j" begin="1" end="10">
			${i} * ${j} = ${i * j}<br>
		</c:forEach>
	</c:forEach>
	<hr/>
<%
	String hobbys = "TV/영화/수영/음악";
	pageContext.setAttribute("hobbys", hobbys);
%>
	<p>토큰(특정기호값)을 이용한 분리 : forTokens</p>
	<c:forTokens var="hobby" items="hobbys" delims="/" >
		<c:out value="${hobby }"/><br>
	</c:forTokens>
	
<pre style='font-size:12pt'>
<h4>기타 참조사항</h4>
<b>지정한 곳으로 이동? location.href() / response.sendRedirect() /c :redirect</b>
<%--jstl3 <c:redirect url="jstl3.st" /> --%>
<%--naver <c:redirect url="www.naver.com"/>--%>
<b>URL문 : 그림파일이나 외부파일을 불러올 수 있다</b>
<div>그림1 : <img src="${ctxPath}/images/nimo.jpg" width="200px"/></div>
<div>그림2 : <img src="images/nimo.jpg" width="200px"/></div>
<div>그림3 : <c:url var="img1" value="${ctxPath}/images/nimo.jpg" /><img src="${img1}" width="200px" /></div>
<b>import문(include와 같음) : Footer화일 삽입 테스트</b>
 <c:import url="/include/footer.jsp"/>
</pre>

</div>
    <%@ include file="/include/footer.jsp" %>
</body>
</html>