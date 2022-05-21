<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
    		let fName = $("#file").val();
    		let ext = fName.substring(fName.lastIndexOf(".") + 1); //pdsTest/atom.jpg
			let uExt = ext.toUpperCase();
    		let maxSize = 1024 * 1024 * 10;
    		fileForm.submit();
    		
    		if ('' == fName.trim()) {
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
    	function deleteFile() {
    		if (!confirm('파일을 삭제하겠습니까?')) return;
			$.ajax({
				type	: "post",
				url		: '{ctxPath}/fileDelete',
				data	: {file : file},
				success : function(result) {
					if ("fileDeleteOk" == result ) {
						alert('삭제됬습니다');
						location.reload();
					}
					else {
						alert('삭제 실패');
					}
				}
			});
    	}
    </script>
</head>
<body>
    <%@ include file="/include/header_home.jsp" %>
    <%@ include file="/include/nav.jsp" %>
<p><br></p>
<div class="container">
	<h2>파일 다운로드 테스트 1(싱글파일처리)</h2>
	<p>파일시스템에 저장되어 있는 파일 리스트</p>
	<p>${ctxPath}/data/pdsTest/*.*</p>
	<hr/>
	<!-- 인코딩 enctype지정 binary코드로 바꿔서 업로드 -->
	<table class="table table-hover text-center">
		<tr class="table-dark text-dark">
			<th>번호</th>
			<th>파일명</th>
			<th>파일형식</th>
			<th>삭제</th>
		</tr>
		<c:forEach var="file" items="${files}" varStatus="st">
			<tr>
				<td>${st.count}</td>
				<td><a href="${ctxPath}/data/pdsTest/${file}" download="${file}">${file}</a></td>
				<td>
					<c:set var="fNameArr" value="${fn:split(file, '.')}" />
					<c:set var="extName" value="${fn:toLowerCase(fNameArr[fn:length(fNameArr)-1])}" />
					<c:if test="${extName == 'jpg' || extName == 'gif' || extname == 'png'}">
						<img src="${ctxPath}/data/pdsTest/${file}" width="150px" />
					</c:if>
					<c:if test="${extName == 'zip'}">압축파일</c:if>
					<c:if test="${extName == 'ppt' || extName == 'pptx'}">파워포인트파일 ${file}</c:if>
					<c:if test="${extName != 'jpg' && extName == 'jpeg' && extName == 'gif'}">그림파일</c:if>
				</td>
				<td>
					<a href="${ctxPath}/fileDownload?file=${file}" class="btn btn-success btn-sm">download</a>
					<a href="${ctxPath}/fileDelete?file=${file}" class="btn btn-success btn-sm">delete</a>
					<a href="javascript:deleteFile('${file}')" class="btn btn-success btn-sm">ajax file delete</a>
				</td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="4" class="p-0"></td>
		</tr>
	</table>
	<hr/>
	<div class="row">
		<div class="col "><a href="upload1.st" class="btn btn-primary form-control">싱글파일 업로드폼으로 돌아가기</a></div>
		<div class="col"><a href="upload2.st" class="btn btn-primary form-control">멀티파일 업로드폼으로 돌아가기</a></div>
		<div class="col"><a href="upload3.st" class="btn btn-primary form-control">멀티파일처리-동적폼으로 돌아가기</a></div>
		<div class="col"><a href="upload4.st" class="btn btn-primary form-control">멀티파일처리-다중파일선택으로 돌아가기</a></div>
	</div>
	<form name="fileForm" method="post" action="upload1Ok.st" enctype="multipart/form-data">
		<div class="form-group">파일명 : 
			<input type="file" name="fname" id="file" class="form-control-file border" />
			<input type="button" value="전송" onclick="checkFile()" class="btn btn-primary form-control" />
		</div>
	</form>
</div>
    <%@ include file="/include/footer.jsp" %>
</body>
</html>