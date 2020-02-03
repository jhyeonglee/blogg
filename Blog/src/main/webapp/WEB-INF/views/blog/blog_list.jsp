<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>blogggg :)</title>
<link
	href="https://fonts.googleapis.com/css?family=Cute+Font&display=swap"
	rel="stylesheet">
<link rel="shortcut icon" href="../../images/cloudicon.png">
<link rel="stylesheet" type="text/css"
	href="resources/css/blog_css/list.css" />
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	allDetailsList();
	reloadList();
	$(".detail").hide();
	$("#logoutBtn").on("click",function(){
		location.href="blog_logout";
	});
	$(".left_list").on("click",function(){
		location.href="blog_list1";
	});
	$(".left_login").on("click",function(){
		location.href="blog_main";
	});
	$(".left_logout").on("click",function(){
		location.href="blog_logout";
	});
	$("#loginBtn").on("click",function(){
		location.href="blog_main";
	});
	
	$(".left_user_update").on("click",function(){
		 $("#actionForm").attr("action","blog_user_update");
	     $("#actionForm").submit();
	});
	
	$(".JH").on("click",function(){
		location.href="blog_list";
	});
	
	$("#searchBtn").on("click",function(){
		$("#page").val("1");
		reloadList();
	});
	
	$("tbody").on("click","tr",function(){
		$(".detail").show();
		  $("#no").val($(this).attr("name")); 
		  
		  var params = $("#actionForm").serialize();
			
			$.ajax({
				type : "post", //데이터 전송방식
				url : "dataAjax", //주소
				dataType : "json", //데이터 전송 규격
				data : params, //보낼 데이터
				//{키:값 , 키:값 , ...} -->json
				success : function(result){
					picolo(result.data);
				},
				error : function(request,status, error){
					console.log("text : " + request.responseText);
					console.log("error : " + error);
				}
			});
	});
	
	$("#writeBtn").on("click",function(){
		location.href="blog_write";
	});
	
	$(".paging_area").on("click","span",function(){
		if($(this).attr("name") != "" ){
			$("#page").val($(this).attr("name"));
			reloadList();
		}
	});
	
	$(".all_detail").on("click", ".ment_del",  function(){
		$("#mentForm #rq").val($(this).attr("name"));
		alert("상세보기에서 삭제하세요.");
		
	});
	
	$(".detail").on("click", ".ment_del",  function(){
		$("#rq").val($(this).attr("name"));
		if('${sBmNm}' == $("#mnm").val() ){
			var params = $("#mentForm").serialize();
			
			if(confirm("정말 삭제하시겠습니까?")){
				
			$.ajax({
				type : "post", 
				url : "mentdelAjax", 
				dataType : "json", 
				data : params,

				success : function(result){
					if(result.res == "SUCCESS"){
						alert("삭제했습니다.");
						location.href="blog_list";
						}
					
					else{
						alert("삭제에 실패하였습니다.");
					}
				},
				error : function(request,status, error){
					console.log("status : " + request.status);
					console.log("text : " + request.responseText);
					console.log("error : " + error);
					
				}
			});	   
			}
				
			}
			else {
				alert("작성자만 삭제 할 수 있습니다.");
			} 
	});
});

