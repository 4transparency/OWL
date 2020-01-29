<%@ page language="java" contentType="text/html; charset=UTF-8" 	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

    
<script>
    const userEmail = "${member.email}";
    const userName = "${member.name}";
    console.log(userEmail + "/" + userName);
	$(document).ready(function() {
		$("#userToggle").hide();
		$("#alarmToggle").hide();
		$("#settingToggle").hide();
		$("#chatToggle").hide();

		$("#userBtn").click(function() {
			$("#alarmToggle").hide();
			$("#settingToggle").hide();
			$("#chatToggle").hide();
			$("#userToggle").animate({width:'toggle'},350);
		});

		$("#chatBtn").click(function() {
			$("#userToggle").hide();
			$("#alarmToggle").hide();
			$("#settingtoggle").hide();
		 	$("#chatToggle").animate({width:'toggle'},350);
			
		 	$.ajax({
				url: "MyProjectsMates.do",
				type: "POST",
				dataType: 'json',
				data : { email :userEmail,
					     name : userName}, 
				success: function (data) {
					console.log("뷰단으로 데이터 들어 오나요?? >" + data);

					var userList = "";
					$.each(data, function(index, value) {          				
					  console.log(value);
					  console.log(value.name + " / " + value.email);

					userList += '<a href = "chatTest.do"'+ '<li id="li' + value.email +'" data-targetUserUid="' + value.email + '" data-username="' + value.name + '" class="collection-item avatar list">'
	               + '<img src="' + 'value.img' + '" alt="" class="circle">' +
	              '<span class="title">'+ value.name+ '</span>'+
	              '<span class="small material-icons right hiddendiv done">done</span>'+
	              '<span class="small material-icons right hiddendiv mood yellow-text">mood</span>'+
	              '</li>' + '</a>';
					  
					});

					$('#chatUserList').append(userList);

					//firebase database 에 신규 회원일 경우 등록 해야 하는데.. 이미 존재 하는 유전 인지 아닌지 먼저 확인을 학고 등록 해야 겠지??
					
				},
				error: function(xhr, status, error){
	    			console.log("아잭스 에러 터짐 ㅠㅠ");
			         var errorMessage = xhr.status + ': ' + xhr.statusText
			         alert('Error - ' + errorMessage);
			     }
			});



	 	
		});

		$("#alarmBtn").click(function() {
			$("#userToggle").hide();
			$("#chatToggle").hide();
			$("#settingToggle").hide();
			$("#alarmToggle").animate({width:'toggle'},350);
		});

		$("#settingBtn").click(function() {
			$("#userToggle").hide();
			$("#chatToggle").hide();
			$("#alarmToggle").hide();
			$("#settingToggle").animate({width:'toggle'},350);
			
		});	

		
	 $("#settingBtn").on({
		    mouseover: function (event) {
		    	$("#setIcon").addClass("fa-spin");
		    },
		    mouseleave: function (event) {
		    	$("#setIcon").removeClass("fa-spin");
		    }
		});
	$(".clickIcon").click(function() {
		let iconChange = $(this).children();
		 if($(iconChange).hasClass("fa-chevron-right")) {
			$(iconChange).removeClass("fa-chevron-right").addClass("fa-chevron-down");
			//$(iconChange).addClass("fa-chevron-down");
		} else {
			$(iconChange).removeClass("fa-chevron-down").addClass("fa-chevron-right");
			//$(iconChange).addClass("fa-chevron-right");
		} 
		
	});

	$("#chatNoticeMoreBtn").click(function() {
		$("#chatNoticeDetail").removeClass("hidden");
		$("#chatNoticePreview").addClass("hidden");
		});
	$("#chatNoticeBackBtn").click(function() {
		$("#chatNoticePreview").removeClass("hidden");
		$("#chatNoticeDetail").addClass("hidden");
		});
	$("#chatUserList").click(function() {
		console.log("채팅방 view");
		$("#chattingRoomIn").removeClass("hidden");
		$("#chattingList").addClass("hidden");
	});
	$("#chatBackBtn").click(function() {
		console.log("백 버튼");
		$("#chattingList").removeClass("hidden");
		$("#chattingRoomIn").addClass("hidden");
		});
	$("#noticeAsideBtn").click(function() {
		if($("#chatNotideAside").hasClass("hidden")) {
		$("#chatNoticeDetail").addClass("hidden");
		$("#chatNotideAside").removeClass("hidden");
		}
		});
	$("#chatNotideAside").click(function() {
		$("#chatNoticePreview").removeClass("hidden");
		$("#chatNotideAside").addClass("hidden");
		});
	});


	function Search(){
		$('.ChatList').empty();   
		var plus = "";
		plus += "<input type='text' id='searchChat' style='width: 75%; height:30px; float:left; margin-top: 10px;'>&emsp; <span style='cursor:pointer;' onclick='Cancle()'><i class='fas fa-times'></i></span>";
		plus += "<a href='#' data-toggle='modal' data-target='#newChat' style='float: right;'>&emsp;<i class='fas fa-comment-medical'></i>&emsp;</a>";
		$('.ChatList').append(plus);
	}

	function Cancle(){
		$('.ChatList').empty();   
		var plus = "";	
		plus += "<a href='#' data-toggle='modal' data-target='#newChat' style='float: right;'><i class='fas fa-comment-medical'></i>&emsp;</a>";
		plus += "<span id='searchChatname' onclick='Search()'><i class='fas fa-search'></i>&emsp;</span><br>";
		$('.ChatList').append(plus);
	}
</script>
<style>

ul {
display: block;
}

.grade1 {
	z-index :10;
}
.hrGray {
	color : #b7babd;
}

.iconMargin {
	margin-right: 17px;
}

.coloricon {
	padding: 15px;
	width: 25px;
	height: 25px;
	margin-right: 10px;
	border: 2px solid #BDBDBD;
	border-radius: 5px;
	cursor : pointer;
}

.whiteColor {
	color: #fff;
}

.whieColor:hover {
	color: #fff;
}

.setting-box {
	margin-top: 20px;
	font-family: 'Noto Sans KR', sans-serif;
}


  .toggleOption {
	margin-right:0px;
 	margin-top:697px;
	background: #326295;
	height: 2081%;
	width: 310px;
	position: absolute;
	right:0;
	
	z-index : -20;
} 
/*   .toggleOption {
	margin-right:0px;userEmail
	background: #326295;
	height: 100%;
	width: 310px;
	position: fixed;
	right:0;
	overflow: hidden;
	z-index : -20;
} 
 */

 
#userImg, .coloricon {
	border: 3px solid #fcf9f5;
	box-shadow: 1px 1px 1px 1px #BDBDBD;
}

#userImg:hover, .coloricon:hover {
	border: 3px solid #BDBDBD;
}

#settingToggle, #alarmToggle, #chatToggle, #userToggle {
	padding-left: 1%;
	padding-right: 1%;
}


.chat_list-group-item {
  position: relative;
  display: block;
  padding: 0.75rem 1.25rem;
  margin-bottom: -1px;
  background-color: #fff;
  border: 1px solid rgba(0, 0, 0, 0.125); 

}


.chat_list-group-item:first-child {
    border-top-left-radius: 0.25rem;
    border-top-right-radius: 0.25rem;
}

.chat_list-group-item:last-child {
    margin-bottom: 0;
    border-bottom-right-radius: 0.25rem;
    border-bottom-left-radius: 0.25rem;
}

.chat_list-group-item-action {
  width: 100%;
  color: #495057;
  text-align: inherit; }

.chat_img {
	width: 42px;
	height: 42px;
	border: 3px solid #fcf9f5;
	box-shadow: 1px 1px 1px 1px #BDBDBD;
	margin-top : 10px;
	margin-right: 10px;
}

.media {
  display: flex;
  align-items: flex-start; }
	
	
.h5{
    margin-bottom: 0.5rem;
    font-family: inherit;
    font-weight: 700;
    line-height: 1.2;
    color: inherit;
}


#searchChat {
	border-right: 0px;
	border-top: 0px;
	boder-left: 0px;
	boder-bottom: 3px solid #326295;
	background-color: rgba(255, 255, 255, 0);
	border-left-width: 0px;
	color: #326295;
}

#searchChatname {
	cursor: pointer;
	float: right;
}

#searchChatname:hover {
	color: #326295;
}

#chatTitle img {
	margin-top: 10px;
	width: 40px;
	height: 40px;
	margin-right: 10px;
}


.media h5 {
	font-size: 15px;
	font-weight: bold;
}


.custom-menu {
	z-index: 1000;
	position: absolute;
	padding: 2px;
	background-color: #f0f3f7;
	text-align: center;
}


/* alarm shake */
#alarmBtn:hover {
	/* Start the shake animation and make the animation last for 0.5 seconds */
	animation: shake 3s;
	/* When the animation is finished, start again */
	animation-iteration-count: infinite;
}




@keyframes shake  {
	0% { transform: translate(2px, 1px) rotate(0deg) scale(1); }
	10% { transform: translate(-1px, -2px) rotate(-1deg); }
	20% { transform: translate(-3px, 0px) rotate(1deg); }
	30% { transform: translate(0px, 2px) rotate(0deg); }
	40% { transform: translate(1px, -1px) rotate(1deg); }
	50% { transform: translate(-1px, 2px) rotate(-1deg); }
	60% { transform: translate(-3px, 1px) rotate(0deg) scale(1.5); }
	70% { transform: translate(2px, 1px) rotate(-1deg); }
	80% { transform: translate(-1px, -1px) rotate(1deg); }
	90% { transform: translate(2px, 2px) rotate(0deg); }
	100% { transform: translate(1px, -2px) rotate(-1deg) scale(0); }
}

