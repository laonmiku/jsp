<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div>
	<h1>게시글정보</h1>
	<div class="card">
		<div class="card-body">
			<div> ${bbs.title} </div>
			<hr>
			<div> ${bbs.contents} </div>
		</div>
		<div class="card-footer text-muted">
			<span>${bbs.bdate}</span>
			<span>${bbs.uname} (${bbs.writer})</span>
		</div>
	</div>
</div>

<div style="display: none ">리퀘스트값을 불러올수있게 ${bid}이걸로 불러올수있음 그냥 HTML은 안댐!! 
	주석도 붙이면 오류남!^^ 그래서 에이작표시도 안에뭐넣어줌! ㅎㅎ</div>
			