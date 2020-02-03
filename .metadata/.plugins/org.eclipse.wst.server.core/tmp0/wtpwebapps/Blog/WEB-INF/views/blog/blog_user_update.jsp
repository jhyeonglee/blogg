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
<link rel="stylesheet" type="text/css" href="resources/css/blog_css/blog_user_update.css" />
<script type="text/javascript"src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#backBtn").on("click",function(){
		history.back();
	});
	
	$("#joinBtn").on("click",function(){
		location.href="blog_join";
	});
	
	$("#mainBtn").on("click",function(){
		location.href="blog_main";
	});
	$("#outBtn").on("click",function(){
		var params = $("#actionForm").serialize();
		
		$.ajax({
			type : "post", 
			url : "useroutAjax", 
			dataType : "json", 
			data : params,
			success : function(result){
				if(result.res == "SUCCESS"){
					if(confirm("삭제하시겠습니까?")){
						alert("삭제되었습니다.");
					location.href="blog_main";
					}
					/* alert(document.referrer); */
				}
				else{
					alert("수정에 실패하였습니다.");
				}
			},
		error : function(request,status, error){
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
		});
	});
	
	$("#updateBtn").on("click", function(){
		if($.trim($("#Bnm").val()) == ""){ //공백을제거한 id의 값이 공백일때
			alert("이름을 입력하세요.");
			$("#Bnm").focus();
		}
		else if($.trim($("#Bpw").val()) == ""){
			alert("비밀번호를 입력하세요.");
			$("#Bpw").focus();
		}
		else {
			var params = $("#actionForm").serialize();
			
			$.ajax({
				type : "post", 
				url : "userUpdateAjax", 
				dataType : "json", 
				data : params,
				success : function(result){
					if(result.res == "SUCCESS"){
						if(confirm("수정하시겠습니까?")){
							alert("회원정보를 수정했습니다. 다시로그인하세요.");
							location.href="blog_logout";
							
						}
						/* alert(document.referrer); */
					}
					else{
						alert("수정에 실패하였습니다.");
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
	
});
</script>
</head>
<body>

<!-- 상단 -->
<div class="main_header">
	<div class="header_top">
		<!-- <div id="joinBtn">회원가입</div>
		<div id="mainBtn">로그인</div> -->
	</div>
	<div class="header_bottom">JaeHyeong's Bloggggg :)</div>
</div>
<!-- 중간 -->
<div class="main_content">
	<div class="main_blank">
		<div class="name_blank"></div>
		<div class="blog_name"></div>
	</div>
	<div class="main_login">
		<div class="login_blank"></div>
		<div class="login_area">
		<div class="login_title">회원정보수정</div>
		<form action="#" id="actionForm" method="post">
		<input type="hidden" name="num" id="num" value="${sBmNo}" /> 
		<input type="hidden" name="bId" id="bId" value="${sBmId}" /> 
		<input type="hidden" name="bNm" id="bNm" value="${sBmNm}" /> 
			<input type="text" class="id_txt" name="id" id="Bid" placeholder = "아이디" value="${sBmId}" readonly/> <br/>
			<input type="text" class="id_txt" name="Bnm" id="Bnm" placeholder = "이름" value="${sBmNm}"/> <br/>
			<input type="password" class="pw_txt" name="Bpw" id="Bpw" placeholder = "비밀번호" /> <br/> <br/>
			<div class="login" id="updateBtn">수정</div>
			<div class="out" id="outBtn" style="color:red;">회원탈퇴</div>
			<div class="join" id="backBtn">이전</div>
		</form>
		</div>
	</div>

</div>
<!-- 하단 -->
<div class="main_footer"></div>

</body>
</html>