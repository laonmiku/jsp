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
	.brand{
		font-size:12px;
	}
	#div_shop img{
		border-radius:10px;
		box-shadow:0px 5px 4px 0px lightgray;
	}
</style>

<div class="my-2">
	<div class="row mb-3 ">
		<div class="col"></div>
		<div class="col-6 col-md-4 ">
			<form name="frm">	
				<div class="input-group ">
					<input name="word" class="form-control" placeholder="검색어">
					<button class="btn btn-info">검색</button>				
				</div>
			</form>
		</div>
	</div>
	<div class="border border-light p-3">
		<div id="div_shop" class="row"></div>
	</div>
	<div id="pagination" class="pagination justify-content-center mt-5"></div>
</div>
<script id="temp_shop" type="x-handlebars-template" >
	{{#each .}}
		<div class="col-2 col-md-4 col-lg-2">
			<div class="mb-2">
				<a href="/goods/read?gid={{gid}}"><img src="{{image}}" width="90%"></a>
			</div>
			<div class="brand">{{brand}}</div>
			<div class="ellipsis">{{title}}</div>
			<div class=""><b>{{price}}원</b></div>
		</div>
	{{/each}}
</script>
<script>
	Handlebars.registerHelper("frmPrice",function(price){
		return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
	});
</script>
<script>
	let size=12;
	let page=1;
	let word=$(frm.word).val();
	getTotal();
	
	$(frm).on("submit",function(e){
		e.preventDefault();
		page=1;
		word=$(frm.word).val();
		getTotal();
	});
	
	
	function getData(){
		$.ajax({
			type:"get",
			url:"/goods/list.json",
			data:{size,page,word},
			dataType:"json",
			success:function(data){
				const temp= Handlebars.compile($("#temp_shop").html());
				$("#div_shop").html(temp(data));
			}
		});
	}
	
	function getTotal(){
		$.ajax({
	        type : "get",
	        url :"/goods/total",
	        data:{word},
	        success:function(data){
	           const total=parseInt(data);
	           if(total==0){
	        	   alert("검색한 상품이 없습니다");
	        	   return;
	           }
	           const totalPage=Math.ceil(total/size);
	           $("#pagination").twbsPagination("changeTotalPages", totalPage, page);
	    	 	if(total > size){
	    	 		$("#pagination").show();
	    	 	}else{
	    	 		$("#pagination").hide();
	    	 	}
	    	 	$("#total").html("검색수: "+total);
	        }
		 });
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