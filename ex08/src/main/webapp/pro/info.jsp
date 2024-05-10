
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<ul class="nav nav-tabs" id="myTab" role="tablist">
  <li class="nav-item" role="presentation">
    <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home-tab-pane" type="button" role="tab" aria-controls="home-tab-pane" aria-selected="true">담당과목</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile-tab-pane" type="button" role="tab" aria-controls="profile-tab-pane" aria-selected="false">지도학생</button>
  </li>	
</ul>
<div class="tab-content" id="myTabContent">
  <div class="tab-pane fade show active" id="contact-tab-pane" role="tabpanel" aria-labelledby="contact-tab" tabindex="0">
     <h3 class="text-center">담당과목</h3>
     <div id="div_cou"></div>
  </div>
  <div class="tab-pane fade" id="disabled-tab-pane" role="tabpanel" aria-labelledby="disabled-tab" tabindex="0">
   <h3 class="text-center">지도학생</h3>
   <div id="div_stu"></div>
  </div>
</div> 
<script id="temp_cou" type="x-handlebars-template">
   <table class=" table  table table-striped text-center">
      <tr class="table-dark ">
         <td>강좌번호</td>
         <td>강좌이름</td>
         <td>강의시간</td>
         <td>강의실</td>
         <td>신청인원</td>
      </tr>
      {{#each .}}
         <tr>
            <td>{{lcode}}</td>
            <td><a href ="/cou/read?lcode={{lcode}}">{{lname}}</a></td>
            <td>{{hours}}시간</td>
            <td>{{room}}</td>
            <td>{{persons}}명/{{capacity}}명</td>
         </tr>
      {{/each}}
   </table>
</script>
<script id="temp_stu" type="x-handlebars-template">
   <table  class=" table table-striped">
      <tr class="table-dark text-center">
         <td>학생 번호</td>
         <td>학생 이름</td>
         <td>학생 학과</td>
         <td>학생 학년</td>
         <td>생년 월일</td> 
      </tr>
      {{#each .}}
         <tr class="text-center">
            <td>{{scode}}</td>
            <td><a href="/stu/read?scode={{scode}}">{{sname}}</a></td>
            <td>{{sdept}}</td>
            <td>{{year}}학년</td>
            <td>{{birthday}}</td>
         </tr>
      {{/each}}
   </table>
</script>
 <script>
    let page=1;
    let size=100;
    let word="${pro.pcode}";
    
    getCou();
    function getCou(){
       let key="instructor";
       $.ajax({
          type : "get",
          url :"/cou/list.json",
          data :{page,size,key,word},
          dataType: "json",
          success:function(data){
             console.log("담당과목 : ",data);
             const temp=Handlebars.compile($("#temp_cou").html());
             $("#div_cou").html(temp(data));
          }
       })
    }
    
    getStu();
    function getStu(){
       let key="advisor";
       $.ajax({
          type : "get",
          url : "/stu/list.json",
          data : {page,size,key,word},
          dataType : "json",
          success : function(data){
             console.log("지도학생 : ",data);
             const temp=Handlebars.compile($("#temp_stu").html());
             $("#div_stu").html(temp(data));
          }
       })
    }
 </script>  