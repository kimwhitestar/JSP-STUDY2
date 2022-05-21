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
    	let cnt = 1;
    	
    	function textBoxAppend() {
    		cnt++;
    		let textbox = '';
    		textbox += '	<div id="tbox"'+cnt+' class="form-group">';
    		textbox += '		<input type="text" name="product" id="product"'+cnt+' class="form-control" style="width:85%;float:left;" />';
    		textbox += '		<input type="button" value="삭제" onclick="deleteBox('+cnt+')" class="btn btn-danger form-control ml-2" style="width:10%" />';
    		textbox += '	</div>';
    		$("#textboxInsert").append(textbox);
    	}
    	function deleteBox(cnt) {
    		$("#tbox"+cnt).remove();
    	}
    	function textView() {
    		let str = "";
    		for (let i=1; i<=cnt; i++) {
    			if(null != $("#product"+1).val()) {
    				str += $("#product"+1).val();
    			}
    		}
    		$("#demo").html(str);
    	}
    </script>
</head>
<body>
    <%@ include file="/include/header_home.jsp" %>
    <%@ include file="/include/nav.jsp" %>
<p><br></p>
<div class="container">
	<h2>동적폼 연습</h2>
	<p>DIV태그를 활용한 동적 테스트박스 추가/삭제</p>
	<hr/>
	<div class="form-group">
		<input type="button" value="택스트박스추가" onclick="textBoxAppend()" class="btn btn-info btn-sm form-control"/>
		<input type="text" name="product1" id="product1" class="form-control" autofocus />
	</div>
	<div id="textboxInsert" class="form-group">
	</div>
	<hr/>
	<div id="" class="form-group">
		<input type="button" value="출력" onclick="textView()" class="btn btn-secondary form-control"/>
	</div>
	<hr/>
	<div id="demo"></div>
</div>
    <%@ include file="/include/footer.jsp" %>
</body>
</html>