<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>blogggg :D</title>
<link
	href="https://fonts.googleapis.com/css?family=Cute+Font&display=swap"
	rel="stylesheet">

<link rel="stylesheet" type="text/css"
	href="resources/css/blog_css/join.css" />

</head>
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="resources/script/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
$(document).ready(
function() {
	$("#Bid").on(
			"focusout",
			function() {
				if ($(this).val().length < 5) {
					$("#idMsg").html("아이디는 5글자 이상입니다.");
					$("#idMsg").css("color", "red");
					$("#idMsg").css("background-color",
						"rgba(255,255,100,0.7)");
					$("#checkId").val(0)
				} 
				else {
					//수동
					//var params = "&id" + $("#id").val();

					//JQuery 활용
					var params = $("#actionForm").serialize();

					$.ajax({
						type : "post", //데이터 전송방식
						url : "bIdCheckAjax", //주소
						dataType : "json", //데이터 전송 규격
						data : params, //보낼 데이터
						//{키:값 , 키:값 , ...} -->json
						success : function(result) {
							if (result.cnt > 0) {
								$("#idMsg").html("중복된 아이디가 있습니다.");
								$("#idMsg").css("color", "red");
								$("#idMsg").css("background-color","rgba(255,255,100,0.7)");
								$("#checkId").val(0)
							} else {
								$("#idMsg").html("사용가능한 아이디입니다.");
								$("#idMsg").css("color", "green");
								$("#idMsg").css("background-color","rgba(100,255,100,0.7)");
								$("#checkId").val(1)
							}

						},
						error : function(request, status, error) {
							console.log("status : "
									+ request.status);
							console.log("text : "
									+ request.responseText);
							console.log("error : " + error);

						}

					});
				}
			});

	$("#joinBtn").on("click", function() {
		if ($.trim($("#Bnm").val()) == "") {
			alert("이름을 입력하세요.");
			$("#Bnm").focus();
		} else if ($.trim($("#Bid").val()) == "") {
			alert("아이디를 입력하세요.");
			$("#Bid").focus();
		} else if ($.trim($("#Bpw").val()) == "") {
			alert("비밀번호를 입력하세요.");
			$("#Bpw").focus();
		} else if ($.trim($("#checkId").val()) == 0) {
			alert("아이디가 유효하지 않습니다..");
		} else {
			//JQuery 활용
			var params = $("#actionForm").serialize();

			$.ajax({
				type : "post", //데이터 전송방식
				url : "bJoinAjax", //주소
				dataType : "json", //데이터 전송 규격
				data : params, //보낼 데이터
				//{키:값 , 키:값 , ...} -->json
				success : function(result) {
					if (result.res == "SUCCESS") {
						alert("가입에 성공했습니다!");
						location.href = "blog_main";
					} else {
						alert("가입에 실패하였습니다.");
					}
				},
				error : function(request, status, error) {
					console.log("status : " + request.status);
					console.log("text : " + request.responseText);
					console.log("error : " + error);
				}
			});
		}


	});
		$("#backBtn").on("click",function(){
			history.back();
		});
});
</script>
<body>
<input type="hidden" id="checkId" value="0"/>
<!-- 상단 -->
<div class="main_header">
	<div class="header_top">
		<div>회원가입</div>
		<div>로그인</div>
	</div>
	<div class="header_bottom">JaeHyeong's Bloggggg :)</div>
</div>
<!-- 중간 -->
<div class="main_content">
	<div class="main_blank">
		<div class="name_blank"></div>
		<div class="blog_name"></div>
	</div>
	<div class="main_join">
		<div class="join_blank"></div>
		<div class="join_area">
			<div class="join_title">회원가입</div>
			<form action="#" id="actionForm" method="post">
				<input type="text" class="id_txt" name="id" id="Bid" placeholder = "아이디를 입력하세요"/> 
				<span id="idMsg"></span><br/>
				<input type="password" class="pw_txt" name="pw" id="Bpw" placeholder = "비밀번호를 입력하세요"/> <br/>
				<input type="text" class="nm_txt" name="nm" id="Bnm" placeholder = "이름을 입력하세요"/> <br/> <br/>
				<div class="login" id="joinBtn">가입</div>
				<div class="join" id="backBtn">이전</div>
			</form>
		<br />
		
		</div>
	</div>
	
</div>
<!-- 하단 -->
<div class="main_footer"></div>
</body>
</html>