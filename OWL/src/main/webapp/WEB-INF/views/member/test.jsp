<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="resources/plugins/common/common.min.js"></script>
<!-- Custom Stylesheet -->
<link href="resources/css/style.css" rel="stylesheet">
<jsp:include page="../include/headTag.jsp"/>
<script type="text/javascript">
	$(function(){
		/* $("#opneModal").click();

		$("#confirmModal").on('hide.bs.modal', function () {
			console.log("close");
	    	location.href="Index.do";
      	});  */
	})
</script>
<style>
.swal-overlay {
			  background-color: rgb(86,98,112);
			  }
</style>
</head>
<body>
	<script type="text/javascript">
	Swal.fire({
			  title: "��������",
			  text: "�̸��� ������ �����ϼ̽��ϴ�. �α����� ���ּ���",
			  type: "success",
			}).then((willDelete) => {
				window.open('', '_self', ''); // ������â �ݱ�
				window.close(); // ������ â �ݱ�
			});
		</script>
	<input type="hidden" id="opneModal" data-toggle="modal" data-target="#confirmModal">
	<jsp:include page="modal/joinEmail.jsp"/>
</body>
</html>