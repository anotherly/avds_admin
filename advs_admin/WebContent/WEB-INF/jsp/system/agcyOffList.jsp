<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Program</title>
<link rel="stylesheet" href="<c:url value='/css/layout.css' />" type="text/css">
<%@ include file="/include/header.jsp" %>

<script src="/js/jquery-ui-1.12.1.custom/datepicker-ko.js"></script> <!-- jQuery 달력 -->
<script type="text/javascript">
//폼 변수
var c_form = "";

$(document).ready(function() {
	c_form = document.detailForm; //폼 셋팅
});


var colModelMast = [
// 	{ label: '번호',	name: 'reservationNumber',		width: 100,	align: "center" },
	{ label: '공유데이터제목',	name: 'docTit',		width: 150,	align: "center" },
	{ label: '희망 방문일시',	name: 'dsrVstDt',	width: 200, align: "center" },
	{ label: '신청일자',	name: 'appcntDt',			width: 150, align: "center" },
	{ label: '신청기관',		name: 'reqOrg',		width: 150, align: "center" },
];

$(window).resize(function(event) {
	if (this == event.target) {
		fn_init();
	}
});

$(document).ready(function() {
	$( "#sDsrVstDt" ).datepicker();
	$( "#sAppcntDt" ).datepicker();
	commonMakeGrid("gridList", "/system/agcy/selectAgcyOffList.do", colModelMast, true
		, function(data) {
			if ($("#rowId").val() == "") $("#rowId").val("1");
			$("#gridList").jqGrid("setSelection", $("#rowId").val());
		}
		, function(rowid, status, e) {
			fn_searchForm(rowid);
		}
	);
	
	fn_init();
	fn_search();
	$("#docTit").focus();
});


function fn_searchForm(rowId) {
	var rowData = $("#gridList").jqGrid("getRowData", rowId);
	commonAjax({ "sDocTit": rowData.docTit}, "/system/agcy/selectAgcyOffList.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;

		var formData = returnData.rows[0];
		$("#docTit").val(formData.docTit);
		$("#dsrVstDt").val(formData.dsrVstDt);
		$("#appcntDt").val(formData.appcntDt);
		$("#reqOrg").val(formData.reqOrg);

		$("#docTit").attr("readonly", true);
		$("#dsrVstDt").attr("readonly", true);
		$("#appcntDt").attr("readonly", true);
		$("#reqOrg").attr("readonly", true);
		
	});
}	

function fn_init() {
	/*$('#grid').css('height', 'calc(100% - 109px)');*/
	$('#gridList').jqGrid('setGridWidth', $('#grid').width()-2);
	$('#gridList').jqGrid('setGridHeight', $('#grid').height()-2);
}

function fn_initClear() { 
	document.searchForm.reset();
	$("#gridList").jqGrid("clearGridData");
	document.detailForm.reset();
	$("#docTit").attr("readonly", true);
	$("#dsrVstDt").attr("readonly", true);
	$("#appcntDt").attr("readonly", true);
	$("#reqOrg").attr("readonly", true);
}

function fn_search() {
	$("#gridList").jqGrid("clearGridData");
	document.detailForm.reset();
	$("#docTit").attr("readonly", true);
	$("#dsrVstDt").attr("readonly", true);
	$("#appcntDt").attr("readonly", true);
	$("#reqOrg").attr("readonly", true);
	
	var searchData = {
		sDocTit: $("#sDocTit").val(),
		sDsrVstDt: $("#sDsrVstDt").val(),
		sAppcntDt: $("#sAppcntDt").val(),
		sReqOrg: $("#sReqOrg").val(),
	};
	
	$("#gridList").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
}

/* 파일 다운로드  */
function fn_Download() {
	c_form.file_nm.value = $("#resvAttachFile").val();
	c_form.dir_nm.value = "sharing";
	c_form.action = "<c:url value='/common/File_Download.do'/>";
	c_form.submit();
}

</script>
</head>

