<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class="row justify-content-center my-5">
	<div class="col-10 col-md-8 col-lg-6">
		<div class="card">
			<div class="card-header">
				<h3 class="text-center">회원가입</h3>
			</div>
			<div class="card-body">
				<form name="frm">
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center px-3"> 아이디 </span>
						<input name="uid" class="form-control">
						<button id="btnCheck" type="button" class="btn btn-outline-primary">중복체크</button>
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center px-2">비밀번호</span>
						<input name="upass" class="form-control" type="password">
					</div>
					<div class="input-group mb-3">
						<span class="input-group-text justify-content-center px-4">이름</span>
						<input name="uname" class="form-control">
					</div>
					<div class="text-center">
						<button class="btn btn-success px-4">가입</button>
						<button class="btn btn-secondary px-4" type="reset">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script>
	let check=false;
	
	$(frm).on("submit",function(e){
		e.preventDefault();
		const uid=$(frm.uid).val();
		const upass=$(frm.upass).val();
		const uname=$(frm.uname).val();
		if(uid=="" || upass=="" || uname==""){
			alert("모든 정보를 입력하세요!")
			return;
		}
		if(!check){
			alert("아이디 중복 체크를 해주세요!")
			return;
		}
		if(confirm("회원가입하실래요")){
			//회원가입,,써블릿에 두포스트에서 가져옴 에이작으로호출!
			$.ajax({
				type:"post",
				url:"/user/join",
				data:{uid,upass,uname},
				success:function(){
					alert("회원가입완료!");
					location.href="/user/login"
				}
			});
		}
	});
	
	//중복체크버튼을 클릭한경우
	$("#btnCheck").on("click",function(){
		const uid=$(frm.uid).val();
		if(uid==""){
			alert("아이디를 입력하세요!")
			return;
		}
		$.ajax({
			type:"post",
			url:"/user/login",
			data:{uid},
			success:function(data){
				if(data==0){
					alert("사용가능합니다!")
					check=true;//아이디바끼면 계속해줘야하니까 아래에 함수또만들어줌!
				}else{
					alert("이미 사용중인 아이디입니다!")
				}
			}
			
		});
	});
	
	//아이디가 바뀐 경우 
	$(frm.uid).on("change",function(){
		check=false;
	});
	
</script>