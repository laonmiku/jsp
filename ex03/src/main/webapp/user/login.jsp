<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	span{ width:100px; }
</style>

<h1>로그인</h1>

<div class="row my-4 justify-content-center">
	<div class="col-8 col-md-6 col-lg-4">
		<div class="card">
			<div class="card-body">
				<form name="frm">
					<div class="input-group mb-3">
						<span class="input-group-text justify-content-center">아이디</span>
						<input name="uid" class="form-control">
					</div>
					<div class="input-group mb-3">
						<span class="input-group-text justify-content-center">비밀번호</span>
						<input name="upass" class="form-control" type="password">
					</div>
					<div>
						<button class="btn btn-dark w-100">☠<b>확인</b>☠</button>
					</div>
					<div class="text-end mt-2">
						<!-- <span><input type="checkbox">로그인상태유지</span> -->
						<a href="/user/join">회원가입</a>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script>
	$(frm).on("submit", function(e){
		e.preventDefault();
		const uid=$(frm.uid).val();
		const upass=$(frm.upass).val();
		if(uid==""){
			alert("아이디를 입력하숑");
		}else if(upass==""){
			alert("비밀번호를 입력하숑");
		}else{
			//로그인체크,,백에서만들어서 여기에쓰기
			$.ajax({
				type:"post",
				url:"/user/login",
				data:{uid:uid,upass:upass},
				success:function(data){
					//alert(data);
					if(data==1){
						alert("로그인 성공 👻")
						location.href="/";
					}else if(data==2){
						alert("비밀번호가 일치하지 않습니다");
						$(frm.upass).val("");
						$(frm.upass).focus();
					}else{
						alert("아이디를 찾을 수 없습니다");
						$(frm.uid).val("");
						$(frm.uid).focus();
					}
				}
			});
		}
	});
</script>