<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Program</title>
<link rel="stylesheet" href="<c:url value='/css/layout.css' />" type="text/css">
<%@ include file="/include/header.jsp" %>

<script src="/js/clip.js"></script> <!-- ClipReport4 -->
<script src="/js/jquery-ui-1.12.1.custom/datepicker-ko.js"></script> <!-- jQuery 달력 -->
<script type="text/javascript">
var colModelMast = [
	{ label: '기준일ID',		name: 'stndDtKey',				hidden: true },
	{ label: '임시운행기관',	name: 'tmpRaceAgency',			width: 200 },
	{ label: '임시운행등록번호',name: 'tmpRaceNumber',			width: 120,	align: "center" },
	{ label: '기준일자',		name: 'stndDtView',				width: 120,	align: "center" },
	{ label: '등록일시',		name: 'regDateView',			width: 120,	align: "center" },
	{ label: '총주행거리',		name: 'totalDrivingDist',		width: 150,	align: "center" },
	{ label: '자율모드주행거리',name: 'autoDrivingDist',		width: 150,	align: "center" },
	{ label: '일반모드주행거리',name: 'nomalDrivingDist',		width: 150,	align: "center" },
//	{ label: '보험증서번호',	name: 'insLetterNumber',		width: 150,	align: "center" },
	{ label: '보험가입일자',	name: 'insInitDateView',		width: 150,	align: "center" },
	{ label: '등록기한 경과',	name: 'coldiff',		width: 150,	align: "center" },
	{ label: '제어권전환 합계',	name: 'changeSum',		width: 150,	align: "center" }
];

var colModelDtl2 = [
	{ label: '기준월',			name: 'drivingDistMonView',		width: 100,	align: "center" },
	{ label: '자율모드주행거리',name: 'autoDrivingDist',		width: 200,	align: "center" }
];

var colModelDtl3 = [
	{ label: '기준월',			name: 'ctrChangeMonView',		width: 100,	align: "center" },
	{ label: '제어권 전환 횟수',name: 'ctrChangeCnt',			width: 200,	align: "center" }
];

var colModelDtl4 = [
	{ label: '일시(월/일/시)',	name: 'ctrChangeDateView',		width: 180,	align: "center" },
	{ label: '장소',			name: 'ctrChangePlace',			width: 200,	align: "center" },
	{ label: '사유(기존사유)',			name: 'ctrChangeNm',		width: 250,	align: "center" },
	{ label: '비고',			name: 'rmk',					width: 200,	align: "center" }
];

$(window).resize(function(event) {
	if (this == event.target) {
		fn_init();
	}
});

$(document).ready(function() {
	commonMakeGrid("gridList1", "/record/driving/selectDrvgHistList.do", colModelMast, true, function(data) {
		if ($("#rowId").val() == "") $("#rowId").val("1");
		$("#gridList1").jqGrid("setSelection", $("#rowId").val());
	}
	, function(rowid, status, e) {
		fn_searchFormMast(rowid);
	});

	commonMakeGrid("gridList2", "/record/driving/selectAutoDrivingList.do", colModelDtl2, true, function(data) {
		$("#gridList2").jqGrid("setSelection", "1");
	});

	commonMakeGrid("gridList3", "/record/driving/selectCtrChangeList.do", colModelDtl3, true, function(data) {
		$("#gridList3").jqGrid("setSelection", "1");
	});

	commonMakeGrid("gridList4", "/record/driving/selectCtrChangeDtlList.do", colModelDtl4, true, function(data) {
		$("#gridList4").jqGrid("setSelection", "1");
	});

	//commonMakeCodeComboBox("sUseYn", "YN_CODE2", true);

	fn_init();

	fn_search();

	$("#sTmpNo").focus();

	//달력 이벤트
	$( "#stdate" ).datepicker();
	$( "#eddate" ).datepicker();

	$("#sTmpNo").keypress(function(e) {
	    if(e.keyCode == 13) fn_search();
	});
	$("#sTmpAg").keypress(function(e) {
	    if(e.keyCode == 13) fn_search();
	});
});

function fn_init() {
//	$("#grid1").css("height", "calc(100% - "+($("#form").height()+119)+"px)");
	$("#gridList1").jqGrid("setGridWidth", $("#grid1").width()-2);
	$("#gridList1").jqGrid("setGridHeight", $("#grid1").height()-45);

	$("#gridList2").jqGrid("setGridWidth", $("#grid2").width()-2);
	$("#gridList2").jqGrid("setGridHeight", $("#grid2").height()+20);

	$("#gridList3").jqGrid("setGridWidth", $("#grid3").width()-2);
	$("#gridList3").jqGrid("setGridHeight", $("#grid3").height()+20);

	$("#gridList4").jqGrid("setGridWidth", $("#grid4").width()-2);
	$("#gridList4").jqGrid("setGridHeight", $("#grid4").height()+20);
}

