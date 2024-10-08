<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.brand {
		font-size:12px;
	}
	#div_shop img {
		border-radius:5px;
	}
	.bi-suit-heart-fill{
		color:red;
		float:right;
	}
	.bi-suit-heart{
		color:red;
		float:right;
		cursor:pointer;
		
	}
</style>
<div class="my-5">
	<div class="row mb-3 justify-content-end">
		<div class="col-6 col-md-4">
			<form name="frm">
				<div class="input-group">
					<input class="form-control" placeholder="검색어" name="word">
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
		</div>
	</div>
	<div id="div_shop" class="row"></div>
	<ul id="pagination" class="pagination justify-content-center pagination-sm"></ul>
</div>
<script id="temp_shop" type="x-handlebars-template">
	{{#each .}}
		<div class="col-6 col-md-4 col-lg-2 mb-5">
			<div class="mb-2 text-center">
				<img gid="{{gid}}" src="{{image}}" width="95%" style="cursor:pointer;">
			</div>
			<div class="brand">
				<span>{{brand}}({{gid}})</span>
			</div>
			<div class="ellipsis">{{{title}}}</div>
			<div>
				<b>{{fmtPrice price}}원</b>
				<span style="font-size:16px;color:red;float:right;">{{fcnt}}
					<span class="bi {{heart ucnt}}  " gid={{gid}}>
					</span>
				</span>
				
			</div>
		</div>
	{{/each}}
</script>
<script>
Handlebars.registerHelper("heart", function(value){
	if(value==0)return "bi-suit-heart";
	else return "bi-suit-heart-fill";
});
	
	Handlebars.registerHelper("fmtPrice", function(price){
		return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	});
</script>
<script>
	let size=12;
	let page=1;
	let word="";
	
	//getData();
	getTotal();
	
	//image click
	$("#div_shop").on("click","img",function(){
		const gid=$(this).attr("gid");
		//alert(uid+"******"+gid);
		location.href="/goods/read?uid="+uid+"&gid="+gid;
		
	});
	
	//하트취소하기
	$("#div_shop").on("click",".bi-suit-heart-fill",function(){
		const gid=$(this).attr("gid");
		//alert(uid+":::::::::"+gid);
		$.ajax({
		type:"post",
		url:"/favorite/delete",
		data:{uid,gid},
		success:function(){
			alert("좋아요 취소!");
			getData();
		}
		});
	});
	
	//하트누르기
	$("#div_shop").on("click",".bi-suit-heart",function(){
		if(uid){
			const gid=$(this).attr("gid");
			//alert(uid+":::::::::"+gid);
			$.ajax({
			type:"post",
			url:"/favorite/insert",
			data:{uid,gid},
			success:function(){
				alert("좋아요 등록!");
				getData();
			}
			});
		}else{
			location.href="/user/login";
		}
		
	
	});
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		word=$(frm.word).val();
		//getData();
		page=1;
		getTotal();
	});
	
	function getData(){
		$.ajax({
			type:"get",
			url:"/goods/list.json",
			dataType:"json",
			data:{size, page, word,uid},
			success:function(data){
				const temp=Handlebars.compile($("#temp_shop").html());
				$("#div_shop").html(temp(data));
			}
		});
	}
	
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/goods/total",
			data:{word},
			success:function(data){
				const total=parseInt(data);
				if(total==0) {
					alert("검색한 상품이 없습니다!");
					return;
				}
				const totalPage=Math.ceil(total/size);
				$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
				if(total > size){
					$("#pagination").show();
				}else{
					$("#pagination").hide();
				}
				$("#total").html("검색수: " + total);
			}
		});
	}
	
	$('#pagination').twbsPagination({
		totalPages:10, 
		visiblePages: 5, 
		startPage : 1,
		initiateStartPageClick: false, 
		first:'<span><<</span>', 
		prev :'<sapn><</span>',
		next :'<span>></span>',
		last :'<span>>></span>',
		onPageClick: function (event, clickPage) {
			 page=clickPage; 
			 getData();
		}
	});
</script>