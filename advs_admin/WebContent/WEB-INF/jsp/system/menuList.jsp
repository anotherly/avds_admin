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

<script type="text/javascript">
$(window).resize(function(event) {
	if (this == event.target) {
		fn_init();
	}
});

$(document).ready(function() {
	commonMakeMenuComboBox("sMenuPrntId", true);
	
	commonMakeCodeComboBox("leafYn", "YN_CODE1");
	commonMakeCodeComboBox("useYn", "YN_CODE2");
	
	fn_init();
	
	fn_search();
	
	$("#sMenuPrntId").focus();
});

function fn_init() {

}

function fn_initClear() {
	document.searchForm.reset();
	document.detailForm.reset();
	$("#menuId").attr("readonly", false);
	$("#menuId").css("background-color", "white");
	
	$("#sMenuPrntId").focus();
}

function fn_search(selectNode) {
	$("#jsTree").jstree("destroy").empty();
	document.detailForm.reset();
	$("#menuId").attr("readonly", false);
	$("#menuId").css("background-color", "white");
	
	var searchData = {
		sMenuPrntId: $("#sMenuPrntId").val()
	};
	
	var sNodeId = selectNode == undefined ? 0 : selectNode;
	
	commonAjax(searchData, "/system/menu/selectMenuList.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length > 0) {
			fn_makeJSTrees(fn_makeTreeJsonData(returnData.rows), sNodeId);
		}
	});
}

function fn_makeTreeJsonData(jsonData) {
	for (var i=0; i<jsonData.length; i++) {
		if (jsonData[i].parent == null) {
			jsonData[i].parent = "#";
		}
	}
	return jsonData;
}

function fn_makeJSTrees(jsonData, sNodeId) {
	$("#jsTree").jstree({
		core: { data: jsonData },
		themes: { theme: "classic", dots: true, icons: false }
	}).bind("loaded.jstree", function(event, data) {
		$(this).jstree("hide_icons").jstree("open_all");
		$(this).jstree("select_node", '#'+sNodeId, true);
	}).on("select_node.jstree", function(event, data) { // node select event
		fn_searchForm(data.node.id);
	});
}

function fn_searchForm(nodeId) {
	commonAjax({ "sMenuId": nodeId }, "/system/menu/selectMenuList.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;
		
		var formData = returnData.rows[0];
		$("#saveMode").val("U");
		
		$("#menuId").val(formData.menuId);
		$("#menuNm").val(formData.menuNm);
		$("#menuPrntId").val(formData.menuPrntId);      
		$("#dispOrdr").val(formData.dispOrdr);
		$("#menuObject").val(formData.menuObject);
		$("#menuPath").val(formData.menuPath);
		$("#menuDesc").val(formData.menuDesc);
		$("#iconNm").val(formData.iconNm);
		$("#leafYn").val(formData.leafYn);
		$("#menuLevel").val(formData.menuLevel);
		$("#useYn").val(formData.useYn);
		
		$("#menuId").attr("readonly", true);
		$("#menuId").css("background-color", "rgb(235, 235, 228)");
	});
}

function fn_new() {
	var menuId = $("#menuId").val();
	var leafYn = $("#leafYn").val();
	var menuLevel = $("#menuLevel").val();
	
	if (menuLevel == '3') {
		alert("메뉴래밸은 '3 Level'까지만 가능합니다.");
		return;
	}
	
	if (leafYn == 'Y') {
		alert("해당 메뉴는 프로그램이므로 하위 메뉴 추가가 불가능합니다.");
		return;
	}
	
	document.detailForm.reset();
	$("#menuId").attr("readonly", false);
	$("#menuId").css("background-color", "white");
	
	$("#saveMode").val("I");
	$("#userIdDupChk").val("N");
	$("#menuPrntId").val(menuId);
	$("#menuLevel").val(parseInt(menuLevel)+1);
	$("#leafYn").val('Y');
	$("#useYn").val('Y');
	
	$("#menuId").focus();
}

function fn_save() {
	if ($("#menuId").val() == "00000") return;
	
	if (!$("#detailForm").valid()) return;
	
	var data = $("#detailForm").serializeArray();
	
	commonAjax(data ,"/system/menu/transactionMenu.do" , function(returnData, textStatus, jqXHR) {		
		alert(returnData.message);
		fn_search();
	});
}

function fn_delete() {
	if ($("#menuId").val() == "00000") return;
	
	if (!confirm("<spring:message code='common.delete.msg'/>")) return;
	
	var node = $("#jsTree").jstree("get_children_dom", $("#jsTree").jstree("get_selected"));
	if (node != undefined && node.length > 0) {
		alert("하위 메뉴가 있어서 삭제할 수 없습니다.");
		return;
	}
	
	$("#saveMode").val("D");
	
	var data = $("#detailForm").serializeArray();
	
	commonAjax(data ,"/system/menu/transactionMenu.do" , function(returnData, textStatus, jqXHR) {		
		alert(returnData.message);
		fn_search();
	});
}
</script>
</head>
<body class="default" style="min-width: 1260px; min-height: 660px;">
<div class="wrap p-20 h-100">
	<div class="float_left w100p t posi_r">
		<div class="cont_tit2 el-box-tit el-depth-2 el-weight-5">◎ <%=java.net.URLDecoder.decode(menuNm, "UTF-8")%></div>
		
