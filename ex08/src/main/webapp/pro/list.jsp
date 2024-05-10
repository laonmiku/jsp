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
    <h1>교수관리</h1>
    <div class="row mt-5 mb-3">
    	<form class="col-10 col-md-6" name="frm">
    		<div class="input-group">
    			<select class="form-select me-3 " name="key" >
    				<option value="pcode">교수번호</option>
    				<option value="pname" selected>교수이름</option>
    				<option value="dept">담당학과</option>
    			</select>
    			<input placeholder="검색어" class="form-control" name="word">
    			<button class="btn btn-dark">검색</button>
    			 <span id="total" class="mt-2 ms-2 p-1 border border-secondary-subtle text-body-secondary rounded-2"></span>
    		</div>
    	</form>
    	<div class="col w-25 ">
    		<select class="form-select" id="size">
    			<option value="2">2행</option>
    			<option value="3">3행</option>
    			<option value="4">4행</option>
    			<option value="5">5행</option>
    		</select>
    	</div>
    </div>
    
    <div id="div_pro"></div>
    <div id="pagination" class="pagination justify-content-center mt-2"></div>
</div>

<script id="temp_pro"  type="x-handlebars-template">
	<table  class=" table table table-striped">
		<tr class="table-dark">
			<td>교수번호</td>
			<td>교수이름</td>
			<td>교수학과</td>
			<td>교수직급</td>
			<td>교수급여</td>
			<td>임용일자</td>
		</tr>
		{{#each .}}
			<tr class="table-light">
			<td>{{pcode}}</td>
			<td><a href="/pro/read?pcode={{pcode}}">{{pname}}</a></td>
			<td>{{dept}}</td>
			<td>{{title}}</td>
			<td>{{salary}}</td>
			<td>{{hiredate}}</td>
			</tr>
		{{/each}}
	</table>
</script>


<script>
	let page=1;
	let size=$("#size").val();
	let key=$(frm.key).val();
	let word=$(frm.word).val();

	$(frm).on("submit", function (e) {
	      e.preventDefault();
	      key = $(frm.key).val();
	      word = $(frm.word).val();
	      let size=$("#size").val();
	      page=1;
	      getData();
	});
	
	$("#size").on("change", function(){
		size=$("#size").val();
		page=1;
		//getData();
		getTotal();
	})

	
	//getData();
	getTotal();
	function getData(){
		$.ajax({
			type:"get",
			url:"/pro/list.json",
			data:{page,size,key,word},
			dataType:"json",
			success: function(data){
				console.log(data);
				const temp = Handlebars.compile($("#temp_pro").html());
				$("#div_pro").html(temp(data));
			}
		});
	}
	
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/pro/total",
			data:{key,word},
			success: function(data){
				$("#total").html("검색결과 : "+data+"건");
				if(data==0){
					alert("검색내용이 없습니다!");
					$(frm.word).val("");
					return;
				}
				
				const totalPage= Math.ceil(data/size);
				$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
				if(parseInt(data) > size){
					$("#pagination").show();
				}else{
					$("#pagination").hide();
				}
			}
		});
	};
	
	 $('#pagination').twbsPagination({
	      totalPages:10, 
	      visiblePages: 3, 
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
    