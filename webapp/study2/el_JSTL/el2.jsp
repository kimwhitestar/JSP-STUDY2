<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
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
    	
    </script>
</head>
<body>
    <%@ include file="/include/header_home.jsp" %>
    <%@ include file="/include/nav.jsp" %>
<p><br></p>
<div class="container">
	<pre>
		<h2>Form값 전달받아 출력</h2>
		아이디 : ${param.mid}
		비밀번호 : ${param.pwd}
		성명 : ${param.name}
		idx : ${param.idx}
		취미 : ${param.hobby}
		- 앞 문장중 '취미'는 같은 변수명 사용해서 여러개 넘기는 배열처리
		- 만약 배열 값을 직접 받아 출력하고자 한다면? paramValues를 사용
		hobby[0] : ${paramValues.hobby[0]}
		hobby[1] : ${paramValues.hobby[1]}
		hobby[2] : ${paramValues.hobby[2]}
		<hr/>
	<%
		int[] num1 = new int[5];
		for (int i=0; i<num1.length; i++) {
			num1[i] = i * 10;
		}
		int[] num2 = {10,2,3,4,50};
		
		pageContext.setAttribute("num1", num1);
		pageContext.setAttribute("num2", num2);
	%>
		<h2>배열에 저장된 값 출력</h2>
		num1[0] : ${num1[0]}
		num1[4] : ${num1[4]}
		num1[5] : ${num1[5]} - Empty출력(ArrayIndexBoundsException발생없음)
		<h2>관계/논리 연산자 출력</h2>
		num1[0] = ${num1[0]} / num2[0] = ${num2[p]}
		num1[0] == num2[0] : ${num1[0] == num2[0]}
		num1[0] eq num2[0] : ${num1[0] eq num2[0]}
		num1[0] != num2[0] : ${num1[0] != num2[0]}
		num1[0] ne num2[0] : ${num1[0] ne num2[0]}
		num1[0] > num2[0] : ${num1[0] > num2[0]}
		num1[0] gt num2[0] : ${num1[0] gt num2[0]}
		num1[0] >= num2[0] : ${num1[0] >= num2[0]}
		num1[0] ge num2[0] : ${num1[0] ge num2[0]}
		num1[0] < num2[0] : ${num1[0] < num2[0]}
		num1[0] lt num2[0] : ${num1[0] lt num2[0]}
		num1[0] <= num2[0] : ${num1[0] <= num2[0]}
		num1[0] le num2[0] : ${num1[0] le num2[0]}
		<hr/>
	<%
		ArrayList<String> arrVos = new ArrayList<>();
		arrVos.add("홍길동");
		arrVos.add("김말숙");
		arrVos.add("이기자");
		arrVos.add("오하늘");
		arrVos.add("똥구멍");
		
		pageContext.setAttribute("arrVos", arrVos);
	%>
		<h2>EL표기 객체 출력(ArrayList)</h2>
		arrVos[0] : ${arrVos[0]}
	<%
		HashMap<String, String> mapVos = new HashMap<>();
		mapVos.put("성명", "홍길순");
		mapVos.put("나이", "25");
		mapVos.put("요일", "월요일");
	%>
		<h2>EL표기 객체 출력(Map)</h2>
		mapVos.get("성명") : ${mapVos["성명"]}
		mapVos.get("나이") : ${mapVos["나이"]}
		mapVos.get("요일") : ${mapVos["요일"]}
		<hr/>
	<%
		pageContext.setAttribute("var1", "문자");
		pageContext.setAttribute("var2", "");
		pageContext.setAttribute("var3", null);
	%>
		<h2>Null값 처리</h2>
		var1 : ${var1}
		var2 : ${var2}
		var3 : ${var3} - Empty출력(NullPointerException발생없음)
		== 비교 : ${var1 == "" } false
		== 비교 : ${var2 == "" } true
		== 비교 : ${var3 == "" } false - Empty출력(NullPointerException발생없음)
		null 비교 : ${var1 == null } false
		null 비교 : ${var2 == null } false
		null 비교 : ${var3 == null } true - Empty출력(NullPointerException발생없음)
		연산자 : empty - EL에서는 null과 ""(공백)을 동시에 비교할 수 있다
		var1 == null || var1 == "" ===> ${empty var1}
		var2 == null || var2 == "" ===> ${empty var2} 공백문자 OK
		var3 == null || var3 == "" ===> ${empty var3} null OK
		3항연산자 ${empty var3 ? "OK" : var3} 
		
		
	</pre>
	<p></p>
	<p><a href="el1.st" class="btn btn-secondary">돌아가기</a></p>
</div>
    <%@ include file="/include/footer.jsp" %>
</body>
</html>