function fn_initClear() {
	document.searchForm.reset();
	$("#gridList1").jqGrid("clearGridData");
	$("#gridList2").jqGrid("clearGridData");
	$("#gridList3").jqGrid("clearGridData");
	$("#gridList4").jqGrid("clearGridData");

	$("#sTmpNo").focus();
}

function fn_search() {
	$("#gridList1").jqGrid("clearGridData");
	$("#gridList2").jqGrid("clearGridData");
	$("#gridList3").jqGrid("clearGridData");
	$("#gridList4").jqGrid("clearGridData");

	var searchData = {
		sTmpNo: $("#sTmpNo").val(),
		sTmpAg: $("#sTmpAg").val(),
		stdate: $("#stdate").val(),
		eddate: $("#eddate").val()
	};
	$("#gridList1").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
}

function fn_searchFormMast(rowId) {
	var rowData = $("#gridList1").jqGrid("getRowData", rowId);
	$("#sStdDt").val(rowData.stndDtKey);
	$("#sDrvNo").val(rowData.tmpRaceNumber);

	commonAjax({ "sStdDt": rowData.stndDtKey, "sTmpNo": rowData.tmpRaceNumber }, "/record/driving/selectDrvgHistList.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;

		var formData = returnData.rows[0];

		fn_searchDtl2(formData.stndDtKey, formData.tmpRaceNumber);
		fn_searchDtl3(formData.stndDtKey, formData.tmpRaceNumber);
		fn_searchDtl4(formData.stndDtKey, formData.tmpRaceNumber);
	});
}

function fn_searchDtl2(stdDt, tmpNo) {
	$("#gridList2").jqGrid("clearGridData");

	var searchData = {
		sStdDt: stdDt,
		sTmpNo: tmpNo
	};
	$("#gridList2").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
}

function fn_searchDtl3(stdDt, tmpNo) {
	$("#gridList3").jqGrid("clearGridData");

	var searchData = {
		sStdDt: stdDt,
		sTmpNo: tmpNo
	};
	$("#gridList3").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
}

function fn_searchDtl4(stdDt, tmpNo) {
	$("#gridList4").jqGrid("clearGridData");

	var searchData = {
		sStdDt: stdDt,
		sTmpNo: tmpNo
	};
	$("#gridList4").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
}

function fn_excel() {
	var columnsNm = [], datafield = [];
	for (var i=0; i<colModelMast.length; i++) {
		columnsNm[i] = colModelMast[i].label;
		datafield[i] = colModelMast[i].name;
	}

	$("#columnsNm").val(columnsNm);
	$("#datafield").val(datafield);
	$("#excelFileNm").val("<%=menuNm%>.xls");

	var url = "/record/driving/selectDrvgHistExcelList.do";
	$("#searchForm").attr("action", url);
	$("#searchForm").submit();
}

function fn_report() {
	var url = "/record/driving/selectDrvgHistReport.do";
	$("#searchForm").attr("action", url);
	$("#searchForm").submit();
}

function fn_report_new() {
	var oReport = GetfnParamSet();
	oReport.rptname = "driveReport";
	oReport.param("DRV_NO").value = $("#sDrvNo").val();
	oReport.param("STD_DT").value = $("#sStdDt").val().substring(0, 8);
	oReport.open();
}
</script>
</head>

<body class="default" style="min-width: 1260px; min-height: 660px;">
<div class="wrap p-20 h-100">
	<div class="float_left w100p c posi_r">
		<div class="cont_tit2 el-box-tit el-depth-2 el-weight-5">◎ <%=java.net.URLDecoder.decode(menuNm, "UTF-8")%></div>

