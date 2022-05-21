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
    	function checkFile() {
    		let fName1 = $("#file1").val();
    		let fName2 = $("#file2").val();
    		let fName3 = $("#file3").val();
    		let ext = fName1.substring(fName1.lastIndexOf(".") + 1); //pdsTest/atom.jpg
			let uExt = ext.toUpperCase();
    		let maxSize = 1024 * 1024 * 10;
    		fileForm.submit();
    		
    		if ('' == fName1.trim()) {
    			alert('업로드할 파일을 선택하세요');
    			return false;
    		}
    		let fileSize = $("#file").files[0].size;
    		if ("JPG" != uExt && "JPEG" != uExt && "GIF" != uExt 
   				&& "HWP" != uExt && "PDF" != uExt && "DOC" != uExt 
   				&& "PPT" != uExt && "PPTX" != uExt 
   				&& "ZIP" != uExt ) {
    			return false;
    		}
    		else if (fileSize > maxSize) {
    			alert('업로드할 파일은 최대 10MB입니다');
    		}
    		else {
    			fileForm.submit();
    		}
    	}
    </script>
</head>
<body>
    <%@ include file="/include/header_home.jsp" %>
    <%@ include file="/include/nav.jsp" %>
<p><br></p>
<div class="container">
	<h2>파일 업로드 테스트 1(멀티파일처리)</h2>
	<p>cos.jar서블릿라이브러리를 이용한 파일 업로드</p>
	<hr/>
	<!-- 인코딩 enctype지정 binary코드로 바꿔서 업로드 -->
	<form name="fileForm" method="post" action="upload1Ok.st" enctype="multipart/form-data">
		<div class="form-group">파일명 : 
			<input type="file" name="fname1" id="file1" class="form-control-file border" />
			<input type="file" name="fname2" id="file2" class="form-control-file border" />
			<input type="file" name="fname3" id="file3" class="form-control-file border" />
			<input type="button" value="전송" onclick="checkFile()" class="btn btn-primary form-control" />
		</div>
		<hr/><br>
		<p><a href="download1.st" class="btn btn-info form-control">다운로드 폼으로 이동</a></p>
	</form>
</div>
    <%@ include file="/include/footer.jsp" %>
</body>
</html>