<!-- 		<div class="contBtn1"> -->
<!-- 			<a href="javascript:fn_initClear()"  class="btn_refresh" title="초기화"></a> -->
<!-- 			<i></i> -->
<!-- 			<a href="javascript:fn_new()" class="btn_new" title="신규"></a> -->
<!-- 			<i></i> -->
<!-- 			<a href="javascript:fn_save()" class="btn_save" title="저장"></a> -->
<!-- 			<i></i> -->
<!-- 			<a href="javascript:fn_delete()" class="btn_del" title="삭제"></a> -->
<!-- 			<i></i> -->
<!-- 			<a href="javascript:fn_search()" class="btn_search" title="조회"></a> -->
<!-- 		</div> -->
	</div>
	
	<div class="box_search lay-boxItem lay-item--full grids__col-12 mt-10 form-wrap ml-0">
		<form id="searchForm" name="searchForm" method="post">
			<div class="d-flex align-center posi_r">
				<fieldset class="d-flex align-center">
					<span class="tit el-txt fw-500">대메뉴</span>
						
					<div class="el-form custom-sel ml-20">
						<select class="el-form__sel" id="sMenuPrntId" name="sMenuPrntId"></select>
					</div>
		    	</fieldset>
		    	<div class="contBtn2">
		    		<button type="button" onclick="fn_new()" class="btn" title="신규">신규</button>
					<button type="button" onclick="fn_save()" class="btn" title="저장">저장</button>
					<button type="button" onclick="fn_delete()" class="btn" title="삭제">삭제</button>
					<button type="button" onclick="fn_search()" class="btn btn-b" title="조회">조회</button>
				</div>
			</div>
		</form>
	</div>
	<div class="lay-boxItem lay-item--full grids__col-12 m-0" style="overflow: auto;height:calc(100% - 90px);">
		<div class="boxItem__inner h-100">
			<div class="d-flex flex-7 h-100 flex-wrap">
				<div id="tree" class="float_left" style="width: 50%; height: 100%; border: 1px solid #e8eef1; border-radius: 3px; background: #fff; padding: 10px;">
					<div id="jsTree" style="overflow: auto; width: 100%; height: 100%;"></div>
				</div>
				<div id="form" style="overflow:auto;width: calc(50% - 10px); height: 100%; float: left; border: 1px solid #e8eef1;  border-radius: 3px; background: #fff; padding: 10px; margin-left: 10px;">
					<form id="detailForm" name="detailForm" method="post">
						<input type="text" style="display: none;" id="saveMode" name="saveMode" value="I"/>
						<input type="text" style="display: none;" id="rowId" name="rowId" value=""/>
						
						<div class="el-table-wrap">
							<table class="el-table  el-table--row el-table--usermanage" style="table-layout:fixed">
								<caption></caption>
								<colgroup>
									<col width="30%" />
									<col width="*%" />
								</colgroup>
								<tbody>
									<tr>
										<th>메뉴ID</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="menuId" name="menuId" value="" caption="메뉴ID" required="required"/>
											</div>
										</td>
									</tr>
									<tr>
										<th>메뉴명</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="menuNm" name="menuNm" value="" caption="메뉴명" required="required"/>
											</div>
										</td>
									</tr>
									<tr>
										<th>상위메뉴ID</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="menuPrntId" name="menuPrntId" value="" caption="상위메뉴ID" required="required"/>
											</div>
										</td>
									</tr>
									<tr>
										<th>메뉴순서</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="dispOrdr" name="dispOrdr" value="" caption="메뉴순서" required="required"/>
											</div>
										</td>
									</tr>
									<tr>
										<th>메뉴대상</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="menuObject" name="menuObject" value="" caption="메뉴대상"/>
											</div>
										</td>
									</tr>
									<tr>
										<th>메뉴경로(팝업)</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="menuPath" name="menuPath" value="" caption="메뉴경로"/>
											</div>
										</td>
									</tr>
									<tr>
										<th>메뉴설명</th>
										<td>
											<div class="el-form custom-textarea">
												<textarea class="el-form__textarea" style="height:200px;" id="menuDesc" name="menuDesc" value="" caption="메뉴설명"></textarea>
											</div>
										</td>
									</tr>
									<tr>
										<th>대메뉴아이콘</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="iconNm" name="iconNm" value="" caption="대메뉴아이콘"/>
											</div>
										</td>
									</tr>
									<tr>
										<th>프로그램여부</th>
										<td>
											<div class="el-form custom-sel">
												<select class="el-form__sel" id="leafYn" name="leafYn" caption="프로그램여부" required="required"></select>
											</div>
										</td>
									</tr>
									<tr>
										<th>메뉴레벨</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="menuLevel" name="menuLevel" value="" caption="메뉴레벨"/>
											</div>
										</td>
									</tr>
									<tr>
										<th>사용여부</th>
										<td>
											<div class="el-form custom-sel">
												<select class="el-form__sel" id="useYn" name="useYn" caption="사용여부" required="required"></select>
											</div>
										</td>
									</tr>
									<tr>
										<th>등록자</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" name="createId" value="" disabled="disabled"/>
											</div>
										</td>
									</tr>
									<tr>
										<th>등록일시</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="createDate" name="createDate" value="" disabled="disabled"/>
											</div>
										</td>
									</tr>
									<tr>
										<th>수정자</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200"  id="updateId" name="updateId" value="" disabled="disabled"/>
											</div>
										</td>
									</tr>
									<tr>
										<th>수정일시</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="updateDate" name="updateDate" value="" disabled="disabled"/>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>			
				
</div>
</body>
</html>