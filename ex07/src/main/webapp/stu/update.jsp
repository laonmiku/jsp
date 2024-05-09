<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	.input-group span{
		width:150px;
	}
	.btn-light{
		border-color:#D8D8D8;
	}
</style>

<div class="row justify-content-center mt-4">
	<div class="col-10 col-md-8">
		<div class="card">
			<div class="card-header">
				<h3 class="text-center">학생정보 수정</h3>
			</div>
			<div class="card-body">
				<form name="frm">
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">학생번호</span>
						<input name="scode" class="form-control" value="${stu.scode}" readonly>
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">학생이름</span>
						<input name="sname" class="form-control"  value="${stu.sname}">
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">학생학과</span>
						<select name="dept" class="form-control">
							<option value="전산" <c:out value="${stu.sdept =='전산'?'selected':''}"/>>컴퓨터정보공학과</option>
							<option value="전자" <c:out value="${stu.sdept =='전자'?'selected':''}"/>>전자공학과</option>
							<option value="건축" <c:out value="${stu.sdept =='건축'?'selected':''}"/>>건축공학과</option>
						</select>
					</div>
					<div class="input-group mb-2">
						<div>
							<span class="input-group-text justify-content-center">학생학년</span>
						</div>
						
							<div class="form-check m-1">
								<input  name="year" value="1" <c:out value="${stu.year =='1'?'checked':''}"/> class="form-check-input" type="radio" >
								<label class="form-check-label">1학년</label>
							</div>
							<div class="form-check m-1">
								<input  name="year" <c:out value="${stu.year =='2'?'checked':''}"/> value="2" class="form-check-input" type="radio">
								<label class="form-check-label">2학년</label>
							</div>
							<div class="form-check m-1">
								<input  name="year" <c:out value="${stu.year =='3'?'checked':''}"/> value="3" class="form-check-input" type="radio">
								<label class="form-check-label">3학년</label>
							</div>		
							<div class="form-check m-1">
								<input  name="year" <c:out value="${stu.year =='4'?'checked':''}"/> value="4" class="form-check-input" type="radio">
								<label class="form-check-label">4학년</label>
							</div>	
						
						
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">지도교수</span>
						<input  name="advisor"class="form-control" value="${stu.advisor}" readonly>
						<input  name="pname"class="form-control" value="${stu.pname}" readonly>
						<button class="btn btn-light" type="button" id="search">검색</button>
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">생년월일</span>
						<input  name="birthday" class="form-control" type="date" value="${stu.birthday}">
					</div>
					<div class="text-center mb-2">
						<button class="btn btn-success">정보수정</button>
						<button class="btn btn-secondary" type="reset">수정취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<jsp:include page="modal.jsp"/>
<script>

	$("#search").on("click",function (){
		$("#modal").modal("show");
	});

	$(frm).on("submit", function(e){
		e.preventDefault();
		const sname=$(frm.sname).val();
		const advisor=$(frm.advisor).val();
		if(sname=="" || advisor==""){
			alert("학생이름과 지도교수를 입력하세요");
			$(frm.sname).focus();
			return;
		}
		if(confirm("학생정보를 수정 하실래요?")){
			frm.method="post";
			frm.submit();
		}
	});
	
</script>