<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

    <nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="/">
    	<span class="navbar-brand text-lg text-bg-secondary  rounded ">
    		<b><i class="bi bi-house-heart m-2" ></i></b></span>
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active <c:out value='${pageName=="/about.jsp"?"active":""}'/>" aria-current="page" href="/"> home </a>
        </li>
        <li class="nav-item">
          <a class="nav-link active <c:out value='${pageName=="/goods/search.jsp"?"active":""}'/>" aria-current="page" href="/goods/search">상품검색</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active <c:out value='${pageName=="/goods/list.jsp"?"active":""}'/>" aria-current="page" href="/goods/list">상품목록</a>
        </li>
        <li class="nav-item" id="cart_menu">
        	<a class="nav-link active" aria-current="page" href="/cart/list">장바구니</a>
        </li>
      </ul>
       <ul class="navbar-nav mb-2 mb-lg-0">
        <li class="nav-item" id="login">
          <a class="nav-link active" aria-current="page" href="/user/login">로그인</a>
        </li>
         <li class="nav-item" id="uid">
          <a class="nav-link active  hide text-bg-secondary rounded" aria-current="page" href="/user/mypage"></a>
        </li>
        <li class="nav-item" id="logout">
          <a class="nav-link active" aria-current="page" href="/user/logout"> 로그아웃</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<script>
	const uid=sessionStorage.getItem("uid");
	const uname=sessionStorage.getItem("uname");
	if(uid){
		$("#login").hide();
		$("#cart_menu").show();
		$("#logout").show();
		$("#uid a").html(uid+"님");
	}else{
		$("#login").show();
		$("#cart_menu").hide();
		$("#logout").hide();
		$("#uid a").hide();
	}
	
	$("#logout").on("click","a",function(e){
		e.preventDefault();
		if(confirm("정맣 로그아웃하길래여?")){
			sessionStorage.clear();
			location.href="/";
		}
	});
</script>
