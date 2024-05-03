<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">
    
      	<img src="/image/moon.png" alt="Logo" width="50" height="50" class="d-inline-block align-text-center rounded-circle">
      	
    
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/">소개</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/user/list">회원목록</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/bbs/list">게시판</a>
        </li>
      </ul>
       <ul class="navbar-nav mb-2 mb-lg-0">
        <li class="nav-item" id="login">
          <a class="nav-link active" aria-current="page" href="/user/login">로그인</a>
        </li>
         <li class="nav-item" id="uid">
          <a class="nav-link active text-bg-dark rounded-pill hide" aria-current="page" href="/user/mypage"></a>
        </li>
        <li class="nav-item" id="logout">
          <a class="nav-link active" aria-current="page" href="/user/logout">로그아웃</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<script>
	const uid="${user.uid}";
	const uname="${user.uname}";
	//alert(uid,uname);
	if(uid){
		$("#login").hide();
		$("#logout").show();
		$("#uid a").html(uname);
	}else{
		$("#login").show();
		$("#logout").hide();
		$("#uid a").hide();
	}
	
	$("#logout").on("click","a",function(e){
		
		if(confirm("정맣 로그아웃하길래여?")){
			e.preventDefault();
			location.href="/user/logout";
		}
	});
	
	
</script>
