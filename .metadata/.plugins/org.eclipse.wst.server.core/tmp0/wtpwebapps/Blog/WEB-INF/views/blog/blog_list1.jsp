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
<link rel="stylesheet" type="text/css" href="resources/css/blog_css/list1.css" />
<script type="text/javascript"src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	reloadList();
	
	$("#logoutBtn").on("click",function(){
		location.href="blog_logout";
	});
	$("#loginBtn").on("click",function(){
		location.href="blog_main";
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
	$("#searchBtn").on("click",function(){
		$("#page").val("1");
		reloadList();
	});
	
	$("tbody").on("click","tr",function(){
		  $("#no").val($(this).attr("name")); 
		  $("#actionForm").attr("action","blog_list");
	      $("#actionForm").submit();	   

	});
	
	$("#writeBtn").on("click",function(){
		location.href="blog_make";
	});
	
	$(".paging_area").on("click","span",function(){
		if($(this).attr("name") != "" ){
			$("#page").val($(this).attr("name"));
			reloadList();
		}
	});
});

function reloadList(){
	var params = $("#actionForm").serialize();
	
	$.ajax({
		type : "post", 
		url : "dListAjax", 
		dataType : "json", 
		data : params, 
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
		html += "<tr name=\"" + list[i].BLOG_NO + "\">";
		html += "<td>"+ list[i].BLOG_NO +"</td>";
		html += "<td>"+ list[i].BLOG_NM +"</td>";
		html += "<td>"+ list[i].BLOG_DT+"</td>";
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

</script>
</head>
<body>
<!-- 상단 -->
<div class="main_header">
	<div class="header_top">
		<div class="user_info">
		<c:choose>
			<c:when test="${!empty sBmNo}">
				<div class="user_name">${sBmNm}님 어서오세요.</div> 
				<div class="top_Btn" id="logoutBtn">로그아웃</div>
			</c:when>
			<c:otherwise>
				<div class="top_Btn" id="loginBtn">로그인</div>
			</c:otherwise>
		</c:choose>
		</div>
	</div>
	<div class="header_bottom">Welcome</div>
</div>
<!-- 중간 -->
<div class="main_content">

	<div class="content_left">
		<div class="left_top"></div>
		<div class="left_list">블로그 목록</div>
		<c:if test="${empty sBmNo}">
			<div class="left_login">로그인</div>					
		</c:if>
		<c:if test="${!empty sBmNo}">
			<div class="left_logout">로그아웃</div>
		</c:if>
	</div>
	<div class="content_center">
		<div class="center_title">블로그 목록</div><br/>
		<!-- 글목록 -->
		<div class="center_main">
		<!--검색 -->
			<form action="#" id="actionForm" method="post">
				<input type="hidden" name="page" id="page" value="1"/>
				<input type="hidden" name="num" id="num" value="${sBmNo}" />
				<input type="hidden" name="no" id="no" value="${param.no}" />
				<div class="search">
				<select name="searchGbn" class="dropbox">
					<option value="0">이름</option>
					<option value="1">블로그 명</option>
					<option value="2">이름 + 블로그 명</option>
				</select>
				<input type="text" name="searchTxt" class="searchTxt"/>
				</div>
				<input type="button" value="검색" id="searchBtn" class="searchBtn" style="font-family: 'Cute Font', cursive;"/>
				
				<c:if test="${!empty sBmNo}">
					<input type="button" value="블로그만들기" id="writeBtn" class="writeBtn" style="font-family: 'Cute Font', cursive;"/>
				</c:if>
			</form>
			<br/>
			<div style="display:inline-block;">
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
						<th>블로그 명</th>
						<th>생성일</th>
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
				<span>처음</span>
				<span>이전</span>
				<span>1</span>
				<span>다음</span>
				<span>마지막</span>
			</div>	
		</div>	
		<div class="center_footer">
			<div class="footer_top"></div>
		</div>
	</div>
	<div class="content_right"></div>
</div>
<!-- 하단 -->
<div class="main_footer"></div>
</body>
</html>