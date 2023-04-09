<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.BestDTO"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dao.BestDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/shop/best_list.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<style type="text/css">
.item_area {
    font-size: 20px;
    color: #222;
    text-align: center;
}
.item_title_area1{
	font-size: 50px;
    font-weight: 300;
    text-align: center;
    
}
.item_title_area2{
	font-size: 50px;
    font-weight: 300;
    color: red;
    text-align: center;
    
}

li { list-style: none; }
input[type=text]::-ms-clear { display:none;}
.hidden{visibility:hidden; overflow:hidden; width:0 !important; height:0 !important; margin:0 !important; padding:0 !important; font-size:0; line-height:0;}


ol, ul {
    padding-left: 0px;
}

a {
    color: black;
}
</style>
	
<div id="content">

	<div id="carouselExampleDark" class="carousel carousel-dark slide" data-bs-ride="carousel">
	<!--캐러셀 이미지 영역----------------------------------------------------------------------->
	<div class="carousel-inner" id="mainImg">
	  <div class="carousel-item active" data-bs-interval="10000">
	    <a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_detail&pNo=4004"><img src="<%=request.getContextPath()%>/main/ANSIM.jpg"   class="d-block w-100"></a>
	  <div class="carousel-caption d-none d-md-block">
	  </div>
	</div>
	<div class="carousel-item" data-bs-interval="2000">
	  <a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_detail&pNo=1004"><img src="<%=request.getContextPath()%>/main/DAKGASM.jpg"   class="d-block w-100"></a>
	  <div class="carousel-caption d-none d-md-block">
	  </div>
	</div>
	 <div class="carousel-item">
	  <a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_detail&pNo=5003"><img src="<%=request.getContextPath()%>/main/DESSERT.jpg"   class="d-block w-100"></a>
	    <div class="carousel-caption d-none d-md-block">
	    </div>
	  </div>
	</div>
	<!--캐러셀 이미지 영역----------------------------------------------------------------------->
	<!--캐러셀 양쪽 화살표 영역---------------------------------------------------------------->
	  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="prev">
	    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	    <span class="visually-hidden">Previous</span>
	  </button>
	  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="next">
	    <span class="carousel-control-next-icon" aria-hidden="true"></span>
	    <span class="visually-hidden">Next</span>
	  </button>
	<!--캐러셀 양쪽 화살표 영역---------------------------------------------------------------->
	</div>


<div class="item_area">



	<div class="item_title_area1" style="font-size: 36px; font-weight: 300; color: #222; text-align: center; padding-top: 70px;">
	<strong style="font-size: 36px; color: #222; font-weight: 500;">간식,</strong> 부담없이 즐길 수 있닭!<br>
	<span style="font-size: 16px; font-weight: 300; color: #555; ">든든하지만 칼로리 부담은 적은 간편식,</span><br>
	<span style="font-size: 16px; font-weight: 300; color: #555; ">지금 바로 즐겨보세요</span>
	</div>


<div class="best_container_area">
    <div style="width:940px; margin:0 auto; padding:0px 0 100px;">
        <table class="best_table">
            <colgroup>
                <col width="300">
                <col width="300">
                <col width="300">
            </colgroup>

			<tbody>
			<!-- 1행 -->
			<tr>
				<td>
				
					<!-- dessert 상품이미지 --> 
					<div class="best1">
						<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_detail&pNo=5000&pageNum=1&search=DESSERT"> 
						<img src="<%=request.getContextPath()%>/product_image/5_1.jpg" width="300" height="300">
						</a>
					</div> 
					<!-- dessert 상품명&가격 -->
					<div class="best_item_info">
						<div class="best_item_name">닭가슴살 한끼<br> 브리또 오리지널</div> 
						<div class="best_item_price">25,200<span>원</span></div>
					</div>
				</td>
				<td class="td_center">
				
					<!-- dessert 상품이미지 --> 
					<div class="best1">
						<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_detail&pNo=5001&pageNum=1&search=DESSERT"> 
							<img
							src="<%=request.getContextPath()%>/product_image/5_2.jpg" width="300" height="300">
						</a>
					</div> 
					<!-- dessert 상품명&가격 -->
					<div class="best_item_info">
						<div class="best_item_name">닭가슴살 한끼<br> 소세지빵</div> 
						<div class="best_item_price">15,300<span>원</span></div>
					</div>
					
				</td>
				<td>
				
					<!-- dessert 상품이미지 --> 
					<div class="best1">
						<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_detail&pNo=5002&pageNum=1&search=DESSERT"> 
							<img
							src="<%=request.getContextPath()%>/product_image/5_3.jpg" width="300" height="300">
						</a>
					</div> 
					<!-- dessert 상품명&가격 -->
					<div class="best_item_info">
						<div class="best_item_name">닭가슴살 크리스피 <br>핫도그 훈제</div> 
						<div class="best_item_price">20,800<span>원</span></div>
					</div>
				</td>
			</tr>
			
			
			
			
			
			<!-- 2행 -->
			<tr>
				<td>
	
					<!-- dessert 상품이미지 --> 
					<div class="best">
						<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_detail&pNo=5003&pageNum=1&search=DESSERT"> 
							<img
							src="<%=request.getContextPath()%>/product_image/5_7.jpg" width="300" height="300">
						</a>
					</div> 
					<!-- dessert 상품명&가격 -->
					<div class="best_item_info">
						<div class="best_item_name">닭가슴살 한끼 <br>쉐이크 혼합</div> 
						<div class="best_item_price">25,500<span>원</span></div>
					</div>
				</td>
				<td class="td_center">
					
					<!--dessert 상품이미지 --> 
					<div class="best1">
						<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_detail&pNo=5004&pageNum=1&search=DESSERT"> 
							<img
							src="<%=request.getContextPath()%>/product_image/5_5.jpg" width="300" height="300">
						</a>
					</div> 
					<!-- dessert 상품명&가격 -->
					<div class="best_item_info">
						<div class="best_item_name">닭가슴살 한끼 <br>고백칩 오리지널</div> 
						<div class="best_item_price">13,600<span>원</span></div>
					</div>
				</td>
				<td>
			
					<!-- dessert 상품이미지 --> 
					<div class="best1">
						<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_detail&pNo=5005&pageNum=1&search=DESSERT"> 
							<img
							src="<%=request.getContextPath()%>/product_image/5_6.jpg" width="300" height="300">
						</a>
					</div> 
					<!-- dessert 상품명&가격 -->
					<div class="best_item_info">
						<div class="best_item_name">닭가슴살 한끼<br>크로크무슈 오리지널</div> 
						<div class="best_item_price">18,600<span>원</span></div>
					</div>
				</td>
			</tr>
			
			
			
			</tbody>
		</table>
		
    </div>  
