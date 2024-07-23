<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Program</title>
<link rel="stylesheet" href="<c:url value='/css/layout.css' />" type="text/css">
<%@ include file="/include/header.jsp" %>

<script type="text/javascript" src="/js/gstatic/loader.js"></script>
<script type="text/javascript">
// global 변수 선언
var colNames, colModel, sPKColumn, searchData;
// grid column 구조
var colNm_mon_All = ['구분','1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월','총 누적 (km)'];
var colNm_mon_Temp = ['임시운행번호','1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월','총 누적 (km)'];
var colNm_mon_User = ['기관ID','1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월','총 누적 (km)'];
var colModel_mon = [
	{ name: 'trn', width: 120, align: 'center' },
	{ name: 'm01', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}},{ name: 'm02', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}},{ name: 'm03', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}},{ name: 'm04', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}},
	{ name: 'm05', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}},{ name: 'm06', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}},{ name: 'm07', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}},{ name: 'm08', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}},
	{ name: 'm09', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}},{ name: 'm10', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}},{ name: 'm11', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}},{ name: 'm12', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}},
	{ name: 'tot', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}}
];
var colNm_year = [];
var colModel_year = [];

$(window).resize(function(event) {
	if (this == event.target) {
		fn_init();
		fn_searchChart();
	}
});

$(document).ready(function() {
	// 구글차트 init
	google.charts.load("current", {packages:["corechart"]});
	$('#sKeyword').prop('disabled', true);
	// 날짜 default 설정
	$('#sDate').yearpicker();
	$('#eDate').yearpicker();
	// 현재 검색옵션(구분, 년/월단위, 기간)에 따른 초기 grid 모양 설정
	fn_makeGrid();
	fn_search();
});

// 현재 검색옵션에 따른 db 테이블명 return
function getColNames() {
	var selType = $('#sType').val();
	var selTerm = $('#sTerm').val();
	if(selTerm == 'MON'){
		colNames = colNm_mon_All; //default
		switch(selType) {
			case 'SEL_ALL':
				colNames = colNm_mon_All;
				break;
			case 'SEL_TEMP':
				colNames = colNm_mon_Temp;
				break;
			case 'SEL_USER':
				colNames = colNm_mon_User;
				break;
		}
	}
	else if(selTerm == 'YEAR'){
		colNm_year = [];
		switch(selType) {
			case 'SEL_ALL':
				colNm_year.push('구분');
				break;
			case 'SEL_TEMP':
				colNm_year.push('임시운행번호');
				break;
			case 'SEL_USER':
				colNm_year.push('기관ID');
				break;
		}
		for(var i=$('#sDate').val(); i<=$('#eDate').val(); i++) colNm_year.push(String(i));
		colNm_year.push('총 누적 (km)');
		colNames = colNm_year;
	}
	else if(selTerm == 'SEMI'){
		colNm_year = [];
		switch(selType) {
			case 'SEL_ALL':
				colNm_year.push('구분');
				break;
			case 'SEL_TEMP':
				colNm_year.push('임시운행번호');
				break;
			case 'SEL_USER':
				colNm_year.push('기관ID');
				break;
		}
		for(var i=$('#sDate').val(); i<=$('#eDate').val(); i++){
			colNm_year.push(String(i)+ '전반기');
			colNm_year.push(String(i)+'하반기');
		} 
		colNm_year.push('총 누적 (km)');
		colNames = colNm_year;
	}	
	return colNames;
}

