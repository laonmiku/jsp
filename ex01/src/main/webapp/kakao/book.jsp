<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div>
	<h1>도서검색</h1>
</div>
<div class="row mb-2">
	<div class="col-8 col-md-4">
		<form class="input-group" name="frm">
			<input class="form-control" name="query" value="자유" placeholder="검색어">
			<button class="btn btn-success">검색</button>
		</form>
	</div>
</div>
<div id="div_book" class="row"></div>
<div class="text-center my-3">
	<button id="prev" class="btn btn-success">이전</button>
	<span id="page" class="mx-3">1</span>
	<button id="next" class="btn btn-success">다음</button>
</div>


<script id="temp_book" type="x-handlebars-template">
	{{#each documents}}
		<div class="col-6 col-md-4 col-lg-2">
			<div class="card">
				<div class="card-body">
					<img src="{{thumbnail}}" width="90%">
				</div>
				<div class="card-footer">
					<div class="ellipsis text-center">{{title}}</div>	
				</div>
			</div>
		</div>
	{{/each}}	

</script>

<script>
	let query = $(frm.query).val();
	let page=1;
	getData();
	

	$("#next").on("click", function() {
		page++;
		getData();
	});
	$("#prev").on("click", function() {
		page--;
		getData();
	});

	$(frm).on("submit", function(e) {
		e.preventDefault();
		query = $(frm.query).val();
		if (query == "") {
			alert("검색어를 입력하세요")
		} else {
			page = 1;
			getData();
		}

	});
	
	function getData() {
		$.ajax({
			type : "get",
			url : "https://dapi.kakao.com/v3/search/book?target=title",
			headers : {
				"Authorization" : "KakaoAK f3d977d0f78639ca211ff67b0676d64c"
			},
			dataType : "json",
			data : {
				query : query,
				size : 6,
				page : page
			},
			success : function(data) {
				console.log(data);
				const temp = Handlebars.compile($("#temp_book").html());
				$("#div_book").html(temp(data));
				$("#page").html(`<b>${page}</b>`);
				 if(page==1){
                     $("#prev").attr("disabled",true);
             	}else{
                     $("#prev").attr("disabled",false);
             	}

            	 if(data.meta.is_end){
                     $("#next").attr("disabled",true);
             	}else{
                     $("#next").attr("disabled",false);
             	}
			}
		});
	}
</script>
