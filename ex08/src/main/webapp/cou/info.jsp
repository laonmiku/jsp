<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="mt-3">
	<h3 class="text-center">-수강 학생 목록-</h3>
	<div id="div_stu" class=""></div>
</div>
<script id="temp_stu" type="x-handlebars-template">
   <table  class=" table table-striped">
      <tr class="table-dark text-center">
         <td>학생 번호</td>
         <td>학생 이름</td>
         <td>학생 학과</td>
         <td>학생 학년</td>
         <td>신청일</td>
		 <td>점수</td> 
      </tr>
      {{#each .}}
         <tr class="text-center">
            <td>{{scode}}</td>
            <td><a href="/stu/read?scode={{scode}}">{{sname}}</a></td>
            <td>{{sdept}}</td>
            <td>{{year}}학년</td>
		  	<td>{{edate}}</td>
		    <td><input value="{{grade}}" size=2 class="text-center px-2">점</td>
         </tr>
      {{/each}}
   </table>
</script>

 <script>
    let lcode="${cou.lcode}";
    
    getData();
    
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