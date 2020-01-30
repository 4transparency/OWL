<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<!-- File Upload -->
<script src="resources/plugin/fileUpload/jquery.fileupload.js"></script>
<script src="resources/plugin/fileUpload/jquery.iframe-transport.js"></script>
<script src="resources/plugin/fileUpload/jquery.ui.widget.js"></script>
<!-- Contect Menu -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.contextMenu.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.contextMenu.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.ui.position.js"></script>

<link href="resources/css/drive.css" rel="stylesheet">
<script src="resources/js/drive.js"></script>

<style>
.btn-link1 {
	display: inline-block;
	padding: 0;
	font-size: inherit;
	color: #0366d6;
	text-decoration: none;
	white-space: nowrap;
	cursor: pointer;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	background-color: initial;
	border: 0;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	
}
/* .more {
    visibility: hidden;
} */
</style>
<script>
var folderList = [];

function folderInfo() {
    this.id = null;
    this.parent = null;   
    this.text = null;
    this.state ={};
}

function addFolder(folder) {
	folderList.push(folder);
}

$(function(){
	initDrive("${project.projectIdx}");

	$.jstree.defaults.core.themes.variant = "large";
	$('#jstree').jstree({
			"core" : {
				"animation" : 0,
				"check_callback" : true,
				'force_text' : true,
				"themes" : { "stripes" : true }
			  },
			"state" : {"opened" : true, "selected": true},
			"types" : {
				"#" : { "max_children" : 1, "max_depth" : 3, "valid_children" : ["root"] },
				"root" : { "icon" : "fas fa-folder", "valid_children" : ["default"] },
				"default" : { "icon" : "fas fa-folder", "valid_children" : ["default","root"] }
			},
			"plugins" : [ "contextmenu", "dnd", "search", "state", "types", "wholerow"]

		}).on('rename_node.jstree', function (e, data) {
			if(data.node.id.startsWith("j1_")){	
			jQuery.ajaxSettings.traditional = true;				
			  $.ajax({
	        		url:"insertFolder.do",
	        		method:"POST",
	        		data:{projectIdx: ${project.projectIdx},
	        			  folderName: data.text,
	        			  ref: data.node.parent,
	        			  refs : data.node.parents
	        			 },
	        		success:function(idx){
		        		data.node.id = idx; 
/* 		        	let element = $("#jstree").find("#j1_1").first();
		        		element.attr("id",idx);
		        		element.attr("aria-labelledby", idx+"_anchor")
		        		element.find("a").first().attr("id", idx+"_anchor");

						let folder = new folderInfo();
						folder.id = idx;
					    folder.parent = data.node.parent;
					    folder.text = data.text;
					    $('#jstree').jstree(true).settings.core.data.push(folder);
					    $('#jstree').jstree(true).refresh();
					    $("#jstree").jstree("select_node", "#"+idx); */
		        		driveRefresh();
	        		}
	    		});
			}else{
				let thisId = data.node.id;
				$.ajax({
	        		url:"updateNewName.do",
	        		method:"POST",
	        		data:{driveIdx: data.node.id,
	        			     folderName: data.text
	        			 },
	        		success:function(idx){
		        		data.node.id = idx;
		        		console.log(data.node);	
		        		driveRefresh();
	        		}
	    		});
		       
			}
		}).on('move_node.jstree', function (e, data) {
			//잘라내기 후 paste 할 때
			jQuery.ajaxSettings.traditional = true				
			  $.ajax({
	        		url:"cutFolder.do",
	        		method:"POST",
	        		data:{driveIdx: data.node.id,
		        		  projectIdx: ${project.projectIdx},
	        			  folderName: data.node.text,
	        			  ref: data.parent,
	        			  refs: data.node.parents,
	        			  oldRef: data.old_parent
	        			 },
	        		success:function(idx){
		        		data.node.id = idx;
		        		driveRefresh();
	        		}
	    		});
			}).on('paste.jstree', function (e, data) {
 	 			//복사 후 paste 할 때
 	 			if(data.mode =="copy_node"){ 	 	 			
				jQuery.ajaxSettings.traditional = true				
				  $.ajax({
		        		url:"copyFolder.do",
		        		method:"POST",
		        		data:{oldId: data.node[0].id,
			        		  projectIdx: ${project.projectIdx},
		        			  folderName: data.node[0].text,
		        			  parent: data.parent, //새로운 ref
		        			  refs: data.node[0].parents
		        			 },
		        		success:function(idx){
			        		data.node[0].id =idx;
			        		driveRefresh();
		        		}
		    		});
 	 			}
 			}).on('delete_node.jstree', function (e, data) {
				deleteDriveFolder(data.node.id, data.node.parent);
 			});

	driveRefresh();
	
	$("#createFolder").click(function(){
		var ref = $('#jstree').jstree(true),
		sel = ref.get_selected();
		if(!sel.length) { return false; }
		sel = sel[0];
		sel = ref.create_node(sel, {"type":"default"});
		if(sel) {
			ref.edit(sel);					
		} 
	});


	$("#deleteFolder").click(function(){
		console.log("delete");
		var ref = $('#jstree').jstree(true),
			sel = ref.get_selected();
		if(!sel.length) { return false; }
		ref.delete_node(sel);
	});		
		
	//대소문자 구분 없이
	$.extend($.expr[":"], {
		"containsIN": function(elem, i, match, array) {
			return (elem.textContent || elem.innerText || "").toLowerCase().indexOf((match[3] || "").toLowerCase()) >= 0;
		}
		});
	
	//검색 기능
	let to = false;
	$('#searchText').keyup(function () {
		if(to) { clearTimeout(to); }
		to = setTimeout(function () {
			var searchText = $('#searchText').val();
		     $(".driveCard").hide();
		     var temp = $(".driveCard >.card-body > h4:containsIN('" + v + "')");
		     $(temp).parent().parent().show();
			$('#jstree').jstree(true).search(searchText);
		}, 100);
	});

	
});

