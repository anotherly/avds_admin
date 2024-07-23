<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Program</title>
<link rel="stylesheet" href="<c:url value='/css/layout.css' />" type="text/css">
<%@ include file="/include/header.jsp" %>
<link rel="stylesheet" href="<c:url value='/js/jstree-3.3.5/dist/themes/default/style.css' />" type="text/css"/>
<script type="text/javascript" src="<c:url value='/js/jstree-3.3.5/dist/jstree.js' />"></script>
<style type="text/css">
.jstree-default .jstree-clicked { background: transparent !important; box-shadow: none !important; }
</style>

<script type="text/javascript">
var colModel = [
	{ label: '권한ID',	name: 'authId',		width: 100,	align: "center" },
  	{ label: '권한명',	name: 'authNm',		width: 200 },
  	{ label: '권한설명',	name: 'authorDc',	width: 300 },
  	{ label: '정렬순서',	name: 'dispOrdr',	width: 100,	align: "center" },
  	{ label: '사용여부',	name: 'useYn',		width: 100,	align: "center" }
];

$(window).resize(function(event) {
	if (this == event.target) {
		fn_init();
	}
});

$(document).ready(function() {
	commonMakeGrid("gridList", "/system/auth/selectAuthList.do", colModel, true
		, function(data) {
			$("#gridList").jqGrid("setSelection", "1");
	    }
		, function(rowid, status, e) {
			fn_checkTree(rowid);
		}
	);

	commonMakeCodeComboBox("sUseYn", "YN_CODE2", true);

	fn_init();

	fn_searchTree();

	$("#sAuthNm").focus();
});

function fn_init() {
	$("#grid").css("height", "calc(100% - "+($("#form").height()+119)+"px)");
	$("#gridList").jqGrid("setGridWidth", $("#grid").width()-2);
	$("#gridList").jqGrid("setGridHeight", $("#grid").height()-30);
}

function fn_searchTree() {
	$("#jsTree").jstree("destroy").empty();

	commonAjax(null, "/system/menu/selectMenuList.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length > 0) {
			fn_makeJSTrees(fn_makeTreeJsonData(returnData.rows), 0);
			fn_search();
		}
	});
}

function fn_makeTreeJsonData(jsonData) {
	for (var i=0; i<jsonData.length; i++) {
		if (jsonData[i].parent == null) jsonData[i].parent = "#";
	}
	return jsonData;
}

function fn_makeJSTrees(jsonData, sNodeId) {
	$("#jsTree").jstree({
		core: { data: jsonData },
		plugins: [ "checkbox" ],
		themes: { theme: "classic", dots: true, icons: false }
	}).bind("loaded.jstree", function(event, data) {
		$(this).jstree("hide_icons").jstree("open_all");
		$(this).jstree("select_node", '#'+sNodeId, true);
	});
}

function fn_initClear() {
	document.searchForm.reset();
	$("#gridList").jqGrid("clearGridData");
	$("#jsTree").jstree(true).deselect_all();

	$("#sAuthNm").focus();
}

function fn_search() {
	$("#gridList").jqGrid("clearGridData");
	$("#jsTree").jstree(true).deselect_all();

	var searchData = {
		sAuthNm: $("#sAuthNm").val(),
		sUseYn: $("#sUseYn").val()
	};
	$("#gridList").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
}

function fn_checkTree(rowId) {
	$("#jsTree").jstree(true).deselect_all();
	var rowData = $("#gridList").jqGrid("getRowData", rowId);

	$("#authId").val(rowData.authId);

	commonAjax({ "authId": rowData.authId }, "/system/authMap/selectAuthMapList.do", function(returnData, textStatus, jqXHR) {
		var tree = $('#jsTree').jstree();
		for (var i=0; i<returnData.rows.length; i++) {
			var node = tree.get_node(returnData.rows[i].menuId);
			if(!tree.is_parent(node)) tree.check_node(node);
		}
	});
}

