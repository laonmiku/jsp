<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<div class="row justify-content-center my-5" id="login">
	<div  class="col-8 dol-md-6 dol-lg-4">
		<div  class="card">
			<div  class="card-header ">
				<h1>로그인</h1>
			</div>
			<div  class="card-body">
				<form name="frm">
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center w-25">아이디</span>
						<input name="uid" class="form-control">
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center w-25">비밀번호</span>
						<input name="upass" class="form-control" type="password">
					</div>
					<div>
						<button class="btn btn-light border  w-100">로그인</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script>
	$(frm).on("submit",function(e){
		e.preventDefault();
		const uid=$(frm.uid).val();
		const upass=$(frm.upass).val();
		if(uid==""){
			alert("아이디를 입력하세요!");
			$(frm.uid).val("");
			$(frm.uid).focus();
			return;
		}
		if(upass==""){
			alert("비밀번호를 입력하세요!");
			$(frm.upass).val("");
			$(frm.upass).focus();
			return;
		}
		//로그인체크
		$.ajax({
			type:"post",
			url:"/user/login",
			data:{uid,upass},
			success:function(data){
				const result = parseInt(data);
				//alert(result);
				if(result==0){
					alert("아이디가 존재하지않습니다");
				}else if(result==2){
					alert("비밀번호가 일치하지 않습니다");
				}else if(result==1){
					sessionStorage.setItem("uid",uid);
					const target=sessionStorage.getItem("target");
					if(target){
						location.href=target;
					}else{
						location.href="/";
					}
				}
			}
		});
	});
</script>