</div>
</div>

 
<div class="best_container_area">
    <div style="width:940px; margin:0 auto; padding:0px 0 100px;">
<ul></ul>  
 

<div class="item_title_area2" style="font-size: 36px; font-weight: 300; color: #222; text-align: center;">
<br>' 지금 제일 ' 
<strong style="font-size: 36px; color: #222; font-weight: 500;">잘나가</strong><br>
<span style="font-size: 16px; font-weight: 300; color: #555; ">가장 핫한 아이들만 모았어요!</span>
</div>

    <table class="best_table">
            <colgroup>
                <col width="300">
                <col width="300">
                <col width="300">
            </colgroup>

			<tbody>
			<!-- 1행 -->
			<tr>
				<td>
				
					<!-- best 상품이미지 --> 
					<div class="best">
						<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_BEST_detail&BtNo=1000"> 
							<img
							src="<%=request.getContextPath()%>/product_image/1_1.jpg" width="300" height="300">
						</a>
					</div> 
					<!-- best 상품명&가격 -->
					<div class="best_item_info">
						<div class="best_item_name">닭가슴살 큐브 고추</div> 
						<div class="best_item_price">24,100<span>원</span></div>
					</div>
				</td>
				<td class="td_center">
			
					<!-- best 상품이미지 --> 
					<div class="best">
						<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_BEST_detail&BtNo=1001"> 
							<img
							src="<%=request.getContextPath()%>/product_image/1_2.jpg" width="300" height="300">
						</a>
					</div> 
					<!-- best 상품명&가격 -->
					<div class="best_item_info">
						<div class="best_item_name">닭가슴살 스테이크 오리지널</div> 
						<div class="best_item_price">20,790<span>원</span></div>
					</div>
				</td>
				<td>
	
					
					<!-- best 상품이미지 --> 
					<div class="best">
						<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_BEST_detail&BtNo=1002"> 
							<img
							src="<%=request.getContextPath()%>/product_image/1_3.jpg" width="300" height="300">
						</a>
					</div> 
					<!-- best 상품명&가격 -->
					<div class="best_item_info">
						<div class="best_item_name">한입 소스 닭가슴살 짜장</div> 
						<div class="best_item_price">21,300<span>원</span></div>
					</div>
				</td>
			</tr>
			
			
			
			
			
			<!-- 2행 -->
			<tr>
				<td>
				
					<!-- best 상품이미지 --> 
					<div class="best">
						<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_BEST_detail&BtNo=1003"> 
							<img
							src="<%=request.getContextPath()%>/product_image/1_4.jpg" width="300" height="300">
						</a>
					</div> 
					<!-- best 상품명&가격 -->
					<div class="best_item_info">
						<div class="best_item_name">닭가슴살 볼 스파이시</div> 
						<div class="best_item_price">23,000<span>원</span></div>
					</div>
				</td>
				<td class="td_center">
					
					<!-- best 상품이미지 --> 
					<div class="best">
						<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_BEST_detail&BtNo=1004"> 
							<img
							src="<%=request.getContextPath()%>/product_image/1_7.jpg" width="300" height="300">
						</a>
					</div> 
					<!-- best 상품명&가격 -->
				<div class="best_item_info">
						<div class="best_item_name">스팀 닭가슴살 혼합</div> 
						<div class="best_item_price">21,900<span>원</span></div>
					</div>
				</td>
				<td>
				
					<!-- best 상품이미지 --> 
					<div class="best">
						<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_BEST_detail&BtNo=1005"> 
							<img
							src="<%=request.getContextPath()%>/product_image/1_6.jpg" width="300" height="300">
						</a>
					</div> 
					<!-- best 상품명&가격 -->
				<div class="best_item_info">
						<div class="best_item_name">소프트 닭가슴살 고추</div> 
						<div class="best_item_price">17,500<span>원</span></div>
					</div>
				</td>
			</tr>
			
			
			
			</tbody>
		</table>
    </div>  
</div>
</div>
  


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

	
</body>
</html>