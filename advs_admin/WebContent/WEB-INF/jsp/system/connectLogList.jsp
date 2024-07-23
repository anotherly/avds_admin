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
var colModelMast = [
	{ label: '로그일자',	name: 'creatDtView',		width: 120,	align: "center" },
	{ label: '사용자ID',	name: 'userId',					width: 150, align: "center" },
	{ label: '사용자명',	name: 'userNm',					width: 150, align: "center" },
	{ label: '기관명',		name: 'agencyCdView',		width: 200, align: "center" },
	{ label: '로그유형',	name: 'conectMthdView',	width: 150, align: "center" },
	{ label: '접속IP',		name: 'connectIp',			width: 150, align: "center" }
];

$(window).resize(function(event) {
	if (this == event.target) {
		fn_init();
	}
});

$(document).ready(function() {
	//달력 이벤트
	$( "#stdate" ).datepicker().datepicker("setDate", -1);
	$( "#eddate" ).datepicker().datepicker("setDate", new Date());

	commonMakeGrid("gridList", "/system/connlog/selectConnectLogList.do", colModelMast, true
		, function(data) {
			if ($("#rowId").val() == "") $("#rowId").val("1");
			$("#gridList").jqGrid("setSelection", $("#rowId").val());
		}
		, function(rowid, status, e) {
		}
	);
	fn_init();
	fn_search();
	$("#sUserId").focus();
});

function fn_init() {
	/*$('#grid').css('height', 'calc(100% - 109px)');*/
	$('#gridList').jqGrid('setGridWidth', $('#grid').width()-2);
	$('#gridList').jqGrid('setGridHeight', $('#grid').height()-2);
}

function fn_initClear() {
	document.searchForm.reset();
	$("#gridList").jqGrid("clearGridData");

	$("#sUserId").focus();
}

function fn_search() {
	$("#gridList").jqGrid("clearGridData");

	var searchData = {
		sUserId: $("#sUserId").val(),
		sUserNm: $("#sUserNm").val(),
		stdate: $("#stdate").val(),
		eddate: $("#eddate").val()
	};
	$("#gridList").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
}

function fn_excel() {
	var columnsNm = [], datafield = [];
	for (var i=0; i<colModelMast.length-1; i++) {
		columnsNm[i] = colModelMast[i].label;
		datafield[i] = colModelMast[i].name;
	}

	$("#columnsNm").val(columnsNm);
	$("#datafield").val(datafield);
	$("#excelFileNm").val("<%=menuNm%>.xls");

	var url = "/system/connlog/selectConnectLogExcel.do";
	$("#searchForm").attr("action", url);
	$("#searchForm").submit();
}

</script>
</head>

<body class="default" style="min-width: 1260px; min-height: 660px;">
<div class="wrap p-20 h-100">
	<div class="float_left w100p q posi_r">
		<div class="cont_tit2 el-box-tit el-depth-2 el-weight-5">◎ <%=java.net.URLDecoder.decode(menuNm, "UTF-8")%></div>

<!-- 		<div class="contBtn1"> -->
<!-- 			<a href="javascript:fn_initClear()" class="btn_refresh" title="초기화"></a> -->
<!-- 			<i></i> -->
<!-- 			<a href="javascript:fn_search()" class="btn_search" title="조회"></a> -->
<!-- 			<i></i> -->
<!-- 			<a href="javascript:fn_excel()" class="btn_excel" title="엑셀"></a> -->
<!-- 		</div> -->
	</div>

	<div class="box_search lay-boxItem lay-item--full grids__col-12 mt-10 form-wrap ml-0">
		<form id="searchForm" name="searchForm" method="post">
			<input type="hidden" id="excelFileNm" name="excelFileNm" value="">
			<input type="hidden" id="columnsNm" name="columnsNm" value="">
			<input type="hidden" id="datafield" name="datafield" value="">

			<div class="d-flex align-center posi_r">
				<fieldset class="d-flex align-center">
					<span class="tit el-txt fw-500">사용자ID</span>
					<div class="el-form custom-input ml-10">
						<input type="text" class="el-form__input el-form-width--l" id="sUserId" name="sUserId" value="" onkeypress="if(event.keyCode==13) {fn_search(); return false;}"/>
					</div>
		    	</fieldset>
				<fieldset class="d-flex align-center ml-20">
					<span class="tit el-txt fw-500">사용자명</span>
					<div class="el-form custom-input ml-10">
						<input type="text" class="el-form__input el-form-width--l" id="sUserNm" name="sUserNm" value="" onkeypress="if(event.keyCode==13) {fn_search(); return false;}"/>
					</div>
				</fieldset>
		    	<fieldset class="d-flex align-center ml-20">
					<span class="tit el-txt fw-500">로그일시</span>
					<div class="el-form custom-sel ml-10">
						<input type="text" class="el-form__input el-form-width--l" id="stdate" name="stdate" value="" />
						<span>&nbsp;~&nbsp;</span>
						<input type="text" class="el-form__input el-form-width--l" id="eddate" name="eddate" value="" />
					</div>
				</fieldset>
				<div class="contBtn2">
					<button type="button" onclick="fn_search()" class="btn btn-b" title="조회">조회</button>
					<button type="button" onclick="fn_excel()" class="btn btn-g" title="엑셀 다운로드">엑셀 다운로드</button>
				</div>
			</div>
		</form>
	</div>
	<div class="lay-boxItem lay-item--full grids__col-12 m-0" style="overflow: auto;height:calc(100% - 90px);">
		<div class="boxItem__inner h-100">
			<div class="d-flex h-100 flex-wrap">
				<div id="grid" class="float_left w100p ov-auto-y ov-hidden-x" style="padding:10px;border:1px solid #e8eef1;border-radius:5px;">
					<table id="gridList" class="word_b"></table>
				</div>
			</div>
		</div>
	</div>

</div>
</body>
</html>
