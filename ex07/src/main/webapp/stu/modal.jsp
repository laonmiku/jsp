<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<Style>
	#modal{
		top:30%;
	}
	.pro{
		cursor:pointer;
	}
</Style>
<!-- Modal -->
<div class="modal fade" id="modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">담당 교수를 선택하세요</h1>
      </div>
      <div class="modal-body">
      	  <div id="div_pro"></div>
      	 	 <script id="temp_pro"  type="x-handlebars-template">
				<table  class=" table table table-striped">
					<tr class="table-secondary">
						<td>교수번호</td>
						<td>교수이름</td>
						<td>교수학과</td>
					</tr>
					{{#each .}}
						<tr class="table-light pro"  pcode="{{pcode}}" pname="{{pname}}">
						<td>{{pcode}}</td>
						<td>{{pname}}</td>
						<td>{{dept}}</td>
						</tr>
					{{/each}}
				</table>
			</script>  
			<script>
				let page=1;
				let size=100;
				let key="dept";
				let word=$(frm.dept).val();
				//같은과교수만보이게하려고
				$(frm.dept).on("change", function(){
					word=$(frm.dept).val();
					getData();
				});
				//각행의 tr을 클릭햇을때
				$("#div_pro").on("click",".pro",function (){
					const pcode= $(this).attr("pcode");
					const pname= $(this).attr("pname");
					//alert(pcode+pname);
					$(frm.advisor).val(pcode);
					$(frm.pname).val(pname);
					$("#modal").modal("hide");
				});
				
				getData();
				function getData(){
					$.ajax({
						type:"get",
						url:"/pro/list.json",
						data:{page,size,key,word},
						dataType:"json",
						success: function(data){
							console.log(data);
							const temp = Handlebars.compile($("#temp_pro").html());
							$("#div_pro").html(temp(data));
						}
					});
				}
			</script>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>