<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div>
	<h1>게시판</h1>
	<div class="text-end mb-2" id="div_write">
		<a href="/bbs/insert" class="btn btn-success btn-sm">글쓰기</a>
	</div>
	<div id="div_bbs"></div>
	<div class="text-center">
		<button id="prev" class="btn btn-secondary btn-sm">이전</button>
		<span id="page"></span>
		<button id="next" class="btn btn-secondary btn-sm">다음</button>
	</div>
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
				<td><a href="/bbs/read?bid={{bid}}" class="link-dark link-offset-1 link-underline-info link-underline-opacity-100 link-underline-opacity-100-hover">{{title}}</a></td>	 
				<td><a href="/bbs/read?bid={{bid}}" class="link-dark link-offset-1 link-underline-opacity-0 link-underline-opacity-100-hover">{{uname}}({{writer}})</a></td>	
				<td>{{bdate}}</td>
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
	

	$("#prev").on("click", function(){
		page--;
		getData();
	});
	
	$("#next").on("click", function(){
		page++;
		getData();
	});
	
	getData();
	function getData(){
		$.ajax({
			type:"get",
			url:"/bbs/list.json",
			dataType:"json",
			data:{page,size},
			success:function(data){
				const temp = Handlebars.compile($("#temp_bbs").html());
				$("#div_bbs").html(temp(data));
				
				$("#page").html(page);
				if(page==1) $("#prev").attr("disabled", true);
				else $("#prev").attr("disabled", false);
			}
		});
	}
</script>
