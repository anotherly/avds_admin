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
	{ label: '사고ID',		name: 'accId',						hidden: true },
	{ label: '임시운행등록번호', name: 'tmpRaceNumber',				width: 120,	align: "center" },
	{ label: '임시운행기관',		name: 'tmpRaceAgency',				width: 150 },
	{ label: '사고일시',			name: 'accDateView',				width: 120,	align: "center" },
	{ label: '등록일시',		name: 'regDateView',				width: 120,	align: "center" },
	{ label: '장소',			name: 'place',						width: 200 }
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
}

function fn_initClear() {
	document.searchForm.reset();
	$("#gridList1").jqGrid("clearGridData");

	$("#sTmpNo").focus();
}

function fn_search() {
	$("#gridList1").jqGrid("clearGridData");

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

	commonAjax({ "sAccId": rowData.accId }, "/record/incident/selectIncdHistList.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;

		var formData = returnData.rows[0];

		$("#weatherView").html(formData.weatherView);
		$("#roadSituationView").html(formData.roadSituationView);
		$("#roadTypeCdView").html(formData.roadTypeCdView);
		$("#autocarDrivingModeView").html(formData.autocarDrivingModeView);
		$("#autocarDrivingStatusCdView").html(formData.autocarDrivingStatusCdView);
		$("#autocarSpeed").html(formData.autocarSpeed);
		$("#autocarRideNumber").html(formData.autocarRideNumber);
		$("#autocarLoadVol").html(formData.autocarLoadVol);
		$("#autocarDamageView").html(formData.autocarDamageView);
		$("#coldiff").html(formData.coldiff);
		// $("#humanInjuryType").html(formData.humanInjuryTypeView);
		// $("#autocarHumanSex").html(formData.autocarHumanSexView);
		// $("#autocarHumanAge").html(formData.autocarHumanAge);
		$("#accDetailInfo").html(formData.accDetailInfo);

	});

	commonAjax({ "sAccId": rowData.accId, "sDrvNo": rowData.tmpRaceNumber }, "/record/video/selectAccVideoList.do", function(returnData, textStatus, jqXHR) {

		if (returnData.rows.length == 0) {
			$("#movie1").attr("src", "");
			$("#movie1").get(0).play();
			$("#movie2").attr("src", "");
			$("#movie2").get(0).play();
			$("#movie3").attr("src", "");
			$("#movie3").get(0).play();
			$("#movie4").attr("src", "");
			$("#movie4").get(0).play();
		}

		for(var i=0; i < 4; i++) {
			var cnt = i+1;
			var path = "/upload/incd/";
			if(returnData.rows[i] == null) {
				$("#movie"+cnt).attr("src", "");
				$("#movie"+cnt).get(0).play();
			} else {
				var formData = returnData.rows[i];
				var move_file = path + formData.drivingVideoFile;

				$("#movie"+cnt).attr("src", move_file);
				$("#movie"+cnt).get(0).play();
			}
//$("#movie"+cnt).get(0).stop();
//$("#movie"+cnt).get(0).currentTime();

		}
	});
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

	var url = "/record/video/selectIncdVideoExcelList.do";
	$("#searchForm").attr("action", url);
	$("#searchForm").submit();
}

</script>
</head>

