<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품상세페이지</title>
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
   crossorigin="anonymous">

<link rel="canonical"
   href="https://getbootstrap.kr/docs/5.1/examples/album/">

<!-- Bootstrap core CSS -->
<link href="/docs/5.1/dist/css/bootstrap.min.css" rel="stylesheet"
   integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
   crossorigin="anonymous">
<link href="common/styles.css" rel="stylesheet">
</head>
<style>
.totPage {
   margin: auto;
   width: 1100px;
   padding: 30px;
   
}
.goods{
   position: relative;
}

.prdNamePrice {
   padding: 30px;
}
textarea {
   width: 1040px;
   height: 100px;
}

.prdInfoPic {
   width: 1040px;
}
.d-grid {
   padding-top: 15px;
}
#litag {
   display: -webkit-box;
   display: -moz-box;      
   display: -ms-flexbox;   
   display: -webkit-flex;   
   display: flex;   
   margin: 15px 0px;
}
#tit {
   width: 450px;
   position: absolute;
   top: 5px;
   left: 550px;
}
 .box {margin:20px auto;}
    .content {
        width:800px;
        padding:10px;
        border:1px solid #ddd;
    }
 .star {
    width: 70px;
 }
 .reviewid {
    width: 60px;
 }
 .reviewdt {
    width: 120px;
 }
</style>
<body>
<script>
var product_id = "<c:out value='${product.product_id}'/>";
var nowPage = "<c:out value='${paging.nowPage}'/>";	

/* $(function() {
   $(document).ready(function() {
      $('select[name=product_cnt]').change(function() {
         $('#product_cnt').val($(this).val());
            $("#product_cnt").attr("readonly", true);
         });
      });
   });
); */


function replyList(nowPage, product_id) {
	/* alert("replyList() 실행");
	alert("nowPage : " + nowPage +"\nproduct_id : " + product_id); */
	
	$.ajax({
		url : "qnaWithPaging.do",
		type : "post",
		data : {
			'product_id' : product_id,
			'nowPage' : nowPage
		},
		dataType : "json",
		success : function(data){
			var a = '';
			var paging = data.paging;
			var qnaList = data.qnaList;
			var product = data.product;
			
			if(qnaList == null){
				a += '<p>등록된 게시물이 없습니다.</p>';
			}
			$.each(qnaList, function(key, value){
				
				if (value.q_or_a == 0) {
					a += '<div class="prdQnaContent">';
					a += '<p>'+value.qna_content+'</p>';
					a += '<small>'+value.user_nickname+'</small>';
					a += '<hr></div>';
				} else {
					a += '<div class="prdQnaContent">';
					a += '<p>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ [답변완료] '+value.qna_content+'</p>';
					a += '<hr></div>';
				}
				
			});
			
			a+='<nav aria-label="Page navigation example">';
			a+='<ul class="pagination">';
			
			/* alert("paging.startPage : " + paging.startPage+"\npaging.endPage : " + paging.endPage); */
			if (paging.startPage != 1){
				a+='<li class="page-item">';
				a+='<a class="page-link" onclick="replyList('+paging.startPage+'-'+1+',\''+product.product_id+'\')" aria-label="Previous">';
				a+='<span aria-hidden="true">&laquo;</span></a></li>';
			} 
			
			for(var num = paging.startPage; num <= paging.endPage; num++){
				 if(num == paging.nowPage){
					a+='<li class="page-item"><b class="page-link" >'+num+'</b></li>';
				} else {
					a+='<li class="page-item"><a class="page-link" onclick="replyList('+num+',\''+product.product_id+'\')">'+num+'</a></li>';
				} 
			}
			
			if(paging.endPage != paging.lastPage){
				a+='<li class="page-item">';
				a+='<a class="page-link" onclick="replyList('+paging.startPage+'+'+3+',\''+product.product_id+'\')" aria-label="Previous">';
				a+='<span aria-hidden="true">&raquo;</span></a></li>';
			}
					
			a+='</ul></nav>';
			$('.prdList').html(a);
		},
		error : function(){
			alert("오류발생");
		}
	});
} 

</script>
   <!-- header -->
   <header>
      <jsp:include page="../common/header.jsp"></jsp:include>
   </header>
   <!-- -------------------------------- -->
   <div class="totPage">
   