// 현재 검색옵션에 따른 grid column 구조 return
function getColModel() {
	var selTerm = $('#sTerm').val();
	if(selTerm == 'MON'){
		colModel = colModel_mon; //default
	}
	else if(selTerm == 'YEAR'){
		colModel_year = [];
		colModel_year.push({ name: 'trn', width: 120, align: 'center' });
		for(var i=$('#sDate').val(); i<=$('#eDate').val(); i++) {
			colModel_year.push({ name: String(i), align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}});
		}
		colModel_year.push({ name: 'tot', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}});
		colModel = colModel_year; //default
	}
	else if(selTerm == 'SEMI'){
		colModel_year = [];
		colModel_year.push({ name: 'trn', width: 120, align: 'center' });
		for(var i=$('#sDate').val(); i<=$('#eDate').val(); i++) {
			colModel_year.push({ name: String(i)+'01', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}});
			colModel_year.push({ name: String(i)+'02', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}});
		}
		colModel_year.push({ name: 'tot', align: 'center', formatter : 'integer',  formatoptions : {defaultValue: '', thousandsSeparator : ','}});
		colModel = colModel_year; //default
	}	
	return colModel;
}

// 데이터 조회 시 현재 검색옵션 파라미터 return
function getSearchData() {
	var sDt = $('#sDate').val();
	var eDt = $('#eDate').val();
	var yearArr = '';
	if($('#sTerm').val() == 'YEAR') {
		for(var i=sDt; i<=eDt; i++) {
			yearArr += String(i);
			if(i != eDt) yearArr += ',';
		}
	}else if($('#sTerm').val() == 'SEMI'){
		for(var i=sDt; i<=eDt; i++) {
			yearArr += String(i) + '01,' + String(i) + '02';
			if(i != eDt) yearArr += ',';
		}
	}
	searchData = {
		sType: $('#sType').val(),
		sKeyword: $('#sKeyword').val(),
		sDate: sDt,
		eDate: eDt,
		yearArr: yearArr
	};
	return searchData;
}

// 년/월 옵션에 따라 요청 request url return
function getSevletUrl() {
	var url;
	if($('#sTerm').val() == 'MON'){
		url = '/statistics/stat/selectDistStatMonList.do';
	}
	else if($('#sTerm').val() == 'YEAR') {
		url = '/statistics/stat/selectDistStatYearList.do';
	}else{
		url = '/statistics/stat/selectDistStatSemiAnnualList.do';
	}
	return url;
}

// 년/월 옵션에 따라 요청 request url (그래프용) return
function getSevletUrlChart() {
	var url;
	if($('#sTerm').val() == 'MON'){
		url = '/statistics/stat/selectDistStatMonListChart.do';
	}
	else if($('#sTerm').val() == 'YEAR'){
		url = '/statistics/stat/selectDistStatYearListChart.do';
	}
	else {
		url = '/statistics/stat/selectDistStatSemiAnnualListChart.do';
	}	
	return url;
}

// 년/월 옵션에 따라 요청 request url (엑셀용) return
function getSevletUrlExcel() {
	var url;
	if($('#sTerm').val() == 'MON'){
		url = '/statistics/stat/selectDistStatMonExcel.do';
	}
	else if($('#sTerm').val() == 'YEAR'){
		url = '/statistics/stat/selectDistStatYearExcel.do';
	}
	else {
		url = '/statistics/stat/selectDistStatSemiAnnualExcel.do';
	}	
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
	var cs_cnt, cs_text;
	var selTerm = $('#sTerm').val();
	if(selTerm == 'MON'){
		cs_cnt = 12;
		cs_text = '월별 주행거리(km)';
	}
	else if(selTerm == 'YEAR'){
		cs_cnt = 0;
		for(var i=$('#sDate').val(); i<=$('#eDate').val(); i++) {
			cs_cnt++;
		}
		cs_text = '년도별 주행거리(km)';
	}
	else {
		cs_cnt = 0;
		for(var i=$('#sDate').val(); i<=$('#eDate').val(); i++) {
			cs_cnt++;
			cs_cnt++;
		}
		cs_text = '반기별 주행거리(km)';
	}	
	$("#gridList").jqGrid('setGroupHeaders', {
		useColSpanStyle: true,
			groupHeaders:[
				{ startColumnName: colModel[1].name, numberOfColumns: cs_cnt, titleText: cs_text }
		  ]
  });
 	fn_init(); // grid 생성 후 화면 레이아웃 refresh
}