<body class="default" style="min-width: 1260px; min-height: 660px;">
<div class="wrap p-20 h-100">
	<div class="float_left w100p e posi_r">
		<div class="cont_tit2 el-box-tit el-depth-2 el-weight-5">◎ <%=java.net.URLDecoder.decode(menuNm, "UTF-8")%></div>

		<!--<div class="contBtn1">
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
				</div>
			</div>
			
		</form>
	</div>


	<div class="lay-boxItem lay-item--full grids__col-12 m-0" style="overflow: auto;height:calc(100% - 90px);">
		<div class="boxItem__inner h-100">
			<div class="d-flex flex-wrap h-100">
				<div class="float_left w100p" style="width: 47%; height: 100%">
			
					<div id="grid1" class="float_left ov-auto-y ov-hidden-x" style="width: 100%; height: 50%; border: 1px solid #ebeef2;  border-radius: 3px; background: #fff; padding: 10px;">
						<table id="gridList1" class="word_b"></table>
					</div>
			
					<div id="form1" class="form_box mt-10" style="overflow:auto;width: 100%; height: calc(50% - 10px);border: 1px solid #ebeef2;  border-radius: 3px;padding:10px;">
						<form id="detailForm" name="detailForm" method="post">
							<input type="text" style="display: none;" id="rowId" name="rowId" value=""/>
			
							<div class="el-table-wrap ov-auto-y ov-hidden-x">
								<table class="el-table  el-table--row el-table--approve el-table--approveDetail word_b">
									<caption></caption>
									<colgroup>
										<col width="20%" />
										<col width="30%" />
										<col width="20%" />
										<col width="30%" />
									</colgroup>
									<tbody>
									<tr>
										<th>기상상황</th>
										<td><div id="weatherView"></div></td>
										<th>도로상황</th>
										<td><div id="roadSituationView"></div></td>
									</tr>
									<tr>
										<th>도로유형코드</th>
										<td><div id="roadTypeCdView"></div></td>
										<th>주행모드</th>
										<td><div id="autocarDrivingModeView"></div></td>
									</tr>
									<tr>
										<th>주행상태</th>
										<td><div id="autocarDrivingStatusCdView"></div></td>
										<th>운행속도</th>
										<td><div id="autocarSpeed"></div></td>
									</tr>
									<tr>
										<th>승차인원</th>
										<td><div id="autocarRideNumber"></div></td>
										<th>적재량</th>
										<td><div id="autocarLoadVol"></div></td>
									</tr>
									<tr>
										<th>파손정도</th>
										<td><div id="autocarDamageView"></div></td>
										<th>등록기한 경과</th>
										<td><div id="coldiff"></div></td>
									</tr>
									<tr>
										<th style="height: 150px;">사고상세묘사</th>
										<td colspan="3">
											<div id="accDetailInfo"></div>
										</td>
									</tr>
								</tbody>
								</table>
							</div>
						</form>
					</div>
				</div>
			
				<div class="h-100 ov-auto" style="width: calc(53% - 10px); float: left;  border: 1px solid #ebeef2; border-radius: 3px; background: #fff; padding: 10px; margin-left: 10px;">
					<p class="w100p el-txt-7" style="font-weight: bold;">▶ mp4, mpeg 영상만 재생 됩니다.(avi 영상 재생 안됨)</p>
			
					<div class="mt-10 w100p h-100">
						<table class="table1" style="width: 100%; height: 100%;">
							<tr align="center">
								<td>
									<video id="movie1" src="" width="395" height="305" muted controls autoplay preload="auto">
										<source src="" type='video/mp4; codecs="avc1.42E01E, mp4a.40.2"'>
										<source src="" type='video/ogg; codecs="theora, vorbis"'>
										<source src="" type='video/webm; codecs="vp8, vorbis"'>
										<source src="" type='video/avi; codecs="MEncoder'>
										<p> 현재 사용하고 있는 브라우저는 비디오 태그를 지원하지 않습니다.(대체 콘텐츠) </p>
									</video>
								</td>
								<td>
									<video id="movie2" src="" width="395" height="305" muted controls autoplay preload="auto">
										<source src="" type='video/mp4; codecs="avc1.42E01E, mp4a.40.2"'>
										<source src="" type='video/ogg; codecs="theora, vorbis"'>
										<source src="" type='video/webm; codecs="vp8, vorbis"'>
										<source src="" type='video/avi; codecs="MEncoder'>
										<p> 현재 사용하고 있는 브라우저는 비디오 태그를 지원하지 않습니다.(대체 콘텐츠) </p>
									</video>
								</td>
							</tr>
							<tr align="center">
								<td>
									<video id="movie3" src="" width="395" height="305" muted controls autoplay preload="auto">
										<source src="" type='video/mp4; codecs="avc1.42E01E, mp4a.40.2"'>
										<source src="" type='video/ogg; codecs="theora, vorbis"'>
										<source src="" type='video/webm; codecs="vp8, vorbis"'>
										<source src="" type='video/avi; codecs="MEncoder'>
										<p> 현재 사용하고 있는 브라우저는 비디오 태그를 지원하지 않습니다.(대체 콘텐츠) </p>
									</video>
								</td>
								<td>
									<video id="movie4" src="" width="395" height="305" muted controls autoplay preload="auto">
										<source src="" type='video/mp4; codecs="avc1.42E01E, mp4a.40.2"'>
										<source src="" type='video/ogg; codecs="theora, vorbis"'>
										<source src="" type='video/webm; codecs="vp8, vorbis"'>
										<source src="" type='video/avi; codecs="MEncoder'>
										<p> 현재 사용하고 있는 브라우저는 비디오 태그를 지원하지 않습니다.(대체 콘텐츠) </p>
									</video>
								</td>
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