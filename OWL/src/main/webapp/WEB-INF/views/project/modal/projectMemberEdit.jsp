<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="memberEditModal" class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header text-center">
				<h4 class="modal-title w-100 font-weight-bold">
					<i class="icon-settings mr-2"></i>프로젝트 멤버 설정
				</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body modal-scroll mx-3">
				<!--  멤버 추가  -->
				<form action="" method="post">
					<div class="form-row">
						<div class="form-group col-md-10 pr-0">
							<input type="email" name="member" class="form-control"
								placeholder="추가할 멤버를 입력해주세요">
						</div>
						<div class="form-group col-md-2 pl-0">
							<input type="button" class="form-control btn btn-primary" value="추가">
						</div>
					</div>
				</form>
				<!--  멤버 삭제   -->
				<label class="m-t-20">멤버 리스트</label>
				<div class="input-group">
					<div class="form-control pt-0 pb-3">
						<i class="icon-user mr-2 iconSize"></i> 홍길동(hong@gmail.com)
					</div>
					<div class="input-group-append">
						<span class="input-group-text"><i
							class="icon-close font-weight-bold iconSize"></i> </span>
					</div>
				</div>
				<!-- 끝 -->
				<div class="input-group ">
					<div class="form-control pt-0 pb-3">
						<i class="icon-user mr-2 iconSize"></i> 김콜린(kim@gmail.com)
					</div>
					<div class="input-group-append">
						<span class="input-group-text"><i
							class="icon-close font-weight-bold iconSize"></i> </span>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
				</div>

			</div>
		</div>
	</div>
</div>