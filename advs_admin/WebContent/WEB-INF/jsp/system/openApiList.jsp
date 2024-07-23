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
  	{ label: '신청API_URL',	name: 'applyApiUrl',		width: 100 },
  	{ label: '신청기관',		name: 'applyApiCompany',		width: 100,	align: "center" },
  	{ label: '목적',	name: 'purpose',		width: 200,	align: "center" },
  	{ label: '승인상태',	name: 'apiApprNm',		width: 60,	align: "center" },
  	{ label: '승인일자',	name: 'apiApprDateView',		width: 100,	align: "center" },
  	{ label: '승인취소일자',	name: 'apiApprCanceldateView',		width: 100,	align: "center" },
  	{ label: 'API KEY',	name: 'apiKey',		width: 100,	align: "center", hidden: true },
  	{ label: '등록자',	name: 'regId',			width: 80,	align: "center" },
  	{ label: '등록일시',	name: 'regDateView',			width: 100,	align: "center" },
  	{ label: '수정자',	name: 'updateId',			width: 80,	align: "center" },
  	{ label: '수정일시',	name: 'updateDateView',			width: 100,	align: "center" }
];

$(window).resize(function(event) {
	if (this == event.target) {
		fn_init();
	}
});

$(document).ready(function() {
	commonMakeGrid("gridList", "/system/openApi/selectOpenApiList.do", colModel, true
		, function(data) {
			if ($("#rowId").val() == "") $("#rowId").val("1");
			$("#gridList").jqGrid("setSelection", $("#rowId").val());
	    }
		, function(rowid, status, e) {
			fn_searchForm(rowid);
		}
	);

	commonMakeCodeComboBox("sApiApprCode", "openapi_appr_cd", false);

	commonMakeCodeComboBox("apiApprCode", "openapi_appr_cd");

	fn_init();

	fn_search();

	$("#sUserId").focus();

	// $("#sUserId").keypress(function(e) {
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
	$("#openApiId").attr("readonly", false);
	$("#openApiId").css("background-color", "white");
	$("#btnDupChk").show();

	$("#sUserId").focus();
}

function fn_search() {
	$("#gridList").jqGrid("clearGridData");
	document.detailForm.reset();

	var searchData = {
		sUserId: $("#sUserId").val(),
		sApplyApiCompany: $("#sApplyApiCompany").val(),
		sApiApprCode: $("#sApiApprCode").val()
	};
	$("#gridList").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
}

function fn_searchForm(rowId) {
	var rowData = $("#gridList").jqGrid("getRowData", rowId);

	commonAjax({ "sUserId": rowData.userId }, "/system/openApi/selectOpenApiList.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;

		var formData = returnData.rows[0];
		$("#saveMode").val("U");

		$("#userId").val(formData.userId);
		$("#applyApiUrl").val(formData.applyApiUrl);
		$("#applyApiCompany").val(formData.applyApiCompany);
		$("#purpose").val(formData.purpose);
		$("#apiApprCode").val(formData.apiApprCode);
		$("#orgApiApprCode").val(formData.apiApprCode);
		$("#apiApprDate").val(formData.apiApprDateView);
		$("#apiApprCanceldate").val(formData.apiApprCanceldateView);
		$("#apiKey").val(formData.apiKey);
		$("#regId").val(formData.regId);
		$("#updateId").val(formData.updateId);
		$("#regDate").val(formData.regDateView);
		$("#updateDate").val(formData.updateDateView);
	});
}

function fn_save() {
	if (!$("#detailForm").valid()) return;

	var data = $("#detailForm").serializeArray();

	commonAjax(data ,"/system/openApi/transactionOpenApi.do" , function(returnData, textStatus, jqXHR) {
		alert(returnData.message);
		fn_search();
	});
}

function fn_delete() {
	if (!confirm("<spring:message code='common.delete.msg'/>")) return;

	$("#saveMode").val("D");

	var data = $("#detailForm").serializeArray();

	commonAjax(data ,"/system/openApi/transactionOpenApi.do" , function(returnData, textStatus, jqXHR) {
		alert(returnData.message);
		fn_search();
	});
}

function fn_makeApiKey(){
	if($("#apiApprCode").val() != '02'){
		alert("신청구분이 승인일 경우에만 API KEY가 생성 가능합니다.");
		return;
	}
	
	if($("#apiKey").val() != ""){
		alert("이미 생성된 API KEY가 존재합니다.");
		return;
	}
	
	commonAjax(null ,"/system/openApi/generationApiKey.do" , function(returnData, textStatus, jqXHR) {
		$("#apiKey").val(returnData.apiKey);
		alert("API KEY가 생성 되었습니다.");
	});
}

function fn_selectAppr(obj){
	var val = obj.value;
	var orgAppr = $("#orgApiApprCode").val();
	if("02" == orgAppr && val == "01"){
		obj.value = orgAppr;
		alert("이미 승인된 건은 신청으로 변경 할 수 없습니다.");
		return;
	}
	
	if("01" == val){
		$("#apiKey").val("");
	}
}

