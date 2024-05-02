<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	a:link {
  		color : blue;
  		text-decoration: none;
  	}
  	a:visited {
  		color : green;
  		text-decoration: none;
	}
</style>


<div>
	<h1>게시판</h1>
	<div id="div_bbs"></div>
</div>
<script id="temp_bbs" type="x-handlebars-template">
	<table class=" table table-striped table table-hover table table-bordered">
		<tr class="table-dark fw-bold">
			<td>ID</td>	 
			<td>Title</td>	 
			<td>Contents</td>	
			<td>Writer</td>
		</tr>
		{{#each .}}
			<tr>
				<td>{{bid}}</td>	 
				<td><a href="/bbs/read?bid={{bid}}">{{title}}</a></td>	 
				<td>{{uname}}({{writer}})</td>	
				<td>{{bdate}}</td>
			</tr>
		{{/each}}
	</table>
</script>
<script>
	getData();
	function getData(){
		$.ajax({
			type:"get",
			url:"/bbs/list.json",
			dataType:"json",
			success:function(data){
				const temp = Handlebars.compile($("#temp_bbs").html());
				$("#div_bbs").html(temp(data));
			}
		});
	}
</script>

