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
    </script>
</head>
<body>
    <%@ include file="/include/header_home.jsp" %>
    <%@ include file="/include/nav.jsp" %>
<p><br></p>
<div class="container">
	<h2>달력...</h2>
	<div class="text-center">
		<button class="btn btn-secondary btn-sm" onclick="location.href='${ctxPath}/schedule.scdl?yy=${yy-1}&mm=${mm}';" title="이전년도">◁</button>
		<button class="btn btn-secondary btn-sm" onclick="location.href='${ctxPath}/schedule.scdl?yy=${yy}&mm=${mm-1}';" title="이전월">◀</button>
		&nbsp; <font size="5">${yy}년 ${mm+1}월</font>&nbsp;
		<button class="btn btn-secondary btn-sm" onclick="location.href='${ctxPath}/schedule.scdl?yy=${yy}&mm=${mm+1}';" title="다음월">▶</button>
		<button class="btn btn-secondary btn-sm" onclick="location.href='${ctxPath}/schedule.scdl?yy=${yy+1}&mm=${mm}';" title="다음년도">▷</button>
		&nbsp;&nbsp;
		<button class="btn btn-secondary btn-sm" onclick="location.href='${ctxPath}/schedule.scdl?';" title="오늘날짜"><i class="fa fa-home"></i></button>
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
				<c:set var="cnt" value="1" />
				<c:forEach var="prevDay" begin="${prevLastDay - (startWeek -2) }" end="${startWeek - 1}" varStatus="st">
					<td style="color:#ccc;font-size:0.6em">${prevYear}-${prevMonth}-${prevDay}</td>
					<c:set var="cnt" value="${cnt + 1}" />
				</c:forEach>
				
				<!-- 날짜 출력 -->
				<c:forEach begin="1" end="${lastDay}" varStatus="st">
					<c:set var="todaySW" value="${toYear==yy && toMonth==mm && toDay==st.count ? 1 : 0}" />
					<td id="td${cnt}" ${todaySW==1 ? 'class=today' : ''} style="font-size:0.9em;height:50px" valign="top">
						<c:set var="ymd" value="${yy}-${mm+1}-${st.count}" />
						<a href="scMenu.scdl?ymd=${ymd}">
							${st.count}<br>
							<!--  해당날짜에 일정이 있으면 part 출력 -->
							<c:set var="tempPart" value="" />
							<c:set var="tempCnt" value="0" />
							<c:set var="tempSw" value="0" />
							
							<c:forEach var="vo" items="${vos}">
								<c:if test="${fn:substring(vo.sDate, 8, 10) == st.count}"><!-- 2022-05-25 hh:mm:ss.n -->
									<c:if test="${vo.part != tempPart}">
										<c:if test="${0 != tempSw}">
											- ${tempPart}(${tempCnt})건<br>
											<c:set var="tempCnt" value="0" />
										</c:if>
										<c:set var="tempPart" value="${vo.part}" />
									</c:if>
									<c:set var="tempSw" value="1" />
									<c:set var="tempCnt" value="${tempCnt + 1}" />
								</c:if>
							</c:forEach>
							<c:if test="${tempCnt != 0}">- ${tempPart}(${tempCnt})건</c:if>
						</a>
					</td>
					<!-- 주간 줄바꿈 -->
					<c:if test="${cnt % 7 == 0}"><tr></tr></c:if>
					<c:set var="cnt" value="${cnt + 1}" />
				</c:forEach>
				
				<!-- 마지막일 이후 공백처리 -->
				<c:forEach begin="${nextStartWeek}" end="7" varStatus="nextDay">
					<td style="color:#ccc;font-size:0.6em">${nextYear}-${nextMonth}-${st.count}</td>
					<c:set var="cnt" value="${cnt + 1}" />
				</c:forEach>
			</tr>
		</table>
	</div>
</div>
    <%@ include file="/include/footer.jsp" %>
</body>
</html>