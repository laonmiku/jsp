<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div>
	<h1>게시글정보</h1>
	
		
	<div class="text-end mb-2" id="div_update">
		<a href="/bbs/update?bid=${bbs.bid}" class="btn-sm btn btn-success px-3">수정</a>
		<button class="btn-sm btn btn-danger px-3 delete" >삭제</button>
	</div>
	<div class="card">
		<div class="card-header">
			<div> [ ${bbs.bid} ]  ${bbs.title} </div>
		</div>
		<div class="card-body">
			<div> ${bbs.contents} </div>
		</div>
		<div class="card-footer  text-muted text-end">
			
			<span>${bbs.bdate}</span>
			<br/>
			<span>작성자 : ${bbs.uname} (${bbs.writer})</span>
		</div>
	</div>
</div>

<jsp:include page="/bbs/comments.jsp"/>
	

			
<script>


	const writer="${bbs.writer}";
	if(uid==writer){
		$("#div_update").show();
	}else{
		$("#div_update").hide();
	}
	
	//삭제버튼
	
	$("#div_update").on("click",".delete",function(){
		const bid="${bbs.bid}";
		if(confirm(bid+"번 게시글을 삭제하실래요?")){
			//삭제하기
			$.ajax({
				type:"post",
				url:"/bbs/delete",
				data:{bid},
				success: function(){
					alert("삭제완료뿅");
					location.href="/bbs/list";
				}
			});
		}
	});
	
</script>			