<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	 #modalPass{
      top:30%;
</style>
<!-- 정적백드롭 모달 -->

<!-- Modal -->
<div class="modal fade" id="modalPass" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">비밀번호변경</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <input id="upass" placeholder="현재 비밀번호" type="password" class="form-control mb-2">
        <input id="npass" placeholder="새로운 비밀번호" type="password" class="form-control mb-2">
        <input id="cpass" placeholder="새로운 비밀번호 확인" type="password" class="form-control mb-2">
      </div>
      <div class="text-center mb-5">
        <button type="button" class="btn btn-secondary" 
        					data-bs-dismiss="modal">Close</button>
        <button id="btnSave"type="button" class="btn btn-primary">확인</button>
      </div>
    </div>
  </div>
</div>

<script>
	$("#modalPass").on("click","#btnSave",function(){
		const upass=$("#upass").val();	
		const npass=$("#npass").val();	
		const cpass=$("#cpass").val();	
		if(upass=="" || npass=="" || cpass==""){
			alert("모든 비밀번호를 입력하세요!");
		}else{
			$.ajax({
				type:"post",
				url:"/user/login",
				data:{uid,upass},
				success:function(data){
					if(data==2){
						alret("현재비밀번호가 일치하지 않습니다!");
						$("upass").val("");
						$("upass").focus();
					}else{
						if(npass!=cpass){
							alter("새비밀번호가 일치하지 않습니다!")
						}else{
							//비밀번호변경
							if(! confirm("비밀번호를 변경하실래요?!"))return;
							//취소누르면 리턴해서 나가게됨 변경전에 컨펌창이뜸!
							$.ajax({
								type:"post",
								url:"/user/update/pass",
								data:{uid,npass}, //유저서블릿으로감
								success:function(){
									alert("비밀번호 변경완료!");
									location.href="/user/logout";
								}
							});
						}
					}
				}
				
			})
		}
		
	});
	
</script>