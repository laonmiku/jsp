<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<h1>네이버 상품검색</h1>  
	<div class="row mb-2">
		
		<form class="col-8 col-md-5" name="frm">
			<div class="input-group my-2">
				<input name="query" class="form-control" value="마라탕" placeholder="검색어">
				<button class="btn border border-info">검색</button>
			</div>
		</form>
		<div class="col text-end">
			<button class="btn border border-info text-end" id="insert">선택저장</button>
		</div>
		<div id="div_shop"></div>
		<div class="text-center">
			<button id="prev" class="btn border border-info">이전</button>
			<span id="page">1</span>
			<button id="next" class="btn border border-info">다음</button>
		</div>
	</div>
</div>
<script id="temp_shop" >
	<table class="table table-striped" > 
		<tr class="table-info" >
			<td><input type="checkbox" id="all"></td>
			<td width="20%">아이디</td>
			<td colspan=2 >상품명</td>
			<td width="15%">상품가격</td>
			<td>저장</td>
		</tr>
		{{#each items}}
			<tr gid="{{productId}}" img="{{image}}" title="{{title}}" brand="{{brand}}" price="{{lprice}}">
				<td><input type="checkbox" class="chk"></td>
				<td>{{productId}} </td>
				<td><img src={{image}} width="50"></td>
				<td><div>{{{title}}}</div></td>
				<td>{{lprice}}</td>
				<td><button class="btn btn-info insert">저장</button></td>
			</tr>
		{{/each}}
	</table>
</script>

<script>
	let query=$(frm.query).val();
	let page=1;
	let size=5;

	//선택저장버튼
	$("#insert").on("click",function(){
		let chk=$("#div_shop .chk:checked").length;
		if(chk==0){
			alert("상품을 선택하세요");
			return;
		}
		if(! confirm(chk + "개 상품을 등록하실래요?")) return;
		//상품등록
		let cnt=0;
		let success=0;
		$("#div_shop .chk:checked").each(function(){
			let tr=$(this).parent().parent();
			let gid=tr.attr("gid");
			let title=tr.attr("title");
			let image=tr.attr("img");
			let price=tr.attr("price");
			let brand=tr.attr("brand");
			console.log(gid,title,image,price,brand);
			$.ajax({
				type:"post",
				url:"/goods/insert",
				data:{gid,title,image,price,brand},
				success:function(data){
					cnt++;
					if(chk==cnt){
						alert("등록성공");
						getData();
					}
				}
			});
		});
	});
	
	//각행의 체크박스를 클릭
	$("#div_shop").on("click",".chk",function(){
		let all= $("#div_shop .chk").length;
		let chk=$("#div_shop .chk:checked").length;
		if(chk==all){
			$("#div_shop #all").prop("checked",true);
		}else{
			$("#div_shop #all").prop("checked",false);
		}
	})
	
	//전체선택
	$("#div_shop").on("click","#all",function(){
		if($(this).is(":checked")){
			$("#div_shop .chk").each(function(){
				$(this).prop("checked",true);
			});
		}else{
			$("#div_shop .chk").each(function(){
				$(this).prop("checked",false);	
			});
		}
	});
	
	//저장버튼
	$("#div_shop").on("click",".insert",function(){
		//alert("................");
		let tr=$(this).parent().parent();
		let gid=tr.attr("gid");
		let title=tr.attr("title");
		let image=tr.attr("img");
		let price=tr.attr("price");
		let brand=tr.attr("brand");
		console.log(gid,title,image,price,brand);
		$.ajax({
			//상품등록
			type:"post",
			url:"/goods/insert",
			data:{gid,title,image,price,brand},
			success:function(data){
				if(data=="true"){
					alert("입력성공");
				}else{
					alert("이미등록한상품입니다.");
				}
				getData();
			}
		});
	});
	
	$("#next").on("click",function(){
		page++;
		getData();
	});
	
	$("#prev").on("click",function(){
		page--;
		getData();
	});
	
	$(frm).on("submit",function(e){
		e.preventDefault();
		query=$(frm.query).val();
		page=1;
		getData();
	});
	
	getData();
	function getData(){
		 $.ajax({
	          type : "get",
	          url :"/goods/search.json",
	          dataType: "json",
	          data:{query,page,size},
	          success:function(data){
	             console.log("결과 : ",data);
	             const temp=Handlebars.compile($("#temp_shop").html());
	             $("#div_shop").html(temp(data));
	             
	             $("#page").html(page);
	             if(page==1) $("#prev").attr("disabled",true);
	             else $("#prev").attr("disabled",false);
	             if(page==10) $("#next").attr("disabled",true);
	             else $("#next").attr("disabled",false);
	      	 }
		 })
	};
</script>