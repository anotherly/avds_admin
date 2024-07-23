<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	int curYear = (Integer)request.getAttribute("curYear");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Program</title>
<link rel="stylesheet" href="<c:url value='/css/layout.css' />" type="text/css">
<%@ include file="/include/header.jsp" %>

<script src="/js/clip.js"></script> <!-- ClipReport4 -->
<script type="text/javascript" src="/js/gstatic/loader.js"></script>
<script type="text/javascript">
// global 변수 선언
var colNames, colModel, sPKColumn, searchData;
// grid column 구조
var colNm_mon_1 = ['임시운행기관','임시운행등록번호','총주행거리','자율모드','일반모드','1월','2월','3월','4월','5월','6월','총 누적 (km)','1월','2월','월3','4월','5월','6월','총 누적'];
var colNm_mon_2 = ['임시운행기관','임시운행등록번호','총주행거리','자율모드','일반모드','7월','8월','9월','10월','11월','12월','총 누적 (km)','7월','8월','9월','10월','11월','12월','총 누적'];
var colModel_mon = [
	{ name: 'tmpRaceAgency', width: 180, align: 'center' }, { name: 'tmpRaceNumber', width: 200, align: 'center' },
	{ name: 'totalDrivingDist', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}},{ name: 'autoDrivingDist', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}},{ name: 'nomalDrivingDist', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}},
	{ name: 'autoDrivingDist1', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}},{ name: 'autoDrivingDist2', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}},{ name: 'autoDrivingDist3', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}},
	{ name: 'autoDrivingDist4', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}},{ name: 'autoDrivingDist5', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}},{ name: 'autoDrivingDist6', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}}, { name: 'autoDrivingSum', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}},
	{ name: 'ctrChangeCnt1', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}},{ name: 'ctrChangeCnt2', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}},{ name: 'ctrChangeCnt3', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}},
	{ name: 'ctrChangeCnt4', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}},{ name: 'ctrChangeCnt5', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}},{ name: 'ctrChangeCnt6', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}}, { name: 'ctrChangeSum', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}}
];

$(window).resize(function(event) {
	if (this == event.target) {
		fn_init();
		//fn_searchChart();
	}
});

$(document).ready(function() {
	// 구글차트 init
	google.charts.load("current", {packages:["corechart"]});
	// 날짜 default 설정
	// 현재 검색옵션(구분, 년/월단위, 기간)에 따른 초기 grid 모양 설정
	fn_makeGrid();
	fn_search();
});

// 현재 검색옵션에 따른 db 테이블명 return
function getColNames() {
	var selTerm = $('#sTerm').val();
	if(selTerm == '01'){
		colNames = colNm_mon_1;
	}
	else if(selTerm == '02'){
		colNames = colNm_mon_2;
	}	
	return colNames;
}

// 현재 검색옵션에 따른 grid column 구조 return
function getColModel() {
	var selTerm = $('#sTerm').val();
	if(selTerm == '01'){
		colModel = colModel_mon;
	}
	else if(selTerm == '02'){
		colModel = colModel_mon;
	}
	return colModel;
}

// 데이터 조회 시 현재 검색옵션 파라미터 return
function getSearchData() {
	searchData = {
		sTerm: $('#sTerm').val(),
		sKeyword: $('#sKeyword').val(),
		sTmpRaceAgency: $('#sTmpRaceAgency').val(),
		sTmpRaceNumber: $('#sTmpRaceNumber').val()
	};
	return searchData;
}

// 년/월 옵션에 따라 요청 request url return
function getSevletUrl() {
	var url = '/statistics/stat/selectReportStatList.do';
	
	return url;
}

// 현재 검색옵션에 따른 default grid 생성
function fn_makeGrid() {
	$.jgrid.gridUnload("gridList");
	commonMakeGridParam('gridList', getSevletUrl(), getColNames(), getColModel(), getSearchData(), true
		, function(data) {
			if ($('#rowId').val() == '') $('#rowId').val('1');
			$('#gridList').jqGrid('setSelection', $('#rowId').val());
			}
		, function(rowid, status, e) {
		}
	);
	$('#gridList').jqGrid('setGridWidth', $('#grid').width()-2);
	// 헤더 colspan 처리
	var colModel = $("#gridList").jqGrid('getGridParam', 'colModel');
	
	$("#gridList").jqGrid('setGroupHeaders', {
		useColSpanStyle: true,
			groupHeaders:[
				{ startColumnName: colModel[2].name, numberOfColumns: 3, titleText: "주행거리" },
				{ startColumnName: colModel[5].name, numberOfColumns: 7, titleText: "월별 주행거리" },
				{ startColumnName: colModel[12].name, numberOfColumns: 7, titleText: "제어권 전환 횟수" }
		  ]
  });
 	fn_init(); // grid 생성 후 화면 레이아웃 refresh
}

