<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    	//부분자료 검색처리
    	function partCheck() {
    		let part = partForm.part.value;
    		location.href = "${ctxPath}/pdsList.pds?part="+part;
    	}
    	//모달창 내용보기
    	function modal_view(title,part,nickName,mid,fName,fDate,fSize,fSName) {
    		let imgs = fSName.split("/");
    		$("#myModal").on("show.bs.modal", function(e)) {
    			$(".modal-header #title").html(title);
    			$(".modal-header #part").html(part);
    			$(".modal-body #mid").html(mid);
    			$(".modal-body #fName").html(fName);
    			$(".modal-body #fDate").html(fDate);
    			$(".modal-body #fSize").html(fSize);
    			$(".modal-body #fSName").html(fSName);
    			$(".modal-body #imgSrc").attr("src", ${ctxPath}+"/pds/tmp/"+imgs[0]);
    		});
    	}
    	//다운로드 수 증가처리
    	function checkDownNum(idx) {
    		$.ajax({
    			type 	: "post",
    			url		: "${ctxPath}/pdsDownNum.pds",
    			data	: {idx : idx},
    			success : function() {
    					location.reload();
    			},
    			error	: function() {
    				alert("전송오류");
    			}
    		});
    	}
    	
    	//파일 삭제 처리하기
    	function checkPdsDel(idx, fSName) {
    		let ans = confirm("파일을 삭제하시겠습니까?");
    		if (!ans) return false;
    		
    		let pwd = prompt("비밀번호를 입력하세요?");
    		let query = {	idx : idx,
    						fSName : fSName,
    						pwd : pwd	};
    		$.ajax({
    			type : "post",
    			url		: "${ctxPath}/pdsDelete.pds",
    			data	: query,
    			success	: function(res) {
    				if ('pdsDeleteOk' == res) {
    					alert('삭제됬습니다');
    				} else if ('pdsDeleteNo' == res) {
    					alert('삭제 실패~~');
    				} else if ('pwdNo' == res) {
    					alert('비밀번호가 틀립니다');
    				}
    			},
    			error	: function() {
    				alert('전송 오류~~');//sql exception과 무관
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
	<h2 class="text-center">자 료 실 리 스 트(${part})</h2>
	<br>
	<table class="table table-borderless texxt-center">
		<tr>
			<td class="text-left" style="width:30%">
				<form name="partForm">
					<select name="part" onchange="partCheck()" class="form-control">
						<option value="전체" ${part=='전체' ? selected : ''}>전체</option>
						<option value="학습" ${part=='학습' ? selected : ''}>학습</option>
						<option value="여행" ${part=='여행' ? selected : ''}>여행</option>
						<option value="음식" ${part=='음식' ? selected : ''}>음식</option>
						<option value="기타" ${part=='기타' ? selected : ''}>기타</option>
					</select>
				</form>
			</td>
			<td class="text-right" style="width:65%"><a href='${ctxPath}/pdsInput.pds' class="btn btn-outline-success">자료올리기</a></td>
		</tr>
	</table>
	<table class="table table-hover table-borderless text-center">
		<tr class="table-dark text-dark">
			<th>번호</th>
			<th>자료제목</th>
			<th>올린이</th>
			<th>올린날짜</th>
			<th>분류</th>
			<th>파일명(사이즈)</th>
			<th>다운수</th>
			<th>비고</th>
		</tr>
		<c:forEach var="vo" items="${vos}">
			<td>${vo.idx}</td>
			<td>
				<c:if test="${'공개' == vo.openSW || sMid == vo.mid || 0 == sLevel}">
					<a href="${ctxPath}/pdsContent.pds?idx=${vo.idx}&pageNo=${pageNo}&part=${part}">
						${vo.title}<c:if test="${vo.wNDate <= 24}">new</c:if>
					</a>
				</c:if>
				<c:if test="${'공개' != vo.openSW || sMid != vo.mid || 0 != sLevel}">
					${vo.title}<c:if test="${vo.wNDate <= 24}">new</c:if>
				</c:if>
			</td>
			<td>${vo.nickName}</td>
			<td>
				<c:if test="${vo.wNDate <= 24}">${fn:substring(vo.fDate,11,19)}</c:if>
				<c:if test="${vo.wNDate > 24}">${fn:substring(vo.fDate,0,10)}</c:if>
			</td>
			<td><a href="#" data-toggle="modal" data-target="#myModal" onclick="modal_view('${vo.title}','${vo.part}','${vo.nickName}','${vo.mid}','${vo.fName}','${vo.fDate}','${vo.fSize}','${vo.fSName}')">${vo.part}</a></td>
			<td>
				<c:if test="${'공개' == vo.openSW || sMid == vo.mid || 0 == sLevel}">
					<%--${vo.fSName}--%>
					<c:set var="fNames" value="${fn:split(vo.fName,'/')}"/>
					<c:set var="fSNames" value="${fn:split(vo.fSName,'/')}"/>
					<c:forEach var="fName" items="${fNames}" varStatus="st">
						<a href="${ctxPath}/pds/temp/${fNames[st.index]}" download="${fName}" onclick="checkDownNum(${vo.idx})">${fName}</a><br>
					</c:forEach>
					<br>(<fmt:formatNumber value="${vo.fSize / 1024}" pattern="#,###KB"/>
				</c:if>
				<c:if test="${'공개' != vo.openSW && sMid != vo.mid && 0 != sLevel}">
					비공개<br>
				</c:if>
			</td>
			<td>${vo.downNum}</td>
			<td>
				<c:if test="${sMid == vo.mid || 0 == sLevel}">
					<a href="${ctxPath}/pdsCompress.pds?idx=${vo.idx}" class="btn btn-danger btn-sm" >압축다운로드</a></td>
					<a href="javascript:checkPdsDel('${vo.idx}','${vo.fSName}')" class="btn btn-danger btn-sm" >삭제</a></td>
					<a href="#" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#myModal" onclick="modal_pdfView('${vo.idx}','${vo.title}','${vo.part}','${vo.nickName}','${vo.mid}','${vo.fName}','${vo.fDate}','${vo.fSize}','${vo.fSName}')">삭제</a>
				</c:if>
		</c:forEach>
	</table>
	
	  <!-- The Modal -->
	  <div class="modal fade" id="myModal">
	    <div class="modal-dialog">
	      <div class="modal-content">
	      
	        <!-- Modal Header -->
	        <div class="modal-header">
	          <h4 class="modal-title"><span id="title">(분류:<span id="part"></span>)${vo.title}</span></h4>
	          <button type="button" class="close" data-dismiss="modal"><font color='red'>x</font></button>
	        </div>
	        
	        <!-- Modal body -->
	        <div class="modal-body">
				- 올린이 : <sapn id="nickName"></sapn>
				<hr/>
				- 아이디 : <span id="mid"></span><br>
				- 파일명 : <span id="fName"></span><br>
				- 올린날짜 : <span id="fDate"></span><br>
				- 파일크기 : <span id="fSize"></span><br>
				<hr/>
				- 저장파일명 : <span id="fSName"></span><br>
				<img id="imgSrc" src="" width="380px"/><br>
	        </div>
	        
	        <!-- Modal footer -->
	        <div class="modal-footer">
	          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	        </div>
	      </div>
	    </div>
	  </div>
  
</div>
    <%@ include file="/include/footer.jsp" %>
</body>
</html>