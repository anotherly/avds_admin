<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Program</title>
<link rel="stylesheet" href="<c:url value='/css/layout.css' />" type="text/css">
<%@ include file="/include/header.jsp" %>

<script type="text/javascript">
var colModel = [
	{ label: '아이디',	name: 'userId',		width: 100,	align: "center" },
  	{ label: '사용자명',	name: 'userNm',		width: 200 },
  	{ label: '권한',		name: 'authNm',		width: 100,	align: "center" },
  	{ label: '사용여부',	name: 'useYn',		width: 100,	align: "center" },
  	{ label: '등록자',	name: '',			width: 60,	align: "center" },
  	{ label: '등록일시',	name: '',			width: 120,	align: "center" },
  	{ label: '수정자',	name: '',			width: 60,	align: "center" },
  	{ label: '수정일시',	name: '',			width: 120,	align: "center" }
];

$(window).resize(function(event) {
	if (this == event.target) {
		fn_init();
	}
});

$(document).ready(function() {
	commonMakeGrid("gridList", "/system/user/selectUserList.do", colModel, true
		, function(data) {
			if ($("#rowId").val() == "") $("#rowId").val("1");
			$("#gridList").jqGrid("setSelection", $("#rowId").val());
	    }
		, function(rowid, status, e) {
			fn_searchForm(rowid);
		}
	);

	commonMakeAuthComboBox("sAuthId", true);
	commonMakeCodeComboBox("sUseYn", "YN_CODE2", true);

	commonMakeAuthComboBox("authId");
	commonMakeCodeComboBox("useYn", "YN_CODE2");

	fn_init();

	fn_search();

	$("#sUserNm").focus();

	// $("#sUserNm").keypress(function(e) {
	//     if(e.keyCode == 13) fn_search();
	// });
});

function fn_init() {
	/*$("#grid").css("height", "calc(100% - "+($("#form").height()+119)+"px)");*/
	$("#gridList").jqGrid("setGridWidth", $("#grid").width()-2);
	$("#gridList").jqGrid("setGridHeight", $("#grid").height()-30);
}

function fn_initClear() {
	document.searchForm.reset();
	$("#gridList").jqGrid("clearGridData");
	document.detailForm.reset();
	$("#userId").attr("readonly", false);
	$("#userId").css("background-color", "white");
	$("#btnDupChk").show();

	$("#sUserNm").focus();
}

function fn_search() {
	$("#gridList").jqGrid("clearGridData");
	document.detailForm.reset();
	$("#userId").attr("readonly", false);
	$("#userId").css("background-color", "white");
	$("#btnDupChk").show();

	var searchData = {
		sUserNm: $("#sUserNm").val(),
		sAuthId: $("#sAuthId").val(),
		sUseYn: $("#sUseYn").val()
	};
	$("#gridList").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
}

function fn_searchForm(rowId) {
	var rowData = $("#gridList").jqGrid("getRowData", rowId);

	commonAjax({ "sUserId": rowData.userId }, "/system/user/selectUserList.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;

		var formData = returnData.rows[0];
		$("#saveMode").val("U");
		$("#userIdDupChk").val("Y");

		$("#userId").val(formData.userId);
		$("#userNm").val(formData.userNm);
		$("#userPwd").val(formData.userPwd);
		$("#userPwdChk").val(formData.userPwd);
		$("#authId").val(formData.authId);
		$("#useYn").val(formData.useYn);

		$("#userId").attr("readonly", true);
		$("#userId").css("background-color", "rgb(235, 235, 228)");
		$("#btnDupChk").hide();
	});
}

function fn_new() {
	$("#gridList").jqGrid("resetSelection");
	document.detailForm.reset();
	$("#userId").attr("readonly", false);
	$("#userId").css("background-color", "white");
	$("#btnDupChk").show();

	$("#saveMode").val("I");
	$("#userIdDupChk").val("N");

	$("#userId").focus();
}

function fn_save() {
	if (!$("#detailForm").valid()) return;

	if ($("#userPwd").val() != $("#userPwdChk").val()) {
		alert("비밀번호를 확인해 주십시오");
		$('#userPwdChk').focus();
		return;
	}
	if ($("#userIdDupChk").val() == "N") {
		alert("ID중복체크를 해주십시오");
		return;
	}

	var data = $("#detailForm").serializeArray();

	commonAjax(data ,"/system/user/transactionUser.do" , function(returnData, textStatus, jqXHR) {
		alert(returnData.message);
		fn_search();
	});
}

function fn_delete() {
	if (!confirm("<spring:message code='common.delete.msg'/>")) return;

	$("#saveMode").val("D");

	var data = $("#detailForm").serializeArray();

	commonAjax(data ,"/system/user/transactionUser.do" , function(returnData, textStatus, jqXHR) {
		alert(returnData.message);
		fn_search();
	});
}

function fn_excel() {
	var columnsNm = [], datafield = [];
	for (var i=0; i<colModel.length-1; i++) {
		columnsNm[i] = colModel[i].label;
		datafield[i] = colModel[i].name;
	}

	$("#columnsNm").val(columnsNm);
	$("#datafield").val(datafield);
	$("#excelFileNm").val("<%=menuNm%>.xls");

	var url = "/system/user/selectUserExcelList.do";
	$("#searchForm").attr("action", url);
	$("#searchForm").submit();
}

