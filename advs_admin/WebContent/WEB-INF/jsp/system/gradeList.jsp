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
	{ label: '사용자ID',		name: 'userId',				width: 100,	align: "center" },
	{ label: '사용자명',		name: 'userNm',				width: 80,	align: "center" },
	{ label: '권한명',			name: 'authCdView',			width: 120,	align: "center" },
	{ label: '기관명',			name: 'agencyCdView',		width: 150 },
// 	{ label: '등급명',			name: 'classIdView',		width: 60,	align: "center" },
	{ label: '레벨',			name: 'autocarLevelView',	width: 60,	align: "center" },
	{ label: '사용여부',		name: 'useYn',				width: 50,	align: "center" },
	{ label: '승인상태',		name: 'apporStatusView',	width: 100,	align: "center" },
	{ label: '접속허용시작',	name: 'startTimeView',		width: 100,	align: "center" },
	{ label: '접속허용종료',	name: 'endTimeView',		width: 100,	align: "center" },
// 	{ label: '평가점수',		name: 'evalPoint',			width: 50,	align: "center" },
// 	{ label: '다운횟수',		name: 'cnt',				width: 50,	align: "center" },
	{ label: '등록자',			name: 'regId',				width: 100,	align: "center" },
	{ label: '등록일시',		name: 'regDateView',		width: 120,	align: "center" }
];

$(window).resize(function(event) {
	if (this == event.target) {
		fn_init();
	}
});

$(document).ready(function() {
	commonMakeGrid("gridList", "/system/grade/selectGradeList.do", colModel, true
		, function(data) {
			if ($("#rowId").val() == "") $("#rowId").val("1");
			$("#gridList").jqGrid("setSelection", $("#rowId").val());
	    }
		, function(rowid, status, e) {
			fn_searchForm(rowid);
		}
	);

	commonMakeCodeComboBox("sUseYn", "YN_CODE2", true);

// 	commonMakeCodeComboBox("classId", "class_id");

	commonMakeCodeComboBox("useYn", "YN_CODE2");
	
	commonMakeCodeComboBox("autocarLevel", "autocar_level");

	fn_init();

	fn_search();

	$("#sUserNm").focus();
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

	$("#sUserNm").focus();
}

function fn_search() {
	$("#gridList").jqGrid("clearGridData");
	document.detailForm.reset();

	var searchData = {
		sUserNm: $("#sUserNm").val(),
		sUseYn: $("#sUseYn").val()
	};
	$("#gridList").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
}

function fn_searchForm(rowId) {
	var rowData = $("#gridList").jqGrid("getRowData", rowId);

	commonAjax({ "sUserId": rowData.userId }, "/system/grade/selectGradeList.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;

		var formData = returnData.rows[0];
		$("#saveMode").val("U");

		$("#userId").val(formData.userId);
		$("#userNm").val(formData.userNm);
// 		$("#classId").val(formData.classId);
		$("#autocarLevel").val(formData.autocarLevel);
// 		$("#evalPoint").val(formData.evalPoint);
// 		$("#cnt").val(formData.cnt);
		$("#useYn").val(formData.useYn);
		$("#authCdView").val(formData.authCdView);
		$("#agencyCdView").val(formData.agencyCdView);
		$("#apporStatusView").val(formData.apporStatusView);
		$("#regId").val(formData.regId);
		$("#regDateView").val(formData.regDateView);

		$("#userId").attr("readonly", true);
		$("#userId").css("background-color", "rgb(235, 235, 228)");
		$("#userNm").attr("readonly", true);
		$("#userNm").css("background-color", "rgb(235, 235, 228)");
		
		console.log(rowId + " " + rowData.userId);
	});
}

