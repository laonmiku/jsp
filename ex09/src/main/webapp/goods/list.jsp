<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<h1>상품목록</h1>
	<div id="div_shop"></div>
</div>
<script id="temp_shop" type="x-handlebars-template">
	<table class="table table-striped" > 
		<tr class="table-info" >
			<td><input type="checkbox" id="all"></td>
			<td width="20%">아이디</td>
			<td colspan=2 >상품명</td>
			<td width="15%">상품가격</td>
			<td width="10%">저장</td>
		</tr>
		{{#each .}}
			<tr>
				<td><input type="checkbox" class="chk"></td>
				<td>{{gid}} </td>
				<td><img src={{image}} width="50"></td>
				<td>
					<div>{{{title}}}</div>
					<div>{{regDate}}</div>
				</td>
				<td>{{price}}</td>
				<td><button class="btn border border-danger delete" gid="{{gid}}">삭제</button></td>
			</tr>
		{{/each}}
	</table>
</script>
<script>

//삭제버튼
$("#div_shop").on("click",".delete",function(){
	//alert("................");
	const gid=$(this).attr("gid");
	if(confirm(gid+"번 상품을 삭제하실래요?")){
		$.ajax({
			//상품삭제
			type:"post",
			url:"/goods/delete",
			data:{gid},
			success:function(data){
				if(data=="true"){
					alert("삭제성공");
					getData();
				}else{
					alert("삭제실패! 해당 상품의 주문건을 살펴주세요!");
				}
			}
		});
	}
});

getData();
function getData(){
	 $.ajax({
          type : "get",
          url :"/goods/list.json",
          dataType: "json",
          success:function(data){
             const temp=Handlebars.compile($("#temp_shop").html());
             $("#div_shop").html(temp(data));
      	 }
	 })
};
</script>
