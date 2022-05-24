<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>schedule.jsp</title>
    <%@ include file="/include/bs4.jsp" %>
    <style>
    	#td1, #td8, #td15, #td22, #td29 { color : red }
    	#td7, #td14, #td21, #td28 { color : blue } 
    	.today {
    		font-size : 1.5em;
    		background-color : pink;
    		color : #fff;
    		margin: 0px;
    		padding: 4px;
    	}
    </style>
    <script>
    	'use strict';
    	
		//ready()는 본문을 먼저 읽고 jquery를 실행한다
    	$(document).ready(function() {
    		$("#scheduleInputHidden").hide();
    	});
		
		//일정 등록 보기
		function scheduleInputView() {
			let scheduleInput = '<hr/><div id="scheduleInputForm>"';
			scheduleInput += '<form name="myForm">';
			scheduleInput += '<table class="table bordered">';
			scheduleInput += '<tr><th>일정분류</th><td>';
			scheduleInput += '<div class="form-group">';
			scheduleInput += '<select name="part" class="form-control">';
			scheduleInput += '<option value="모임">모임</option>';
			scheduleInput += '<option value="업무">업무</option>';
			scheduleInput += '<option value="학습">학습</option>';
			scheduleInput += '<option value="여행">여행</option>';
			scheduleInput += '<option value="기타">기타</option>';
			scheduleInput += '</select>';
			scheduleInput += '</div>';
			scheduleInput += '</td></tr>';
			scheduleInput += '<tr><th>내용</th><td>';
			scheduleInput += '<textarea name="content" rows="4" class="form-control"></textarea>';
			scheduleInput += '</td></tr>';
			scheduleInput += '</table>';
			scheduleInput += '<div>';
			scheduleInput += '<input type="button" value="일정등록" onclick="scheduleInputOk()" class="btn btn-secondary">';
			scheduleInput += '</div>';
			scheduleInput += '</form></div>';
			
			$("#scheduleInputView").hide();
			$("#scheduleInputHidden").show();
			$("#demo").slideDown(500);
			$("#demo").html(scheduleInput);
		}
		
		// 일정 등록 닫기
		function scheduleInputHidden() {
			$("#scheduleInputForm").slideUp(500);
			$("#scheduleInputForm").hide();
			$("#scheduleInputHidden").hide();
			$("#scheduleInputView").show();
		}
		
		//일정 등록
		function scheduleInputOk() {
			let part = myForm.part.value;
			let content = myForm.content.value;
			if ("" == content) {
				alert("일정을 입력하세요!");
				myForm.content.focus();
				return false;
			}
			let query =  {
					mid : '${sMid}',
					ymd : '${ymd}',
					part : part,
					content : content
			}
			
			$.ajax({
				type : "post",
				url	 : "${ctxPath}/scheduleInputOk",
				data : query,
				success : function(data) {
					if ('scheduleInputOk' == data) {
						alert('일정이 등록됬습니다');
						location.reload();
					}
					else {
						alert('일정 등록 실패~~');
					}
				},
				error : function() {
					alert('전송 오류~~');
				}
			});
		}
		
		function newWin(idx) {
			let url = "${ctxPath}/scContent.scdl?idx="+idx+"&ymd=${ymd}";
			windows.open(url, "newWin", "width=420px,height=350px");
		}
		
		function checkScheduleUpdate(idx, part, content) {
			let url = "${ctxPath}/scheduleUpdate.scdl?idx="+idx+"&part="+part+"&content="+content;
			windows.open(url, "newWin", "width=420px,height=350px");
		}
		
		function checkScheduleDelete(idx) {
			if ( ! confirm("일정을 삭제하겠습니까?")) return false;

			$.ajax({
				type : "post",
				url  : "${ctxPath}/secheduleDeleteOk";
				data : { idx : idx },
				success : function(res) {
					if ('secheduleDeleteOk' == res) {
						alert('일정이 삭제됬습니다');
						location.reload();
					} else {
						alert('일정삭제 실패~~');
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
    <%@ include file="/include/header_home.jsp" %>
    <%@ include file="/include/nav.jsp" %>
<p><br></p>
<div class="container">
	<h4><font color="blue"><b>${ymd}</b></font>일정 입니다.</h4>
	<p>오늘의 일정은 총 <font color="red"><b>${scheduleCnt}</b></font>건 입니다.</p>
	<hr/>
	<div>
		<input type="button" value="일정등록" onclick="scheduleInputView()" id="scheduleInputView" class="btn btn-info" >
		<input type="button" value="등록창닫기" onclick="scheduleInputHidden()" id="scheduleInputHidden" class="btn btn-info" >
		<input type="button" value="돌아가기" onclick="location.href='${ctxPath}/schedule.scdl?yy=${fn:split(ymd, '-')[0]}&mm=${fn:split(ymd, '-')[1]-1}';" id="scheduleInputView" class="btn btn-info" >
	</div>
	<div id="demo"></div>
	<hr/>
	<c:if test="${scheduleCnt != 0}">
		<table class="table table-hover text-center">
			<tr class="table-dark text-dark">
				<th>번호</th>
				<th>제목</th>
				<th>분류</th>
				<th>비고</th>
			</tr>
			<c:forEach var="vo" items=${vos} varStatus="st">
				<tr>
					<td>${st.count}</td>
					<td><a href="javascript:newWin(${vo.idx})">${fn:substring(vo.content,0,15)}</a></td>
					<td>${vo.part}</td>
					<td>
						<input type="button" value="수정" onclick="checkScheduleUpdate(${vo.idx}, '${vo.part}', '${vo.content}')" class="btn btn-secondary">
						<input type="button" value="삭제" onclick="checkScheduleDelete(${vo.idx})" class="btn btn-secondary">
					</td>
				</tr>
			</c:forEach>
			<tr><td colspan="3" class="p-0"></td></tr>
		</table>
	</c:if>
</div>
    <%@ include file="/include/footer.jsp" %>
</body>
</html>