function fn_save() {
	if (!$("#detailForm").valid()) return;

	var data = $("#detailForm").serializeArray();

	commonAjax(data ,"/system/grade/transactionGrade.do" , function(returnData, textStatus, jqXHR) {
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

	var url = "/system/grade/selectGradeExcelList.do";
	$("#searchForm").attr("action", url);
	$("#searchForm").submit();
}

</script>
</head>
<body class="default" style="min-width: 1260px; min-height: 660px;">
<div class="wrap p-20 h-100">
	<div class="float_left w100p s posi_r">
		<div class="cont_tit2 el-box-tit el-depth-2 el-weight-5">◎ <%=java.net.URLDecoder.decode(menuNm, "UTF-8")%></div>

<!-- 		<div class="contBtn1"> -->
<!-- 			<a href="javascript:fn_initClear()"  class="btn_refresh" title="초기화"></a> -->
<!-- 			<i></i> -->
<!-- 			<a href="javascript:fn_save()" class="btn_save" title="저장"></a> -->
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
						<input type="text" class="el-form__input el-form-width--200" id="sUserNm" name="sUserNm" value="" onkeypress="if(event.keyCode==13) {fn_search(); return false;}"/>
					</div>
		    	</fieldset>
		    	<fieldset class="d-flex align-center ml-20">
					<span class="tit el-txt fw-500">사용여부</span>
					<div class="el-form custom-input ml-10">
						<select class="el-form__sel" id="sUseYn" name="sUseYn"></select>
					</div>
		    	</fieldset>
		    	<div class="contBtn2">
					<button type="button" onclick="fn_save()" class="btn" title="저장">저장</button>
					<button type="button" onclick="fn_search()" class="btn btn-b" title="조회">조회</button>
					<button type="button" onclick="fn_excel()" class="btn btn-g" title="엑셀 다운로드">엑셀 다운로드</button>
				</div>
		    </div>
	    </form>
	</div>
	<div class="lay-boxItem lay-item--full grids__col-12 m-0" style="overflow: auto;height:calc(100% - 90px);">
		<div class="boxItem__inner h-100">
			<div class="d-flex flex-7 h-100 flex-wrap">
				<div id="grid" class="float_left w100p ov-auto-y ov-hidden-x" style="height:calc(100% - 205px);border: 1px solid #e8eef1;  border-radius: 3px; background: #fff; padding: 10px;">
					<table id="gridList" class="word_b"></table>
				</div>
			
				<div id="form" class="form_box mt-10" style="width:100%;height: 195px;padding:10px;border: 1px solid #e8eef1;  border-radius: 3px;">
					<form id="detailForm" name="detailForm" method="post">
						<input type="text" style="display: none;" id="saveMode" name="saveMode" value="I"/>
						<input type="text" style="display: none;" id="rowId" name="rowId" value=""/>
			
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
												<input type="text" class="el-form__input el-form-width--full" id="userId" name="userId" value="" caption="사용자ID" required="required" readonly="readonly"/>
											</div>
										</td>
										<th>사용자명</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--full" id="userNm" name="userNm" value="" caption="사용자명" required="required"/>
											</div>
										</td>
										<th>권한명</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--full" id="authCdView" name="authCdView" value="" caption="권한명" disabled="disabled"/>
											</div>
										</td>
									</tr>
									<tr>
<!-- 										<th>평가점수</th> -->
<!-- 										<td> -->
<!-- 											<div class="el-form custom-input"> -->
<!-- 												<input type="text" class="el-form__input el-form-width--full" id="evalPoint" name="evalPoint" value="" caption="평가점수" disabled="disabled"/> -->
<!-- 											</div> -->
<!-- 										</td> -->
<!-- 										<th>다운횟수</th> -->
<!-- 										<td> -->
<!-- 											<div class="el-form custom-input"> -->
<!-- 												<input type="text" class="el-form__input el-form-width--full" id="cnt" name="cnt" value="" caption="다운횟수" disabled="disabled"/> -->
<!-- 											</div> -->
<!-- 										</td> -->
									</tr>
									<tr>
										<th>기관명</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--full" id="agencyCdView" name="agencyCdView" value="" caption="기관명" disabled="disabled"/>
											</div>
										</td>
										<th>등록자</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--full" id="regId" name="regId" value="" disabled="disabled"/>
											</div>
										</td>
										<th>등록일시</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="regDateView" name="regDateView" value="" disabled="disabled"/>
											</div>
										</td>
									</tr>
									<tr>
										<th>승인상태</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--full" id="apporStatusView" name="apporStatusView" value="" caption="승인상태" disabled="disabled"/>
											</div>
										</td>
<!-- 										<th>등급명</th> -->
<!-- 										<td> -->
<!-- 											<div class="el-form custom-sel"> -->
<!-- 												<select class="el-form__sel" id="classId" name="classId" caption="등급명" required="required"></select> -->
<!-- 											</div> -->
<!-- 										</td> -->
										<th>레벨</th>												
										<td>
											<div class="el-form custom-sel">
												<select class="el-form__sel"  id="autocarLevel" name="autocarLevel" caption="레벨권한" required="required"></select>
											</div>
										</td>
										<th>사용여부</th>
										<td>
											<div class="el-form custom-sel">
												<select class="el-form__sel" id="useYn" name="useYn" caption="사용여부" required="required"></select>
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
</div>
</body>
</html>
