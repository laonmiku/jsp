<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.page-link {
  color: #000; 
  background-color: #fafafa;
  border: 1px solid #ccc ; 
}

.page-item.active .page-link {
 z-index: 1;
 color: #000;
 font-weight:bold;
 background-color: #fff;
 border: 1px solid ;
 
}

.page-link:focus, .page-link:hover {
  color: #000;
  background-color: #fafafa; 
  border-color: #ccc;
}

#size {
   width:100px;
   float:right;
}
</style>

<div>
	<c:choose>
    <c:when test="${uid == 'admin'}">
        <h1>강좌관리</h1>
    </c:when>
    <c:otherwise>
        <h1>강좌목록</h1>
    </c:otherwise>
	</c:choose>
	
	<div class="row">
		<div class="col-8 col-md-6">
			<form name="frm">
				<div class="input-group mb-2">
					<select name="key" class="form-select">
						<option value="lname">강좌이름</option>
						<option value="lcode">강좌번호</option>
						<option value="pname">담당교수</option>
						<option value="room">강의실</option>
					</select>
					<input name="word" placeholder="검색어" class="form-control ms-2">
					<button class="btn btn-dark">검색</button>
					<span id="total" class="mt-2 ms-3"></span>
				</div>
			</form>
		</div>
		<div class="col">
			<select class="form-select" id="size">
				<option value="3">3행</option>
				<option value="5" selected>5행</option>
				<option value="10">10행</option>
			</select>
		</div>
	</div>
	<div id="div_cou"></div>
	<div id="pagination" class="pagination justify-content-center mt-5"></div>
</div>
<script id="temp_cou" type="x-handlebars-template">
	<table class="table table-bordered table-hover">
		<tr class="text-center">
			<td>강좌번호</td>
			<td>강좌이름</td>
			<td>강의시간</td>
			<td>강의실</td>
			<td>신청인원</td>
			<td>담당교수</td>
		</tr>
		{{#each .}}
		<tr class="text-center">
			<td>{{lcode}}</td>
			<td><a href="/cou/read?lcode={{lcode}}">{{lname}}</a></td>
			<td>{{hours}}</td>
			<td>{{room}}</td>
			<td>{{persons}}/{{capacity}}</td>
			<td>{{pname}}({{instructor}})</td>
		</tr>
		{{/each}}
	</table>
</script>
<script>
	let page=1;
	let size=5;
	let key="lname";
	let word="";
	
	//size 변경될때
	$("#size").on("change", function(){
		size=$("#size").val();
		page=1;
		//getData();
		getTotal();
	});
	
	//submit 될때
	$(frm).on("submit", function(e){
		e.preventDefault();
		page=1;
		key=$(frm.key).val();
		word=$(frm.word).val();
		//getData();
		getTotal();
	});
	
	//getData();
	function getData(){
		$.ajax({
			type:"get",
			url:"/cou/list.json",
			data:{page, size, key, word},
			dataType:"json",
			success:function(data){
				const temp=Handlebars.compile($("#temp_cou").html());
				$("#div_cou").html(temp(data));
			}
		});
	}
	
	getTotal();
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/cou/total",
			data:{key, word},
			success:function(data){
				let total=parseInt(data);
				if(total==0) {
					alert("검색데이터가 없습니다!");
					$(frm.word).val("");
					return;
				}
				$("#total").html("검색수: " + total);
				let totalPage=Math.ceil(total/size);
				$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
				
				if(total > size){
					$("#pagination").show();
				}else{
					$("#pagination").hide();
				}
			}
		});
	}
	
	$('#pagination').twbsPagination({
		totalPages:10, 
		visiblePages: 5, 
		startPage : 1,
		initiateStartPageClick: false, 
		first:'<i class="bi bi-chevron-double-left"></i>', 
		prev :'<i class="bi bi-chevron-left"></i>',
		next :'<i class="bi bi-chevron-right"></i>',
		last :'<i class="bi bi-chevron-double-right"></i>',
		onPageClick: function (event, clickPage) {
			 page=clickPage; 
			 getData();
		}
	});
</script>