function fn_dupCheck() {
	if ($("#userId").val() == "") return;

	commonAjax({ "sUserId": $("#userId").val() }, "/system/user/selectUserList.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) {
			$("#userIdDupChk").val("Y");
			alert("사용가능한 아이디 입니다.");
		} else {
			$("#userIdDupChk").val("N");
			alert("중복된 아이디가 존재합니다. 다시 입력해 주십시오.");
			$("#userId").focus();
		}
	});
}
</script>
</head>
<body class="default" style="min-width: 1260px; min-height: 660px;">
<div class="wrap p-20 h-100">
	<div class="float_left w100p ff posi_r">
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
<!-- 			<i></i> -->
<!-- 			<a href="javascript:fn_excel()" class="btn_excel" title="엑셀"></a> -->
<!-- 		</div> -->
	</div>

	<div class="box_search lay-boxItem lay-item--full grids__col-12 mt-10 form-wrap ml-0">
		<form id="searchForm" name="searchForm" method="post">
			<input type="hidden" id="columnsNm" name="columnsNm" value="">
			<input type="hidden" id="datafield" name="datafield" value="">
			<input type="hidden" id="excelFileNm" name="excelFileNm" value="">
			<div class="d-flex align-center posi_r">
				<fieldset class="d-flex align-center">
					<span class="tit el-txt fw-500">사용자명</span>
					<div class="el-form custom-input ml-10">
						<input type="text" class="el-form__input el-form-width--200" id="sUserNm" name="sUserNm" value="" onkeypress="if(event.keyCode==13) {fn_search(); return false;}" />
					</div>
		    	</fieldset>
		    	<fieldset class="d-flex align-center ml-20">
					<span class="tit el-txt fw-500">권한</span>
					<div class="el-form custom-sel ml-10">
						<select class="el-form__sel" id="sAuthId" name="sAuthId"></select>
					</div>
		    	</fieldset>
		    	<fieldset class="d-flex align-center ml-20">
					<span class="tit el-txt fw-500">사용여부</span>
					<div class="el-form custom-sel ml-10">
						<select class="el-form__sel" id="sUseYn" name="sUseYn"></select>
					</div>
		    	</fieldset>
		    	<div class="contBtn2">
					<button type="button" onclick="fn_new()" class="btn btn-w" title="신규">신규</button>
					<button type="button" onclick="fn_save()" class="btn btn-w" title="저장">저장</button>
					<button type="button" onclick="fn_delete()" class="btn btn-w" title="삭제">삭제</button>
					<button type="button" onclick="fn_search()" class="btn btn-b" title="조회">조회</button>
					<button type="button" onclick="fn_excel()" class="btn btn-g" title="엑셀 다운로드">엑셀 다운로드</button>
				</div>
	    	</div>
	    </form>
	</div>
	
	<div class="lay-boxItem lay-item--full grids__col-12 m-0" style="overflow: auto;height:calc(100% - 90px);">
		<div class="boxItem__inner h-100">
			<div class="d-flex flex-7 h-100 flex-wrap">
				<div id="grid" class="float_left flex-10 w100p ov-auto-y ov-hidden-x" style="height:50%;padding:10px;border:1px solid #e8eef1;border-radius:3px;">
					<table id="gridList" class="word_b"></table>
				</div>
				
				<div id="form" class="form_box mt-10" style="width:100%;height: calc(50% - 5px);padding:10px;border:1px solid #e8eef1;border-radius:5px;">
					<form id="detailForm" name="detailForm" method="post">
						<input type="text" style="display: none;" id="saveMode" name="saveMode" value="I"/>
						<input type="text" style="display: none;" id="rowId" name="rowId" value=""/>
						<input type="text" style="display:none;" id="userIdDupChk" name="userIdDupChk" value="N"/>
			
						<div class="el-table-wrap">
							<table class="el-table  el-table--row el-table--usermanage" style="table-layout:fixed">
								<caption></caption>
								<colgroup>
									<col width="10%" />
									<col width="23.3%" />
									<col width="10%" />
									<col width="23.3%" />
									<col width="10%" />
									<col width="*%" />
								</colgroup>
								<tbody>
									<tr>
										<th>사용자ID</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="userId" name="userId" value="" caption="사용자ID" required="required"/>
												<input type="button" style="font-size:0.875rem; text-indent:0; height:30px; line-height:30px; padding: 0 10px; display:inline-box; margin-left:5px;" id="btnDupChk" name="btnDupChk" onclick="javascript:fn_dupCheck();" value="중복확인"/>
											</div>
										</td>
										<th>사용자명</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="userNm" name="userNm" value="" caption="사용자명" required="required"/>
											</div>
										</td>
										<th>권한</th>
										<td>
											<div class="el-form custom-sel">
												<select class="el-form__sel" id="authId" name="authId" caption="권한" required="required"></select>
											</div>
										</td>
									</tr>
									<tr>
										<th>비밀번호</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="userPwd" name="userPwd" value="" caption="비밀번호" required="required"/>
											</div>
										</td>
										<th>비밀번호확인</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="userPwdChk" name="userPwdChk" value="" caption="비밀번호확인" required="required"/>
											</div>
										</td>
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
												<input type="text" class="el-form__input el-form-width--200" id="createId" name="createId" value="" disabled="disabled"/>
											</div>
										</td>
										<th>등록일시</th>
										<td colspan="3">
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="createDate" name="createDate" value="" disabled="disabled"/>
											</div>
										</td>
									</tr>
									<tr>
										<th>수정자</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="updateId" name="updateId" value="" disabled="disabled"/>
											</div>
										</td>
										<th>수정일시</th>
										<td colspan="3">
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
