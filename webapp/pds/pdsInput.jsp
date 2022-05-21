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
    	
    	function fileBoxAppend() {
    		cnt++;
    		let filebox = '';
    		filebox += '	<div id="filebox"'+cnt+' class="form-group">';
    		filebox += '		<input type="file" name="fName" id="fName"'+cnt+' class="form-control-file border" style="width:85%;float:left;" />';
    		filebox += '		<input type="button" value="삭제" onclick="deleteBox('+cnt+')" class="btn btn-danger form-control ml-2" style="width:10%" />';
    		filebox += '	</div>';
    		$("#fileInsert").append(filebox);
    	}
    	function deleteBox(cnt) {
    		$("#filebox"+cnt).remove();
    	}
    	function checkFile() {
			let fNme = $("#fName1").val();
			let maxSize = 1024 * 1024 * 10;
			let title = $("#title").val();
			let pwd = $("#pwd").val();
			
			if ("" == fName.trim()) {
				alert('업로드할 파일명을 선택하세요');
				$("#title").focus();
				return false;
			}
			if("" == title.trim()) {
				alert('파일 제목을 입력하세요')
				$("#pwd").focus();
				return false;
			}
			if("" == pwd.trim()) {
				alert('비밀번호를 입력하세요')
				return false;
			}
			let fileSize = 0, ext = '', uExt = '';
			for (let i=1; i<=cnt; i++) {
				fName = $("#fName" + 1).val();
				if ('' != fName) {
					ext = fName.substring(fName.lastIndexOf(".")+1);
					uExt = ext.toUpperCase();
					fileSize += $("#fName" + 1).files[0].size;

		    		if ("JPG" != uExt && "JPEG" != uExt && "GIF" != uExt 
	       				&& "HWP" != uExt && "PDF" != uExt && "DOC" != uExt 
	       				&& "PPT" != uExt && "PPTX" != uExt 
	       				&& "ZIP" != uExt ) {
	    				alert('업로드 가능한 파일이 아닙니다');
	        			return false;
	        		}
				}
			}
    		if (fileSize > maxSize) {
    			alert('업로드할 파일의 최대용량은 20MB입니다');
    		}
    		else {
    			myForm.fileSize.value = fileSize;
    			myForm.submit();
    		}			
    	}
    </script>
</head>
<body>
    <%@ include file="/include/header_home.jsp" %>
    <%@ include file="/include/nav.jsp" %>
<p><br></p>
<div class="container">
	<form name="myForm" method="post" action="${ctxPath}/pdsInputOk.pds" enctype="multipart/form-data">
		<h2>자 료 올 리 기</h2>	
		<div class="form-group">
			<input type="button" value="파일추가" onclick="fileAppend()" class="btn btn-info btn-sm mb-1"/>
			<input type="file" name="fName1" id="fName1" class="form-control-file border" accept=".jpg,.gif,.png,.zip,.ppt,.pptx,.hwp"/>
		</div>
		<div class="form-group" id="fileInsert"></div>
		<div class="form-group">올린이 : ${sNickName}</div>
		<div class="form-group">
			<label for="title">제목 : </label>
			<input type="text" name="title" id="title" placeholder="자료의 제목을 입력하세요" class="form-control" required>
		</div>
		<div class="form-group">
			<label for="content">내용 : </label>
			<textarea rows="4" name="content" id="content" class="form-control">		
		</div>
		<div class="form-group">
			<label for="part">분류 : </label>
			<select name="part" id="part" class="form-control">
				<option value="학습">학습</option>
				<option value="여행" selected>여행</option>				
				<option value="음식">음식</option>				
				<option value="기타">기타</option>				
			</select>	
		</div>
		<div class="form-group"><label for="openSW">공개여부 : </label>&nbsp;
			<input type="radio" name="openSW1" id="openSW1" value="공개" checked />공개 &nbsp;
			<input type="radio" name="openSW2" id="openSW2" value="비공개" checked />비공개 
		</div>
		<div class="form-group">
			<label for="pwd">비밀번호 : </label>
			<input type="password" name="pwd" id="pwd" class="form-control">
		</div>
		
		<div class="form-group text-center">
			<input type="button" value="자료올리기" onclick="checkForm()" class="btn btn-primary">&nbsp;&nbsp;
			<input type="reset" value="다시쓰기" class="btn btn-info">&nbsp;&nbsp;
			<input type="button" value="돌아가기" onclick="location.href='${ctxPath}/pdsList.pds'" class="btn btn-secondary">
		</div>
		<input type="hidden" name="fileSize" />
	</form>
</div>
    <%@ include file="/include/footer.jsp" %>
</body>
</html>