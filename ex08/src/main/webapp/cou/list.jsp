<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
 	<h1>강좌관리</h1>
 	<div class="row">
 		<div class="col-8 col-md-6">
 			<form name="frm">
 				<div class="input-group mb-2">
 					<select name="key" class="form-select">
 						<option value="lname">강좌명</option>
 						<option value="lcode">강좌번호</option>
 						<option value="pname">담당교수</option>
 						<option value="room">강의실</option>
 					</select >
 					<input placeholder="검색어" name="word" class="form-control ms-2">
					<button class="btn btn-dark">검색</button>
					<span id="total" class="mt-2 ms-2 p-1 border border-secondary-subtle text-body-secondary rounded-2"></span>
 				</div>
 			</form>
 		</div>
 		<div class="col">
 			<select name="size" class="form-select" id="size">
 				<option value="1">1행</option>
 				<option value="2">2행</option>
 				<option value="3">3행</option>
 				<option value="4">4행</option>
 				<option value="5" selected>5행</option>
 			</select>
 		</div>
 	</div>
 	<div id="div_cou"></div>
 	<div id="pagination" class="pagination justify-content-center mt-2"></div>
 </div>
 <script id="temp_cou" type="x-handlebars-template">
	<table class=" table  table table-striped text-center">
		<tr class="table-dark ">
			<td>강좌번호</td>
			<td>강좌이름</td>
			<td>강의시간</td>
			<td>강의실</td>
			<td>신청인원</td>
			<td>담당교수</td>
		</tr>
		{{#each .}}
			<tr>
				<td>{{lcode}}</td>
				<td><a href ="/cou/read?lcode={{lcode}}">{{lname}}</a></td>
				<td>{{hours}}시간</td>
				<td>{{room}}</td>
				<td>{{persons}}명/{{capacity}}명</td>
				<td>{{pname}} ({{instructor}})</td>
			</tr>
		{{/each}}
	</table>
</script>

<script>
	let page=1;
	let size=$("#size").val();
	let key=$(frm.key).val();
	let word=$(frm.word).val();
	
	$("#size").on("change", function(){
		size=$("#size").val();
		page=1;
		//getData();
		getTotal();
	})
	
	$(frm).on("submit",function(e){
		e.preventDefault();
		page=1;
		key=$(frm.key).val();
		word=$(frm.word).val();
		//getData();
		getTotal();
	})
	
	getTotal();
	//getData();
	function getData(){
		$.ajax({
			type: "get",
			url:"/cou/list.json",
			data:{page,size,key,word},
			dataType:"json",
			success: function (data){
				const temp = Handlebars.compile($("#temp_cou").html());
				$("#div_cou").html(temp(data));
			}
		})
	}
	
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/cou/total",
			data:{key,word},
			success: function(data){
				let total = parseInt(data);
				$("#total").html("검색결과 : "+total+"건");
				if(total==0){
					alert("검색내용이 없습니다!");
					$(frm.word).val("");
					return;
				}
				const totalPage= Math.ceil(total/size);
				$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
				if(total > size){
					$("#pagination").show();
				}else{
					$("#pagination").hide();
				}
			}
		})
	}
	
	$('#pagination').twbsPagination({
	      totalPages:10, 
	      visiblePages: 5, 
	      startPage : 1,
	      initiateStartPageClick: false, 
	      first:'<i class="bi bi-backspace-fill"></i>', 
	      prev :'<i class="bi bi-caret-left"></i>',
	      next :'<i class="bi bi-caret-right"></i>',
	      last :'<i class="bi bi-backspace-reverse-fill"></i>',
	      onPageClick: function (event, clickPage) {
	          page=clickPage; 
	          getData();
	      }
	   });
</script>