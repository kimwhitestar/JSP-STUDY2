<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>jstl3.jsp</title>
    <%@ include file="/include/bs4.jsp" %>
    <style></style>
    <script>
    	'use strict';
    	
    </script>
</head>
<body>
    <%@ include file="/include/header_home.jsp" %>
    <%@ include file="/include/nav.jsp" %>
<p><br></p>
<div class="container">
	<h2>JSTL ( Format Library )</h2>
	<hr/>
<%
	int won = 1234567;
	pageContext.setAttribute("won", won);

				// 0123456789012345678901234
	String atom = "Welcome to My Homepage!!!";
	pageContext.setAttribute("atom", atom);
%>
<p>형식문자열을 지정할 때 사용(쉼표, 화폐단위, 백분율...)</p>
<p>사용법 : < fmt : 명령어 value = " $ {값} " /></p>
<hr/>
<h3>국가별설정(Local)</h3>
톰캣 서버의 디폴트 로케일 : <%=response.getLocale() %>
톰캣 서버의 로케일을 미국식 로케일로 수정 : < fmt : setLocale value="en_US" />
<fmt:setLocale value="en_US"/>
<fmt:formatNumber value="${won }" type="currency"/> 
<hr/>
<h3>숫자 표현</h3>
won 변수의 값 : <%=won %> / ${won }
<pre style='font-size:12pt'>
<h5>formatNumber 형식을 지정한 출력</h5>
1. 천단위 콤마 : <fmt:formatNumber value="${won}" />
2. 화폐단위 : <fmt:formatNumber value="${won }" type="currency"/>
2-2. 미국 화폐단위 : <fmt:formatNumber value="${won }" type="currency" currencyCode="USD"/>
<c:set var="su" value="123456.789"/>
3. 소수이하 두자리 출력(반올림) : <fmt:formatNumber value="${su }" /> / <fmt:formatNumber value="${su }" pattern=".00" />
3-2. 정수 출력(소수이하 반올림) : <fmt:formatNumber value="${su }" /> / <fmt:formatNumber value="${su }" pattern="0" />
3-3. 정수, 콤마 출력(소수이하 반올림) : <fmt:formatNumber value="${su }" /> / <fmt:formatNumber value="${su }" pattern="#,##0" />
3-4. 정수, 콤마 출력(소수이하 버림) : <fmt:formatNumber value="${su }" /> / <fmt:parseNumber value="${su }" integerOnly="true" />
<c:set var="su1" value="55"/>
<c:set var="su2" value="100"/>
4. 백분율 : <fmt:formatNumber value="${su1/su2}"/> / <fmt:formatNumber value="${su1/su2}" type="percent"/>
<hr/>
<h4>날짜형식 : formatDate()</h4>
자바형식의 날짜를 jstl변수에 저장하기 :  <c:set var="now" value="<%=new java.util.Date() %>"/>
오늘 날짜 : ${now} / 
<fmt:formatDate value="${now }" />
<fmt:formatDate value="${now }" pattern="yyyy.MM.dd"/>
<fmt:formatDate value="${now }" pattern="yyyy-MM-dd"/>
<fmt:formatDate value="${now }" pattern="hh : mm : ss"/>
<fmt:formatDate value="${now }" pattern="yyyy-MM-dd hh:mm:ss"/>
<fmt:formatDate value="${now }" pattern="yyyy년 MM월 dd일 hh시 mm분 ss초"/>
</pre>
</div>
    <%@ include file="/include/footer.jsp" %>
</body>
</html>