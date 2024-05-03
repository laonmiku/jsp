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

.cdelete{
	cursor:pointer; 
	font-size:20px;
	color: red;
}



</style>
<div class="card mt-2">

	<div class="row text-end card-body mt-0 px-2 " id="div_insert">
		<div class="mt-0 px-3 text-end " >
			<button class="btn btn-success mt-2 insert mb-1 ">등록</button>
		</div>
		<div >
			<textarea id="contents" rows="1" class="form-control text-end " placeholder="댓글내용을 입력하세요"></textarea>
		</div>
	</div>
	
	<div class="row text-end card-body login_plz mt-0 px-2 ">
		<div class="mt-0 px-3 text-end " id="div_login">
			<button  class=" btn btn-success login mb-1 ">로그인</button>
		</div>
		<div  >
			<textarea rows="1"  class=" form-control text-end" readOnly placeholder="댓글을 쓰려면 로그인해주세요"></textarea>
		</div>
	</div>
	
 	<div class="card-header border-top">
 		<span id="total"></span>
 	</div>
 	
 	<div class="card-body p-0 ">
 		<div id="div_comments" class=" mt-2 mx-2 p-2 border border-info"></div>
	
	
 		<div id="pagination" class="pagination justify-content-center mt-3 "></div> 
 	</div>
 </div> 
 
 
 <script id="temp_comments" type="x-handlebars-template">
 	{{#each .}}
	
		
			
		

		<div class=" text-start" >
			<div class="text-muted">
				<span>{{cdate}}</span>
				<span>{{uname}}({{writer}})</sapn>
				<i class="bi bi-trash cdelete writer ms-1" style="{{delete writer}}" cid="{{cid}}" ></i>
			</div>
			<div class="mb-5 ellipsis2"><b>{{cid}}</b>: {{contents}}</div>
		</div>
	
		<hr>
	{{/each}}
 </script> 
 
 <script>
 	Handlebars.registerHelper("delete",function(writer){
 		if(uid!=writer){
 			return "display:none;";
 		}
 	})
 </script>
 
 <script>
 	const bid="${bbs.bid}";
 	let page=1;
 	let size=5;
 	
 	if(uid){
        $("#div_insert").show();
        $("#div_login").hide();
        $(".login_plz").hide();
     }else{
        $("#div_insert").hide();
        $("#div_login").show();
        $(".login_plz").show();
     }
     
 	
 	//로그인버튼누를때
 	$("#div_login").on("click",".login", function(){
 		sessionStorage.setItem("target","/bbs/read?bid="+bid);
 		location.href="/user/login";
 	});
 	
 	//등록버튼누를때
 	$("#div_insert").on("click",".insert", function(){
 		const contents=$("#contents").val();
 		if(contents==""){
 			alert("댓글내용을 입력하세요!");
 			$("#contents").focus();
 			return;
 		}
 		$.ajax({
 			type:"post",
 			url:"/com/insert",
 			data:{bid,contents, writer:uid },//써블릿에 라이터로 줫음!!
 			success:function(){
 				page=1;
 				getTotal();
 				contents=$("#contents").val("");
 			}
 		});
 	});
 	
 	//쓰레기통아이콘누를떄
 	$("#div_comments").on("click",".cdelete", function(){
 		const cid= $(this).attr("cid");
 		//alert(cid); 안나옴
 		if(confirm("삭제하실래요?")){
 			//delete
 			$.ajax({
 				type:"post",
 				url:"/com/delete",
 				data:{cid},
 				success: function(){
 					alert("삭제완료!");
 					getTotal();
 				}
 			});
 		}
 	});
 	
 	
 	getData();
 	function getData(){
 		$.ajax({
 			type:"get",
			url:"/com/list.json",
			data:{bid:bid ,page:page, size:size},
			dataType:"json",
			success:function(data){
				//console.log(data);
				const temp = Handlebars.compile($("#temp_comments").html());
				$("#div_comments").html(temp(data));
			}
 		});
 		
 	};
 	
 	//페이지네이션 출력
	 $('#pagination').twbsPagination({
	      totalPages:100, 
	      visiblePages: 5, 
	      startPage : 1,
	      initiateStartPageClick: false, 
	      first:'<i class="bi bi-chevron-double-left"></i>', 
	      prev :'<i class="bi bi-chevron-compact-left"></i>',
	      next :'<i class="bi bi-chevron-compact-right"></i>',
	      last :'<i class="bi bi-chevron-double-right"></i>',
	      onPageClick: function (event, clickPage) {
	          page=clickPage; 
	          getData();
	      }
	   }); 
 	
	 getTotal();
		function getTotal(){
			$.ajax({
				type:"get",
				url:"/com/total",
				data:{bid},
				success:function(data){
					const totalPage=Math.ceil(data/size);
					$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
					$("#total").html("댓글수 : "+data + "건" );
				}
			})
		};
 </script>
 