function sendFileToServer(formData,status){
	console.log(formData);
    var uploadURL ="http://hayageek.com/examples/jquery/drag-drop-file-upload/upload.php"; //Upload URL
    var extraData ={}; //Extra Data.
    var jqXHR=$.ajax({
            xhr: function() {
            var xhrobj = $.ajaxSettings.xhr();
            if (xhrobj.upload) {
                    xhrobj.upload.addEventListener('progress', function(event) {
                        var percent = 0;
                        var position = event.loaded || event.position;
                        var total = event.total;
                        if (event.lengthComputable) {
                            percent = Math.ceil(position / total * 100);
                        }
                        //Set progress
                        status.setProgress(percent);
                    }, false);
                }
            return xhrobj;
        },
    url: uploadURL,
    type: "POST",
    contentType:false,
    processData: false,
        cache: false,
        data: formData,
        success: function(data){
            status.setProgress(100); 
        }
    }); 
 
    status.setAbort(jqXHR);
}
</script>


<div class="container-fluid mt-3">
    <div class="row">
        <div class="col-md-3">
            <h2 style="padding-left: 25px;">
                <b>D r i v e</b>
            </h2>
            <hr>
            <span id="createFolder" style="cursor: pointer; float: right;"><i class="fas fa-plus"></i></span>
            <br>
            <div class="row">
                <div class="col-lg-12">
                    <div id="jstree" class="demo" style="margin-top:1em; min-height:200px;">

                    </div>
                    <div>
                        <button id="trashBtn" class="btn-link" style="color:#326295;"><i class="fas fa-trash-alt"></i>&nbsp;&nbsp;휴지통</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-9" style="padding-left: 0;">
            <div class="defaultDriveMenu pt-0">
	            <div class="h-100">
	            	<div style="height: 15%" class="mt-1 mb-3">
	            		<span style="font-size: medium;font-weight: 700;"  id="driveName"></span>
	            	</div>
	            	<div style="height: 70%; position: relative;">
		                <span style="font-size : large; font-weight:bold" class="hidden" id="trashName">
		                	<i class="fas fa-trash-alt"></i>&nbsp;&nbsp;휴지통
		               	</span>
		               	<div id="allCheck" class="hidden">
		               		<button type='button' class='driveBtn btn-primary'>삭제</button>&nbsp;&nbsp;
		               		<button type='button' class='driveBtn btn-primary'>이동</button>&nbsp;&nbsp;		               		
							<button type='button' class='driveBtn btn-primary' onclick='ReturnCheck()'>선택해제</button>&nbsp;&nbsp;
		               	</div>
		               	<div id="theCheck" class="hidden">
		               		<button type='button' class='driveBtn btn-primary'>업로드</button>&nbsp;&nbsp;
		               		<button type='button' class='driveBtn btn-primary'>이동</button>&nbsp;&nbsp;
		               		<button type='button' class='driveBtn btn-primary'>삭제</button>&nbsp;&nbsp;		               		
							<button type='button' class='driveBtn btn-primary' onclick='ReturnCheck()'>선택해제</button>&nbsp;&nbsp;
		               	</div>
		               	<div id="default">
		                <button id="driveSearchBtn" type="button" class="driveBtn btn-primary"
		                    onclick="Search()">검색</button>&nbsp;&nbsp;
		                <div class="filebox" style="display:inline;">
		                    <input type="file" id="driveUploadFiles" name="driveUploadFiles" multiple>
		                    <label for="driveUploadFiles" style="cursor: pointer; margin-bottom: 0px;"
		                        class="driveBtn btn-primary" id="driveUploadBtn">업로드</label>&nbsp;&nbsp;
		                </div>
		                <button id="driveAllSelectBtn" type="button" class="driveBtn btn-primary"
		                    onclick="Allcheck()">전체선택</button>
		                </div>   
		                &nbsp;&nbsp;&nbsp;&nbsp;
		                <div class="drivegroup" style="position: absolute; right: 0px; top: 0px;">
		                    <button class="btn driveViewBtn" id="tableView">
		                        <i class="fas fa-list fa-2x"></i>
		                    </button>
		                    <button class="btn driveViewBtn active" id="iconView" disabled>
		                        <i class="fas fa-th-large fa-2x"></i>
		                    </button>
		                </div>
	            	</div>
	            </div>
            </div>

            <div class="searchDriveMenu" style="display:none;">
                <input type='text' id='searchText' style='width: 40%; height: 30px; border-left-width: 0px;'>
                <a href='#' onclick='Return()'><i class='fas fa-times'></i></a>
                &nbsp;&nbsp;&nbsp;&nbsp;
		                <div class="drivegroup" style="position: absolute; right: 0px; top: 0px;">
		                    <button class="btn driveViewBtn" id="tableView">
		                        <i class="fas fa-list fa-2x"></i>
		                    </button>
		                    <button class="btn driveViewBtn active" id="iconView" disabled>
		                        <i class="fas fa-th-large fa-2x"></i>
		                    </button>
		                </div>
            </div>

            <div class="row" style="margin : 10px 10px; margin-top: 0px;">
                <div class="col-lg-12">
                    <div id="dragandrophandler" style="height: 630px; overflow-y: auto; overflow-x:hidden;">
                        <div class="text-center mt-5 hidden" id="emptyDriveBox">
                            <img src="resources/images/drive/notFound.png" style="height: 250px">
                            <h1 class="text-muted mt-5">File Not Found.</h1>
                            <h4>Please upload a file in <span id="directoryName"></span></h4>
                        </div>

                        <div id="driveIconViewBox"></div>

                        <div id="driveTableViewBox" class="hidden">
                            <table id="driveTable" class="table table-hover table-bordered text-center">
                                <thead>
                                    <tr>
                                        <th width="45">file name</th>
                                        <th width="30%">create date</th>
                                        <th width="15%">creator</th>
                                        <th width="10%">size</th>
                                    </tr>
                                </thead>

                                <tbody> </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>