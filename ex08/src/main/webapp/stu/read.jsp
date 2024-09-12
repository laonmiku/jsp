
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
	table .title{
		background-color:black;
		color:white;
	}
</style>

<div class="row">
	<div class="col">
		<div><h1>학생정보</h1></div>
		<table class="table table-bordered">
			<tr>
				<td class="title">학생번호</td>
				<td>${stu.scode}</td>
				<td class="title">학생이름</td>
				<td>${stu.sname}</td>
				<td class="title">학생전공</td>
				<td>${stu.sdept}</td>
			</tr>
			<tr>
				<td class="title">생년월일</td>
				<td>${stu.birthday}</td>
				<td class="title">학생학년</td>
				<td>${stu.year}학년</td>
				<td class="title">지도교수</td>
				<td> ${stu.pname}  ( ${stu.advisor} )</td>
			</tr>
		</table>
		<c:if test="${uid == 'admin'}">
			<div class="text-center">
				<button class="btn  border border-info me-3" id="update">정보수정</button>
				<button class="btn border border-danger" id="delete">정보삭제</button>
			</div>
		</c:if>
	</div>
</div>   
<jsp:include page="info.jsp"/>
<script>
	//수정버튼
	$("#update").on("click", function(){
		const scode= "${stu.scode}";
		location.href="/stu/update?scode="+ scode;
	});

	//삭제버튼	
	$("#delete").on("click", function(){
		const scode= "${stu.scode}";
		if(confirm(scode+ "번 학생 정보를 삭제하실래요?")){
			//교수삭제
			$.ajax({
				type:"post",
				url:"/stu/delete",
				data:{scode},
				success: function(data){
					//alert(scode);
					if(data=="true"){ //불린값을 스트링으로가져가서 스트링처리해줌	
						alert("삭제완료!");
						location.href="/stu/list";
					}else{
						alert("!!삭제실패 : 해당학생의 수강 정보를 먼저 삭제해주세요!");
					}
				}
			});
		}
	});
	
	
	
</script>