function fn_init() {
	/*$('#grid').css('height', 'calc(100% - 109px)');*/
	$('#gridList').jqGrid('setGridWidth', $('#grid').width()-2);
	$('#gridList').jqGrid('setGridHeight', $('#grid').height()-30);
}

// 검색 옵션에 따른 데이터 검색
function fn_search() {
	$('#gridList').jqGrid('clearGridData');
	$('#gridList').jqGrid('setGridParam', {datatype: 'json', postData : getSearchData()}).trigger('reloadGrid');
	fn_init();
}

function fn_report_new() {
	var oReport = GetfnParamSet();
	oReport.rptname = "reportReport";
	oReport.param("TMPRACEAGENCY").value = $("#sTmpRaceAgency").val();
	oReport.param("TMPRACENUMBER").value = $("#sTmpRaceNumber").val();
	oReport.param("YEAR").value = $("#sKeyword").val();
	oReport.param("SEMI").value = $("#sTerm").val();
	oReport.open();
}

</script>
</head>
<body class="default" style="min-width: 1260px; min-height: 660px;">
<div class="wrap p-20 h-100">
	<div class="float_left w100p m posi_r">
		<div class="cont_tit2 el-box-tit el-depth-2 el-weight-5">◎ <%=java.net.URLDecoder.decode(menuNm, "UTF-8")%></div>

<!-- 		<div class="contBtn1"> -->
<!-- 			<a href="javascript:fn_report_new()" class="btn_template_down" title="보고서 출력"></a> -->
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
					<span class="tit el-txt fw-500">임시운행기관</span>
					<div class="el-form custom-input ml-10">
						<input type="text" class="el-form__input el-form-width--200" id="sTmpRaceAgency" name="sTmpRaceAgency" value=""/>
					</div>
					<span class="tit el-txt fw-500 ml-20">임시운행등록번호</span>
					<div class="el-form custom-input ml-10">
						<input type="text" class="el-form__input el-form-width--200" id="sTmpRaceNumber" name="sTmpRaceNumber" value=""/>
					</div>
				</fieldset>
			
				<fieldset class="d-flex align-center ml-20">
					<span class="tit el-txt fw-500">기간</span>
					<div class="el-form custom-sel ml-10">
						<select class="el-form__sel" id="sTerm" name="sTerm" >
							<option value="01">상반기</option>
							<option value="02">하반기</option>
						</select>
						<div class="el-form custom-input ml-10">
							<input type="text" class="el-form__input el-form-width--200" id="sKeyword" name="sKeyword" value="<%=curYear%>"/>
						</div>
					</div>
				</fieldset>
				<div class="contBtn2">
					<button type="button" onclick="fn_search()" class="btn btn-b" title="조회">조회</button>
					<button type="button" onclick="fn_report_new()" class="btn btn-g" title="보고서 출력">보고서 출력</button>
				</div>
			</div>
		</form>
	</div>
	<div class="lay-boxItem lay-item--full grids__col-12 m-0 ov-auto" style="height:calc(100% - 90px);">
		<div class="boxItem__inner h-100">
			<div id="grid" class="float_left flex-10 w100p h-100 ov-auto-y ov-hidden-x">
				<table id="gridList" class="word_b"></table>
			</div>
		</div>
	</div>

</div>
</body>
</html>
<script type="text/javascript">

$("#sKeyword").keypress(function(e) {
    if(e.keyCode == 13) fn_search();
});
$("#sTmpRaceAgency").keypress(function(e) {
    if(e.keyCode == 13) fn_search();
});
$("#sTmpRaceNumber").keypress(function(e) {
    if(e.keyCode == 13) fn_search();
});
$("#sTerm").change(function () {
	fn_makeGrid();
});

</script>
