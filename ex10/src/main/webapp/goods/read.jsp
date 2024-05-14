<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 
<div>
	<h1>상품정보</h1>
</div>    


<div>
	<div class="row" >
		<div class="col text-center">
			<img src="${goods.image}" width="80%">
		</div>
		<div class="col ">
			<h3>${goods.title}</h3>
			<hr>
			<div>가격: ${goods.price}</div>
			<div>브랜드: ${goods.brand}</div>
			<div>등록일: ${goods.regDate}</div>
			<div>배송정보: 배송사(CJ), 출고(주문일의 익일까지)</div>
			<div>결제: 국민,하나,토스,카카오페이 가능</div>
			<div class="my-3 text-center">
				<button class="btn border border-dark">바로구매</button>
				<button class="btn border border-dark" id="cart">장바구니</button>
			</div>
		</div>
	</div>
</div>
<script>
	const gid="${goods.gid}";
	$("#cart").on("click",function(){
		if(uid){
			//장바구니에넣기
			$.ajax({
				type:"post",
				url:"/cart/insert",
				data:{uid,gid},
				success:function(data){
					if(data=="true"){
						alert("장바구니에 담겼습니다!");
					}else{
						alert("장바구니에 이미 있는 상품입니다");
					}
				}
			})
		}else{
			sessionStorage.setItem("target","/goods/read?gid="+gid);
			location.href="/user/login";
		}
	});
</script>