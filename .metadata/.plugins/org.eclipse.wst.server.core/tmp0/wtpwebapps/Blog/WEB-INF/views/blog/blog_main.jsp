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
<link rel="stylesheet" type="text/css" href="resources/css/blog_css/main.css" />
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
	
	$("#loginBtn").on("click", function(){
		if($.trim($("#Bid").val()) == ""){ //공백을제거한 id의 값이 공백일때
			alert("아이디를 입력하세요.");
			$("#Bid").focus();
		}
		else if($.trim($("#Bpw").val()) == ""){
			alert("비밀번호를 입력하세요.");
			$("#Bpw").focus();
		}
		else {
			var params = $("#actionForm").serialize();
			
			$.ajax({
				type : "post", //데이터 전송방식
				url : "bLoginAjax", //주소
				dataType : "json", //데이터 전송 규격
				data : params, //보낼 데이터
				//{키:값 , 키:값 , ...} -->json
				success : function(result){
					if(result.res == "SUCCESS"){
						if(document.referrer == "http://localhost:8090/Blog/blog_list1"){
							
						location.href="blog_list1";
						}
						else{
							
						location.href="blog_list";
						}
						/* alert(document.referrer); */
					}
					else{
						alert("로그인에 실패하였습니다.");
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
		<div id="joinBtn">회원가입</div>
		<div id="mainBtn">로그인</div>
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
		<div class="login_title">로그인</div>
		<form action="#" id="actionForm" method="post">
			<input type="text" class="id_txt" name="id" id="Bid" placeholder = "아이디를 입력하세요"/> <br/>
			<input type="password" class="pw_txt" name="pw" id="Bpw" placeholder = "비밀번호를 입력하세요"/> <br/> <br/>
			<div class="login" id="loginBtn">로그인</div>
			<div class="join" id="backBtn">이전</div>
		</form>
		</div>
	</div>
	
</div>
<!-- 하단 -->
<div class="main_footer"></div>

</body>
</html>