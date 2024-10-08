<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">홍길똥</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/">회사소개</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/kakao/book">도서검색</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/kakao/local">지역검색</a>
        </li>
      </ul>
       <ul class="navbar-nav mb-2 mb-lg-0">
        <li class="nav-item" id="login">
          <a class="nav-link active" aria-current="page" href="/user/login">로그인</a>
        </li>
         <li class="nav-item" id="uid">
          <a class="nav-link active text-bg-dark rounded-pill" aria-current="page" href="/user/mypage"  ></a>
        </li>
        <li class="nav-item" id="logout">
          <a class="nav-link active" aria-current="page" href="/user/logout">로그아웃</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<script>
	const uid="${uid}";
	if(uid){
		$("#login").hide();
		$("#logout").show();
		$("#uid").show();
		$("#uid a").html(uid);
	}else{
		$("#login").show();
		$("#logout").hide();
		$("#uid").hide();
	}
	
	$("#logout").on("click","a",function(e){
		e.preventDefault();
		if(confirm("로그아웃하실래요")){
			location.href="/user/logout";
		}
	});
</script>