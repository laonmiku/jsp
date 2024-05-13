<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="mt-3">
	<h3 class="text-center">-수강 학생 목록-</h3>
	<div id="div_stu" class=""></div>
</div>
<script id="temp_stu" type="x-handlebars-template">
   <div class="mb-2 text-end mx-5">
		<button class="btn  border border-dark px-4" id="update">점수저장</button>
	</div>
	
	<table  class=" table table-striped">
      <tr class="table-dark text-center">
		 <td><input type="checkbox" id="all"></td>
         <td>학생 번호</td>
         <td>학생 이름</td>
         <td>학생 학과</td>
         <td>학생 학년</td>
         <td>신청일</td>
		 <td>점수</td> 
      </tr>
      {{#each .}}
         <tr class="text-center" scode="{{scode}}">
 			<td><input type="checkbox" class="chk"></td>
            <td>{{scode}}</td>
            <td><a href="/stu/read?scode={{scode}}">{{sname}}</a></td>
            <td>{{sdept}}</td>
            <td>{{year}}학년</td>
		  	<td>{{edate}}</td>
		    <td scode="{{scode}}" >
				<input value="{{grade}}" size=2 class="text-center px-2 grade">점
				<button class="btn btn-sm btn-secondary update">수정</button>
			</td>
         </tr>
      {{/each}}
   </table>
	
</script>

 <script>
    let lcode="${cou.lcode}";
    
    getData();
    
    //선택저장 버튼을 클릭한 경우
    $("#div_stu").on("click","#update", function(){
    	let chk=$("#div_stu .chk:checked").length;
    	if(chk==0){
    		alert("수정할 학생을 선택하세요")
    		return;
    	}
    	if(! confirm (chk + "개 성적을 수정하실래요")) return;
    	//성적수정
    	let cnt=0;
    	$("#div_stu .chk:checked").each(function(){
    		let tr=$(this).parent().parent();
    		let scode= tr.attr("scode");
    		let grade = tr.find(".grade").val();
    		//alert("lcode="+lcode+"...scode="+scode+"....grade="+grade);
    		$.ajax({
        		type:"post",
        		url:"/enroll/update",
        		data:{scode,lcode,grade},
        		success:function(){
        			cnt++;
        			if(chk==cnt){
        				alert("수정완료");
        				getData();
        			}
        		}
        	});
    	})
    })
    
    //전체선택 체크박스클릭
    $(div_stu).on("click","#all",function(){
    	if($(this).is(":checked")){
    		//alert('checked');
    		$("#div_stu .chk").each(function(){
    			$(this).prop("checked",true);
    		});
    	}else{
    		//alert('unChecked');
    		$("#div_stu .chk").each(function(){
    			$(this).prop("checked",false);
    		});
    	}
    });
    
    //각행의 체크박스를 클릭
    $("#div_stu").on("click",".chk",function(){
    	let all=$("#div_stu .chk").length;
    	let chk=$("#div_stu .chk:checked").length;
    	//alert("all---"+all);
    	if(all==chk){
    		$("#div_stu #all").prop("checked",true);
    	}else{
    		$("#div_stu #all").prop("checked",false);
    	}
    });
    
    //각행의 수정버튼
    $("#div_stu").on("click", "tr .update", function(){
    	let scode=$(this).parent().attr("scode");
    	let td=$(this).parent()
    	let grade=td.find(".grade").val();
    	//alert("lcode="+lcode+"...scode="+scode+"....grade="+grade);
    	$.ajax({
    		type:"post",
    		url:"/enroll/update",
    		data:{scode,lcode,grade},
    		success:function(){
    			alert("수정완료");
    			getData();
    			alert("수정"+grade);
    		}
    	});
    });
    
    function getData(){
       $.ajax({
          type : "get",
          url :"/enroll/slist.json", 
          dataType: "json",
          data :{lcode},
         
          success:function(data){
             console.log(data);
             const temp=Handlebars.compile($("#temp_stu").html());
				$("#div_stu").html(temp(data));
          }
       });
    }
    
</script>    