<nav id="navbar-example2" class="navbar navbar-light bg-white px-3 sticky-lg-top border-bottom border-top">
  <a class="navbar-brand" href="#"><img src="./img/상세페이지위로.png" alt="상세페이지위로로고" width="20"></a>
  <ul class="nav nav-pills">
    <li class="nav-item">
      <a class="nav-link text-dark" href="#scrollspyHeading1"><strong>상품 설명</strong></a>
    </li>
    <li class="nav-item">
      <a class="nav-link text-black-50"><small>|</small></a>
    </li>
    <li class="nav-item">
      <a class="nav-link text-dark" href="#scrollspyHeading2"><strong>상세 정보</strong></a>
    </li>
    <li class="nav-item">
      <a class="nav-link text-black-50"><small>|</small></a>
    </li>
    <li class="nav-item">
      <a class="nav-link text-dark" href="#scrollspyHedding3"><strong>후기<span class="text-danger">(1,800[지영아 후기갯수넣으렴])</span></strong></a>
     </li>
     <li class="nav-item">
      <a class="nav-link text-black-50"><small>|</small></a>
    </li>
     <li class="nav-item"> 
      <a class="nav-link text-dark" href="#scrollspyHedding4"><strong>상품 문의</strong></a>
     </li>
  </ul><hr>
</nav>
   <div class="goods">
              <img src="./img/과일주스여러개.jpg" alt="..." width= "480px" height="448px">
           <div id="tit">
              <div class="h3"><strong>${product.product_name }</strong></div>
              <div class="text-black-50 h5"><small>건강하게 마시는</small></div>   
           <hr>
           <div class="item">
              <ul class="list-inline">
                 <li id="litag">
                    <strong>정가</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <div>
                    <del>
                    <span>12,000</span>
                    원 
                    </del>
                    </div>
                 </li>
                 <li class="price " id="litag">
                      <strong>판매가</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      <div>
                          <strong style="color:#d1221d;">7,200</strong><strong style="color:#d1221d; font-size:14px;">원</strong>
                  <strong style="color:#d1221d; font-size:14px;">(40%)</strong>
                      </div>
                  </li>
                  <li id="litag">
                     <strong>구매제한</strong> &nbsp;&nbsp;&nbsp;&nbsp;
                     <div>
                         <span> 최소  1개  </span>
                     </div>
                  </li>
                   <li id="litag">
                     <strong>상품구분</strong> &nbsp;&nbsp;&nbsp;&nbsp;
                     <div>
                         <span> 식품  </span>
                     </div>
                     
                 <form action="cart/insert.do" method="post" enctype="multipart/form-data">
                  <input type="hidden" name="product_id"
					value="${product.product_id}"> <input type="hidden"
					id="product_cnt" value="product_cnt">
					<input type="hidden"
					name="user_id" value="${user_id}">
						
                  </li>
                   <li id="litag">
                     <strong>수량</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     <div>
                         <span>
                            <select name="cart_product_qty"  style="font-size:15px;" >
                           <option value="1" selected>1</option>
                           <option value="2">2</option>
                           <option value="3">3</option>
                           <option value="4">4</option>
                           <option value="5">5</option>
                           <option value="6">6</option>
                           <option value="7">7</option>
                        </select>
                         </span>
                     </div>
                  </li>
                  <li><br><br></li>
                  <li>
                     <div class="d-grid gap-2 mx-auto">
                     <input class="btn btn-block btn-outline-success" type="submit" value="장바구니 담기">
                   </form>  
                   <form action="cart/orderDirect.do" method="post" enctype="multipart/form-data">
						<!-- <input class="btn btn-primary" type="submit" value="구매하기">
						 --><input type="hidden" name="product_id"
						value="${product.product_id}"> <input type="hidden" 
						id="cart_product_qty" value="cart_product_qty">
	                     <input class="btn btn-block btn-success" type="submit" value="바로 구매하기">
	                     <!-- <input type="hidden" type="number" name ="cart_product_qty" value="cart_product_qty">  -->
				   </form>
                     
                  </div>
               </li>
              </ul>
           </div>
        </div>
     </div>
     <hr>
     <br>
