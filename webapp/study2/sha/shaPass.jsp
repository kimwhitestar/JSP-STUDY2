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
    	function passCheck() {
    		let pwd = document.getElementById("pwd").value;
     		console.log("pwd = "+ pwd);
    		if('' == pwd) {
    			alert('비밀번호를 입력하세요');
    			document.getElementById("pwd").focus();
    		}
    		else {
    			alert('페이지이동');
    			location.href='${ctxPath}/shaPassOk.st?pwd='+pwd;
    		}
    	}
    </script>
</head>
<body>
    <%@ include file="/include/header_home.jsp" %>
    <%@ include file="/include/nav.jsp" %>
<p><br></p>
<div class="container">
	<h2>SHA(Secure Hash Algorithm)</h2>
	<pre>
		SHA는 단방향식 암호화기법으로, 암호학적 해시함수들의 모임이다.
		일반적으로 복호화할 수 없도록 만든 알고리즘을 SHA-2(256bit암호화)라고 한다.
	</pre>
	숫자나 문자를 입력하시오. <input type="text" id="pwd" name="pwd" value="1234" />
	<input type="button" value="암호화하기" onclick="passCheck()"/>
	<div id="demo">암호화된 비밀번호 : <font color="red">${shaPwd}</font></div>
</div>
    <%@ include file="/include/footer.jsp" %>
</body>
</html>