.activity {
	height: 15px;
	width: 15px;
	border-radius: 50%;
	display: inline-block;
	position: absolute;
	border: 3px solid #fff;
	bottom: .4rem;
	right: 0rem;
	padding: 0;
	background-color: #326295; /*#ff763b*/
	left: 30px;
	top: 37px;
}

.activity.off {
	background-color: lightgrey;
}
.accordionBody {  
	max-height: 650px; 
	overflow: auto;
}
.top_card {
	border-radius: 0.25rem;
}
/* 채팅방  css */
.chatImgBorder {
	border: 2px solid #BDBDBD;
}
.chatbg{
	background-color: #326295 !important;
}
#chatBackBtn:hover{
	cursor: pointer;
}
.ownBubble {
	border-radius: 16px 16px 0 16px;
}
.otherBubble {
	border-radius: 16px 16px 16px 0;
	background-color: #dbd9d9 !important;
}
</style>


<header class="topbar" data-navbarbg="skin5">
    <nav class="navbar top-navbar navbar-expand-md navbar-dark">
        <div class="navbar-header">
            <!-- This is for the sidebar toggle which is visible on mobile only -->
            <a class="nav-toggler waves-effect waves-light d-block d-md-none" href="javascript:void(0)"><i class="ti-menu ti-close"></i></a>
            <!-- ============================================================== -->
            <!-- Logo -->
            <!-- ============================================================== -->
            <a class="navbar-brand" href="Index.do">
                <!-- Logo icon -->
                <b class="logo-icon p-l-10">
                    <!--You can put here icon as well // <i class="wi wi-sunset"></i> //-->
                    <!-- Dark Logo icon -->
                    &nbsp;<img src="resources/images/logo_dj.png" alt="homepage" class="light-logo" style="margin-bottom: 10px;"/>
                   
                </b>
                <!--End Logo icon -->
                 <!-- Logo text -->
                <span class="logo-text">
                     <!-- dark Logo text -->
                     <img src="resources/images/OWL_LOGO_BEIGE.png" alt="homepage" class="light-logo" />
                    
                </span>
                <!-- Logo icon -->
                <!-- <b class="logo-icon"> -->
                    <!--You can put here icon as well // <i class="wi wi-sunset"></i> //-->
                    <!-- Dark Logo icon -->
                    <!-- <img src="../../assets/images/logo-text.png" alt="homepage" class="light-logo" /> -->
                    
                <!-- </b> -->
                <!--End Logo icon -->
            </a>
            <!-- ============================================================== -->
            <!-- End Logo -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- Toggle which is visible on mobile only -->
            <!-- ============================================================== -->
            <a class="topbartoggler d-block d-md-none waves-effect waves-light" href="javascript:void(0)" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><i class="ti-more"></i></a>
        </div>
        <!-- ============================================================== -->
        <!-- End Logo -->
        <!-- ============================================================== -->
        <div class="navbar-collapse collapse grade1" id="navbarSupportedContent" data-navbarbg="skin5">
            <!-- ============================================================== -->
            <!-- toggle and nav items -->
            <!-- ============================================================== -->
            <!-- Hamburger Icon -->
            <ul class="navbar-nav float-left mr-auto">   
                <li class="nav-item d-none d-md-block">
                	<a class="nav-link sidebartoggler waves-effect waves-light" href="javascript:void(0)" data-sidebartype="mini-sidebar">
                		<i class="mdi mdi-menu font-24"></i>
                	</a>
                </li>
            </ul>
            
            <!-- ============================================================== -->
            <!-- Right side toggle and nav items -->
            <!-- ============================================================== -->
            <ul class="navbar-nav float-right">

                <!-- User profile and search -->
                <!-- ============================================================== -->
                <li class="nav-item iconMargin">
                    <a class="nav-link text-muted waves-effect waves-dark pro-pic" href="javascript:void(0)" id="userBtn">
                    	<img id="userImgTop" src="upload/member/${member.profilePic}" onerror="this.src='resources/images/login/profile.png'" height="35" width="35" alt="" style="border-radius:50%;">
                    </a>
                </li>
                
                  <!-- Chatting Icon -->
                 <li class="nav-item iconMargin">
                  <a class="nav-link waves-effect waves-dark" href="javascript:void(0)" id="chatBtn"> 
                   	 	<i class="far fa-comment fa-lg"></i>
                    </a>
                </li>
                
                <!-- Alarm Icon -->
                <li class="nav-item iconMargin">
                    <a class="nav-link waves-effect waves-dark" href="javascript:void(0)" id="alarmBtn"> 
                    	<i class="far fa-bell fa-lg"></i>
                    </a>
                </li>
                
                <!-- Setting Icon 
                 <li class="nav-item iconMargin">
                    <a class="nav-link waves-effect waves-dark" href="javascript:void(0)" id="settingBtn"> 
                    	<i class="fas fa-cog fa-lg" id="setIcon"></i>
                    </a>
                </li>-->
            </ul>
            
            
            <!-- toggle content Start-->
            <!-- user toggle  -->
			<div class="toggleOption " id="userToggle"  style="padding-top: 0px;">
				<div class="text-center setting-box mt-5">
					<div class="user-img c-pointer position-relative">
					<a href="#" data-toggle="modal" data-target="#myProfileSetModal">
						<img src="upload/member/${member.profilePic}" onerror="this.src='resources/images/login/profile.png'" class="rounded-circle" alt="" id="userImg" height="100" width="100">
						</a>
					</div>
					<h4 class="mt-3 mb-1 " style="color:white; padding-top: 10px;">${member.name}</h4>
					<p class="mt-2 whiteColor">${member.email}</p>
				</div>
				<hr>
				<div class="text-center setting-box">
					
					<a href="Logout.do" class="whiteColor"><i class="icon-key"></i> <span>Logout</span></a>
					
				
				</div>
			</div>
			
			<!-- 채팅 목록 토글 -->
			<div class="toggleOption" id="chatToggle" style="padding-top: 0px; z-index: -20;">

				
				<div class="setting-box" id="chattingList">
					<div class="ChatList" style="margin-top : 30px"> 
					<a href="#" data-toggle="modal" data-target="#newChat" style=" float: right;" class="whiteColor">
						<i class="fas fa-comment-medical fa-lg"></i>&emsp;</a>					
					<span class ="whiteColor" id="searchChatname" onclick="Search()"><i class="fas fa-search fa-lg"></i>&emsp;</span>
				<br>
				</div>
				<hr>
					 <ul class="list-group" id="ulRoomList">
                         <li class="chat_list-group-item chat_list-group-item-action flex-column align-items-start chatList"  style="height: 106px;">
                           <div class="d-flex w-100 justify-content-between" id="chatTitle">
                               <div class="media">
                               <img src="resources/images/user/group.png" class="rounded-circle chat_img" alt="" id="userImg">
                               <h5 style="margin-top: 18px; color: #ffb1b9">Project 1</h5>
                               </div>
                                <small style="float:right;">AM 12:00</small>
                           </div>
                           <ul>
		                      	<li class="d-flex justify-content-between align-items-center">
		                      			진성씨 시말서 제출하세요.
		                        <span class="badge badge-primary badge-pill" style="background-color: #ffb1b9">2</span>
		                        </li>
                           </ul>             
                       </li>
						<li class="chat_list-group-item chat_list-group-item-action flex-column align-items-start"  style="height: 106px;">
                           <div class="d-flex w-100 justify-content-between" id="chatTitle">
                               <div class="media">
                               <img src="resources/images/user/group.png" class="rounded-circle chat_img" alt="" id="userImg">
                               <h5 style="margin-top: 18px; color: #ccccff">Family_c</h5>
                               </div>
                                <small style="float:right;">2020-01-05</small>
                           </div>
                           <ul>
		                      	<li class="d-flex justify-content-between align-items-center">
		                      			2/13일 화이팅
		                        	<span class="badge badge-primary badge-pill" style="background-color: #ccccff">2</span>
		                        </li>
                           </ul>             
                       </li>
                       <li class="chat_list-group-item chat_list-group-item-action flex-column" style="height: 106px;" id="chatroom" >					                   
                           <div class="d-flex w-100 justify-content-between" id="chatTitle">
                               <div class="media">
                               <div class="user-img c-pointer position-relative">
                               <span class="activity"></span>
                               <img src="resources/images/member/4.jpg" class="rounded-circle chat_img" alt="" id="userImg">   
                               </div>                            
                               <h5 style="margin-top: 18px;">윤다정</h5>
                               </div>
                                <small style="float:right;">AM 11:11</small>
                           </div>
                           <ul>
		                      	<li class="d-flex justify-content-between align-items-center">
		                      			샐러드 사왔어?
		                        		<span class="badge badge-primary badge-pill">1</span>
		                        </li>
                           </ul>             
                       </li> 	       
                    </ul>
                    <!-- 채팅 유정 목록 유엘 끝 -->
				</div>	
				
				<!--  채팅방 view -->	
			<div class="setting-box hidden" id="chattingRoomIn">
					 <ul class="list-group">
                         <li class="chat_list-group-item chat_list-group-item-action flex-column align-items-start" style="height: 650px;">
             <div class="row">
             <div class="text-left">
             <a class="" href="javascript:void(0)" id="chatBackBtn"> 
    			<i class="fas fa-chevron-left font-22 ml-1" ></i></a>
    			</div>
    			<div class="offset-3">
    			<h4 class="d-inline">Family_c</h4><h4 class="text-muted d-inline ml-2">(5)</h4></div>
    			<i class="mdi mdi-menu font-24 mt-1" style="right:12px;top:0px; position: absolute;"></i>
   			</div>
   			<hr>
                                <div class="chat-box scrollable" style="height:510px;">
                                    <!--chat Row -->
                                    <ul class="chat-list">
                                    <!--chat Row -->
                                    <!-- background-color: #dbd9d9;  -->
                                    
                                    <!--  채팅 미리보기 공지 -->
                                        <li class="chat-item mt-0" style="padding:10px; background-color: rgba(219, 217, 217, 0.5); " id="chatNoticePreview">
                                           <div class="row">
                                           <div class="col-11 pr-0">
                                               <div class="chat-img"> <i class="fas fa-bullhorn btn-circle" style="background-color: #326295;color: white;padding-top: 12px;padding-left: 12px;"></i>
                                                	</div>	
                                                	 <div class="chat-content pl-0" style="max-height: 42px; overflow: hidden">
                                                	축 콜린 장가 가는 날  식장은 복정역 날짜는 2월 22일입니다. 기쁜자리에 함께해주시길바랍니다.
                                                	</div>
                                                	</div>
                                                	<div class="col-1 p-0">
                                                	<i class="fas fa-chevron-down font-20" style="padding-top:12px;" id="chatNoticeMoreBtn"></i>
                                                	</div>	
                                           </div>	
                                        </li>
                                         <!--  채팅 공지 자세히보기  -->
                                        <li class="chat-item mt-0 pb-0  hidden" style="padding:10px; background-color: rgba(219, 217, 217, 0.5); " id="chatNoticeDetail">
                                           <div class="row">
                                           <div class="col-11 pr-0">
                                               <div class="chat-img"> <i class="fas fa-bullhorn btn-circle" style="background-color: #326295;color: white;padding-top: 12px;padding-left: 12px;"></i>
                                                	</div>	
                                                	 <div class="chat-content pl-0">
                                                	축 콜린 장가 가는 날  식장은 복정역 날짜는 2월 22일입니다. 기쁜자리에 함께해주시길 바랍니다.
                                                	</div>
                                                	</div>
                                                	<div class="col-1 p-0">
                                                	<i class="fas fa-chevron-up font-20" style="padding-top:12px;" id="chatNoticeBackBtn"></i>
                                                	</div>	
                                           </div>
                                             <div class="row text-center" style="border-top: 1px solid  #BDBDBD">
                                           <div class="col-6" style="border-right:1px solid  #BDBDBD;padding:6px;">다시 열지 않음</div>
                                           <div class="col-6" style="padding:6px;" id="noticeAsideBtn">접어두기</div>
                                           </div>	
                                        </li>
                                        <!--  채팅방 공지 접어두기 -->  
                                        
                                         <div class="chat-img hidden" id="chatNotideAside"style="position: absolute;right:0; top:0"> <i class="fas fa-bullhorn btn-circle op-5" style="background-color: #326295;color: white;padding-top: 12px;padding-left: 12px;"></i>
                                               </div>
                                          
                                        <!--chat Row -->
                                        <li class="chat-item" style="margin-top:10px;">
                                            <div class="chat-img"><img src="resources/images/user/group.png" alt="user" class="chatImgBorder"></div>
                                            <div class="chat-content pl-2 ">
                                                <h6 class="font-medium">콜린</h6>
                                                <div class="box bg-light-info otherBubble">저 장가갑니다. 축하해주세요.</div>
                                            </div>
                                            <div class="chat-time">10:56 am</div>
                                        </li>
                                        <!--chat Row -->
                                        <li class="chat-item" style="margin-top:10px;">
                                            <div class="chat-img"><img src="resources/images/user/group.png" alt="user" class="chatImgBorder"></div>
                                            <div class="chat-content pl-2">
                                                <h6 class="font-medium">이정은</h6>
                                                <div class="box bg-light-info otherBubble">아악 콜린 축하해요!!!</div>
                                            </div>
                                            <div class="chat-time">10:57 am</div>
                                        </li>
                                        <!--chat Row -->
                                        <li class="odd chat-item" style="margin-top:10px;">
                                            <div class="chat-content">
                                                <div class="box bg-light-inverse chatbg ownBubble">그래서 날짜는 언제인가요?</div>
                                                <br>
                                            </div>
                                            <div class="chat-time">10:59 am</div>
                                        </li>
                                    </ul>
                               </div>	
 							<div class="card-body border-top p-0">
                                <div class="row">
                                    <div class="col-9">
                                        <div class="input-field m-t-0 m-b-0" >
                                            <textarea id="textarea1" placeholder="메시지를 입력해주세요" class="form-control border-0 mb-0"></textarea>
                                        </div>
                                    </div>
                                    <div class="col-3">
                                        <a class="btn-circle btn-md btn-cyan float-right text-white chatbg mt-2" href="javascript:void(0)"><i class="fas fa-paper-plane"></i></a>
                                    </div>
                                </div>
                            </div>
                       </li>
                    </ul>
                    <!-- 채팅 유정 목록 유엘 끝 -->
              </div>
		</div>
		
					<!--  알람 토글  -->
			<div class="toggleOption" id="alarmToggle"  style="padding-top: 0px;">
					
					<div class="setting-box">
				        <div class="card top_card ">
                            <div class="card-body" style="padding:20px;">
                                <div id="accordion-three" class="accordion">
                                    <div class="card">
                                        <div class="card-header">
                                            <h5 class="mb-0 collapsed clickIcon" data-toggle="collapse" data-target="#collapseOne4" aria-expanded="false" aria-controls="collapseOne4">공지사항 <i class="fa fa-chevron-right" style="float:right"></i>
                                            </h5>
                                        </div>
                                        <div id="collapseOne4" class="collapse" data-parent="#accordion-three" style="line-height:2em;">
                                            <div class="card-body pt-3 accordionBody">
                                            <div class="mt-2"><span class="mr-1"><i class="far fa-bell fa-lg"></i></span>
                                            <span class="badge badge-primary badge-pill mr-1" style="background-color: #ccccff; font-size:13px; color: black;">구매계획</span>
                                            	프로젝트 기간이 연장되었습니다. <span class="ml-1" ><i class="fas fa-times-circle" style="font-size: 1.2em"></i></span>
                                            </div>
                                           
                                            <div class="mt-2">
                                            <span class="mr-1"><i class="far fa-bell fa-lg"></i></span>
                                            <span class="badge badge-primary badge-pill mr-1" style="background-color: #ffb1b9; font-size:13px; color: black">판매전략 프로젝트</span>다음주는 대청소 기간입니다.
                                            <span class="ml-1" ><i class="fas fa-times-circle" style="font-size: 1.2em"></i></span>
                                            </div>
                                           
                                              <div class="mt-2">
                                            <span class="mr-1"><i class="far fa-bell fa-lg"></i></span>
                                            <span class="badge badge-primary badge-pill mr-1" style="background-color: #326295; font-size:13px;">후기관리</span>설날 잘 보내시길 바랍니다.
                                            <span class="ml-1" ><i class="fas fa-times-circle" style="font-size: 1.2em"></i></span>
                                            </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card">
                                        <div class="card-header">
                                            <h5 class="mb-0 collapsed clickIcon" data-toggle="collapse" data-target="#collapseTwo5" aria-expanded="false" aria-controls="collapseTwo5">드라이브<i class="fa fa-chevron-right clickIcon" style="float:right"></i></h5>
                                        </div>
                                        <div id="collapseTwo5" class="collapse" data-parent="#accordion-three" style="line-height:2em;">
                                            <div class="card-body pt-3 accordionBody">
                                            <div class="mt-2"><span class="mr-1"><i class="far fa-bell fa-lg"></i></span>
                                            <span class="badge badge-primary badge-pill mr-1" style="background-color: #ccccff; font-size:13px; color: black;">구매계획</span>
                                            	'file.jpg'파일이 업로드 되었습니다. <span class="ml-1" ><i class="fas fa-times-circle" style="font-size: 1.2em"></i></span>
                                            </div>
                                            
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card">
                                        <div class="card-header">
                                            <h5 class="mb-0 collapsed clickIcon" data-toggle="collapse" data-target="#collapseThree6" aria-expanded="false" aria-controls="collapseThree6">이슈<i class="fa fa-chevron-right clickIcon" style="float:right"></i></h5>
                                        </div>
                                        <div id="collapseThree6" class="collapse" data-parent="#accordion-three" style="line-height:2em;">
                                            <div class="card-body pt-3 accordionBody">
                                            <div class="mt-2 col-md-12"><span class="mr-1"><i class="far fa-bell fa-lg"></i></span>
                                            <span class="badge badge-primary badge-pill mr-1" style="background-color: #ccccff; font-size:13px; color: black;">구매계획</span>
                                            	'[view]로그인 view 구현' 이슈가 등록되었습니다.<span class="ml-1" ><i class="fas fa-times-circle" style="font-size: 1.2em"></i></span>
                                            </div>
                                            <div class="mt-2"><span class="mr-1"><i class="far fa-bell fa-lg"></i></span>
                                             <span class="badge badge-primary badge-pill mr-1" style="background-color: red; font-size:13px; color: black;">PM</span>
                                            <span class="badge badge-primary badge-pill mr-1" style="background-color: #ccccff; font-size:13px; color: black;">구매계획</span>
                                            	칸반보드 view 구현'이슈가 승인 요청을 있습니다. <span class="ml-1"><i class="fas fa-times-circle" style="font-size: 1.2em"></i></span>
                                             </div>
                                 
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card">
                                        <div class="card-header">
                                            <h5 class="mb-0 collapsed clickIcon" data-toggle="collapse" data-target="#collapseThree7" aria-expanded="false" aria-controls="collapseThree7">멘션<i class="fa fa-chevron-right clickIcon" style="float:right"></i></h5>
                                        </div>
                                        <div id="collapseThree7" class="collapse" data-parent="#accordion-three" style="line-height:2em;">
                                            <div class="card-body pt-3 accordionBody">
                                             <div class="mt-2"><span class="mr-1"><i class="far fa-bell fa-lg"></i></span>
                                            <span class="badge badge-primary badge-pill mr-1" style="background-color: #ccccff; font-size:13px; color: black;">구매계획</span>
                                            	배인영님이 언급하였습니다. 
                                            	<span class="ml-1" ><i class="fas fa-times-circle" style="font-size: 1.2em"></i></span>
                                            </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                     </div>	
				</div>  
		
		
			<!-- Setting toggle 
			<div class="toggleOption " id="settingToggle"  style="padding-top: 0px; z-index: 20;">
				<div class="text-center setting-box  mt-5" id="setBackgroundColor">
					<h5 class="mt-3 mb-1 whiteColor">SIDEBAR BACKGROUND</h5>
					<hr class="hrGray">
					<span class="coloricon" style="background-color: white; display: inline-block;"></span>
					<span class="coloricon" style="background-color: gray; display: inline-block;"></span>


				</div>
				<div class="text-center setting-box mt-5" id="setActiveColor">
					<h5 class="mt-3 mb-1 whiteColor">SIDEBAR ACTIVE COLOR</h5>
					<hr class="hrGray">
					<span class="coloricon " style="background-color: white; display: inline-block;"></span>
					<span class="coloricon " style="background-color: #f7c9c9;display: inline-block;"></span>
					<span class=" coloricon " style="background-color: #91a8d1; display: inline-block;"></span>
					<span class=" coloricon " style="background-color: #c4d7a4; display: inline-block;"></span>
				</div>
				<div class="text-center setting-box mt-5">
					<h5 class="mt-3 mb-1 whiteColor">SELECT FONT</h5>
					<hr class="hrGray">
					<div class="col-lg-12">
						<select class="form-control" id="setFont" name="val-skill">
							<option value="'Nanum Brush Script', cursive" style="font-family: 'Nanum Brush Script', cursive;">나눔붓체</option>
                            <option value="'Jua', sans-serif" style="font-family: 'Jua', sans-serif;">주아체</option>
                            <option value="'Hi Melody', cursive" style="font-family: 'Hi Melody', cursive;">하이멜로디체</option>
                            <option value="'Gothic A1', sans-serif" style="font-family: 'Gothic A1', sans-serif;">고딕체</option>
						</select>
					</div>
				</div>
			</div>
			-->
			
        </div>
        
    </nav>