</script>
</head>
<body class="default" style="min-width: 1260px; min-height: 660px;">
<div class="wrap p-20 h-100">
	<div class="float_left w100p x posi_r">
		<div class="cont_tit2 el-box-tit el-depth-2 el-weight-5">◎ <%=java.net.URLDecoder.decode(menuNm, "UTF-8")%></div>

<!-- 		<div class="contBtn1"> -->
<!-- 			<a href="javascript:fn_initClear()"  class="btn_refresh" title="초기화"></a> -->
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
			<input type="hidden" id="columnsNm" name="columnsNm" value="">
			<input type="hidden" id="datafield" name="datafield" value="">
			<input type="hidden" id="excelFileNm" name="excelFileNm" value="">
			<div class="d-flex align-center posi_r">
				<fieldset class="d-flex align-center">
					<span class="tit el-txt fw-500">신청자ID</span>
					<div class="el-form custom-input ml-10">
						<input type="text" class="el-form__input el-form-width--l" id="sUserId" name="sUserId" value="" onkeypress="if(event.keyCode==13) {fn_search(); return false;}" />
					</div>
		    	</fieldset>
				<fieldset class="d-flex align-center ml-20">
					<span class="tit el-txt fw-500">신청기관</span>
					<div class="el-form custom-input ml-10">
						<input type="text" class="el-form__input el-form-width--l" id="sApplyApiCompany" name="sApplyApiCompany" value="" onkeypress="if(event.keyCode==13) {fn_search(); return false;}" />
					</div>
		    	</fieldset>
		    	<fieldset class="d-flex align-center ml-20">
					<span class="tit el-txt fw-500">권한</span>
					<div class="el-form custom-sel ml-10">
						<select  class=el-form__sel id="sApiApprCode" name="sApiApprCode"></select>
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
			<div class="d-flex h-100 flex-wrap">
				<div id="grid" class="float_left w100p ov-auto-y ov-hidden-x" style="height:calc(100% - 400px);padding:10px;border: 1px solid #e8eef1; border-radius: 5px;">
					<table id="gridList" class="word_b"></table>
				</div>
			
				<div id="form" class="form_box mt-10" style="width:100%;height: 390px;border: 1px solid #e8eef1;  border-radius: 3px;">
					<form id="detailForm" name="detailForm" method="post">
						<input type="text" style="display: none;" id="saveMode" name="saveMode" value="I"/>
						<input type="text" style="display: none;" id="rowId" name="rowId" value=""/>
						<input type="hidden" id="orgApiApprCode" name="orgApiApprCode" />
			
						<div class="el-table-wrap">
							<table class="el-table  el-table--row el-table--notice" >
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
												<input type="text" class="el-form__input el-form-width--full"  id="userId" name="userId" value="" caption="사용자ID" required="required"/>
											</div>
										</td>
										<th>신청URL</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--full" id="applyApiUrl" name="applyApiUrl" value="" caption="신청URL" required="required"/>
											</div>
										</td>
										<th>신청기관</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--full" id="applyApiCompany" name="applyApiCompany" value="" caption="신청URL" required="required"/>
											</div>
										</td>
									</tr>
									<tr>
										<th>사용목적</th>
										<td>
											<div class="el-form custom-textarea">
												<textarea class="el-form__textarea" style="height:100px" id="purpose" name="purpose" value="" caption="메뉴설명"></textarea>
											</div>
										</td>
										<th>신청구분</th>
										<td>
											<div class="el-form custom-sel">
												<select class="el-form__sel" id="apiApprCode" name="apiApprCode" caption="신청구분" required="required" onchange="fn_selectAppr(this);"></select>
										</td>
										<th>승인일자</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--full" id="apiApprDate" name="apiApprDate" value="" disabled="disabled"/>
											</div>
										</td>
									</tr>
									<tr>
										<th>승인취소일자</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--full" id="apiApprCanceldate" name="apiApprCanceldate" value="" disabled="disabled"/>
											</div>
										</td>
										<th>API KEY</th>
										<td colspan="3">
											<div class="el-form el-form-row custom-input">
												<input type="text" class="el-form__input el-form-width--350"id="apiKey" name="apiKey" value="" readonly="readonly"/>
												<input type="button" style="display:flex;align-items:center;justify-content:center;width: 80px; height: 34px;margin-left:5px; vertical-align: bottom;line-height:35px;font-size:14px;text-indent:0;" id="makeApiKey" name="makeApiKey" onclick="javascript:fn_makeApiKey();" value="키생성" />
											</div>
										</td>
									</tr>					
									<tr>
										<th>등록자</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--full" id="regId" name="regId" value="" disabled="disabled"/>
											</div>
										</td>
										<th>등록일시</th>
										<td colspan="3">
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--full" id="regDate" name="regDate" value="" disabled="disabled"/>
											</div>
										</td>
									</tr>
									<tr>
										<th>수정자</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--full" id="updateId" name="updateId" value="" disabled="disabled"/>
											</div>
										</td>
										<th>수정일시</th>
										<td colspan="3">
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--full" id="updateDate" name="updateDate" value="" disabled="disabled"/>
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
