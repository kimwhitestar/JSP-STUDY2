<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>calendar.jsp</title>
    <%@ include file="/include/bs4.jsp" %>
    <style>
    	#td1, #td8, #td15, #td22, #td29 { color : red }
    	#td7, #td14, #td21, #td28 { color : blue } 
    	.today {
    		font-size : 1.5em;
    		background-color : pink;
    		color : #fff;
    	}
    </style>
    <script>
    	'use strict';
    </script>
</head>
<body>
    <%@ include file="/include/header_home.jsp" %>
    <%@ include file="/include/nav.jsp" %>
<p><br></p>
<div class="container">
	<h2>달력...</h2>
	<div class="text-center">
		<button class="btn btn-secondary btn-sm" onclick="location.href='${ctxPath}/calendar.cld?yy=${yy-1}&mm=${mm}';" title="이전년도">◁</button>
		<button class="btn btn-secondary btn-sm" onclick="location.href='${ctxPath}/calendar.cld?yy=${yy}&mm=${mm-1}';" title="이전월">◀</button>
		&nbsp; <font size="5">${yy}년 ${mm+1}월</font>&nbsp;
		<button class="btn btn-secondary btn-sm" onclick="location.href='${ctxPath}/calendar.cld?yy=${yy}&mm=${mm+1}';" title="다음월">▶</button>
		<button class="btn btn-secondary btn-sm" onclick="location.href='${ctxPath}/calendar.cld?yy=${yy+1}&mm=${mm}';" title="다음년도">▷</button>
		&nbsp;&nbsp;
		<button class="btn btn-secondary btn-sm" onclick="location.href='${ctxPath}/calendar.cld?';" title="오늘날짜"><i class="fa fa-home"></i></button>
	</div>
	<br>
	<div>
		<table class="table table-bordered">
			<tr class="text-center" style="background-color:#ddd">
				<th style="width:13%; color:red; vertical-aligh:middle;">일</th>
				<th style="width:13%;vertical-aligh:middle;">월</th>
				<th style="width:13%;vertical-aligh:middle;">화</th>
				<th style="width:13%;vertical-aligh:middle;">수</th>
				<th style="width:13%;vertical-aligh:middle;">목</th>
				<th style="width:13%;vertical-aligh:middle;">금</th>
				<th style="width:13%; color:blue;vertical-aligh:middle;">토</th>
			</tr>
			<tr style="vertical-align:top">
				<!-- 시작일 이전 공백처리 -->
				<c:set var="gap" value="1" />
				<c:forEach begin="1" end="${startWeek - 1}" varStatus="st">
					<td>&nbsp;</td>
					<c:set var="gap" value="${gap + 1}" />
				</c:forEach>
				
				<!-- 날짜 출력 -->
				<c:set var="cnt" value="1" />
				<c:forEach begin="1" end="${lastDay}" varStatus="st">
					<c:set var="todaySW" value="${toYear==yy && toMonth==mm && toDay==st.count ? 1 : 0}" />
					<td id="td${cnt}" ${todaySW==1 ? 'class=today' : ''} style="font-size:0.9em" valign="top">
						${st.count}
					</td>
					<!-- 주간 줄바꿈 -->
					<c:if test="gap % 7 == 0"><tr></tr></c:if>
					<c:set var="cnt" value="${cnt + 1}" />
					<c:set var="gap" value="${gap + 1}" />
				</c:forEach>
				
				<!-- 마지막일 이후 공백처리 -->
				<c:forEach begin="${gap}" end="42">
					<td>&nbsp;</td>
					<c:if test="gap % 7 == 0"><tr></tr></c:if>
					<c:set var="gap" test="${gap + 1}" />
				</c:forEach>
			</tr>
		</table>
	</div>
</div>
    <%@ include file="/include/footer.jsp" %>
</body>
</html>