<body class="default" style="min-width: 1260px; min-height: 660px;">
<div class="wrap p-20 h-100">
	<div class="float_left w100p q posi_r">
		<div class="cont_tit2 el-box-tit el-depth-2 el-weight-5">◎ <%=java.net.URLDecoder.decode(menuNm, "UTF-8")%></div>
	</div>

	<div class="box_search lay-boxItem lay-item--full grids__col-12 mt-10 form-wrap ml-0">
		<form id="searchForm" name="searchForm" method="post">

			<div class="d-flex align-center posi_r">
				<fieldset class="d-flex align-center">
					<span class="tit el-txt fw-500">공유 데이터 제목</span>
					<div class="el-form custom-input ml-10">
						<input type="text" class="el-form__input el-form-width--l" id="sDocTit" name="sDocTit" value="" onkeypress="if(event.keyCode==13) {fn_search(); return false;}"/>
					</div>
		    	</fieldset>
				<fieldset class="d-flex align-center ml-20">
					<span class="tit el-txt fw-500">희망 방문일시</span>
					<div class="el-form custom-input ml-10">
						<input type="text" class="el-form__input el-form-width--l" id="sDsrVstDt" name="sDsrVstDt" value="${paramMap.sDsrVstDt}"/>
					</div>
		    	</fieldset>
				<fieldset class="d-flex align-center ml-20">
					<span class="tit el-txt fw-500">신청일자</span>
					<div class="el-form custom-input ml-10">
						<input type="text" class="el-form__input el-form-width--l" id="sAppcntDt" name="sAppcntDt"  value="${paramMap.sAppcntDt}" />
					</div>
				</fieldset>
		    	<fieldset class="d-flex align-center ml-20">
					<span class="tit el-txt fw-500">신청기관</span>
					<div class="el-form custom-sel ml-10">
						<input type="text" class="el-form__input el-form-width--l" id="sReqOrg" name="sReqOrg" value="" onkeypress="if(event.keyCode==13) {fn_search(); return false;}"  />
					</div>
				</fieldset>
				<div class="contBtn2">
					<button type="button" onclick="fn_search()" class="btn btn-b" title="조회">조회</button>
				</div>
			</div>
		</form>
	</div>
	
	<div class="lay-boxItem lay-item--full grids__col-12 m-0" style="overflow: auto;height:calc(100% - 90px);">
		<div class="boxItem__inner h-100">
			<div class="d-flex flex-7 h-100 flex-wrap">
				<div id="grid" class="float_left flex-10 w100p ov-auto-y ov-hidden-x" style="height:70%;padding:10px;border:1px solid #e8eef1;border-radius:3px;">
					<table id="gridList" class="word_b"></table>
				</div>
				
				<div id="form" class="form_box mt-10" style="width:100%;height: calc(30% - 5px);padding:10px;border:1px solid #e8eef1;border-radius:5px;">
					<form id="detailForm" name="detailForm" method="post">
						<input type="hidden" id="sDocTit" name="sDocTit" >
						<input type="hidden" id="sDsrVstDt" name="sDsrVstDt">
						<input type="hidden" id="sAppcntDt" name="sAppcntDt">
						<input type="hidden" id="sReqOrg" name="sReqOrg">
			
						<div class="el-table-wrap">
							<table class="el-table  el-table--row el-table--usermanage" style="table-layout:fixed">
								<caption></caption>
								<colgroup>
									<col width="10%" />
									<col width="23.3%" />
									<col width="10%" />
									<col width="23.3%" />
									<col width="10%" />
									<col width="23.3%" />
								</colgroup>
								<tbody>
									<tr>
										<th>공유 데이터 제목</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--full" id="docTit" name="docTit" value="" caption="사용자ID" required="required"/>
											</div>
										</td>
										<th>희망방문일시</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="dsrVstDt" name="dsrVstDt" value="" caption="사용자명" required="required"/>
											</div>
										</td>
										<th>신청일자</th>
										<td>
											<div class="el-form custom-sel">
												<input type="text" class="el-form__input el-form-width--200" id="appcntDt" name="appcntDt" value="" caption="사용자명" required="required"/>
											</div>
										</td>
									</tr>
									<tr>
										<th>신청기관</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="reqOrg" name="reqOrg" value="" caption="비밀번호확인" required="required"/>
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