function fn_init() {
	/*$('#grid').css('height', 'calc(60% - 119px)');*/
	$('#gridList').jqGrid('setGridWidth', $('#grid').width()-2);
	$('#gridList').jqGrid('setGridHeight', $('#grid').height()-57);
}

// 검색 옵션에 따른 데이터 검색
function fn_search() {
	$('#gridList').jqGrid('clearGridData');
	$('#gridList').jqGrid('setGridParam', {datatype: 'json', postData : getSearchData()}).trigger('reloadGrid');
	fn_init();
	// grid 생성 후 그래프 그리기
	fn_searchChart();
}

function fn_searchChart() {
	// grid 생성 후 그래프 그리기
	commonAjax(getSearchData(), getSevletUrlChart(), function(returnData, textStatus, jqXHR) {
		var records = returnData.rows;
		if(records.length > 0) {
			$("#chart_area").empty();
			google.charts.setOnLoadCallback(function() { drawChart(records); });
		}
		else {
			$('#chart_area').html("<div id='chart_area' style='width:100%; height:100%;'><table style='width:100%; height:100%;'><tr><td style='width:100%; height:100%; text-align:center;'>데이터가 없습니다.</td></tr></table></div>");
		}
	});
}

// 쿼리 결과를 그래프용 배열데이터로 생성
function getPivotArray(dataArray) {
	//Code from https://techbrij.com
	var result = {}, ret = [];
	var newCols = [];
	for (var i = 0; i < dataArray.length; i++) {
  	if (!result[dataArray[i].sterm]) {
			result[dataArray[i].sterm] = {};
		}
		result[dataArray[i].sterm][dataArray[i].trn] = dataArray[i].acnt;
		//To get column names
		if (newCols.indexOf(dataArray[i].trn) == -1) {
			newCols.push(dataArray[i].trn);
		}
	}
	newCols.sort();
	var item = [];
	//Add Header Row
	item.push('기간');
	item.push.apply(item, newCols);
	ret.push(item);
	//Add content
	for (var key in result) {
		item = [];
		item.push(key);
		for (var i = 0; i < newCols.length; i++) {
			item.push(result[key][newCols[i]] || 0);
		}
		ret.push(item);
	}
	return ret;
}

// draw 그래프
function drawChart(inputData) {
	var arr = eval(inputData);
	if(arr == null) {
		return;
	} else {
		var options = {
			legend: 'top',
			legendTextStyle: {color:'#000',fontName: 'NanumGothic',fontSize: '12'},
			lineWidth: 5,
			chartArea: {left:100, width:'90%'}
		}
		// 그래프용 배열데이터 생성
		var yearWiseData = google.visualization.arrayToDataTable(getPivotArray(arr));
		var chart = new google.visualization.ColumnChart(document.getElementById('chart_area'));
		chart.draw(yearWiseData, options);
		yearWiseData = null;
		options = null;
		chart = null;
	}
	arr = null;
}

function fn_excel() {
	var datafield = [];
	var yearArr = '';
	var tempCol = getColModel();
	var sDt = $('#sDate').val();
	var eDt = $('#eDate').val();

	for (var i=0; i<tempCol.length; i++) {
		datafield[i] = tempCol[i].name;
	}
	if($('#sTerm').val() == 'YEAR') {
		for(var i=sDt; i<=eDt; i++) {
			yearArr += String(i);
			if(i != eDt) yearArr += ',';
		}
	}else if($('#sTerm').val() == 'SEMI') {
		for(var i=sDt; i<=eDt; i++) {
			yearArr += String(i) + '01,' + String(i) + '02';
			if(i != eDt) yearArr += ',';
		}
	}

	$('#columnsNm').val(getColNames());
	$('#datafield').val(datafield);
	// $('#excelFileNm').val('주행거리통계'+'_'+$("#sType option:selected").text()+'_'+$("#sTerm option:selected").text()+'.xls');
	$('#excelFileNm').val('Distance_statistics_excel.xls');

	$('#yearArr').val(yearArr);

	$('#searchForm').attr('action', getSevletUrlExcel());
	$('#searchForm').submit();
}

