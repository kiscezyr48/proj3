<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터 문의 등록</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<style>
	#container { width: 700px; margin: auto; }
	h1, h3, p { text-align: center; }
	table { border-collapse: collapse; }
	table, th, td {
		border: 1px solid black;
		margin: 0 auto;
	}
	.center { text-align: center; }
	
	.border-none, .border-none td { border: none; }
</style>
<!-- 제이쿼리를 사용하기 위한 스크립트 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script>
	//은송언니 널체크 함수
	function writeQna() {
	    console.log("writeQna() 실행~~")
	    var contentBlank = $("#prdQnaForm").children("textarea").val()
	          .trim();
	    console.log("contentBlank : " + contentBlank);
	    if (contentBlank.length == 0) {
	       alert("내용이 없어요.")
	    } else {
	       document.forms[1].submit();
	    }
	 }
	
	//내용이 비어있으면 alert를 띄우는 함수
	function go_nullCheck() {
		alert("go_nullCheck() 함수 실행~");
        var titleNull = $("#insertCenterQna").find("center_qna_title").val().trim();
        var contentNull = $("#insertCenterQna").find("center_qna_content").val().trim();
        if (titleNull.length == 0) {
        	alert("제목을 입력하세요.");
        } else {
        	if (contentNull.length == 0) {
        		alert("내용을 입력하세요.");
        	} else {
        		document.forms[0].submit();
        	}
        }
    }
		
</script>
</head>
<body>
	<header>
		<jsp:include page="../common/header.jsp"></jsp:include>
	</header>
<div id="container">
	<form id="insertCenterQna" action="insertCenterQnaWrite.do" method="post">
		<input type="hidden" id="user_id" name="user_id" value="${user.user_id }">
	<table class="table table-hover">
		<tr>
			<th class="center">문의제목</th>
			<td>
				<input type="text" name="center_qna_title">
			</td>
		</tr>
		<tr>
			<th class="center">문의내용</th>
			<td>
				<textarea name="center_qna_content" rows="10" cols="40"></textarea>
			</td>
		</tr>
	</table>
	
	<br>
	<p>
		<button type="submit" class="btn btn-outline-secondary btn-sm">문의 하기</button>
		<button type="reset" class="btn btn-outline-secondary btn-sm">초기화</button>
	</p>
	</form>
</div>	
	<!-- footer -->
	<footer>
		<jsp:include page="../common/footer.jsp"></jsp:include>
	</footer>
	
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
</body>
</html>






