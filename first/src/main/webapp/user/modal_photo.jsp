<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
    
<style>
#modalPhoto {
	top: 10%;
}
</style>
<!-- Modal -->
<div class="modal fade" id="modalPhoto" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">사진변경</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body text-center">
      <!--  jstl안머금 ㅠㅠ
      <c:if test="${user.photo!=null}">
	        <img id="photo" src="${user.photo}" width="300">
	        <input id="file" type="file" style="display:none;">
       </c:if>
       <c:if test="${user.photo==null}">
	        <img id="photo" src="http://via.placeholder.com/50x50" width="300">
	        
       </c:if> 
       -->
       <img id="photo" src="">
       <input id="file" type="file" style="display:none;">
      </div>
      
      <div class="text-center mb-5">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button id="btnSave" type="button" class="btn btn-primary">확인</button>
      </div>
	  
    </div>
  </div>
</div>

<script>
	
	$("#file").on("change",function(e){
		$("#photo").attr("src",URL.createObjectURL(e.target.files[0]));
	});
	$("#photo").on("click",function(){
		$("#file").click();
	});
	
	$("#modalPhoto").on("click","#btnSave",function(){
		if($("#file").val()==""){
			alert("변경할 사진을 선택하세요!")
		}else{
			if(confirm("사진을 업데이트하실래요?")){
				//사진수정하기
				const file=$("#file")[0].files[0]; //사진선택을 여러개하면 배열이되니까 배열0번만되라고!
				const formData = new FormData();
				formData.append("photo", file);
				formData.append("uid", uid);
				$.ajax({
					type:"post",
					url:"/user/upload",
					data: formData,
					processData:false,
					contentType:false,
					success:function(){
						alert("사진 업로드 성공")
						location.reload(true);
					}
				});
			}
		}	
	});
</script>