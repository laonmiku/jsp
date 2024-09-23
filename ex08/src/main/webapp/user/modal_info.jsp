<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>	
	
<style>
#modalInfo {
	top: 10%;
}
</style>
<!-- 정적백드롭 모달 -->

<!-- Modal -->
<div class="modal fade" id="modalInfo" data-bs-backdrop="static"
	data-bs-keyboard="false" tabindex="-1"
	aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title fs-5" id="staticBackdropLabel">정보수정</h1>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="input-group mb-3">
				  <span class="input-group-text mb-1" id="basic-addon1">name</span>
				  <input id="uname" class="form-control mb-1" placeholder="이름" value="${user.uname}">
				</div>
				
        	</div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button id="btnSave" type="button" class="btn btn-primary">SAVE</button>
      </div>
    </div>
  </div>
</div>

<script>
	$("#btnSearch").on("click", function(){
	    new daum.Postcode({
	          oncomplete:function(data){
	              console.log(data);
	              const building=data.buildingName;
	              let address="";
	              if(building!=""){
	                  address=data.address + "(" + building + ")";
	              }else{
	                  address=data.address;
	              }
	              $("#address1").val(address);
	          }
	      }).open();
	 });
	
	
	$("#modalInfo").on("click","#btnSave",function(){
		const uname=$("#uname").val();
		const phone=$("#phone").val();
		const address1=$("#address1").val();
		const address2=$("#address2").val();
		console.log(uname,phone,address1,address2,uid);
		if(confirm("수정하시겠습니까?")){
			//수정하기,,유저서블릿에서 가져옴,,
			//$("#modalInfo").modal("hide");
			$.ajax({
				type:"post",
				url:"/user/update",
				data:{uid,uname,phone,address1,address2},
				success:function(){
					alert("수정완료!");
					location.href="/user/mypage";
				}
			});
		}
	});
</script>

