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
	{ label: '사고ID',		name: 'accId',						hidden: true },
	{ label: '임시운행등록번호',name: 'tmpRaceNumber',				width: 120,	align: "center" },
	{ label: '임시운행기관',		name: 'tmpRaceAgency',				width: 150 },
	{ label: '사고일시',			name: 'accDateView',				width: 120,	align: "center" },
	{ label: '등록일시',		name: 'regDateView',				width: 120,	align: "center" },
	{ label: '장소',			name: 'place',						width: 250 },
	{ label: '기상상황',		name: 'weatherView',				width: 80,	align: "center" },
	{ label: '도로상황',		name: 'roadSituationView',			width: 80,	align: "center" },
	{ label: '도로유형코드',	name: 'roadTypeCdView',				width: 100,	align: "center" },
	{ label: '주행모드',		name: 'autocarDrivingModeView',		width: 100,	align: "center" },
	{ label: '주행상태',		name: 'autocarDrivingStatusCdView',	width: 60,	align: "center" },
	{ label: '운행속도',		name: 'autocarSpeed',				width: 60,	align: "center" },
	{ label: '승차인원',		name: 'autocarRideNumber',			width: 60,	align: "center" },
	{ label: '적재량',		name: 'autocarLoadVol',				width: 60,	align: "center" },
	{ label: '파손정도',		name: 'autocarDamageView',			width: 60,	align: "center" },
	{ label: '등록기한 경과',			name: 'coldiff',		width: 120,	align: "center" }
];

var colModelDetl = [
	{ label: '사고ID',	name: 'accId',						hidden: true },
	{ label: '사고차량종류',name: 'acccarCarTypeView',			width: 90,	align: "center" },
	{ label: '주행모드',	name: 'acccarDrivingModeView',		width: 90,	align: "center" },
	{ label: '주행상태',	name: 'acccarDrivingStatusCdView',	width: 80,	align: "center" },
	{ label: '운행속도',	name: 'acccarSpeed',				width: 60,	align: "center" },
	{ label: '승차인원',	name: 'acccarRideNumber',			width: 60,	align: "center" },
	{ label: '적재량',	name: 'acccarLoadVol',					width: 60,	align: "center" },
	{ label: '파손정도',	name: 'acccarDamageView',			width: 60,	align: "center" },
	{ label: '인적피해',	name: 'humanInjuryTypeView',		width: 80,	align: "center" },
	{ label: '성별',		name: 'acccarHumanSexView',			width: 60,	align: "center" },
	{ label: '나이',		name: 'acccarHumanAge',				width: 60,	align: "center" }
];

$(window).resize(function(event) {
	if (this == event.target) {
		fn_init();
	}
});