<div data-bs-spy="scroll" data-bs-target="#navbar-example2" data-bs-offset="0" class="scrollspy-example" tabindex="0">
  <h4 id="scrollspyHeading1"><strong>상품 설명</strong></h4>
  <div class="productInfo">
         <img src="./img/고무밴드.jpg" alt="..." class="prdInfoPic">
     <h1>설명은 여기에~~</h1>
  </div>
  <h4 id="scrollspyHeading2"><strong>상세 정보</strong></h4>
  <p>상세 정보는 여기에~~~~</p>
  <h4 id="scrollspyHedding3"><strong>상품후기<span class="text-danger">(1,800[지영아 후기갯수넣으렴])</span></strong></h4>
      <div class="reviewZone">
         <hr>
         <p>
            <a class="text-dark text-decoration-none"><strong>베스트순</strong></a><small class="text-muted"> | </small> 
            <a class="text-dark text-decoration-none"><strong>최신순</strong></a>
         </p>
         
         <!-- forEach 쓰걸아 -->
   <div class="reviewComment">
      <table class="table table-hover">
        <thead>
          <tr>
            <th scope="col" class="star text-start"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">별점</font></font></th>
            <th scope="col"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">후기내용</font></font></th>
            <th scope="col" class="reviewid "><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">아이디</font></font></th>
            <th scope="col" class="reviewdt text-end"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">후기등록일</font></font></th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <th scope="row" class="star text-start">*****</th>
            <td><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">맛이 좋아요~(내용)</font></font></td>
            <td class="reviewid text-end"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;"><strong>ID222332</strong></font></font></td>
            <td class="reviewdt text-end"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;"><small class="text-muted">2022-06-05</small></font></font></td>
          </tr>
        </tbody>
      </table>
    </div>
    </div>
   
  <h4 id="scrollspyHedding4"><strong>상품 문의</strong></h4>
  <hr>
  	
  	<div class="prdList">
	
		<script>
		replyList(nowPage, product_id);
		</script>

	</div>
	
	<c:choose>
		<c:when test="${empty user }">
			<br>
			<p>상품문의는 로그인 후 가능합니다.</p>
			<a href="login.do">로그인</a>
		</c:when>
		<c:otherwise>
			<div id="prdQnaWrite">
				<%-- <form id="prdQnaForm" action="insertPrdQna.do?product_id=${product.product_id }"method="post">
				 --%><form id="prdQnaForm" role="form" method="post">
					<textarea id="txtara" name="qna_content"></textarea>
				</form>
					<button type="button" id="testBtn" onclick="writeQna()">등록</button>
			</div>
		</c:otherwise>
	</c:choose>
  
  <%-- <div class="prdQnaZone">
  <!-- forEach 스세요 -->
         <c:set var="qna" value="${productQnaList }" />
         <c:choose>
            <c:when test="${empty productQnaList }">
               <p>등록된 게시물이 없습니다.</p>
            </c:when>
            <c:otherwise>
               <c:forEach var="productQnaNick" items="${productQnaList }">
                  <c:choose>
                     <c:when test="${0 eq productQnaNick.q_or_a }">
                        <div class="prdQnaContent">
                           <p>${productQnaNick.qna_content }</p>
                           <p>${productQnaNick.user_nickname }</p>
                           <hr>
                        </div>
                     </c:when>
                     <c:otherwise>
                        <div class="prdQnaContent">
                           <p>&nbsp;&nbsp;&nbsp;[답변완료] ${productQnaNick.qna_content }</p>
                           <hr>
                        </div>
                     </c:otherwise>
                  </c:choose>
               </c:forEach>
            </c:otherwise>
         </c:choose>

         <c:choose>
            <c:when test="${empty user }">
               <p>상품문의는 로그인 후 가능합니다.</p>
               <a href="login.do?product_id=${product.product_id }">로그인 하기</a>
               <form action="login.do">
               <input type="submit" value="로그인">
               </form>
            </c:when>
            <c:otherwise>
               <div id="prdQnaWrite" class="prdInput">
                  <form id="prdQnaForm"
                     action="insertPrdQna.do?product_id=${product.product_id }"
                     method="post">
                     <textarea name="qna_content"></textarea>
                     <button type="button" id="testBtn" onclick="writeQna()">상품문의
                        등록</button>
                  </form>
               </div>
            </c:otherwise>
         </c:choose>
      </div> --%>
      
      
   </div>
  </div>
  
<script>

function writeQna() {
	console.log("writeQna() 실행~~")
	var contentBlank = $("#prdQnaForm").children("textarea").val()
			.trim();
	console.log("contentBlank : " + contentBlank);
	if (contentBlank.length == 0) {
		alert("내용이 없어요.");
	} else {
		alert("product_id, nowPage : " + product_id +','+nowPage);
		
		var formObj = $("#prdQnaWrite form[role='form']");
		var qna_content = $("#txtara").val();
		
		/* alert("formObj,qna_content :" +formObj+","+ qna_content); */
		
		var data = {
			'nowPage' : null,
			'qna_content' : qna_content,
			'product_id' : product_id
					};
		alert("data : " + data);
		
		$.ajax({
			url : 'writePrdQna.do',
			type : 'post',
			data : data,
			success : function(){
				alert("formObj,qna_content :" +formObj+","+ qna_content);
				$("#txtara").val("");
				replyList(nowPage, product_id);
			},
			error : function(){
				alert("오류발생");
			}
		});
	}
}
	
</script>


   <!-- footer -->
   <jsp:include page="../common/footer.jsp"></jsp:include>
   <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
      crossorigin="anonymous"></script>
</body>
</html>