function reloadList(){
	var params = $("#actionForm").serialize();
	
	$.ajax({
		type : "post", //데이터 전송방식
		url : "bListAjax", //주소
		dataType : "json", //데이터 전송 규격
		data : params, //보낼 데이터
		//{키:값 , 키:값 , ...} -->json
		success : function(result){
			
			redrawList(result.list);
			redrawPaging(result.pb);	
			
		},
		error : function(request,status, error){
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}
function redrawList(list){
	var html = "";
	
	if(list.length == 0){
		html += "<tr>";
		html += "<td colspan=\"5\">조회된 데이터가 없습니다.</td>";
		html += "</tr>";
	}
	else{
		for(var i in list){
		html += "<tr name=\"" + list[i].P_NO + "\">";
		html += "<td>"+ list[i].P_NO +"</td>";
		html += "<td>"+ list[i].P_TITLE +"</td>";
		html += "<td>"+ list[i].P_DATE +"</td>";
		html += "</tr>";
		}
	}
	
	$("tbody").html(html);
}
/***************************/


function redrawPaging(pb){
	var html="";
	//처음
	
	html += "<span name=\"1\">처음 </span>&nbsp;";
	
	//이전
	if($("#page").val()=="1"){
		html += "<span name=\"1\">이전 </span>&nbsp;";
	}
	else{
		html += "<span name=\"" + ($("#page").val() * 1 -1) + "\">이전</span>&nbsp;";
	}
	//숫자
	for(var i = pb.startPcount; i<=pb.endPcount; i++){
		if($("#page").val()== i){
			html += "<span><b>"+ i + "</b></span>&nbsp;";
		}
		else{
			html += "<span name=\"" + i + "\">"+ i +"</span>&nbsp;";
			
		}
	}
	
	//다음
	if($("#page").val()==pb.maxPcount){
		html += "<span name=\""+pb.maxPcount +"\">다음</span>&nbsp;";
	}
	else{
		html += "<span name=\"" + ($("#page").val() * 1 +1) + "\">다음</span>&nbsp;";
	}
	
	//마지막
	html += "<span name=\"" + pb.maxPcount + "\">마지막</span>";
	
	$(".paging_area").html(html);
		
}
/** ************************************************************* **/
/* 1개 상세보기 수정삭제o */
function picolo(data){
	$("#mnm").val(data.M_NM);
	
	var html ="";
	html += "<form id=\"updateForm\" method=\"post\" action=\"#\">";
	html += "<input type=\"hidden\" name=\"qwe\" id=\"qwe\" value=\"" + data.P_NO+"\"/>";
	html += "<input type=\"hidden\" name=\"mnm\" id=\"mnm\" value=\""+data.M_NM+"\"/>";
	html += "<div class=\"detail_btn\">";
	html += "<div id=\"listBtn\" class=\"listBtn\">목록</div>";
	html += "<c:if test="${!empty sBmNo}">";
	html += "<div id=\"updateBtn\">수정</div>";
	html += "<div id=\"deleteBtn\"class=\"deleteBtn\" style=\"color : red;\">삭제</div>";
	html += "</c:if>";
	html += "</div><br />";
	html += "<div class=\"real_detail_title\">" + data.P_TITLE+" <br /></div>";
	html += "<div class=\"real_detail_center\"><div class=\"real_detail_writer\">"+ data.M_NM +"<br /></div>";
	html += "<div class=\"real_detail_date\">"+ data.P_DATE+ "<br /></div>";
	html += "<div class=\"real_detail_hit\"><br /></div></div>";
	html += "<div class=\"real_detail_content\"><br/> "+ data.P_CON+"<br /><br /></div><br/>";
	html += "<br/>";
	
 	html +="<input type=\"hidden\" id=\"no\" name=\"no\" value=\"" + data.P_NO+"\"/>";
 	html +="<input type=\"hidden\" id=\"num\" name=\"num\" value=\"${sBmNo}\"/>";
 	html +="<input type=\"hidden\" id=\"rq\" name=\"rq\" value=\"\"/>";
 	
 	html +="<div><div class=\"ment_title\">댓글</div><br/><br/>";
	html +="<div class=\"comment_area " + data.P_NO +"\">";
	html +="</div><br/>";
	
	html += "<c:if test="${!empty sBmNo}">";
	html +="<input type=\"text\" class=\"recomment\" id=\"mCon\"name=\"mCon\"style=\"font-family: 'Cute Font', cursive;\" placeholder=\"댓글을 작성해주세요.\"/><br/>";
	html +="<div class=\"nm_area\"><div class=\"nm_blank\"></div><div id=\"comment_nm\" class=\"comment_nm\">${sBmNm}</div></div><br/>"
	html +="<input type=\"button\" style=\"font-family: 'Cute Font', cursive;\"  id=\"commentBtn\" class=\"commentBtn\" value=\"등록\"/><br/>";
	html += "</c:if>";
	
	html += "<c:if test="${empty sBmNo}">";
	html +="<input type=\"text\" class=\"recomment\" id=\"mCon\"name=\"mCon\"style=\"font-family: 'Cute Font', cursive;\" placeholder=\"댓글을 작성하려면 로그인을 하세요.\" readonly=\"readonly\"/><br/>";	
	html += "</c:if>";
	html +="</div><br/><br/>";
	html +="</form>";

	$("#no").val(data.P_NO);
	mentList();

	$(".detail").html(html);
	$(".all_detail").remove();

	$("#updateBtn").on("click",function(){
		if('${sBmNm}' == data.M_NM){
		 $("#updateForm").attr("action","blog_update");
	     $("#updateForm").submit();
		}
		else{
			alert("작성자만 수정 할 수 있습니다.");
		}
	});
	
	$("#deleteBtn").on("click",function(){

 		if('${sBmNm}' == data.M_NM){
		var params = $("#updateForm").serialize();
		
		$.ajax({
			type : "post", //데이터 전송방식
			url : "cdeleteAjax", //주소
			dataType : "json", //데이터 전송 규격
			data : params, //보낼 데이터
			//{키:값 , 키:값 , ...} -->json
			success : function(result){
				if(result.res == "SUCCESS"){
					confirm("정말 삭제하시겠습니까?");
					location.href="blog_list";
				}
				else{
					alert("삭제에 실패하였습니다.");
				}
			},
			error : function(request,status, error){
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
				
			}
		
		});	   
			
 		}
 		else {
 			alert("작성자만 삭제 할 수 있습니다.");
 		}
	});
	$(".commentBtn").on("click",function(){
		if($.trim($("#mCon").val())== ""){
			alert("내용을 입력하세요.");
			$("#mCon").focus();
		}
				
		else {
			var params = $("#updateForm").serialize();
			
			$.ajax({
				type : "post", //데이터 전송방식
				url : "aMentAjax", //주소
				dataType : "json", //데이터 전송 규격
				data : params, //보낼 데이터
				//{키:값 , 키:값 , ...} -->json
				success : function(result){
					if(result.res == "SUCCESS"){
						alert("댓글을 작성했습니다.")
						location.href="blog_list";
					}
					else{
						alert("댓글작성에 실패하였습니다.");
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
	$(".listBtn").on("click",function(){
		location.href="blog_list";
	});
	
	
}//피콜로
/** ************************************************* **/


function allDetailsList(){
	var params = $("#actionForm").serialize();
	
	$.ajax({
		type : "post", 
		url : "cListAjax",
		dataType : "json", 
		data : params,
		
		success : function(result){

			
			redrawList(result.list);
			redrawPaging(result.pb);	
			reDetailsList(result.list);
		},
		error : function(request,status, error){
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}
/* 여러개 상세보기 수정삭제x */
function reDetailsList(list){		
	var html = "";
	for(var i in list){
		html += "<form id=\"detailsForm\" action=\"#\" method=\"post\" class=\"detailsForm\">";
		html += "<div>";
		html += "<div class=\"b_btn\">";
		html += "<div>번호 :"+list[i].P_NO+"</div></div>";
		html += "<div class=\"detail_title\"> " + list[i].P_TITLE+" </div>";
		html += "<div class=\"detail_date\">"+ list[i].P_DATE+ "</div><br /><br />";
		html += "<div class=\"detail_content\">" + list[i].P_CON + "<br /><br /></div>";
		html +="</div><br/>";
		
		html +="<div class=\"a\"><div class=\"ment_title\">댓글</div><br/><br/>";
		html +="<div class=\"comment_area " + list[i].P_NO +"\">";
		html +="</div><br/>";
		
		html +="</div><br/><br/>";
		html +="</form><br/>";
		
		$("#no").val(list[i].P_NO);
		mentList();
		
	}
	
	$(".all_detail").html(html);
	
	
	/** 왜 클래스는 먹고 id는 안먹냐  **/
	
}


function commentList(list){	
	if(list.length != 0) {
		
		var html = "";
	
		for(var i in list){
	
			html += "<div class=\"ment_area\" >";
			html += "<div class=\"ment_no\"style=\"float:left;\">no."+list[i].MENT_NO+"</div>";
			html += "<div class=\"ment_writer\"style=\"float:left;\">"+list[i].M_NM+"</div><br/>";
			html += "<div class=\"ment_con\" style=\"float:left;\"> "+list[i].MENT_CON+"</div><br/>";
			html += "<div class=\"ment_tm\" >"+list[i].MENT_TM+"";
			
			if("${sBmNo}" != '') {
				html += "<div class=\"ment_del\" id=\"ment_del\" name=\"" + list[i].MENT_NO + "\">삭제</div>";
			}
			
			html += "</div><br/>";
			html += "</div><br/>";
		}

		$("."+list[0].P_NO).html(html);
		
	}
}

function mentList(){
	var params = $("#actionForm").serialize();
	
	$.ajax({
		type : "post", 
		url : "mentListAjax",
		dataType : "json", 
		data : params, 
		
		success : function(result){
			commentList(result.ment);
			
		},
		error : function(request,status, error){
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}
 
 
 /* ************************************************* */
</script>
</head>
<body>
	<form action="#" id="mentForm" method="post">
		<input type="hidden" name="rq" id="rq" />
	</form>
	<!-- 상단 -->
	<div class="main_header">
		<div class="header_top">
			<div class="user_info">
				<c:choose>
					<c:when test="${!empty sBmNo}">
						<div class="user_name">${sBmNm}님어서오세요.</div>
						<div class="top_Btn" id="logoutBtn">로그아웃</div>
					</c:when>
					<c:otherwise>
						<div class="top_Btn" id="loginBtn">로그인</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="header_bottom">
			<div class="JH">JaeHyeong's Bloggggg :)</div>

		</div>

	</div>
	<!-- 중간 -->
	<div class="main_content">

		<div class="content_left">
			<div class="left_top"></div>
			<div class="left_info">
				<div class="info_img"></div>
				<div class="info_id"
					style="text-align: left; margin-left: 5px; padding-top: 5px;">이재형(Jaehyeong)</div>
				<div class="info_txt">블로그 소개</div>
			</div>
			<div class="left_mid"></div>
			<div class="left_list">블로그 목록</div>

			<c:if test="${empty sBmNo}">
				<div class="left_login">로그인</div>
			</c:if>
			<c:if test="${!empty sBmNo}">
				<div class="left_logout">로그아웃</div>
				<div class="left_user_update">회원정보수정</div>
			</c:if>
		</div>
		<div class="content_center">
			<div class="center_title">JaeHyeong's bloggggg :)</div>
			<br />
			<!-- 글목록 -->
			<div class="center_main">
				<!--검색 -->
				<form action="#" id="actionForm" method="post">
					<input type="hidden" name="page" id="page" value="1" /> 
					<input type="hidden" name="num" id="num" value="${sBmNo}" /> 
					<input type="hidden" name="no" id="no" value="${param.no}" />
					
					<div class="search">
						<select name="searchGbn" class="dropbox">
							<option value="0">제목</option>
							<option value="1">작성자</option>
							<!-- <option value="2">제목 + 작성자</option> -->
						</select> <input type="text" name="searchTxt" class="searchTxt" /> <input
							type="button" value="검색" id="searchBtn" class="searchBtn"
							style="font-family: 'Cute Font', cursive;" />
					</div>
					<c:if test="${sBmNo eq 9}">
						<input type="button" value="글쓰기" id="writeBtn" class="writeBtn"
							style="font-family: 'Cute Font', cursive;" />
					</c:if>
				</form>
				<br />
				<div style="display: inline-block;">
					<table class="list_tbl">
						<colgroup>
							<!-- 테이블열들의 너비입니다. -->
							<col width="10%" />
							<col width="30%" />
							<col width="30%" />

						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>작성일</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="5">조회된 데이터가 없습니다.</td>
							</tr>
						</tbody>
					</table>
				</div>
				<br />
				<div class="paging_area">
					<span>처음</span> <span>이전</span> <span>1</span> <span>다음</span> <span>마지막</span>
				</div>
			</div>

			<div class="center_footer">
				<div class="footer_top"></div>
				<!-- 상세ㅐ보기 -->
				<!-- 글상세보기 -->
				<div class="detail"></div>
				<!-- 글전체보기 -->
				<div class="all_detail">
					<div class="detail_title"></div>
				</div>
			</div>
		</div>
		<div class="content_right"></div>


	</div>

	<!-- 하단 -->
	<div class="main_footer"></div>
</body>
</html>