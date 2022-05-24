<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<c:set var="newLine" value="\n" scope="page"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <%@ include file="/include/bs4.jsp" %>
    <style>
    	th {background-color: #ccc}
    </style>
    <script>
    	'use strict';
		//일정 등록
    	function checkScheduleUpdate() {
			if ("" == $("#content").val()) {
				alert("일정을 입력하세요!");
				$("#content").focus();
				return false;
			}
			let query =  {
					mid : '${vo.idx}',
					part : $("#part").val(),
					content : $("#content").val()
			}
			
			$.ajax({
				type : "post",
				url	 : "${ctxPath}/scheduleUpdateOk",
				data : query,
				success : function(data) {
					if ('scheduleUpdateOk' == data) {
						alert('일정이 수정됬습니다');
						location.reload();
					}
					else {
						alert('일정 수정 실패~~');
					}
				},
				error : function() {
					alert('전송 오류~~');
				}
			});
    	}
    </script>
</head>
<body>
<p><br></p>
<div class="container">
	<h2>일정 내역보기(${vo.ymd})</h2>
	<br>
	<table class="table table-bordered">
		<tr>
			<th>작성자</th>
			<td>${vo.mid}</td>
		</tr>
		<tr>
			<th>분류</th>
			<td>${vo.part}
				<select id="part" name="part" class="form-control">
					<option value="모임" ${vo.part == '모임' ? 'selected' : '' }>모임</option>
					<option value="업무" ${vo.part == '업무' ? 'selected' : '' }>업무</option>
					<option value="학습" ${vo.part == '학습' ? 'selected' : '' }>학습</option>
					<option value="여행" ${vo.part == '여행' ? 'selected' : '' }>여행</option>
					<option value="기타" ${vo.part == '기타' ? 'selected' : '' }>기타</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea row="4" id="content" name="content" class="form-control">${vo.content}</textarea></td>
		</tr>
		<tr>
			<td colspan="2" class="text-center">
				<input type="button" value="창닫기" onclick="window.close()" class="btn btn-success" />
				<input type="button" value="수정" onclick="checkScheduleUpdate()" class="btn btn-success" />
			</td>
		</tr>
	</table>
</div>
</body>
</html>