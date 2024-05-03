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

.page-link {
}
</style>

<div>
	<h1>게시판</h1>
	<div class="row text-end">
			<span id="total"></span>
	</div>
	
	<div class="row text-end">
		<div class="col-6 col-md-4 col-lg-3 mb-2 text-start" id="div_write">
				<a href="/bbs/insert" class="btn btn-success btn-sm">글쓰기</a>
		</div>
		<div class="col">
		</div>
		<div class="col ">
		</div>
		<div class="col-6 col-md-4 col-lg-3 mb-2 text-end">
			<form name="frm">
				<div class="input-group ">
					<input name="query" class="form-control">
					<button class="btn btn-dark">검색</button>
				</div>
			</form>
		</div>
	</div>	
	
		
	
	<div id="div_bbs"></div>
	<div id="pagination" class="pagination justify-content-center mt-5  "></div>
</div>
<script id="temp_bbs" type="x-handlebars-template">
	<table class=" table table-striped table table-hover table table-bordered">
		<tr class="table-dark fw-bold">
			<td>ID</td>	 
			<td>Title</td>	 
			<td>User</td>	
			<td>Writer</td>
		</tr>
		{{#each .}}
			<tr>
				<td>{{bid}}</td>	
				<div class="ellipsis"> 
					<td><a href="/bbs/read?bid={{bid}}" class="link-dark link-offset-1 link-underline-info link-underline-opacity-100 link-underline-opacity-100-hover">{{title}}</a></td>
	 			</div>
				<div class="ellipsis"> 	
					<td><a href="/bbs/read?bid={{bid}}" class="link-dark link-offset-1 link-underline-opacity-0 link-underline-opacity-100-hover">{{uname}}({{writer}})</a></td>
				</div>
				<div class="ellipsis"> 	
					<td>{{bdate}}</td>
				</div>
			</tr>
		{{/each}}
	</table>
</script>
<script>
	if(uid){
		$("#div_write").show();
	}else{
		$("#div_write").hide();
	}

	let page=1;
	const size=5;
	let query="";
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		query=$(frm.query).val();
		page=1;
		getTotal();
	});
	
	
	getData();
	function getData(){
		$.ajax({
			type:"get",
			url:"/bbs/list.json",
			dataType:"json",
			data:{page,size,query},
			success:function(data){
				const temp = Handlebars.compile($("#temp_bbs").html());
				$("#div_bbs").html(temp(data));
				
			}
		});
	}
	getTotal();
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/bbs/total",
			data:{query},
			success:function(data){
				if(data ==0){
					alert("검색된 결과가 없습니다!");
					$(frm.query).val("");
					$(frm.query).focus();
				}else{	
					const totalPage=Math.ceil(data/size);
					$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
					$("#total").html("검색수 : "+data + "건" );
				}
			}
		})
	};
	//페이지네이션 출력
	 $('#pagination').twbsPagination({
	      totalPages:200, 
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

