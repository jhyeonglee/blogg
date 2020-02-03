<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>blogggg :)</title>
<link href="https://fonts.googleapis.com/css?family=Cute+Font&display=swap" rel="stylesheet">
<link rel="shortcut icon" href="../../images/cloudicon.png">
<link rel="stylesheet" type="text/css" href="resources/css/blog_css/write.css" />
<script type="text/javascript" src="resources/script/ckeditor/ckeditor.js"></script>
<script type="text/javascript"src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	CKEDITOR.replace("con",{
		resize_enabled : false,
		language : "ko",
		enterMode : "2"
	});
	
	
	$("#saveBtn").on("click", function(){
		$("#con").val(CKEDITOR.instances['con'].getData());
		if($.trim($("#title").val())== ""){
			alert("제목을 입력하세요.");
			$("#title").focus();
		}
		else if($.trim($("#con").val()) == ""){
			alert("내용을 입력하세요.");
			$("#con").focus();
		}
		else {
			var params = $("#saveForm").serialize();
			console.log($("#title").val());
			$.ajax({
				type : "post", //데이터 전송방식
				url : "bSaveAjax", //주소
				dataType : "json", //데이터 전송 규격
				data : params, //보낼 데이터
				//{키:값 , 키:값 , ...} -->json
				success : function(result){
					if(result.res == "SUCCESS"){
						alert("글쓰기를 완료하였습니다.")
						location.href="blog_list";
					}
					else{
						alert("글작성에 실패하였습니다.");
					}
				},
				error : function(request,status, error){
					console.log("status : " + request.status);
					console.log("text : " + request.responseText);
					console.log("error : " + error);
					
				}
			
			});
		}
	});
	
	$("#cancelBtn").on("click",function(){
		history.back();
	});
	
	
});
</script>
<body>
<!-- 상단 -->
<div class="main_header">
	<div class="header_top">
		<!-- <div class="top_Btn">회원가입</div> -->
		<!-- <div class="top_Btn" id="mainBtn">로그아웃</div> -->
		<div class="user_info">
		<%-- <c:choose>
			<c:when test="${!empty sBmNo}">
				<div class="user_name">${sBmNm}님 어서오세요.</div> 
				<div class="top_Btn" id="logoutBtn">로그아웃</div>
				<!-- <input type="button" value="로그아웃" id="logoutBtn" /> -->	
			</c:when>
			<c:otherwise>
				<div class="top_Btn" id="loginBtn">로그인</div>
				<!-- <input type="button" value="로그인 " id="loginBtn"/> -->
			</c:otherwise>
		</c:choose> --%>

		</div>
	</div>
	<div class="header_bottom">JaeHyeong's Bloggggg :)</div>
</div>
<!-- 중간 -->
<div class="main_content">

	<div class="content_left"></div>
	<div class="content_center">
		
		
		<div class="write_center">
		<form action="#" id="saveForm" method="post" style="text-align:center;">
		<input type="hidden" name="num" id="num" value="${sBmNo}" />
		
		<div style="display:inline-block; ">
		<table cellspacing="0">
			<tbody>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" id="title" class="title" /> </td>
				</tr>
				<tr>
					<th>작성자</th>
					<td> <input type="text" name="writer" id="writer" class="writer" value="${sBmNm}" />  </td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="con" id="con" rows="10" cols="20"> </textarea> </td>
				</tr>
			
			</tbody>
	
		</table>
		</div>
		<input style="font-family: 'Cute Font', cursive;" type="button" id="saveBtn" class="saveBtn"  value="저장"/>
		<input style="font-family: 'Cute Font', cursive;" type="button" id="cancelBtn" class="cancelBtn" value="취소"/>
		</form>
		</div>
	
	
	</div>
	<div class="content_right"></div>
</div>
<!-- 하단 -->
<div class="main_footer"></div>

</body>
</html>