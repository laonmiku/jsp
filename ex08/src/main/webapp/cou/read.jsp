
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
		<div><h1>강좌정보</h1></div>
		<table class="table table-bordered">
			<tr>
				<td class="title">강의번호</td>
				<td>${cou.lcode}</td>
				<td class="title">강의이름</td>
				<td colspan="3">${cou.lname}</td>
			</tr>
			<tr>
				<td class="title">강의실</td>
				<td>${cou.room}</td>
				<td class="title">신청인원</td>
				<td>${cou.persons}/${cou.capacity}</td>
				<td class="title">담당교수</td>
				<td> ${cou.pname}  ( ${cou.instructor} )</td>
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
		const lcode= "${cou.lcode}";
		location.href="/cou/update?lcode="+ lcode;
	});

	//삭제버튼	
	$("#delete").on("click", function(){
		const lcode= "${cou.lcode}";
		if(confirm(lcode+ "번 강좌 정보를 삭제하실래요?")){
			//강좌삭제
			$.ajax({
				type:"post",
				url:"/cou/delete",
				data:{lcode},
				success: function(data){
					alert(data);
					if(data=="true"){
						alert("삭제완료!");
						location.href="/cou/list";
					}else{
						alert("!!삭제실패: 해당강좌를 신청한 학생이 존재합니다!");
					}	
				}
			});
		}
	});
	
	
	
</script>