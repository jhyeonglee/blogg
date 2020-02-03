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
	href="resources/css/blog_css/make.css" />

</head>
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="resources/script/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
$(document).ready(
function() {
	$("#bNm").on(
			"focusout",
			function() {
				if ($(this).val().length < 3) {
					$("#idMsg").html("블로그 명은 3글자 이상입니다.");
					$("#idMsg").css("color", "red");
					$("#idMsg").css("background-color",
						"rgba(255,255,100,0.7)");
					$("#blogcheck").val(0)
				} 
				else {
					//수동
					//var params = "&id" + $("#id").val();

					//JQuery 활용
					var params = $("#actionForm").serialize();

					$.ajax({
						type : "post", //데이터 전송방식
						url : "blogNameAjax", //주소
						dataType : "json", //데이터 전송 규격
						data : params, //보낼 데이터
						//{키:값 , 키:값 , ...} -->json
						success : function(result) {
							if (result.cnt > 0) {
								$("#idMsg").html("중복된 블로그가 있습니다.");
								$("#idMsg").css("color", "red");
								$("#idMsg").css("background-color","rgba(255,255,100,0.7)");
								$("#blogcheck").val(0)
							} else {
								$("#idMsg").html("사용가능한 블로그입니다.");
								$("#idMsg").css("color", "green");
								$("#idMsg").css("background-color","rgba(100,255,100,0.7)");
								$("#blogcheck").val(1)
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
		if ($.trim($("#bNm").val()) == "") {
			alert("이름을 입력하세요.");
			$("#bNm").focus();
		} else if ($.trim($("#blogcheck").val()) == 0) {
			alert("블로그명을 사용 할 수 없습니다.");
		} else {
			//JQuery 활용
			var params = $("#actionForm").serialize();

			$.ajax({
				type : "post", //데이터 전송방식
				url : "makeAjax", //주소
				dataType : "json", //데이터 전송 규격
				data : params, //보낼 데이터
				//{키:값 , 키:값 , ...} -->json
				success : function(result) {
					if (result.res == "SUCCESS") {
						location.href = "blog_list1";
					} else {
						alert("블로그 생성을 실패하였습니다.");
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
<input type="hidden" id="blogcheck" value="0"/>
<!-- 상단 -->
<div class="main_header">
	<div class="header_top">
		
	</div>
	<div class="header_bottom"></div>
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
			<div class="join_title">블로그 만들기</div>
			<form action="#" id="actionForm" method="post">
				<input type="hidden" name="bmno" value="${sBmNo}"/>
				<input type="text" class="blog_txt" name="bNm" id="bNm" placeholder = "블로그 명을 입력하시오"/>  
				<span id="idMsg"></span><br/><br/>
				<input type="text" class="blog_txt" name="id" id="id"  value="${sBmNm}"/>  
				<div class="login" id="joinBtn">만들기</div>
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