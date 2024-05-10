<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">   
<div>
<hr>
	<h3 class="text-center mb-3">-수강신청목록-</h3>
	 <div class="input-group col-6 mb-2">
        <div id="div_cou"></div>
        <button class="btn btn-light  border" id="insert">수강신청</button>   
     </div>
     <div id="div_enroll"></div>
</div>
<script id="temp_enroll" type="x-handlebars-template">
	<table class="table  table table-striped text-center">
		<tr class="table-dark ">
			<td>강좌번호</td>
			<td>강좌이름</td>
			<td>강의시간</td>
			<td>강의실</td>
			<td>신청인원</td>
			<td>담당교수</td>
			<td>신청일</td>
			<td>취소</td>
		</tr>
		{{#each .}}
		<tr class="text-center">
			<td>{{lcode}}</td>
			<td><a href="/cou/read?lcode={{lcode}}">{{lname}}</a></td>
			<td>{{hours}}</td>
			<td>{{room}}</td>
			<td>{{persons}}/{{capacity}}</td>
			<td>{{pname}}({{pcode}})</td>
			<td>{{edate}}</td>
			<td><button class="btn border border-danger delete" lcode="{{lcode}}"><i class="bi bi-person-fill-dash"></i></button></td>
		</tr>
		{{/each}}
	</table>
</script>
<script id="temp_cou" type="x-handlebars-template" >
	<select class="form-select" id="lcode">
		{{#each .}}
			<option value="{{lcode}}">
				-&nbsp;{{lname}}&nbsp;({{pname}})&nbsp;-&nbsp;&nbsp;({{persons}}/{{capacity}})
			</option>
		{{/each}}
	</select>
</script>
<script>
	let scode="${stu.scode}";
	
	//수강취소버튼을 클릭
	$("#div_enroll").on("click",".delete",function(){
		const lcode=$(this).attr("lcode");
		//alert(scode+" : "+lcode+"88888888888888");
		if(confirm("수강신청을 취소하실래요")){
			 $.ajax({
		  			type:"post",
		  			url:"/enroll/delete",
		  			data:{scode,lcode},
		  			success:function(data){
		  				if(data=="true"){
		  					alert("수강취소 완료!");
		  					getData();
		  					getCou();
		  				}else{
		  					alert("다시한번 시도해보세요!");
		  				}
		  			}
			});
		}
	});
	
	//수강신청 버튼을 클릭한 경우
	   $("#insert").on("click", function () {
	      const lcode=$("#div_cou #lcode").val();
	      //alert(scode + " : " + lcode);
	      if(confirm("수강신청 하실래요?")){
	    	  $.ajax({
	  			type:"post",
	  			url:"/enroll/insert",
	  			data:{scode,lcode},
	  			success:function(data){
	  				if(data=="true"){
	  					alert("수강신청 완료!");
	  					getData();
	  					getCou();
	  				}else{
	  					alert("이미 수강신청한 강좌입니다");
	  				}
	  			}
	  		})
	      }
	   });
	
	
	getData();
	function getData(){
		$.ajax({
			type:"get",
			url:"/enroll/list.json",
			data:{scode},
			dataType:"json",
			success:function(data){
				const temp=Handlebars.compile($("#temp_enroll").html());
				$("#div_enroll").html(temp(data));
			}
		});
	}
	
	getCou();
	function getCou(){
		$.ajax({
			type:"get",
			url:"/cou/list.json",
			data:{ page:1, size:100, key:'lcode',word:'' },
			dataType:"json",
			success:function(data){
				const temp=Handlebars.compile($("#temp_cou").html());
				$("#div_cou").html(temp(data));
			}
		});
	}
</script>