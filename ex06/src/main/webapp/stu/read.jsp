
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
		<div class="text-center">
			<button class="btn  border border-info me-3" id="update">정보수정</button>
			<button class="btn border border-danger" id="delete">정보삭제</button>
		</div>
	</div>
</div>   

<script>
	//수정버튼
	$("#update").on("click", function(){
		const pcode= "${pro.pcode}";
		location.href="/pro/update?pcode="+ pcode;
	});

	//삭제버튼	
	$("#delete").on("click", function(){
		const pcode= "${pro.pcode}";
		if(confirm(pcode+ "번 교수 정보를 삭제하실래요?")){
			//교수삭제
			$.ajax({
				type:"post",
				url:"/pro/delete",
				data:{pcode},
				success: function(data){
					if(data==1){	
						alert("삭제완료!");
						location.href="/pro/list";
					}else{
						alert("!!삭제실패 : 해당교수의 지도학생 및 담당과목 정보를 먼저 삭제해주세요!");
					}
				}
			});
		}
	});
</script>