function fn_save() {
	// var menuIds = $("#jsTree").jstree().get_selected();
	function makeSelectedTree(arrIds, tree) {
		var menuIds = [];
		var temaArr = [];
		arrIds.forEach(function(nodeId) {
			var node = tree.get_node(nodeId);
		  var parent_node = tree.get_node(node.parent);
			if(!tree.is_checked(parent_node)) {
				if(parent_node.id != '#') {
					temaArr.push(parent_node.id);
				}
				temaArr.push(node.id);
			}
			else {
				temaArr.push(node.id);
			}
		});
		temaArr.forEach(function(id) {
			if($.inArray(id,menuIds) === -1) menuIds.push(id);
		});
		return menuIds;
	}
	var tree = $('#jsTree').jstree();
	var firstIds = makeSelectedTree(tree.get_selected(), tree);
	var menuIds = makeSelectedTree(firstIds, tree);

	var data = $("#detailForm").serializeArray();
	data.push({ name: "menuIds", value: menuIds });

	commonAjax(data ,"/system/authMap/transactionAuthMap.do" , function(returnData, textStatus, jqXHR) {
		alert(returnData.message);
		parent.$(".tmenu").empty();
		parent.fn_makeMenu("00000");
		setTimeout(function(){
  		if(parent.$("#tmenu_1")[0]) parent.$("#tmenu_1")[0].click();
		}, 1000);
		fn_search();
	});
}
</script>
</head>
<body class="default" style="min-width: 1260px; min-height: 660px;">
<div class="wrap p-20 h-100">
	<div class="float_left w100p o posi_r">
		<div class="cont_tit2 el-box-tit el-depth-2 el-weight-5">◎ <%=java.net.URLDecoder.decode(menuNm, "UTF-8")%></div>

<!-- 		<div class="contBtn1"> -->
<!-- 			<a href="javascript:fn_initClear()"  class="btn_refresh" title="초기화"></a> -->
<!-- 			<i></i> -->
<!-- 			<a href="javascript:fn_save()" class="btn_save" title="저장"></a> -->
<!-- 			<i></i> -->
<!-- 			<a href="javascript:fn_search()" class="btn_search" title="조회"></a> -->
<!-- 		</div> -->
	</div>

	<div class="box_search lay-boxItem lay-item--full grids__col-12 mt-10 form-wrap ml-0">
		<form id="searchForm" name="searchForm" method="post">
			
			<div class="d-flex align-center posi_r">
				<fieldset class="d-flex align-center">
					<span class="tit el-txt fw-500">권한명</span>
					<div class="el-form custom-input ml-10">
						<input type="text" class="el-form__input el-form-width--200"  id="sAuthNm" name="sAuthNm" value="" onkeypress="if(event.keyCode==13) {fn_search(); return false;}"/>
					</div>
		    	</fieldset>
		    	<fieldset class="d-flex align-center ml-20">
					<span class="tit el-txt fw-500">사용여부</span>
					<div class="el-form custom-sel ml-10">
						<select class="el-form__sel" id="sUseYn" name="sUseYn"></select>
					</div>
		    	</fieldset>
		    	<div class="contBtn2">
					<button type="button" onclick="fn_save()" class="btn" title="저장">저장</button>
					<button type="button" onclick="fn_search()" class="btn btn-b" title="조회">조회</button>
				</div>
		    </div>
		</form>
	</div>
	<div class="lay-boxItem lay-item--full grids__col-12 m-0" style="overflow: auto;height:calc(100% - 90px);">
		<div class="boxItem__inner h-100">
			<div class="d-flex flex-7 h-100 flex-wrap">
				<div id="grid" class="float_left w100p ov-auto-y ov-hidden-x" style="width: 50%; height: 100%; border: 1px solid #e8eef1;  border-radius: 3px; background: #fff; padding: 10px;">
					<table id="gridList" class="word_b"></table>
				</div>
			
				<div id="tree" style="width: calc(50% - 10px); height: 100%;  border: 1px solid #e8eef1; border-radius: 3px; background: #fff; padding: 10px; margin-left: 10px;">
					<form id="detailForm" name="detailForm" method="post">
						<input type="text" style="display: none;" id="authId" name="authId" value=""/>
					</form>
					<div id="jsTree" style="overflow: auto; width: 100%; height: 100%;"></div>
				</div>
</div>
</body>
</html>