</script>
</head>
<body class="default" style="min-width: 1260px; min-height: 660px;">
<div class="wrap p-20 h-100">
	<div class="float_left w100p k posi_r">
		<div class="cont_tit2 el-box-tit el-depth-2 el-weight-5">◎ <%=java.net.URLDecoder.decode(menuNm, "UTF-8")%></div>

<!-- 		<div class="contBtn1"> -->
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
			<input type="hidden" id="yearArr" name="yearArr" value="">

			<div class="d-flex align-center posi_r">
				<fieldset class="d-flex align-center">
					<span class="tit el-txt fw-500">구분</span>
					<div class="el-form custom-sel ml-10">
						<select class="el-form__sel" id="sType" name="sType" >
							<option value="SEL_ALL">전체 자율모드 주행거리</option>
							<option value="SEL_TEMP">차량별 자율모드 주행거리</option>
							<option value="SEL_USER">기관별 자율모드 주행거리</option>
						</select>
					</div>
					<div class="el-form custom-input ml-10">
						<input type="text" class="el-form__input el-form-width--200" id="sKeyword" name="sKeyword" value=""/>
					</div>
				</fieldset>
				<fieldset class="d-flex align-center ml-20">
					<span class="tit el-txt fw-500">기간</span>
					<div class="el-form custom-sel ml-10">
						<select class="el-form__sel" id="sTerm" name="sTerm" >
							<option value="MON">월별</option>
							<option value="SEMI">반기별</option>
							<option value="YEAR">년도별</option>
						</select>
						<div class="el-form custom-sel ml-10">
							<input type="text" class="yearpicker el-form__input el-form-width--200" id="sDate" name="sDate" value="2018" />
							&nbsp;~&nbsp;
							<input type="text" class="yearpicker el-form__input el-form-width--200" id="eDate" name="eDate" value="2019" />
						</div>
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
			<div class="d-flex flex-7 h-100 flex-wrap">
				<div id="grid" class="float_left flex-10 w100p ov-auto-y ov-hidden-x" style="height:50%;padding:10px;border:1px solid #e8eef1;border-radius:3px;">
					<table id="gridList"></table>
				</div>

				<div id="form" class="form_box flex-10" style="width:100%;height: calc(50% - 5px);margin-top:5px;border:1px solid #e8eef1;border-radius:5px;">
					<div id="chart_area" style="width:100%;height:100%">
						<table style="width:100%;height:100%">
							<tr>
								<td style="width:100%;height:100%; text-align:center;">데이터가 없습니다.</td>
							</tr>
						</table>
					</div>
				</div>
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
$("#sType").change(function () {
	if($(this).val() == 'SEL_ALL') $('#sKeyword').prop('disabled', true);
	else $('#sKeyword').prop('disabled', false);
	fn_makeGrid();
});
$("#sTerm").change(function () {
	if($(this).val() == 'MON') $('#eDate').prop('disabled', true);
	else if($(this).val() == 'YEAR' || $(this).val() == 'SEMI') {
		if($("#sDate").val() > $("#eDate").val()) $("#sDate").val($("#eDate").val());
		$('#eDate').prop('disabled', false);
	}
	fn_makeGrid();
});
$("#sDate").bind("change", function() {
	if($("#sTerm").val() == 'YEAR' || $("#sTerm").val() == 'SEMI') {
		if($(this).val() > $("#eDate").val()) $(this).val($("#eDate").val());
		fn_makeGrid();
	}
});
$("#eDate").bind("change", function() {
	if($("#sTerm").val() == 'YEAR' || $("#sTerm").val() == 'SEMI') {
		if($(this).val() < $("#sDate").val()) $(this).val($("#sDate").val());
		fn_makeGrid();
	}
});

</script>