$(document).ready(function() {
	commonMakeGrid("gridList1", "/record/incident/selectIncdHistList.do", colModelMast, false, function(data) {
		if ($("#rowId").val() == "") $("#rowId").val("1");
		$("#gridList1").jqGrid("setSelection", $("#rowId").val());
	}
	, function(rowid, status, e) {
		fn_searchFormMast(rowid);
	});

	commonMakeGrid("gridList2", "/record/incident/selectAccCarList.do", colModelDetl, false, function(data) {
		$("#gridList2").jqGrid("setSelection", "1");
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
	$("#gridList1").jqGrid("setGridHeight", $("#grid1").height()-30);

	$("#gridList2").jqGrid("setGridWidth", $("#grid2").width()-2);
	$("#gridList2").jqGrid("setGridHeight", $("#grid2").height()-30);
}

function fn_initClear() {
	document.searchForm.reset();
	$("#gridList1").jqGrid("clearGridData");
	$("#gridList2").jqGrid("clearGridData");

	$("#sTmpNo").focus();
}

function fn_search() {
	$("#gridList1").jqGrid("clearGridData");
	$("#gridList2").jqGrid("clearGridData");

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
	$("#sAccId").val(rowData.accId);
	$("#sTmpRaceNumber").val(rowData.tmpRaceNumber);

	commonAjax({ "sAccId": rowData.accId }, "/record/incident/selectIncdHistList.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;

		var formData = returnData.rows[0];

		$("#humanInjuryType").val(formData.humanInjuryTypeView);
		$("#autocarHumanSex").val(formData.autocarHumanSexView);
		$("#autocarHumanAge").val(formData.autocarHumanAge);
		$("#accDetailInfo").html(formData.accDetailInfo);
//		$("#accDetailInfo").val(formData.accDetailInfo);

		fn_searchDetl(formData.accId);
	});
}

function fn_searchDetl(accId) {
	$("#gridList2").jqGrid("clearGridData");

	var searchData = {
		sAccId: accId
	};
	$("#gridList2").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
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

	var url = "/record/incident/selectIncdHistExcelList.do";
	$("#searchForm").attr("action", url);
	$("#searchForm").submit();
}

function fn_report() {
	var url = "/record/incident/selectIncdHistReport.do";
	$("#searchForm").attr("action", url);
	$("#searchForm").submit();
}

function fn_report_new() {
	var oReport = GetfnParamSet();
	oReport.rptname = "incdReport";
	oReport.param("DRV_NO").value = $("#sTmpRaceNumber").val();
	oReport.param("ACC_ID").value = $("#sAccId").val();
	oReport.open();
}
</script>
</head>

<body class="default" style="min-width: 1260px; min-height: 660px;">
<div class="wrap p-20 h-100">
	<div class="float_left w100p d posi_r">
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
		</div> -->
	</div>

	<div class="box_search lay-boxItem lay-item--full grids__col-12 mt-10 form-wrap ml-0">
		<form id="searchForm" name="searchForm" method="post">
			<input type="hidden" id="excelFileNm" name="excelFileNm" value="">
			<input type="hidden" id="columnsNm" name="columnsNm" value="">
			<input type="hidden" id="datafield" name="datafield" value="">
			<input type="hidden" id="sAccId" name="sAccId" value="">
			<input type="hidden" id="sTmpRaceNumber" name="sTmpRaceNumber" value="">

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
					<span class="tit el-txt fw-500">사고일시</span>
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
	
	<div class="lay-boxItem lay-item--full grids__col-12 m-0" style="overflow: auto;height:calc(100% - 90px);">
		<div class="boxItem__inner h-100">
			<div class="d-flex flex-wrap h-100">
			
				<div id="grid1" class="float_left w100p ov-auto-y ov-hidden-x" style="height: 50%;padding:10px;border:1px solid #ebeef2;border-radius:3px;">
					<table id="gridList1" class="word_b"></table>
				</div>
				
				<div class="float_left w100p ov-auto-y ov-hidden-x" style="height: 50%; margin-top: 16px;border: 1px solid #ebeef2; border-radius: 3px; padding: 10px;">
					<p class="float_left w100p el-txt-7" style="font-weight: bold;">▶ 사고차량 정보</p>
			
					<div id="form1" class="float_left form_box mt-10 h-100 ov-auto-y ov-hidden-x" style="width: calc(50% - 5px); padding:10px;border:1px solid #ebeef2;border-radius:3px;">
						<form id="detailForm" name="detailForm" method="post">
							<input type="text" style="display: none;" id="rowId" name="rowId" value=""/>
							<div class="el-table-wrap">
								<table class="el-table  el-table--row el-table--approve el-table--approveDetail">
									<caption></caption>
									<colgroup>
										<col width="20%" />
										<col width="*%" />
									</colgroup>
									<tbody>
										<tr>
											<th>자율주행차 인적피해</th>
											<td>
												<input type="text" style="width: 100%; height: 34px;border:1px solid #d5dde7;font-size:0.875rem;" id="humanInjuryType" name="humanInjuryType" value="" caption="인적피해" required="required"/>
											</td>
										</tr>
										<tr>
											<th>자율주행차 성별</th>
											<td><input type="text" style="width: 100%; height: 34px;border:1px solid #d5dde7;font-size:0.875rem;" id="autocarHumanSex" name="autocarHumanSex" value="" caption="성별" required="required"/></td>
										</tr>
										<tr>
											<th>자율주행차 나이</th>
											<td><input type="text" style="width: 100%; height: 34px;border:1px solid #d5dde7;font-size:0.875rem;" id="autocarHumanAge" name="autocarHumanAge" value="" caption="나이" required="required"/></td>
										</tr>
										<tr>
											<th style="height: 200px;">사고상세묘사</th>
											<td>
												<div id="accDetailInfo"></div>
											</td>
				 							<!--<td><textarea style="width: 300px; height: 45px;" id="accDetailInfo" name="accDetailInfo" caption="사고상세묘사"></textarea></td>-->
										</tr>
									</tbody>
								</table>
							</div>
						</form>
					</div>
			
					<div id="grid2" class="float_left mt-10 h-100 ov-auto-y ov-hidden-x" style="width: calc(50% - 5px); border: 1px solid #ebeef2; border-radius: 3px; padding: 10px;margin-left: 10px;">
						<div id="grid2" class="float_left w100p" style="">
							<table id="gridList2" class="word_b"></table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


</div>
</body>
</html>
