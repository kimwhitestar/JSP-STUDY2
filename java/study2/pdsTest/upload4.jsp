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
    	//let cnt = 1;
    	
/*     	function fileBoxAppend() {
    		cnt++;
    		let filebox = '';
    		filebox += '	<div id="filebox"'+cnt+' class="form-group">';
    		filebox += '		<input type="file" name="fName" id="fName"'+cnt+' class="form-control" style="width:85%;float:left;" />';
    		filebox += '		<input type="button" value="삭제" onclick="deleteBox('+cnt+')" class="btn btn-danger form-control ml-2" style="width:10%" />';
    		filebox += '	</div>';
    		$("#fileboxInsert").append(filebox);
    	}
    	function deleteBox(cnt) {
    		$("#filebox"+cnt).remove();
    	}
 */    	function checkFile() {
			let fNme = $("#fName1").val();
			let maxSize = 1024 * 1024 * 10;
			
			if ("" == fName.trim()) {
				alert('업로드할 파일명을 선택하세요');
				return false;
			}
			
			let fileSize = 0, ext = '', uExt = '';
			
/* 			for (let i=1; i<=cnt; i++) {
				fName = $("#fName" + 1).val();
				if ('' != fName) {
					ext = fName.substring(fName.lastIndexOf(".")+1);
					uExt = ext.toUpperCase();
					fileSize += $("#fName" + 1).files[0].size;

		    		if ("JPG" != uExt && "JPEG" != uExt && "GIF" != uExt 
		       				&& "HWP" != uExt && "PDF" != uExt && "DOC" != uExt 
		       				&& "PPT" != uExt && "PPTX" != uExt 
		       				&& "ZIP" != uExt ) {
		        			return false;
	        		}
				}
			}
 */	

 			let fileLen = $("#fName").files.length();
 			let fileSize = 0;
			for (let i=1; i<=cnt; i++) {
				fName = $("#fName").file[i].name;
				ext = fName.substring(fName.lastIndexOf(".")+1);
				uExt = ext.toUpperCase();
				fileSize += $("#fName").files[i].size;
	
	    		if ("JPG" != uExt && "JPEG" != uExt && "GIF" != uExt 
	       				&& "HWP" != uExt && "PDF" != uExt && "DOC" != uExt 
	       				&& "PPT" != uExt && "PPTX" != uExt 
	       				&& "ZIP" != uExt ) {
	        			return false;
	    		}
			}
 
    		if (fileSize > maxSize) {
    			alert('업로드할 파일의 최대용량은 20MB입니다');
    		}
			
    	}
    </script></head>
<body>
    <%@ include file="/include/header_home.jsp" %>
    <%@ include file="/include/nav.jsp" %>
<p><br></p>
<div class="container">
	<h2>파일 업로드 테스트 4(멀티파일처리-다중파일선택)</h2>
	<p>cos라이브러리를 이용한 파일 업로드</p>
	<p>여러개의 파일을 선택할 경우는 'Ctrl+클릭/Shift+클릭'</p>
	<hr/>
	<div class="form-group">
	<form name="myForm" method="post" action="${ctxPath}/upload2Ok.st">
		<input type="file" name="fName" id="fName" class="form-control-file border" autofocus multiple />
	</div>
	<hr/>
	<div class="form-group">
		<input type="button" value="전송" onclick="checkFile()" class="btn btn-secondary form-control mb-3"/>
		<input type="button" value="다운로드 폼으로" onclick="location.href='${ctxPath}/download1.st'" class="btn btn-info form-control"/>
	</div>
	<input type="hidden" name="uploadFlag" value="4" />
	</form>
</div>    <%@ include file="/include/footer.jsp" %>
</body>
</html>