<!-- 		<div class="contBtn1">
			<a href="javascript:fn_report_new()" class="btn_template_down" title="보고서 출력"></a>
			<i></i>		
			<a href="javascript:fn_report()" class="btn_template_down" title="보고서 출력"></a>
			<i></i> 
			<a href="javascript:fn_initClear()" class="btn_refresh" title="초기화"></a>
			<i></i>
			<a href="javascript:fn_search()" class="btn_search" title="조회"></a>
			<i></i>
			<a href="javascript:fn_excel()" class="btn_excel" title="엑셀"></a>
		</div>-->
	</div>

	<div class="box_search lay-boxItem lay-item--full grids__col-12 mt-10 form-wrap ml-0">
		<form id="searchForm" name="searchForm" method="post">
			<input type="hidden" id="excelFileNm" name="excelFileNm" value="">
			<input type="hidden" id="columnsNm" name="columnsNm" value="">
			<input type="hidden" id="datafield" name="datafield" value="">
			<input type="hidden" id="sStdDt" name="sStdDt" value="">
			<input type="hidden" id="sDrvNo" name="sDrvNo" value="">

			<div class="d-flex align-center posi_r">
				<fieldset class="d-flex align-center">
					<span class="tit el-txt fw-500">임시운행등록번호</span>
					<div class="el-form custom-input ml-10">
						<input type="text" class="el-form__input el-form-width--200" id="sTmpNo" name="sTmpNo" value=""/>
					</div>
				</fieldset>
				<fieldset class="d-flex align-center ml-20">
					<span class="tit el-txt fw-500">기관명</span>
					<div class="el-form custom-input ml-10">
						<input type="text" class="el-form__input el-form-width--200" id="sTmpAg" name="sTmpAg" value=""/>
					</div>
				</fieldset>
				<fieldset class="d-flex align-center ml-20">
					<span class="tit el-txt fw-500">기준일시</span>
					<div class="el-form custom-sel ml-10">
						<input type="text" class="el-form__input el-form-width--l" id="stdate" name="stdate" value="" autocomplete='off'/> 
						&nbsp;~&nbsp;
						<input type="text" class="el-form__input el-form-width--l" id="eddate" name="eddate" value="" autocomplete='off'/>
					</div>
				</fieldset>
				<div class="contBtn2">
					<button type="button" onclick="fn_search()" class="btn btn-b" title="조회">조회</button>
					<button type="button" onclick="fn_report_new()" class="btn btn-o" title="보고서 출력">보고서 출력</button>
					<button type="button" onclick="fn_excel()" class="btn btn-g" title="엑셀 다운로드">엑셀 다운로드</button>
				</div>
			</div>
		</form>
	</div>
	<div class="lay-boxItem lay-item--full grids__col-12 m-0" style="overflow: auto; height:calc(100% - 90px);">
		<div class="boxItem__inner h-100">
			<div class="d-flex flex-wrap h-100">
			
				<div id="grid1" class="float_left w100p ov-auto-y ov-hidden-x" style="height: 50%;padding:10px;border:1px solid #ebeef2;border-radius:3px;">
					<form id="detailForm" name="detailForm" method="post">
						<input type="text" style="display: none;" id="rowId" name="rowId" value=""/>
						
						<p class="float_left w100p el-txt-7" style="font-weight: bold;">▶ 운행정보</p>
						<div id="grid_1" class="float_left mt-10 ov-auto ">
							<table id="gridList1" class="word_b"></table>
						</div>
					</form>
				</div>
				<div id="grid2" class=" ov-auto float_left" style="overflow:hidden;width: calc(33.3% - 5px); height:50%;padding: 10px; margin-top: 5px; border: 1px solid #ebeef2;  border-radius: 3px; background: #fff; ">
					<p class="float_left w100p el-txt-7" style="font-weight: bold;">▶ 월별 자율모드주행거리</p>
					<div id="grid_2" class="float_left mt-10 bottom ov-auto" style="width: 100%; height: 100%;">
						<table id="gridList2" class="word_b"></table>
					</div>
				</div>
			
				<div id="grid3" class=" ov-auto float_left " style="overflow:hidden;width: calc(33.3% - 5px); height:50%;padding: 10px; margin-top: 5px;margin-left:5px; border: 1px solid #ebeef2;  border-radius: 3px; background: #fff;">
					<p class="float_left w100p el-txt-7" style="font-weight: bold;">▶ 월별 제어권 전환 횟수</p>
					<div id="grid_3" class="float_left mt-10 bottom ov-auto" style="width: 100%; height: 100%;">
						<table id="gridList3" class="word_b"></table>
					</div>
				</div>
			
				<div id="grid4" class=" ov-auto float_left " style="overflow:hidden;width: calc(33.3% - 5px); height:50%;padding: 10px; margin-top: 5px;margin-left:5px; border: 1px solid #ebeef2;  border-radius: 3px; background: #fff;">
					<p class="float_left w100p el-txt-7" style="font-weight: bold;">▶ 제어권 전환 상세정보</p>
					<div id="grid_4" class="float_left mt-10 ov-auto" style="width: 100%; height: 100%;">
						<table id="gridList4" class="word_b"></table>
					</div>
				</div>
				
			</div>
		</div>
	</div>

	
</div>
</body>
</html>
