<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<style>
	 .modal-body img, .card-body img{ 
		border-radius: 50%;
		border: 1px solid gray;
		cursor: pointer; 
	}
	.date {
	 font-size : 0.8rem;
	 color : gray;
	}
</style>

<div class="row justify-content-center">
	<div class="col-10 col-md-8 col-lg-6">
		<h1>마이페이지</h1>
		<div class="card">
			<div class="card-body">
				<div>
					<span> 이름: ${user.uname} ( ${user.uid} )</span>
					<button class="btn  btn-secondary btn-sm ms-3" id="btnPass">비밀번호변경</button>
					<hr>
				</div>   
				<div>
					<div class="w-100" >${user.memo}</div>
				</div>
				<hr/>
				<div class="row">
					<div class=" col date">
						가입일 : <fmt:formatDate value="${user.jdate}" pattern="yyyy년MM월dd일 HH:ss"/>
					</div>
					<div class=" col date">
						수정일 : <fmt:formatDate value="${user.udate}" pattern="yyyy년MM월dd일 HH:ss"/>
					</div>
				</div>
				<hr/>
				<div class="text-center my-3">
					<button class="btn btn-success px-5" id="btnInfo">수정</button>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="modal_info.jsp"/>
	<jsp:include page="modal_pass.jsp"/>
</div>

<script>
	
	$("#btnInfo").on("click",function(){
		$("#modalInfo").modal("show");
	});//부트스트랩메소드
	$("#btnPass").on("click",function(){
		$("#modalPass").modal("show");
	});
	$("#imgPhoto").on("click",function(){
		$("#modalPhoto").modal("show");
	});
</script>