</header>
 <!-- <script type="text/javascript" src="resources/js/jquery-3.2.1.min.js"></script> -->
      <script type="text/javascript" src="resources/js/materialize.min.js"></script>
      <script type="text/javascript" src="resources/js/underscore-min.js"></script>
      
      
	<!-- The core Firebase JS SDK is always required and must be listed first -->
	<script src="https://www.gstatic.com/firebasejs/7.6.2/firebase-app.js"></script>
      
      <!-- TODO: Add SDKs for Firebase products that you want to use
     https://firebase.google.com/docs/web/setup#available-libraries -->
	<script
		src="https://www.gstatic.com/firebasejs/7.6.2/firebase-analytics.js"></script>
	<!-- firebase cloud firestore -->
	<script
		src="https://www.gstatic.com/firebasejs/7.6.2/firebase-firestore.js"></script>
	<!-- firebase database -->
	<script src="https://www.gstatic.com/firebasejs/7.6.2/firebase-database.js"></script>
	<!-- firebase cloud store... for uploading and downloading large object -->
	<script src="https://www.gstatic.com/firebasejs/7.6.2/firebase-firestore.js"></script>
	<!-- firebase cloud messaging... for sending notification -->
	<script src="https://www.gstatic.com/firebasejs/7.6.2/firebase-messaging.js"></script>
 <script>
      console.log("value : " + '${member.name}');
      const curName = "${member.name}";
      const curEmail = "${member.email}"; 
      const curProfilePic = "${member.profilePic}";
     
      const SPLIT_CHAR = '@spl@';
      var roomFlag;
		var roomUserList; // 챗방 유저리스트  			
		var roomUserName; // 챗방 유저 이름 
		var roomId;		
		var roomTitle; 	
    	  
      console.log("현재 접속중인 유저 정보" + curName+"/"+curEmail+"/"+curProfilePic);

      
   
          
        
          // Your web app's Firebase configuration
          var firebaseConfig = {
            apiKey: "AIzaSyCUWhwHawfZnngksqB7RstHZJVC_fQloeg",
            authDomain: "owl-chat-c27f1.firebaseapp.com",
            databaseURL: "https://owl-chat-c27f1.firebaseio.com",
            projectId: "owl-chat-c27f1",
            storageBucket: "owl-chat-c27f1.appspot.com",
            messagingSenderId: "626219367568",
            appId: "1:626219367568:web:84d90164e32b237822ac15",
            measurementId: "G-7FX553N3RH"
          };
          // Initialize Firebase
          firebase.initializeApp(firebaseConfig);
          firebase.analytics();
          
        //Get a reference to the database service
          const database = firebase.database();
             
   


			

			
	      //유저가 채팅기능 버튼을 눌렀을 때 작동하는 콜백 함수... 목적은.. firebase database 유저 정보저장(메세지 읽기, 쓰기를 위해 특정키 부여 누군인지 구분하기 위해 필요)
		  //그리고 이미 디비에 있으면...키 값을 불러서 해당 유저와 관련된 정보를 보여 주는 데 활용 할 수 있다...    
          function writeUserData(name, email, imageUrl) {
		       return new Promise(function(resolve){

		        	  var myRootRef = database.ref();
		        	  myRootRef.child("emails").orderByChild('email').equalTo(email).once('value', function(data){
		          	    console.log('현재 접속한 유저는 채팅 경험이 있나요??	 :' +email+ " / "+ data.key + " / " + data.val() + " / " +data.numChildren());		          	    
						var myResult = data.val();
						var userKey;
						if(myResult == null){
							console.log("신규회원 이메일 등록을 통한 유아디 생성과.. 유저 데이터 등록 필요");
							
							var newUser = database.ref('emails/').push({email :email});
							 userKey = newUser.key;
							console.log("새로 들어온 유저의 키 값은 ??"  + userKey);
							database.ref('users/' + newUser.key).set({
				        	    username: name,
				        	    email: email,
				        	    profile_picture : imageUrl
				        	  });
				        	 
							}else{
								console.log("이미디비에 있는 회원이므로 키값을 뽑아내서... 채팅에 활용");
								data.forEach(function(childSnapshot) {
									userKey = childSnapshot.key;
		              				console.log("이미 있는 회원의 키 값 뽑아 보자 " + userKey);	              				
		         		 		});
							}
						console.log("라이트유저 데이타 펑션에서 유저 키 함 찍어 볼까??>>>"+userKey);
						resolve(userKey);
		          	});
			          
			     });
        	}
       
				function writeProjectRoomData(name, email, imageUrl) {
					
					var roomListTarget = document.querySelectorAll('[data-roomType="MULTI"][data-roomOneVSOneTarget="'
							+ targetUserUid +'"]')[0]; 
					
					if(roomListTarget){ // null 이 아니면 여기가 핵심이다.  룰리스트 타겟있으면 새로운 방 아이디를 만들지 않는다.
						roomListTarget.click(); 
						}else{ // 메세지 로드 
							roomTitle = targetUserName+'님 과의 대화'; 
							roomUserList = [targetUserUid, curUserKey]; // 챗방 유저리스트  			
							roomUserName = [targetUserName, curName] // 챗방 유저 이름 
							roomId = '@make@' + curUserKey +'@time@' + yyyyMMddHHmmsss(); 
							console.log("새로운 상대와의 채팅이 시작 되면 룸 아이디 생성.. 그 값은요??>>>>>>>>>>>>" +roomId);
							openChatRoom(); // 파라미터 추가
							}



									
					var multiUpdates = {}; 
					var messageRef = database.ref('Messages/'+ roomId);
					var messageRefKey = messageRef.push().key	; // 메세지 키값 구하기 
					//var convertMsg = convertMsg(msg); //메세지 창에 에이치티엠엘 태그 입력 방지 코드.. 태그를 입력하면 대 공황 발생.. 그래서

					//UsersInRoom 데이터 저장
					if(document.getElementById('ulMessageList').getElementsByTagName('li').length === 0){ //메세지 처음 입력 하는 경우 
						var roomUserListLength = roomUserList.length; 
						for(var i=0; i < roomUserListLength; i++){ 
							multiUpdates['UsersInRoom/' +roomId+'/' + roomUserList[i]] = true; 
						} 
						//firebase.database().ref('usersInRoom/' + roomId);
						database.ref().update(multiUpdates); // 권한 때문에 먼저 저장해야함 
						loadMessageList(); //방에 메세지를 처음 입력하는 경우 권한때문에 다시 메세지를 로드 해주어야함 
					} 
					
					multiUpdates ={}; // 변수 초기화 

					//메세지 저장 
					multiUpdates['Messages/' + roomId + '/' + messageRefKey] = { 
							uid: curUserKey, 
							userName: curName, 
							message: convertMsg, // 태그 입력 방지
							profileImg: curProfilePic ? curProfilePic : 'noprofile.png', 
							timestamp: firebase.database.ServerValue.TIMESTAMP //서버시간 등록하기 
					} 

					//유저별 룸리스트 저장 
					var roomUserListLength = roomUserList.length;
					 
					if(roomUserList && roomUserListLength > 0){ 
						for(var i = 0; i < roomUserListLength ; i++){ 
							multiUpdates['RoomsByUser/'+ roomUserList[i] +'/'+ roomId] = { 
								roomId : roomId, 
								roomUserName : roomUserName.join('@spl@'), 
								roomUserList : roomUserList.join('@spl@'), 
								roomType : 'MULTI', 
								roomOneVSOneTarget : roomUserListLength == 2 && i == 0 ? roomUserList[1] : // 1대 1 대화이고 i 값이 0 이면 
									roomUserListLength == 2 && i == 1 ? roomUserList[0] // 1대 1 대화 이고 i값이 1이면 
									: '', // 나머지 
								lastMessage : convertMsg, 
								profileImg : curProfilePic ? curProfilePic : 'noprofile.png', 
								timestamp: firebase.database.ServerValue.TIMESTAMP 

							}; 
						} 
					} 
					database.ref().update(multiUpdates);

					//RoomsByUser 디비 업데이트 후 다시 챗방 리스트 다시 로드
					loadRoomList(curUserKey);


					//프로젝트 룸 리스트 업 하는 것이 이 함수의 목적이고 아래와 같은 파라미터가 필요하다. 룸리스트 업 함수는 태그를 리턴하다.. 그래서 포쿤을 돌려서 붙이던가 해야 함...
					var roomListTag = roomListUp(roomId, roomTitle, roomUserName,roomType, roomOneVSOneTarget, roomUserList, lastMessage, datetime);
					
		        	}	
			



			

			//채팅방 유적 목록 클릭시 실행 되는 펑션
          function onUserListClick(event){
                roomFlag = 'tabUserList';//유저 리스트를 클릭했다는 플래그
				console.log("유저 목폭 클릭 펑션 타나요?? >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
				console.log("이함수 에서 현재 접속한 유저의 챗방 키 값 뽑아 보자" + $('#curUserKey').val());
				var curUserKey = $('#curUserKey').val();
				document.getElementById('aBackBtn').classList.remove('hiddendiv'); // 백버튼 노출 
				document.getElementById('aInvite').classList.remove('hiddendiv'); // 초대 버튼 노툴 			

				var targetUserUid = event.getAttribute('data-targetUserUid'); 
				console.log("targetUserUid 는 제대로 찍히나요(온 유저 리스트 클릭시)>>>>>>>>>" + targetUserUid);				
				var targetUserName = event.getAttribute('data-username'); 

				console.log("온 유저 리스 클릭시에.. 타겟 유저 유 아 이 디 가져 오나요???" + targetUserUid);

				
				//바로 위 코드 까지는 워킹~~ 아래 코드는 해당 유저를 클릭시 이미 챗방이 만들어 져 잇으면 데이타를 가져오기 위한 코드
				var roomListTarget = document.querySelectorAll('[data-roomType="ONE_VS_ONE"][data-roomOneVSOneTarget="'
										+ targetUserUid +'"]')[0]; 
				console.log("roomListTarget 이아이는 무슨 값??" + roomListTarget);
				
				
				if(roomListTarget){ // null 이 아니면 여기가 핵심이다.  룰리스트 타겟있으면 새로운 방 아이디를 만들지 않는다.
					roomListTarget.click(); 
					}else{ // 메세지 로드 
						roomTitle = targetUserName+'님 과의 대화'; 
						roomUserList = [targetUserUid, curUserKey]; // 챗방 유저리스트  			
						roomUserName = [targetUserName, curName] // 챗방 유저 이름 
						roomId = '@make@' + curUserKey +'@time@' + yyyyMMddHHmmsss(); 
						console.log("새로운 상대와의 채팅이 시작 되면 룸 아이디 생성.. 그 값은요??>>>>>>>>>>>>" +roomId);
						openChatRoom(); // 파라미터 추가
						}

				
            }
          

		  function pressEnter(ev) {
			  console.log("챗방 메세지 입력하고 엔터 누르면 타야 되는 함수");
				console.log("openChatRoom function  변수값 받아야 하는데~~~!!!!" + roomId +"/"+roomUserList+"/"+roomUserName);
				if(ev.keyCode === 13){ //엔터키 키코드가 입력이 되면 
					ev.preventDefault();
					console.log("챗방 메세지 입력하고 엔터 누르면 타야 되는 함수 이프문 안인데  여기는 타나요??"); 
					saveMessages(); 

			  }
		  }
		

          function openChatRoom() {
             
        	  //loadRoomList(roomId); 
        	  window.isOpenRoom = true; // 방이 열린 상태인지 확인하는 플래그 값 
        	  if(roomTitle){ //상단 타이틀 변경 
            	  document.getElementById('spTitle').innerHTML = roomTitle; 
            	  } 
        	  loadMessageList(); //메세지 로드 
              $('#tabMessageList').click();
            
			console.log("이즈 오픈 룸의 값은??" + window.isOpenRoom);

			//아래 코드는 온로드 뒤에 실행 되게 위치 이동해야 함... 일단은 다른게 급하니... 남겨두고...
			document.getElementById('iBtnSend').addEventListener('click', function(){
				saveMessages();
				});

			
        	console.log("오픈챗룸 함수 마지막 단 타나요????");


			//오픈 챗방 했을 때 초대 모달 창 세팅을 위한 함수
        	setAddUserList();

        	
              }


			//챗방 초대를 위한 모달 창 세팅을 위한 함수
          function setAddUserList() {
        	  //$('#ulAddUserList').html($('#ulUserList').html()); 
        	  var arrAddUserList = Array.prototype.slice.call($('#ulUserList li')); 
        	  console.log("setAddUserList 함수에서 arrAddUserList 요기에 담기는 값은?? " + arrAddUserList);
        	  console.log("setAddUserList 함수 탔을 때... 룸 유저 리스트 값은??>>>>" + roomUserList);
        	 
        	  arrAddUserList.forEach(cbArrayForEach);
           }


          var cbArrayForEach = function(item){
              item.removeAttribute('onclick');  
              
        	  var itemUserUid = item.getAttribute('data-targetUserUid'); 
        	 
    	  	  if(roomUserList.indexOf(itemUserUid) === -1){
        	  	  console.log("여기는 타기는 할까???");
        	  	
        	  	
        	  	//item.getElementsByClassName('done')[0].classList.remove('hiddendiv'); 
        	  	item.addEventListener('click',function(){
            	  	console.log("클릭 이벤트 리슨너가 왜 안들어가냐???-----------------------------------------------"); 
            	  if(Array.prototype.slice.call(item.classList).indexOf('blue-text') == -1){ 
                	  item.classList.add('blue-text'); 
                	  }else{ 
                    	  item.classList.remove('blue-text'); 
                    	  } 
            	  }); 
        	  }else{ 
            	  item.parentNode.removeChild(item); 
            	  } 
    	  } 		

          /** * 메세지 로드 */ 
          function loadMessageList(){ 
              console.log("메세지 로드 함수 타나요??");
              console.log("아잭스에서 선언된 윈도우.. 글로벌 변수 찍히나 여기서??" + window.myUserKy);             
              var myKey = $('#curUserKey').val();
                           
              var messageRef = database.ref('Messages/'+roomId);

             if(roomId){ 
                 document.getElementById('ulMessageList').innerHTML = ''; //메세지 화면 리셋 
                 console.log("이프 룸아이디 밑에다.. 여기 타나요??");
					//언더스코어 제이에서 어쩌구... 자꾸 에러 나서 .. 그리고 어케 사용하는 지 몰라서 포기........
                 //var messageTemplate = document.getElementById('templateMessageList').innerHTML;

              
                 
                 messageRef.off();
        
             	  
                 messageRef.limitToLast(50).on('child_added', function(data){
                     	console.log("여기까지 오긴 하는 거니??~~~~~~~~~~~~~~~~~~~~~~데이타 값은~~~~~~~~~~~~~~~~~~" + data + " / " + data.val());
                     	var msgKey = data.val();
                     	console.log("데이타 값은~~~~~~~~~~~~~~~~~~" + data + " / " + data.key + "/"+msgKey.userName);
           			 	messageListUp(data.key, msgKey.profileImg, msgKey.timestamp, msgKey.userName, msgKey.message);              				
      		 		
							
                     }); 
             }else{
           	  messageRef.limitToLast(50).on('child_added', function(data){
                   	console.log("여기까지 오긴 하는 거니??~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
             	  data.forEach(function(childSnapshot) {
							var msgKey = childSnapshot.key;
         				console.log("메세지 로드 함수를 타긴 하는거야 머야??? " + msgKey);
                 }); 
           	  });
           } 

         }
			




          /** * 두번째 탭 채팅방 목록리스트 호출 */
  		function loadRoomList(uid) {
  			document.getElementById('ulRoomList').innerHTML='';
			var ulRoomList = document.getElementById('ulRoomList');
			//var curUserKey = $('#curUserKey').val();			
			var roomRef = database.ref('RoomsByUser/'+ uid);
			console.log("현재 유저의 키 찍히나??>>>>>>>>>>>>>>>>>>>>>>" + uid)	;
			console.log("loadRoomList 함수에서 찍히는 현재 유저의 uid >???>>>?????" + uid +"/"+roomRef);					 
			roomRef.off(); 
			roomRef.orderByChild('timestamp').on('value', function(snapshot){
				console.log("loadRoomList 함수 아래다.. 쿼리문 날리고.. 데이타 들어 오나 확인중....." + ">>"+snapshot+"<<" + snapshot.exists());
				console.log(snapshot+"/"+snapshot.numChildren());
	
				var arrRoomListHtml = []; 			
				snapshot.forEach(function(data){
						var val = data.val();				
						console.log(val.roomId);
						console.log(val.roomUserName);
						console.log(val.timestamp);

						
						var arrRoomUserName = val.roomUserName.split('@spl@');
						console.log("어레이 룸 유져 네임 에 찍히는 값은??" + arrRoomUserName); 
						arrRoomUserName.splice(arrRoomUserName.indexOf(curName), 1); // 방 제목 타이틀에서는 자신의 이름을 제외합니다. 
						var eachRoomTitle = arrRoomUserName.length > 1 ? arrRoomUserName[0] + " 외 " + (arrRoomUserName.length - 1) + "명 참여중" : arrRoomUserName[0] +'님과의 대화'; 
						if(data.key === roomId && window.isOpenRoom){ //데이터 키가 현재 방ID와 같고 채팅방이 열려있는 경우에 현재 메세지 상단 제목을 갱신해줍니다. 
							document.getElementById('spTitle').innerHTML = eachRoomTitle; 
						} 
						var roomId = data.key,
						lastMessage = val.lastMessage, 
						profileImg = val.profileImg, 
						roomTitle = eachRoomTitle, 
						roomUserName =val.roomUserName, 
						roomUserList = val.roomUserList, 
						roomType = val.roomType, 
						roomOneVSOneTarget = val.roomOneVSOneTarget, 
						datetime = timestampToTimeForRoomList(val.timestamp); 

						arrRoomListHtml.push(roomListUp(roomId, roomTitle, roomUserName,roomType, roomOneVSOneTarget, roomUserList, lastMessage, datetime));
					}); 

				console.log("너는 어레이 타입이니????" + Array.isArray(arrRoomListHtml));
				console.log(arrRoomListHtml.length);
				console.log("조인 붙이고" +arrRoomListHtml.reverse().join(''));
				console.log("조인 안 아니아ㅣㄴ  붙이고" +arrRoomListHtml.reverse());
				
				//var reversedRoomList = arrRoomListHtml.reverse().join(''); // 역순 정렬, 끝에 싱글 코테이션 조인 해야 되나??? 오류 나올듯 도 한데.... 
				var reversedRoomList = arrRoomListHtml.reverse();
				console.log(typeof reversedRoomList);
				console.log("너는 어레이 타입이니????" + Array.isArray(reversedRoomList));
				console.log(reversedRoomList);

				reversedRoomList.forEach(function(item, index){
					console.log("여기를 타야 그 챗방 리스트를 뿌려 줄수 있다... 과연...." + item);
					$('#ulRoomList').append(item);
					}); 
				
				});
  	  		}

  		function onRoomListClick(event){
  	  		console.log("++++++++++++당신은 채팅방 리스트를 클릭했거나... 유저목록에서.. 이미 채팅한적이 있는 유저를 클릭했습니다.");
  	  		roomFlag = 'tabRoomList'; //채팅방을 클릭했다는 것을 알기 위한 플래그
  	  		document.getElementById('aBackBtn').classList.remove('hiddendiv'); 
  	  		document.getElementById('aInvite').classList.remove('hiddendiv'); 

  			// 메세지 로드 
  			roomId = event.getAttribute('data-roomId'); 
  			roomTitle = event.getAttribute('data-roomTitle'); 
  			roomUserList = event.getAttribute('data-roomUserList').split('@spl@'); // 챗방 유저리스트  			
  			roomUserName = event.getAttribute('data-roomUserName').split('@spl@'); // 챗방 유저 이름 
  			openChatRoom();   

            console.log("온 룸 리스트 클릭 함수 타냐?????");
  			// 메세지 화면 이동 
  			 $('#tabMessageList').click();
  	  		}


  		/** * RoomList 화면 시간변환 */ 
  		var timestampToTimeForRoomList = function(timestamp){ 
  	  		var date = new Date(timestamp), 
  	  			year = date.getFullYear(), 
  	  			month = date.getMonth()+1, 
  	  			day = date.getDate(), 
  	  			hour = date.getHours(), 
  	  			minute = date.getMinutes(); 
  	  		var nowDate = new Date(), 
  	  			nowYear = nowDate.getFullYear(), 
  	  			nowMonth = nowDate.getMonth()+1, 
  	  			nowDay = nowDate.getDate(), 
  	  			nowHour = nowDate.getHours(), 
  	  			nowMinute = nowDate.getMinutes(); 
	  		var result; 
	  		if(year === nowYear && month === nowMonth && day === nowDay){ 
		  		result = pad(hour) +":" + pad(minute); 
		  	}else{ 
			  	result = pad(year) +"-" + pad(month) + "-" + pad(day); 
			  	} 
		  	return result; 

		  	}

	  	function pad(n) {
	  		return n > 9 ? "" + n: "0" + n;  		
		  	}

  		
 
 				/** * 메세지에 태그 입력시 변경하기 */ 
 			function myConvertMsg(html){ 
				console.log("챗 메세지 창 태그 방지 함수 타나요???");
	  			var tmp = document.createElement("DIV"); 
	  			tmp.innerHTML = html; 
	  			return tmp.textContent || tmp.innerText || ""; 
		 	}
			
			function saveMessages(inviteMessage) {
				console.log("세이브 메세지 함수 여기까지 룸 아이디 오나요???" + roomId + " / " + roomUserList + " / " +roomUserName);
				console.log("세이브 메세지 함수 여기까지 룸 아이디 오나요???" + roomUserList);
				var msgDiv = document.getElementById('dvInputChat');
				var msg = inviteMessage ? inviteMessage : msgDiv.innerHTML.trim(); 
				console.log("메세지 왜 못 잡아??" + msg);
				var curUserKey = $('#curUserKey').val();
				var curUserName = $('#memberName').val();	
				console.log("세이브 메세지 함수  현재 사용중인 유저 이름 가져오기  ~~~????>>>>>>" + curUserName);			
				var curUserProfilePic = curProfilePic;
				var convertMsg = myConvertMsg(msg); //메세지 창에 에이치티엠엘 태그 입력 방지 코드.. 태그를 입력하면 대 공황 발생.. 그래서
				if(msg.length > 0){ 
					msgDiv.focus(); 
					msgDiv.innerHTML = ''; 
					var multiUpdates = {}; 
					var messageRef = database.ref('Messages/'+ roomId);
					var messageRefKey = messageRef.push().key	; // 메세지 키값 구하기 
					//var convertMsg = convertMsg(msg); //메세지 창에 에이치티엠엘 태그 입력 방지 코드.. 태그를 입력하면 대 공황 발생.. 그래서

					//UsersInRoom 데이터 저장
					if(document.getElementById('ulMessageList').getElementsByTagName('li').length === 0){ //메세지 처음 입력 하는 경우 
						var roomUserListLength = roomUserList.length; 
						for(var i=0; i < roomUserListLength; i++){ 
							multiUpdates['UsersInRoom/' +roomId+'/' + roomUserList[i]] = true; 
						} 
						//firebase.database().ref('usersInRoom/' + roomId);
						database.ref().update(multiUpdates); // 권한 때문에 먼저 저장해야함 
						loadMessageList(); //방에 메세지를 처음 입력하는 경우 권한때문에 다시 메세지를 로드 해주어야함 
					} 
					
					multiUpdates ={}; // 변수 초기화 

					//메세지 저장 
					multiUpdates['Messages/' + roomId + '/' + messageRefKey] = { 
							uid: curUserKey, 
							userName: curName, 
							message: convertMsg, // 태그 입력 방지
							profileImg: curProfilePic ? curProfilePic : 'noprofile.png', 
							timestamp: firebase.database.ServerValue.TIMESTAMP //서버시간 등록하기 
					} 

					//유저별 룸리스트 저장 
					var roomUserListLength = roomUserList.length;
					 
					if(roomUserList && roomUserListLength > 0){ 
						for(var i = 0; i < roomUserListLength ; i++){ 
							multiUpdates['RoomsByUser/'+ roomUserList[i] +'/'+ roomId] = { 
								roomId : roomId, 
								roomUserName : roomUserName.join('@spl@'), 
								roomUserList : roomUserList.join('@spl@'), 
								roomType : roomUserListLength > 2 ? 'MULTI' : 'ONE_VS_ONE', 
								roomOneVSOneTarget : roomUserListLength == 2 && i == 0 ? roomUserList[1] : // 1대 1 대화이고 i 값이 0 이면 
									roomUserListLength == 2 && i == 1 ? roomUserList[0] // 1대 1 대화 이고 i값이 1이면 
									: '', // 나머지 
								lastMessage : convertMsg, 
								profileImg : curProfilePic ? curProfilePic : 'noprofile.png', 
								timestamp: firebase.database.ServerValue.TIMESTAMP 

							}; 
						} 
					} 
					database.ref().update(multiUpdates);

					//RoomsByUser 디비 업데이트 후 다시 챗방 리스트 다시 로드
					loadRoomList(curUserKey);

					
					
				} 
		   }



          
          /** * 현재날짜 yyyyMMddHHmmsss형태로 반환 */ 
          var yyyyMMddHHmmsss =function(){ 
              var vDate = new Date(); 
              var yyyy = vDate.getFullYear().toString(); 
              var MM = (vDate.getMonth() + 1).toString(); 
              var dd = vDate.getDate().toString(); 
              var HH = vDate.getHours().toString(); 
              var mm = vDate.getMinutes().toString(); 
              var ss = vDate.getSeconds().toString(); 
              var sss= vDate.getMilliseconds().toString(); 
              return yyyy + (MM[1] ? MM : '0'+MM[0]) + (dd[1] ? dd : '0'+dd[0]) + (HH[1] ? HH : '0'+ HH[0]) + (mm[1] ? mm : '0'+ mm[0]) + (ss[1] ? ss : '0'+ss[0])+ sss; 
              };

          
              /** * timestamp를 날짜 시간 으로 변환 */ 
              var timestampToTime = function(timestamp){ 
                  var date = new Date(timestamp), 
                  	  year = date.getFullYear(), 
                  	  month = date.getMonth()+1, 
                  	  day = date.getDate(), 
                  	  hour = date.getHours(), 
                  	  minute = date.getMinutes(), 
                  	  week = new Array('일', '월', '화', '수', '목', '금', '토'); 
              	  var convertDate = year + "년 "+month+"월 "+ day +"일 ("+ week[date.getDay()] +") "; 
              	  var convertHour=""; 
              	  if(hour < 12){ 
                  	  convertHour = "오전 " + FirebaseChat.pad(hour) +":" + FirebaseChat.pad(minute); 
                  	  }else if(hour === 12){ 
                      	  convertHour = "오후 " + FirebaseChat.pad(hour) +":" + FirebaseChat.pad(minute); 
                      	  }else{ convertHour = "오후 " + FirebaseChat.pad(hour - 12) +":" + FirebaseChat.pad(minute); 
                      	  } 
              	  return convertDate + convertHour; 

              }

              
          

          var rootRef = database.ref();

		  //채팅방 만들기 버튼 눌렀을 때 유저 목록 뿌려 주는 함수....	
          var userListUp = function(targetuid, name, userpic, email){
        	  var userProPic = 	(userpic ? 'resources/images/user/'+ userpic : 'resources/images/user/noprofile.png'); 
        	  let errorSource = "this.src='resources/images/login/profile.png'";
        	  var userTemplate = '<li id="li' + targetuid +'" data-targetUserUid="' +targetuid + '" data-username="' + name + '" class="collection-item avatar list" onclick = "onUserListClick(this)" >' 
        	  				  + '<div class="input-group "><div class="form-control pt-2 pb-2"><img src="' + userProPic + '"  alt="" class="circle mr-3" height="35" width="35" onerror="'+errorSource+'" >'+ name + '('+email+')</div>'                      
        	  				 // + '<div class="input-group-append"><span class="input-group-text">'+ name + '('+email+')</span></div>'
        	  				 // +'<span class="small material-icons right done">done</span>'
        	  				 // + '<span class="small material-icons right hiddendiv mood yellow-text">mood</span>'
        	  				  + '</div></li>'; 

/*         	  var userTemplate = '<li id="li' + targetuid +'" data-targetUserUid="' +targetuid + '" data-username="' + name + '" class="collection-item avatar list" onclick = "onUserListClick(this)">' 
       	  				 		 + '<div class="row"><div class="col-2"><img src="' + userProPic + '"  alt="" class="circle" height="35" width="35" onerror="'+errorSource+'"></div>'                      
       	  				 		 + '<div class="col-10"><span class="title" style="font-size : 14px;">'+ name + '('+email+')</span></div>'
       	  						  + '</div></li>';  */
      	            					 
        	  $('#ulUserList').append(userTemplate);

              }
          
	
          var messageListUp= function(key, profileImg, time, userName, message){
              console.log("messageListUp 함수..데이타 들어오냐??" + key+"/"+profileImg+"/"+time+"/"+userName+"/"+message);
			  var userProPic = 	(profileImg ? 'resources/images/user/'+ profileImg : 'resources/images/user/noprofile.png');
        	  var messageTemplate = '<li id="li' + key  + '" class="collection-item avatar" data-key="' + key + '">'+
  									'<img src="'+ userProPic +'" alt="" class="rounded-circle">'+
  									'<span class="title">'+userName+'</span><span class="time">'+time+'</span>'+
  									'<p>'+message+'</p>'+
  					 				'</li>'; 
          
        	  $('#ulMessageList').append(messageTemplate);
        	  messageTemplate += '먼데 안들어가는 거야??';
        	  console.log("messageListUp 합수 타변 변수에 담기는 값들은??>>>" +messageTemplate);
          } 

          var roomListUp = function(roomId, roomTitle, roomUserName,roomType, roomOneVSOneTarget, roomUserList, lastMessage, datetime){
        	    var userProPic = 	(curProfilePic ? curProfilePic : 'resources/images/user/noprofile.png');
				var roomTemplate = '<li id="liRoom' + roomId + '" data-roomId="' + roomId + '" data-roomTitle="' 
									+ roomTitle+ '" data-roomUserName="'+roomUserName+ '" data-roomType="'+roomType+'" data-roomOneVSOneTarget="'
									+roomOneVSOneTarget+'" data-roomUserList="'+roomUserList +'" class="collection-item avatar" onclick="onRoomListClick(this)">'
	            					+'<img src="' + userProPic + '" alt="" class="circle">'
	            					+'<span class="title">'+roomTitle+'</span>'
	            					+'<p>'+lastMessage +'</p>'
	            					+'<a href="#!" class="secondary-content">' +datetime +'</a>'
	        						+'</li>';	



					return roomTemplate;	
              }
          
          function onBackBtnClick(){ 
              window.isOpenRoom = false; 
              document.getElementById('aBackBtn').classList.add('hiddendiv'); 
              document.getElementById('aInvite').classList.add('hiddendiv'); 
              console.log("백 버튼 누르면 룸 플래그 값은 ??" + roomFlag);
              document.getElementById(roomFlag).click(); 
              document.getElementById('spTitle').innerText = 'OWL Chat Room'; 
              document.getElementById('ulMessageList').innerHTML='';
              
               
              }



		  function createRoomInfo(){
			    roomTitle = $('#chatRoomTitle').val(); 
				roomUserList = []; // 챗방 유저리스트  			
				roomUserName = []; // 챗방 유저 이름 
				roomId = '@make@' + curUserKey +'@time@' + yyyyMMddHHmmsss();


				 
					msgDiv.focus(); 
					msgDiv.innerHTML = ''; 
					var multiUpdates = {}; 
					var messageRef = database.ref('Messages/'+ roomId);
					var messageRefKey = messageRef.push().key	; // 메세지 키값 구하기 
					//var convertMsg = convertMsg(msg); //메세지 창에 에이치티엠엘 태그 입력 방지 코드.. 태그를 입력하면 대 공황 발생.. 그래서

					//UsersInRoom 데이터 저장
					if(document.getElementById('ulMessageList').getElementsByTagName('li').length === 0){ //메세지 처음 입력 하는 경우 
						var roomUserListLength = roomUserList.length; 
						for(var i=0; i < roomUserListLength; i++){ 
							multiUpdates['UsersInRoom/' +roomId+'/' + roomUserList[i]] = true; 
						} 
						//firebase.database().ref('usersInRoom/' + roomId);
						database.ref().update(multiUpdates); // 권한 때문에 먼저 저장해야함 
						loadMessageList(); //방에 메세지를 처음 입력하는 경우 권한때문에 다시 메세지를 로드 해주어야함 
					} 
					
					multiUpdates ={}; // 변수 초기화 

					//메세지 저장 
					multiUpdates['Messages/' + roomId + '/' + messageRefKey] = { 
							uid: curUserKey, 
							userName: curName, 
							message: convertMsg, // 태그 입력 방지
							profileImg: curProfilePic ? curProfilePic : 'noprofile.png', 
							timestamp: firebase.database.ServerValue.TIMESTAMP //서버시간 등록하기 
					} 

					//유저별 룸리스트 저장 
					var roomUserListLength = roomUserList.length;
					 
					if(roomUserList && roomUserListLength > 0){ 
						for(var i = 0; i < roomUserListLength ; i++){ 
							multiUpdates['RoomsByUser/'+ roomUserList[i] +'/'+ roomId] = { 
								roomId : roomId, 
								roomUserName : roomUserName.join('@spl@'), 
								roomUserList : roomUserList.join('@spl@'), 
								roomType : roomUserListLength > 2 ? 'MULTI' : 'ONE_VS_ONE', 
								roomOneVSOneTarget : roomUserListLength == 2 && i == 0 ? roomUserList[1] : // 1대 1 대화이고 i 값이 0 이면 
									roomUserListLength == 2 && i == 1 ? roomUserList[0] // 1대 1 대화 이고 i값이 1이면 
									: '', // 나머지 
								lastMessage : convertMsg, 
								profileImg : curProfilePic ? curProfilePic : 'noprofile.png', 
								timestamp: firebase.database.ServerValue.TIMESTAMP 

							}; 
						} 
					} 
					database.ref().update(multiUpdates);

					//RoomsByUser 디비 업데이트 후 다시 챗방 리스트 다시 로드
					loadRoomList(curUserKey);

			  }
			
          function onCreateClick(){
        	  roomTitle = $('#chatRoomTitle').val(); 
			  roomUserList = [curUserKey]; // 챗방 유저리스트  			
			  roomUserName = [curName]; // 챗방 유저 이름 
			  roomId = '@make@' + curUserKey +'@time@' + yyyyMMddHHmmsss();





			  var multiUpdates = {}; 
				var messageRef = database.ref('Messages/'+ roomId);
				var messageRefKey = messageRef.push().key	; // 메세지 키값 구하기 
				//var convertMsg = convertMsg(msg); //메세지 창에 에이치티엠엘 태그 입력 방지 코드.. 태그를 입력하면 대 공황 발생.. 그래서

				//UsersInRoom 데이터 저장
				if(document.getElementById('ulMessageList').getElementsByTagName('li').length === 0){ //메세지 처음 입력 하는 경우 
					var roomUserListLength = roomUserList.length; 
					for(var i=0; i < roomUserListLength; i++){ 
						multiUpdates['UsersInRoom/' +roomId+'/' + roomUserList[i]] = true; 
					} 
					//firebase.database().ref('usersInRoom/' + roomId);
					database.ref().update(multiUpdates); // 권한 때문에 먼저 저장해야함 
					loadMessageList(); //방에 메세지를 처음 입력하는 경우 권한때문에 다시 메세지를 로드 해주어야함 
				} 
				
				multiUpdates ={}; // 변수 초기화 

				//메세지 저장 
				multiUpdates['Messages/' + roomId + '/' + messageRefKey] = { 
						uid: curUserKey, 
						userName: curName, 
						message: convertMsg, // 태그 입력 방지
						profileImg: curProfilePic ? curProfilePic : 'noprofile.png', 
						timestamp: firebase.database.ServerValue.TIMESTAMP //서버시간 등록하기 
				} 

				//유저별 룸리스트 저장 
				var roomUserListLength = roomUserList.length;
				 
				if(roomUserList && roomUserListLength > 0){ 
					for(var i = 0; i < roomUserListLength ; i++){ 
						multiUpdates['RoomsByUser/'+ roomUserList[i] +'/'+ roomId] = { 
							roomId : roomId, 
							roomUserName : roomUserName.join('@spl@'), 
							roomUserList : roomUserList.join('@spl@'), 
							roomType : roomUserListLength > 2 ? 'MULTI' : 'ONE_VS_ONE', 
							roomOneVSOneTarget : roomUserListLength == 2 && i == 0 ? roomUserList[1] : // 1대 1 대화이고 i 값이 0 이면 
								roomUserListLength == 2 && i == 1 ? roomUserList[0] // 1대 1 대화 이고 i값이 1이면 
								: '', // 나머지 
							lastMessage : convertMsg, 
							profileImg : curProfilePic ? curProfilePic : 'noprofile.png', 
							timestamp: firebase.database.ServerValue.TIMESTAMP 

						}; 
					} 
				} 
				database.ref().update(multiUpdates);

				//RoomsByUser 디비 업데이트 후 다시 챗방 리스트 다시 로드
				loadRoomList(curUserKey);

				

           }
			
          
       


	           
          console.log("널인가???" + curName + " / " + curEmail);

			// 초기화 를 위한 온로드 함수... 같은 프로제트에 있는 유저목록과 프로젝트 채팅방을 만들기 위한 정보를 디비에서 뽑아낸다.	
          $(function(){
            console.log("아잭스 펑션을 타긴 하니??");
			var curUserKey;
            //writeUserData(curName, curEmail, curProfilePic);
            writeUserData(curName, curEmail, curProfilePic).then(function(resolvedData){
				console.log("현재 사용자의 챗방 키는용???>>" + resolvedData + "<<<<<");
                $('#curUserKey').val(resolvedData);
                window.myUserKy = resolvedData;
                loadRoomList(resolvedData);
                
                
            }); 

            //같은 프로젝트에 있는 유저 정보를 뽑아오는 아젝스...요걸로 채팅 가능한 유저들 리스트 화면 뿌려 준다.
      		$.ajax({
      			url: "MyProjectsMates.do",
      			type: "POST",
      			dataType: 'json',
      			data : { email : curEmail,
      				     name : curName }, 
      			success: function (data) {
      				console.log("뷰단으로 데이터 들어 오나요?? >" + data);

      				
      				$.each(data, function(index, value) {          				
      				  console.log(value);
      				  console.log(value.name + " / " + value.email + " / " + value.profilePic);
      				  //var myResult = writeUserData(value.name, value.email, value.profilePic);
      				  //console.log("유저 디비 저장 하는 펑션 실행 한뒤 리턴 값은?? 키여야 하는데>>>>>>>>>" + myResult);

				
      				writeUserData(value.name, value.email, value.profilePic).then(function(resolvedData){          				
    					console.log("프라미스 실행뒤 오는 값은>>>>>>>>>>" + resolvedData + "유저리스트 값은??");
    					//목록을 뿌리기위한 태크 뭉치들이 들어 있는 함수 콜
    					userListUp(resolvedData, value.name, value.profilePic, value.email);
						
      					});

      				});

					//채팅방 만들기 할 때 유저 리스업 되고 나서... 클릭 리스너 다는 함수..
      				setAddUserList();
      				
      			},
      			error: function(xhr, status, error){
          			console.log("아잭스 에러 터짐 ㅠㅠ");
      		         var errorMessage = xhr.status + ': ' + xhr.statusText
      		         alert('Error - ' + errorMessage);
      		     }
      		});

			//같은 프로젝트에 있는 유저들끼리의 챗방을 만들기 위한 아젝스.... 요게 가능 한가... 아....
      		/* $.ajax({
      			url: "MyProjectsMatesFull.do",
      			type: "POST",
      			dataType: 'json',
      			data : { email : curEmail,
      				     name : curName }, 
      			success: function (data) {
      				console.log("뷰단으로 데이터 들어 오나요?? >" + data);

      			    var projectIdxGrouped = new Set();
      			    
      				$.each(data, function(index, value) {          				
      				  console.log(value);
      				  console.log("풀리스트" +value.name + " / " + value.email + " / " + value.profilePic + " / " + value.projectIdx);
      				projectIdxGrouped.add(value.projectIdx);
      				  
      				  //var myResult = writeUserData(value.name, value.email, value.profilePic);
      				  //console.log("유저 디비 저장 하는 펑션 실행 한뒤 리턴 값은?? 키여야 하는데>>>>>>>>>" + myResult);

      				  //같은 프로젝트에 속해 있는 유저들간의  챗방을 만들기 위해서 우선 디비에서 같은 프로젝트에 속해 있는 유저 정보 뽑아 오고.. 
      				  // 요 데이타를 그룹핑 하고... 함수에 태워서.... 채팅방을 만든다....
						
      				
      				

      				});
	
      				console.log("너의 프로젝트 아이디엑스는>>>>>>>>>>>>>>>>>>>>>>>" + projectIdxGrouped);
      				
      				var arrIdx = [...projectIdxGrouped];
      				console.log("어레이로 바뀌었을까????????????????????????" + arrIdx);
      				console.log(arrIdx.length);
      				console.log(arrIdx[0]);
                   
      				$.each(data, function(index, value) {          				
        				  
      					for(var i=0; i<arrIdx.length; i++){
                            if(arrIdx[i] == value.projectIdx){
                                

                                }
    						}
		

        				});


      				
      				//바로 아래 함수는 위 아젝스에 받은 데이터..... 콜렉션을.. 그룹핑해서... 그 데이터를 가지고... 파이어 베이스에 데이터 저장을 위한 함수...
      				//writeProjectRoomData(value.name, value.email, value.profilePic); 
      				
      			},
      			error: function(xhr, status, error){
          			console.log("풀리스트 불러오는 아잭스 에러 터짐 ㅠㅠ");
      		         var errorMessage = xhr.status + ': ' + xhr.statusText
      		         alert('Error - ' + errorMessage);
      		     } 
      		});*/

      		
		//온로드 뒤에 백 버튼 리스너 달기
    		$('#aBackBtn').click(onBackBtnClick);

      	//메세지 입력창 키다운 이벤트 달기
			document.getElementById('dvInputChat').addEventListener('keydown', pressEnter);

		//채팅 초대창 모달 띄우기
			 //FirebaseChat 클래스 초기화
				 //다운로드 프로그레스 팝업 modal 설정 
				 $('#dnModal').modal(); 
				 
				 //채팅방 초대 modal 설정 
				 $('#dvAddUser').modal(); 
				 console.log("모달 설정하는 제이쿼리 실행된거야 머야??????>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
				

		//초대 모달창에서 초대 버튼 클릭시  체크된 인원을 현재 챗방에 추가하는 클릭 리스너
			$('#onCreateClick').click(onCreateClick);


      	});	
          
      </script>

	<!-- MyProfile Modal -->
	<jsp:include page="../member/myProfileSetting.jsp" />
	<jsp:include page="../chat/newChat.jsp" />
