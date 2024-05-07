<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">
    	<span class="navbar-brand text-lg text-bg-secondary  rounded "><b><i class="bi bi-globe mx-2 mt-2 " 
    		style="color:white;" ></i></b></span>
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/"> 학교소개  </a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/pro/list"> 교수관리</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/pro/insert">교수등록</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/stu/list">학생관리</a>
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
