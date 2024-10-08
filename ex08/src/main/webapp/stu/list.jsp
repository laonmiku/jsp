<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
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

#size {
   width:100px;
   float:right;
}
</style>
    
<div>
   <c:choose>
    <c:when test="${uid == 'admin'}">
        <h1>학생관리</h1>
    </c:when>
    <c:otherwise>
        <h1>학생목록</h1>
    </c:otherwise>
	</c:choose>
   <div class="row mt-5 mb-3">
       <form class="col-10 col-md-6" name="frm">
          <div class="input-group">
             <select class="form-select me-3 " name="key" >
                <option value="scode">학생번호</option>
                <option value="sname" selected>학생이름</option>
                <option value="dept">전공학과</option>
                <option value="pname">지도교수</option>
             </select>
             <input placeholder="검색어" class="form-control" name="word">
             <button class="btn btn-dark">검색</button>
             <span id="total" class="mt-2 ms-2 p-1 border border-secondary-subtle text-body-secondary rounded-2"></span>
          </div>
       </form>
       <div class="col w-25 ">
          <select class="form-select" id="size">
            <option value="3">3행</option>
			<option value="5" selected>5행</option>
			<option value="10">10행</option>
          </select>
       </div>
    </div>
   <div id="div_stu"></div>
   <div id="pagination" class="pagination justify-content-center mt-2"></div>
</div>
<script id="temp_stu" type="x-handlebars-template">
   <table  class=" table table-striped">
      <tr class="table-dark text-center">
         <td>학생 번호</td>
         <td>학생 이름</td>
         <td>학생 학과</td>
         <td>학생 학년</td>
         <td>생년 월일</td>
         <td>지도 교수</td>
      </tr>
      {{#each .}}
         <tr class="text-center">
            <td>{{scode}}</td>
            <td><a href="/stu/read?scode={{scode}}">{{sname}}</a></td>
            <td>{{sdept}}</td>
            <td>{{year}}학년</td>
            <td>{{birthday}}</td>
            <td>{{pname}} ({{advisor}})</td>
         </tr>
      {{/each}}
   </table>
</script>


<script>
   let page=1;
   let size=$('#size').val();
   let key=$(frm.key).val();
   let word=$(frm.word).val();
   
   $(frm).on("submit", function (e) {
         e.preventDefault();
         key = $(frm.key).val();
         word = $(frm.word).val();
         let size=$("#size").val();
         page=1;
         getData();
      
   });
   
   $("#size").on("change", function(){
      size=$("#size").val();
      page=1;
      //getData();
      getTotal();
   });
   
 //getData();
   getTotal();
   function getData() {
      $.ajax({
         type : "get",
         url : "/stu/list.json",
         dataType : "json",
         data : {page, size, key, word},
         success : function (data) {
            console.log(data);
            const temp = Handlebars.compile($("#temp_stu").html());
         $("#div_stu").html(temp(data));
         }
      });
   }
   
   function getTotal() {
	      $.ajax({
	         type : "get",
	         url : "/stu/total",
	         data : {key, word},
	         success : function (data){
	         	let total= parseInt(data);
	         	$("#total").html("검색결과 : "+total+"건");
	            if(total==0) {
	               alert("검색 내용이 없습니다.");
	               return;
	            }
	            const totalPage=Math.ceil(total/size);
	            $("#pagination").twbsPagination("changeTotalPages", totalPage, page);
	            
	           // alert(data + "/" + size);
	            if(total>size) {   
	               $("#pagination").show();
	            }
	            else{
	               $("#pagination").hide();
	            }
	         }
	      });
	      
	   }
   
   
   $('#pagination').twbsPagination({
         totalPages:100, 
         visiblePages: 3, 
         startPage : 1,
         initiateStartPageClick: false, 
         first:'<i class="bi bi-backspace-fill"></i>', 
         prev :'<i class="bi bi-caret-left"></i>',
         next :'<i class="bi bi-caret-right"></i>',
         last :'<i class="bi bi-backspace-reverse-fill"></i>',
         onPageClick: function (event, clickPage) {
             page=clickPage; 
             getData();
         }
      });
   
</script>