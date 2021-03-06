<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<c:set var="LF" value="\n" scope="page" />
<c:set var="BR" value="<br>" scope="page" />
<c:set var="First" value="<<" scope="page" />
<c:set var="Last" value=">>" scope="page" />
<c:set var="Prev" value="◁" scope="page" />
<c:set var="Next" value="▷" scope="page" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ajax1.jsp</title>
    <%@ include file="/include/bs4.jsp" %>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>	
    <script>
    	'use strict';
    	function idCheck1() {
    		//let mid = document.getElementById("mid").value;//html,jsp
    		//let mid = '${mid}';//jstl(모든 request parameter 문자는 default로 공백처리됨)
    		let mid = $("#mid").val();//jquery(ajax framework)
    		if (''==mid || ''==mid.trim()) {
    			alert('아이디를 입력하세요.');
    			$("#mid").focus();
    			return false;
    		}
    		
    		let arr = [];
    		arr.push('a');
    		arr.push('b');
    		arr.push('c');
    		alert('arr.length='+arr.length);
    		
    		let params = {
    				mid: mid,
    				mid2: '',
    				testArr: arr,//배열로 넘기고 서블릿에서 getparametervalues배열로 받으면null처리된다
			};
    		
    		//jquery함수
			//$(document).ready(function() {
			//});
    		
    		//aJax함수
			$.ajax({
				type:			"get", //전송방식(get,post,enctype(화일전송용))
				url:			"${ctxPath}/ajaxIdSearch", //비동기식aJax는 확장자패턴은 편법으로 사용되며, url패턴으로 사용함
				data:			params,
				contextType:	"application/json",
				//charset:		"utf-8", //xml에서 설정했으면 생략
				success:		function(name) { //response로 앞에서 준 파라미터는 function함수의 파라미터로 받는다
	    							$("#demo").html(name);//$('#demo').innerHtml=name 와 같음
				},
				error:			function() {
									alert("서버 요청 실패~~");
				}
			});
    	}
    	
    	function idCheck2() {
    		let mid = $("#mid").val();
    		if (''==mid) {
    			alert("아이디를 입력하세요");
    			$("#mid").focus();
    			return false;
    		}

    		$.ajax({
    			type: 		"post",
    			url: 		"${ctxPath}/ajaxIdSearch2",//서블릿에서 dispatcher로 이동할 jsp지정안함
    			data: 		{mid : mid},
				//contextType:	"application/json",//생략가능(default ?)
				//charset:		"utf-8", //xml에서 설정했으면 생략
    			success: 	function(resData) {
    							$("#demo").html(resData);//$('#demo').innerHtml=resData 와 같음
    						},
				error: function() {
							alert("전송 실패~~");
				}
    		});
    	}
    	
    	function idCheck3() {
    		let mid = $("#mid").val();
    		if (""==mid) {
    			alert("아이디를 입력하세요");
    			$("#mid").focus();
    			return false;
    		}
    		
    		$.ajax({
    			type: 		"post",
    			url: 		"${ctxPath}/ajaxIdSearch3",//서블릿에서 dispatcher로 이동할 jsp지정안함
    			data: 		{mid : mid},
				contextType:	"application/json",//생략가능(default ?)
				//charset:		"utf-8", //xml에서 설정했으면 생략
    			success: 	function(resData) {
    							$("#demo").html(resData);//$('#demo').innerHtml=resData 와 같음
     							let arrData = resData.split("/");//response로 받은 파라미터는 1개만 넘어옴, 여러개 받고자 할 때는 편집해서 보낼 것(객체로 못받음,null도 못받음).
     							if (null!=arrData[0] && null!=arrData[1] && null!=arrData[2] && null!=arrData[3])	
    								userSearch(arrData[0], arrData[1], arrData[2], arrData[3]);
    						},
    						error: function() {
    							alert("전송 실패~~");
    						}
    		});
    	}

    	//유저 등록
    	function userInput() {
    		let mid = $("#userId").val();
    		let name = $("#userName").val();
    		let age = $("#userAge").val();
    		let address = $("#userAddress").val();
    		if (''==mid || ''==name) {
    			alert('아이디/성명/나이/주소를 입력하세요.');
    			$("#userId").focus();
    			return false;
    		}
    		
    		let query = {
    				mid : mid,
    				name : name,
    				age : age,
    				address : address
    		};
    		
    		$.ajax({
    			type: "post",
    			url: "${ctxPath}/ajaxUserInput",
    			data: query,
    			success: function(data) {
    				if ('1' == data) {
    					alert('자료를 등록했습니다');
    					location.reload();
    				}
    				else if ('0' == data){
    					alert('등록 실패');
    				}
    			},
    			error: function() {
    				alert('전송오류~~');
    			}
    		}); 
    	}

    	//전체유저 조회
    	function userList() {
    		location.href = "${ctxPath}/userList.st";
    	}
    	
    	//개별자료조회 출력
    	function userSearch(mid, name, age, address) {
    		$("#userId").val(mid);
    		$("#userName").val(name);
    		$("#userAge").val(age);
    		$("#userAddress").val(address);
    	}
    	
    	function userDelete(idx) {
    		if ( !confirm('삭제할까요?') ) return false;
    		
    		$.ajax({
    			type: "post",
    			url: "${ctxPath}/ajaxUserDelete",
    			data: {idx : idx},
    			success: function(data) {
    				if ('1' == data) {
    					alert('자료를 삭제했습니다');
    					location.reload();
    				}
    				else {
    					alert('삭제 실패~~');
    				}
    			},
    			error: function() {
    				alert('전송오류');
    			}
    		});
    	}
    	
    </script>
    <style>
    	th {
    		background-color: #eee;
    		text-align: center;
    	}
    </style>
