<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ajax1.jsp</title>
    <%@ include file="/include/bs4.jsp" %>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>	
    <script>
    	'use strict';
    	function idCheck() {
    		//let mid = document.getElementById("mid").value;//html,jsp
    		//let mid = '${mid}';//jstl(모든 request parameter 문자는 default로 공백처리됨)
    		let mid = $("#mid").val();//jquery(ajax framework)
    		if (''==mid || ''==mid.trim()) {
    			alert('아이디를 입력하세요.');
    			$("mid").focus();
    			return false;
    		}
    		
    		let params = {
    				mid: mid,
    				mid2: '',
    				testMap: null,
    		}
    		
    		//jquery함수
			//$(document).ready(function() {
			//});
    		
    		//aJax함수
			$.ajax({
				type:			"get", //전송방식(get,post,enctype(화일전송용))
				url:			"${ctxPath}/ajaxIdSearch", //비동기식aJax는 확장자패턴은 편법으로 사용되며, url패턴으로 사용함
				data:			params,
				contextType:	"application/json",
				//charset:		"utf-8", //xml에서 설정했으면 생략
				success:		function(name) { //response로 앞에서 준 파라미터는 function함수의 파라미터로 받는다
					alert("서버 비동기 요청,응답 성공");
					alert("response로 받은 parameter 중 name : " + name);
				},
				error:			function() {
					alert("서버 요청 실패~~")
				}
			});
    	}
    </script>
    <style></style>
</head>
<body>
    <%@ include file="/include/header_home.jsp" %>
    <%@ include file="/include/nav.jsp" %>
<p><br></p>
<div class="container">
	<h2>AJax연습</h2>
	<form name="searchForm">
		아이디 : <input type="text" name="mid" id="mid"/>&nbsp;
		<input type="button" value="아이디검색" onclick="idCheck()"/>
	</form>
</div>
    <%@ include file="/include/footer.jsp" %>
</body>
</html>