</head>
<body>
    <%@ include file="/include/header_home.jsp" %>
    <%@ include file="/include/nav.jsp" %>
<p><br></p>
<div class="container">
	<h2>AJax연습</h2>
	<form name="searchForm">
		아이디 : <input type="text" name="mid" id="mid"/>&nbsp;
		<input type="button" value="아이디검색1" onclick="idCheck1()" class="btn btn-success"/>&nbsp;
		<input type="button" value="아이디검색2" onclick="idCheck2()" class="btn btn-success"/>&nbsp;
		<input type="button" value="아이디검색3" onclick="idCheck3()" class="btn btn-warning"/>
	</form>
	<div>출력 결과 : <span id="demo"></span></div>
	<hr/>
	<br>
	<form>
		<table class="table table-bordered">
			<tr>
				<td colspan="2">User 가입 폼</td>
			</tr>
			<tr>
				<th>아이디</th>
				<td><input type="text" name="userId" id="userId" class="form-control"/></td>
			</tr>
			<tr>
				<th>성명</th>
				<td><input type="text" name="userName" id="userName" class="form-control"/></td>
			</tr>
			<tr>
				<th>나이</th>
				<td><input type="text" name="userAge" id="userAge" class="form-control"/></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><input type="text" name="userAddress" id="userAddress" class="form-control"/></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" value="유저등록" onclick="userInput()" class="btn btn-info"/>&nbsp;
					<input type="reset" value="다시입력"  class="btn btn-info"/>&nbsp;
					<input type="button" value="유저전체보기" onclick="userList()" class="btn btn-info"/>&nbsp;
				</td>
			</tr>
		</table>
	</form>
	<hr/>
	<br>
	<h3>User 전체 목록</h3>
		<!-- 페이징 처리 시작 -->
		<div class="col text-right">
<c:if test="${pageNo > 1}">
			<a href='${ctxPath}/userList.st?pageNo=1' title='first'>${First}</a>
				<a href='${ctxPath}/userList.st?pageNo=${pageNo - 1}' title='prev'>${Prev}</a>
</c:if>
				${pageNo}Page / ${totPage}Pages
<c:if test="${pageNo != totPage}">
				<a href='${ctxPath}/userList.st?pageNo=${pageNo + 1}' title='next'>${Next}</a>
</c:if>
			<a href='${ctxPath}/userList.st?pageNo=${totPage}' title='last'>${Last}</a>
		</div>
		<!-- 페이징 처리 끝 -->
	<table class="table table-hover">
		<tr>
			<th>번호</th><th>아이디</th><th>성명</th><th>나이</th><th>주소</th><th>조회/삭제</th>
		</tr>
<c:forEach var="vo" items="${vos}">
		<tr>
			<td>${curScrStartNo}</td>
			<td>${vo.mid }</td>
			<td>${vo.name }</td>
			<td>${vo.age }</td>
			<td>${vo.address }</td>
			<td>
				<a href="javascript:userSearch('${vo.mid}','${vo.name}','${vo.age}','${vo.address}');" class="btn btn-secondary btn-sm">조회</a>
				<a href="javascript:userSearch('${vo.mid}','${vo.name}','${vo.age}','${vo.address}');javascript:userDelete('${vo.idx}');" class="btn btn-secondary btn-sm">삭제</a>
			</td>
		</tr>
		<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
</c:forEach>
	</table>
	
		<!-- 블럭페이징 처리 시작 -->
		<div class="text-center">
<c:if test="${pageNo > 1}">
			[<a href='${ctxPath}/userList.st?pageNo=1' title='first'>첫페이지</a>]
</c:if>
<c:if test="${curBlock > 0}">
				[<a href='${ctxPath}/userList.st?pageNo=${(curBlock-1)*blockSize+1}' title='prevBlock'>이전블록</a>]
</c:if>
<c:set var="isBreak" value="false"/>
				<c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
			      <c:if test="${i <= totPage && i == pageNo}">
			        [<a href="${ctxPath}/userList.st?pageNo=${i}"><font color='red'><b>${i}</b></font></a>]
			      </c:if>
			      <c:if test="${i <= totPage && i != pageNo}">
			        [<a href="${ctxPath}/userList.st?pageNo=${i}">${i}</a>]
			      </c:if>
			    </c:forEach>
<c:if test="${curBlock < lastBlock}">
				[<a href='${ctxPath}/userList.st?pageNo=${(curBlock+1)*blockSize+1}' title='nextBlock'>다음블록</a>]
</c:if>
			[<a href='${ctxPath}/userList.st?pageNo=${totPage}' title='last'>마지막페이지</a>]
		</div>
		<!-- 블럭페이징 처리 끝 -->
</div>
    <%@ include file="/include/footer.jsp" %>
</body>
</html>