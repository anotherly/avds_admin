<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resource/css/ux-admin.css">
    <link rel="stylesheet" href="resource/css/main.css">
    <script type="text/javascript" src="resource/js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="resource/js/lib/simplebar.js"></script>
    <script type="text/javascript" src="resource/js/lib/isotope.pkgd.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script type="text/javascript" src="resource/js/main.js"></script>
    <title>자율주행 데이터 공유센터</title>
</head>
	<body>
		        <section class="container">
		            <div class="container__inner">
		                <div class="content">
		                    <div class="lnb-wrap">
		                        <div class="lnb__cont" id="leftMenu">
		                            <h3 class="lnb__cont__tit el-tit-3 el-weight-5">시스템관리</h3>
		                            <ul class="lnb__list">
		                                <li class="lnb__item">
		                                    <a href="javascript:void(0)">기본정보</a>
		                                    <ul class="ui-listUl ui-listUl--bar">
		                                        <li>
		                                            <a href="">test</a>
		                                        </li>
		                                        <li>
		                                            <a href="">test</a>
		                                        </li>
		                                    </ul>
		                                </li>
		                                <li class="lnb__item">
		                                    <a href="javascript:void(0)">웹사이트 관리</a>
		                                    <ul class="ui-listUl ui-listUl--bar">
		                                        <li>
		                                            <a href="">시스템로그 관리</a>
		                                        </li>
		                                        <li>
		                                            <a href="">작업로그 관리</a>
		                                        </li>
		                                        <li>
		                                            <a href="">접속로그 관리</a>
		                                        </li>
		                                        <li>
		                                            <a href="">공지사항</a>
		                                        </li>
		                                        <li>
		                                            <a href="">자율주행 공지사항</a>
		                                        </li>
		                                        <li>
		                                            <a href="">요청승인</a>
		                                        </li>
		                                        <li>
		                                            <a href="">협의체 등급관리</a>
		                                        </li>
		                                        <li>
		                                            <a href="">권한관리</a>
		                                        </li>
		                                        <li>
		                                            <a href="">메뉴관리</a>
		                                        </li>
		                                        <li>
		                                            <a href="">역할관리</a>
		                                        </li>
		                                        <li>
		                                            <a href="">OpenApi관리</a>
		                                        </li>
		                                    </ul>
		                                </li>
		                            </ul>
		                        </div>
		                        <a href="" class="lnb__logo">
		                            <img src="new/resource/image/common/img/img-logo--foot.png" alt="TS 한국교통안전공단">
		                        </a>
		                    </div>
		                    <div class="content__inner flex_box">
		                    	<div class="lay-box-wrap grids flex_wrap">
		                    		<div class="lay-boxItem lay-boxItem--index lay-item--784 grids__col-12 bgc--greenBlue">
		                                <div class="boxItem__inner boxItem-index">
		                                    <span class="boxItem__img">
		                                        <img src="new/resource/image/main/img-boxItem--index02.png" alt="">
		                                        <em class="boxItem__caption">거리</em>
		                                    </span>
		                                    <p class="boxItem__txt">
		                                        <span>총 주행</span>
		                                        <strong id="topArea2-1">
		                                            -
		                                            <em>KM</em>
		                                        </strong>
		
		                                    </p>
		                                    <p class="boxItem__txt">
		                                        <span>자율모드 주행</span>
		                                        <strong id="topArea2-2">
		                                            -
		                                            <em>KM</em>
		                                        </strong>
		
		                                    </p>
		                                    <p class="boxItem__txt">
		                                        <span>일반모드 주행</span>
		                                        <strong id="topArea2-3">
		                                            -
		                                            <em>KM</em>
		                                        </strong>
		
		                                    </p>
		                                </div>
		                            </div>
	                            	<div class="lay-boxItem lay-boxItem--index flex_1 grids__col-6 bgc--lightNavy">
		                                <div class="boxItem__inner boxItem-index">
		                                    <span class="boxItem__img">
		                                        <img src="new/resource/image/main/img-boxItem--index01.png" alt="">
		                                        <em class="boxItem__caption">임시운행</em>
		                                    </span>
		                                    <p class="boxItem__txt">
		                                        <span>허가대수</span>
		                                        <strong id="topArea1">
		                                            -
		                                            <em>대</em>
		                                        </strong>
		
		                                    </p>
		                                </div>
		                            </div>
		                            <div class="lay-boxItem lay-boxItem--index flex_1 grids__col-6 bgc--steelBlue">
		                                <div class="boxItem__inner boxItem-index">
		                                    <span class="boxItem__img">
		                                        <img src="new/resource/image/main/img-boxItem--index03.png" alt="">
		                                        <em class="boxItem__caption">데이터</em>
		                                    </span>
		                                    <p class="boxItem__txt">
		                                        <span>용량</span>
		                                        <strong id="topArea4">
		                                            -
		                                            <em>GB</em>
		                                        </strong>
		
		                                    </p>
		                                    <!-- <p class="boxItem__txt">
		                                        <span>건수</span>
		                                        <strong id="topArea3">
		                                            -
		                                            <em>건</em>
		                                        </strong>
		
		                                    </p> -->
		                                    
		                                </div>
		                            </div>
		                            <div class="lay-boxItem lay-item--775 grids__col-12">
		                                <div class="boxItem__inner">
		                                    <h5 class="boxItem__tit">
		                                        데이터 사용 현황
		                                        <button type="button" class="boxItem__reset" onClick = "fn_search_Data();' ">
		                                            <img src="new/resource/image/common/icon/icon-reset.png" alt="">
		                                        </button>
		                                    </h5>
		                                    <div class="lay-table-wrap">
		                                        <div class="lay-table__inner">
		                                            <div class="el-table-wrap">
		                                                <table id="gridListData"
		                                                    class="el-table el-table--col el-table--dataUse el-table--dataList mt-10">
		                                                    <caption>데이터 사용 현황 테이블 지난주,이번주</caption>
			                                                <colgroup>
			                                                    <col style="width:25%" />
			                                                    <col style="width:25%" />
			                                                    <col style="width:25%" />
			                                                    <col style="width:25%" />
			                                                </colgroup>
			                                                <thead>
			                                                    <tr>
			                                                        <th scope="col" colspan="2">지난 주</th>
			                                                        <th scope="col" colspan="2">이번 주</th>
			                                                    </tr>
			                                                    <tr>
			                                                        <th scope="col">다운로드(GB)</th>
			                                                        <th scope="col">업로드(GB)</th>
			                                                        <th scope="col">다운로드(GB)</th>
			                                                        <th scope="col">업로드(GB)</th>
			                                                    </tr>
			                                                </thead>
			                                                <tbody>
			                                                    <tr>
			                                                        <td>-</td>
			                                                        <td>-</td>
			                                                        <td>-</td>
			                                                        <td>-</td>
			                                                    </tr>
			                                                </tbody>
			                                            </table>
			                                        </div>
			                                    </div>
			                                </div>
			                                <div class="lay-table-wrap mt-10">
			                                    <div class="lay-table__inner">
			                                        <div class="el-table-wrap ui-scroller ui-table-fixHead"
			                                            data-simplebar-auto-hide="false" style="max-height: 500px;">
			                                            <table id="gridListDataList"
			                                                class="el-table el-table--col el-table--dataUse el-table--dataDetail">
			                                                <caption>데이터 사용 현황 테이블 순번, 사용자ID, 업로드(GB)</caption>
			                                                <colgroup>
			                                                    <col style="width:25%" />
			                                                    <col style="width:auto" />
			                                                    <col style="width:25%" />
			                                                </colgroup>
			                                                <thead>
			                                                    <tr>
			                                                        <th scope="col">순번</th>
			                                                        <th scope="col">사용자 ID</th>
			                                                        <th scope="col">업로드(GB)</th>
			                                                    </tr>
			                                                </thead>
			                                                <tbody>
			                                                    <tr>
			                                                        <td>-</td>
			                                                        <td>-</td>
			                                                        <td>-</td>
			                                                    </tr>
			                                                </tbody>
			                                            </table>
			                                        </div>
			                                    </div>
			                                </div>
			                            </div>
			                        </div>
		                    	</div>
		                        <div class="lay-box-wrap grids flex_wrap">
			                        <div class="lay-boxItem grids__col-12 lay-item--775">
		                                <div class="boxItem__inner">
		                                    <h5 class="boxItem__tit">
		                                        자율주행 플랫폼 공유
		                                        <button type="button" class="boxItem__reset">
		                                            <img src="resource/image/common/icon/icon-reset.png" alt="">
		                                        </button>
		                                    </h5>
		                                    <div class="lay-table-wrap">
		                                        <div class="lay-table__inner">
		                                            <div class="calendar-wrap mb-80">
		                                                <div class="calWrap mt_20">
		                                                    <div class="controlDate">
		                                                        <button type="button" class="datePrev" title="이전달로 이동">
		                                                            <img src="resource/image/common/icon/icon-calendar__prev.jpg" alt=""  onclick="prevCal();">
		                                                        </button>
		                                                        <div class="">
			                                                        <span class="year_mon" id="curYear"></span>
				                                            		<span class="year_mon" id="curMon"></span>
				                                            	</div>
		                                                        <button type="button" class="dateNext" title="다음달로 이동">
		                                                            <img src="resource/image/common/icon/icon-calendar__next.jpg" alt=""  onclick="nextCal();">
		                                                        </button>
		                                                    </div>
		                                                    <div class="calendar-info">
		                                                        <div class="calendar-info__inner">
		<!--                                                             <p class="res-status">예약현황: 총 <span class="totRecodeCnt" id="totCnt"></span></p> -->
		                                                            <div class="calendar-badge">
		                                                                <div class="calendar-badge__inner2">
		                                                                    <p class="calendar-badge__list calendar-badge__list--deepblue"><span>예</span>예약가능</p>
		                                                                    <p class="calendar-badge__list calendar-badge__list--green ml_15"><span>불</span>예약신청</p>
		                                                                    <p class="calendar-badge__list calendar-badge__list--red ml_15"><span>불</span>예약불가</p>
		                                                                </div>
		                                                            </div>
		                                                        </div>
		                                                    </div>
		                                                    
		                                                    
		                                                    <div class="calendarSt mt_30 forIE" id="cal30"> 
		                                                    </div>
		 	                                			</div>
		                                            </div>
		                                        </div>
		                                    </div>
		                                </div>
	                           	 	</div>
		                        <!-- <div class="lay-boxItem lay-item--775 grids__col-6">
		                            <div class="boxItem__inner">
		                                <h5 class="boxItem__tit">
		                                    통계 현황
		                                    <button type="button" class="boxItem__reset">
		                                        <img src="new/resource/image/common/icon/icon-reset.png" alt="">
		                                    </button>
		                                </h5>
		                                <div class="lay-box-wrap">
		                                    <div class="lay-box__inner" style="width:100%;">
		                                        <div id="chart_area" style="width:100%;"></div>
		                                    </div>
		                                </div>
		                            </div>
		                        </div>
		                        <div class="lay-boxItem lay-item--775 grids__col-6">
		                            <div class="boxItem__inner">
		                                <h5 class="boxItem__tit">
		                                    데이터베이스 사용 현황
		                                    <button type="button" class="boxItem__reset">
		                                        <img src="new/resource/image/common/icon/icon-reset.png" alt="">
		                                    </button>
		                                </h5>
		                                <div class="lay-box-wrap">
		                                    <div class="lay-box__inner" style="width:100%;">
		                                        <div id="chart_db" style="width:100%;"></div>
		                                    </div>
		                                </div>
		                            </div>
		                        </div> -->
								<div class="el-tab-wrap">
		                            <div class="el-tab__inner">
		                                <div class="el-tab__link" id="tabs">
		                                    <!-- <ul>
		                                        <li class="is-open" data-id="tab-link--1">
		                                            <button type="button">
		                                                권한관리
		                                            </button>
		                                            <span>
		                                                <img src="../../resource/image/common/icon/icon-close-s.png" alt="">
		                                            </span>
		                                        </li>
		                                        <li data-id="tab-link--2">
		                                            <button type="button" class="">
		                                                요청승인
		                                            </button>
		                                            <span>
		                                                <img src="../../resource/image/common/icon/icon-close-s.png" alt="">
		                                            </span>
		                                        </li>
		                                        <li data-id="tab-link--3">
		                                            <button type="button" class="">
		                                                메뉴관리
		                                            </button>
		                                            <span>
		                                                <img src="../../resource/image/common/icon/icon-close-s.png" alt="">
		                                            </span>
		                                        </li>
		                                    </ul> -->
		                                    
		                                </div>
			                    	</div>
			                	</div>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </section>
    <footer></footer>
</body>

</html>
<script type="text/javascript">

var CDate = new Date(); 
var today = new Date();
var selectCk = 0;
var sec = 0; // interval

var colModel_data = [
	{ label: '다운로드', name: 'bu', align: "center" },
  { label: '업로드', name: 'bd', align: "center" },
  { label: '다운로드', name: 'nu', align: "center" },
  { label: '업로드', name: 'nd', align: "center" }
];
var colModel_data_list = [
	{ label: '순번', name: 'rnum', align: "center" },
  { label: '사용자ID',	name: 'regId', align: "center" },
  { label: '업로드건수', name: 'upCnt', align: "center" }
];
var colModel_acc = [
	{ label: '자율모드', name: 'bu', align: "center" },
  { label: '일반모드', name: 'bd', align: "center" },
  { label: '자율모드', name: 'nu', align: "center" },
  { label: '일반모드', name: 'nd', align: "center" }
];
var colModel_acc_list = [
	{ label: '순번', name: 'rnum', align: "center" },
  { label: '기관',	name: 'regId', align: "center" },
  { label: '사고발생건수', name: 'upCnt', align: "center" }
];

$(window).resize(function(event) {
	if (this == event.target) {
		fn_operCnt();
		fn_drivingInfo();
		fn_dataInfo();

		fn_init_Data();
		fn_init_Acc();
		fn_mkeChart();
		fn_mkeDBChart();
	}
});

$(document).ready(function() {
	
	  fn_selectReserve();

	// 구글차트 init
// 	google.charts.load("current", {packages:["corechart"]});
	

	fn_operCnt();
	fn_drivingInfo();
	fn_dataInfo();

	fn_mkeGrid_Data();
	fn_mkeGrid_Acc();

	//fn_mkeChart();
	//fn_mkeDBChart();

	refresh();
	timer_manager();
});

function timer_manager() {

	if(sec === 300) {
		sec = 0;
		fn_operCnt();
		fn_drivingInfo();
		fn_dataInfo();
		fn_mkeGrid_Data();

		fn_search_Data();
		fn_search_Acc();

// 		fn_mkeChart();
// 		fn_mkeDBChart();
	}
	else {
		sec += 1;
	}
	// 10초 간격 재호출
	setTimeout(timer_manager,1000);
}

function fn_operCnt() {
	commonAjax({}, "/main/dashboard/selectTempOperTotCnt.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;
		$("#topArea1").html(returnData.rows[0]+'<em>대</em>');
	});
}

function fn_drivingInfo() {
	commonAjax({}, "/main/dashboard/selectDrivingInfo.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;
		var rd = returnData.rows[0];
		/* var text = rd.totalView + ' / ' + rd.autoView + ' / ' + rd.nomalView; */
		$("#topArea2-1").html(rd.totalView+'<em>KM</em>');
		$("#topArea2-2").html(rd.autoView+'<em>KM</em>');
		$("#topArea2-3").html(rd.nomalView+'<em>KM</em>');
	});
}

function fn_dataInfo() {
	commonAjax({}, "/main/dashboard/selectDataTotCnt.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;
		$("#topArea3").html(returnData.rows[0]+'<em>건</em>');
	});
	commonAjax({}, "/main/dashboard/selectDataTotVolume.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;
		$("#topArea4").html(returnData.rows[0]+'<em>GB</em>');
	});
}

function fn_mkeGrid_Data() {
	// 카운트
	commonAjax({}, "/main/dashboard/selectUpDnStatus.do", function(returnData, textStatus, jqXHR) {
		$("#gridListData > tbody").empty();
		if (returnData.rows.length == 0) {
			var h = $(".ui-jqgrid-bdiv").height()-3;
			$("#gridListData").append('<tr><td colspan="4" style="text-align:center; height: 100%; border: none;" title="no data">검색된 결과가 없습니다.</td></tr>');
			return;
		}
		$("#gridListData > tbody").append('<tr><td>'+returnData.rows[0].bu+'</td><td>'+returnData.rows[0].bd+'</td><td>'+returnData.rows[0].nu+'</td><td>'+returnData.rows[0].nd+'</td></tr>');
	});
	/* commonMakeGrid("gridListData", "/main/dashboard/selectUpDnStatus.do", colModel_data, true
		, function(data) {
			//alert(data.rows[0].bu);
			}
		, function(rowid, status, e) {
		}
	); */
	/* $("#gridListData").jqGrid('setGroupHeaders', {
		useColSpanStyle: true,
			groupHeaders:[
				{ startColumnName: colModel_data[0].name, numberOfColumns: 2, titleText: '지난 주' },
				{ startColumnName: colModel_data[2].name, numberOfColumns: 2, titleText: '이번 주' }
		  ]
  }); */
	// 리스트
	commonAjax({}, "/main/dashboard/selectUploadCnt.do", function(returnData, textStatus, jqXHR) {
		$("#gridListDataList > tbody").empty();
		if (returnData.rows.length == 0) {
			var h = $(".ui-jqgrid-bdiv").height()-3;
			$("#gridListDataList").append('<tr><td colspan="3" style="text-align:center; height: 100%; border: none;" title="no data">검색된 결과가 없습니다.</td></tr>');
			return;
		}
		for(var i = 0; i < returnData.rows.length; i++) {
			$("#gridListDataList > tbody").append('<tr><td>'+returnData.rows[i].rnum+'</td><td>'+returnData.rows[i].regId+'</td><td>'+returnData.rows[i].fileSize+'</td></tr>');
// 			$("#gridListDataList > tbody").append('<tr><td>'+returnData.rows[i].rnum+'</td><td>'+returnData.rows[i].regId+'</td><td>'+returnData.rows[i].upCnt+'</td></tr>');
		}
	});
	/* commonMakeGrid("gridListDataList", "/main/dashboard/selectUploadCnt.do", colModel_data_list, true
		, function(data) {
			}
		, function(rowid, status, e) {
		}
	); */
	fn_init_Data();
	fn_search_Data();
}
function fn_mkeGrid_Acc() {
	// 카운트
	commonAjax({}, "/main/dashboard/selectAccStatus.do", function(returnData, textStatus, jqXHR) {
		$("#gridListAcc > tbody").empty();
		if (returnData.rows.length == 0) {
			var h = $(".ui-jqgrid-bdiv").height()-3;
			$("#gridListAcc").append('<tr><td colspan="4" style="text-align:center; height: '+h+'px; border: none;" title="no data">검색된 결과가 없습니다.</td></tr>');
			return;
		}
		$("#gridListAcc > tbody").append('<tr><td>'+returnData.rows[0].bu+'</td><td>'+returnData.rows[0].bd+'</td><td>'+returnData.rows[0].nu+'</td><td>'+returnData.rows[0].nd+'</td></tr>');
	});
	/* commonMakeGrid("gridListAcc", "/main/dashboard/selectAccStatus.do", colModel_acc, true
		, function(data) {
			}
		, function(rowid, status, e) {
		}
	);
	$("#gridListAcc").jqGrid('setGroupHeaders', {
		useColSpanStyle: true,
			groupHeaders:[
				{ startColumnName: colModel_data[0].name, numberOfColumns: 2, titleText: '지난 주' },
				{ startColumnName: colModel_data[2].name, numberOfColumns: 2, titleText: '이번 주' }
		  ]
  }); */
	// 리스트
	commonAjax({}, "/main/dashboard/selectAccList.do", function(returnData, textStatus, jqXHR) {
		$("#gridListAccList > tbody").empty();
		if (returnData.rows.length == 0) {
			var h = $(".ui-jqgrid-bdiv").height()-3;
			$("#gridListAccList").append('<tr><td colspan="3" style="text-align:center; height: '+h+'px; border: none;" title="no data">검색된 결과가 없습니다.</td></tr>');
			return;
		}
		for(var i = 0; i < returnData.rows.length; i++) {
			$("#gridListAccList > tbody").append('<tr><td>'+returnData.rows[i].rnum+'</td><td>'+returnData.rows[i].regId+'</td><td>'+returnData.rows[i].upCnt+'</td></tr>');
		}
	});
	/* commonMakeGrid("gridListAccList", "/main/dashboard/selectAccList.do", colModel_acc_list, true
		, function(data) {
			}
		, function(rowid, status, e) {
		}
	); */
	fn_init_Acc();
	fn_search_Acc();
}

function fn_search_Data() {
	$("#gridListData").jqGrid("clearGridData");
	$('#gridListData').jqGrid('setGridParam', {datatype: 'json', postData : ''}).trigger('reloadGrid');
	$("#gridListDataList").jqGrid("clearGridData");
	$('#gridListDataList').jqGrid('setGridParam', {datatype: 'json', postData : ''}).trigger('reloadGrid');
}
function fn_search_Acc() {
	$("#gridListAcc").jqGrid("clearGridData");
	$('#gridListAcc').jqGrid('setGridParam', {datatype: 'json', postData : ''}).trigger('reloadGrid');
	$("#gridListAccList").jqGrid("clearGridData");
	$('#gridListAccList').jqGrid('setGridParam', {datatype: 'json', postData : ''}).trigger('reloadGrid');
}

function fn_init_Data() {
	$("#gridListData").jqGrid("setGridWidth", $("#grid1").width()-2);
	$("#gridListData").jqGrid("setGridHeight", '26px');
	$("#gridListDataList").jqGrid("setGridWidth", $("#grid1").width()-2);
	$("#gridListDataList").jqGrid("setGridHeight", $("#grid1").height()-145);
}

function fn_init_Acc() {
	$("#gridListAcc").jqGrid("setGridWidth", $("#grid2").width()-2);
	$("#gridListAcc").jqGrid("setGridHeight", '26px');
	$("#gridListAccList").jqGrid("setGridWidth", $("#grid2").width()-2);
	$("#gridListAccList").jqGrid("setGridHeight", $("#grid2").height()-145);
}

function fn_mkeChart() {
	commonAjax('', "/main/dashboard/selectChart.do", function(returnData, textStatus, jqXHR) {
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

function drawChart(inputData) {
	var arr = eval(inputData);
	if(arr == null) {
		return;
	} else {
		var chartData = new google.visualization.DataTable();
		chartData.addColumn('string', '기준월');
		chartData.addColumn('number', '업로드건수');
		chartData.addColumn('number', '다운로드건수');
		chartData.addColumn('number', '자율모드사고건수');
		chartData.addRows(arr.length);

		for(var i = 0; i < arr.length; i++) {

			var ana_m = arr[i].m;
			var upCnt = arr[i].upCnt;
			var dnCnt = arr[i].dnCnt;
			var accCnt = arr[i].accCnt;

			chartData.setValue(i, 0, ana_m);
			chartData.setValue(i, 1, upCnt);
			chartData.setValue(i, 2, dnCnt);
			chartData.setValue(i, 3, accCnt);

			var ana_m = null;
			var upCnt = null;
			var dnCnt = null;
			var accCnt = null;
		} //for문끝

		var options = {
			legend: 'top',
			legendTextStyle: {color:'#000',fontName: 'NanumGothic',fontSize: '12'},
			lineWidth: 5,
			colors: ['#009933', '#e7711b', '#6633ff'],
			// backgroundColor: '#334',
			chartArea: {left:50, width:'90%'}
		}
		var chart = new google.visualization.LineChart(document.getElementById('chart_area'));
		chart.draw(chartData, options);
		chartData = null;
		options = null;
		chart = null;
	};
	arr = null;
}

function fn_mkeDBChart() {
	commonAjax('', "/main/dashboard/selectDBStatus.do", function(returnData, textStatus, jqXHR) {
		var records = returnData.rows;
		if(records.length > 0) {
			$("#chart_db").empty();
			google.charts.setOnLoadCallback(function() { drawDBChart(records); });
		}
		else {
			$('#chart_db').html("<div id='chart_db' style='width:100%; height:100%;'><table style='width:100%; height:100%;'><tr><td style='width:100%; height:100%; text-align:center;'>데이터가 없습니다.</td></tr></table></div>");
		}
	});
}

function drawDBChart(inputData) {
	var arr = eval(inputData);
	if(arr == null) {
		return;
	} else {
		var chartData = new google.visualization.DataTable();
		chartData.addColumn('string', 'Tablespace');
		chartData.addColumn('number', '사용(GB)');
		chartData.addColumn('number', 'Free(GB)');
		chartData.addRows(arr.length);

		for(var i = 0; i < arr.length; i++) {

			var tablespaceName = arr[i].tablespaceName;
			var used = arr[i].used;
			var free = arr[i].free;
			var accCnt = arr[i].accCnt;

			chartData.setValue(i, 0, tablespaceName);
			chartData.setValue(i, 1, used);
			chartData.setValue(i, 2, free);

			var tablespaceName = null;
			var used = null;
			var free = null;
		} //for문끝

		var options_fullStacked = {
			isStacked: 'percent',
			legend: {position: 'top', maxLines: 3},
			hAxis: {
			 minValue: 0,
			 ticks: [0, .3, .6, .9, 1],
		 	},
			colors: ['#990000', '#1b4ee7'],
		 	chartArea: {left:160, width:'80%'}
		};
		var chartDb = new google.visualization.BarChart(document.getElementById('chart_db'));
		chartDb.draw(chartData, options_fullStacked);
		chartData = null;
		options_fullStacked = null;
		chartDb = null;
	};
	arr = null;
}

function fn_selectReserve(){
	  /* $.ajax( {
        type : "POST",
        dataType : "json",
        cache: false,
        contentType:"application/x-www-form-urlencoded;charset=utf-8",
        url : "/main/dashboard/SelectCarReserveList.do",
        data : {},
        success : function(data) {
      	  var result = data.resultList;
      	  console.log(result);
      	  buildcalendar(result);
        },
        error : function(data) {
        }
      }); */
	  
	  commonAjax('', "/main/dashboard/SelectCarReserveList.do", function(returnData, textStatus, jqXHR) {
			var records = returnData.rows;
			//if(records.length > 0) {
				buildcalendar(records)
			//}
		});
	  
}

function buildcalendar(dayReserve){
  	var htmlDates = ''; 
  	var htmlDays = ''; 
  	var prevLast = new Date(CDate.getFullYear(), CDate.getMonth(), 0); //지난 달의 마지막 날 
  	var thisFirst = new Date(CDate.getFullYear(), CDate.getMonth(), 1); //이번 달의 첫쨰 날
  	var thisLast = new Date(CDate.getFullYear(), CDate.getMonth() + 1, 0); //이번 달의 마지막 날
  	var dates = [];
  	
  	$("#curYear").html(CDate.getFullYear() + "년&nbsp;&nbsp;");
  	$("#curMon").html((CDate.getMonth() + 1) + "월");
  	
  	
  	if(thisFirst.getDay()!=0){ 
  		for(var i = 0; i < thisFirst.getDay(); i++){
  			dates.unshift(prevLast.getDate()-i); // 지난 달 날짜 채우기
  		} 
  	} 
  	for(var i = 1; i <= thisLast.getDate(); i++){
  			 dates.push(i); // 이번 달 날짜 채우기 
  	} 
  	for(var i = 1; i <= (13-thisLast.getDay()); i++){
  		// 다음 달 채우기 빈칸없앰
  		if(thisFirst.getDay() < thisLast.getDay()){
  			staticDay = 35;
  		}else if(thisFirst.getDay() > thisLast.getDay()){
  			staticDay = 42;
  		}else{
  			staticDay = 35;
  		}
  		dates.push(i); // 다음 달 날짜 채우기 (나머지 다 채운 다음 출력할 때 42개만 출력함)
  	}
  	
		htmlDates += "<div><p>일</p></div><div><p>월</p></div><div><p>화</p></div><div><p>수</p></div><div><p>목</p></div><div><p>금</p></div><div><p>토</p></div>"
			for(var i = 0; i < staticDay; i++){
				var year = CDate.getFullYear();
		  		//var pastMonth = ("0" + (CDate.getMonth())).slice(-2);
				var curMonth = ("0" + (1 + CDate.getMonth())).slice(-2);
				//var nextMonth = ("0" + (2 + CDate.getMonth())).slice(-2);
		  		//var pastDate = (year+pastMonth+("0" + dates[i]).slice(-2));
		  		var currentDate = (year+curMonth+("0" + dates[i]).slice(-2));
		  		//var nextDate = (year+nextMonth+("0" + dates[i]).slice(-2));		
		  		//var  reservationStatus  = []; // 예약상태 (0 : 예약, 1 : 취소, 2 : 예약완료)
		  		//var  reservationNumber = [];// 예약 순번
		  		/* var status = [];
		  		var addClass = [];
		  		var carCode = []; */
		  		if(i < thisFirst.getDay()){ // 지난 달 마지막 주
		  			htmlDates += '<div id="date_'+("0" + dates[i]).slice(-2)+'" class="dates linkCalendar" ><p>'+dates[i]+'</p>';
		  			htmlDates += '<div class="calendar-badge__inner">';
		  			htmlDates += '</div>'; 
		  			htmlDates += '</div>';
		  		}else if(i >= thisFirst.getDay() + thisLast.getDate()){// 다음 달 마지막주
					htmlDates += '<div id="date_'+("0" + dates[i]).slice(-2)+'" class="dates linkCalendar" ><p>'+dates[i]+'</p>';
		  			htmlDates += '<div class="calendar-badge__inner">';
		  			htmlDates += '</div>';
		  			htmlDates += '</div>';
		  		}else if(today.getDate()==dates[i] && today.getMonth()==CDate.getMonth() && today.getFullYear()==CDate.getFullYear()){ // 오늘
		  			htmlDates += '<div id="date_'+("0" + dates[i]).slice(-2)+'" class="dates linkCalendar today" ><p>'+dates[i]+'</p>';
		  			htmlDates += '<div class="calendar-badge__inner">';
		  			htmlDates += '<p class="calendar-badge__list calendar-badge__list--deepblue" id="sorentoP_'+("0" + dates[i]).slice(-2)+'"><span id="sorentoSpan_'+("0" + dates[i]).slice(-2)+'">예</span><a id="sorentoA_'+("0" + dates[i]).slice(-2)+'" href="javascript:detail_View(\''+currentDate+'\', \'쏘렌토\');">쏘렌토</a></p>';
		  			htmlDates += '<p class="calendar-badge__list calendar-badge__list--deepblue" id="santafeP_'+("0" + dates[i]).slice(-2)+'"><span id="santafeSpan_'+("0" + dates[i]).slice(-2)+'">예</span><a id="santafeA_'+("0" + dates[i]).slice(-2)+'" href="javascript:detail_View(\''+currentDate+'\', \'싼타페\');">싼타페</a></p>';
		  			htmlDates += '<p class="calendar-badge__list calendar-badge__list--deepblue" id="carnivalP_'+("0" + dates[i]).slice(-2)+'"><span id="carnivalSpan_'+("0" + dates[i]).slice(-2)+'">예</span><a id="carnivalA_'+("0" + dates[i]).slice(-2)+'" href="javascript:detail_View(\''+currentDate+'\', \'카니발\');">카니발</a></p>';
		  			htmlDates += '<p class="calendar-badge__list calendar-badge__list--deepblue" id="genesysP_'+("0" + dates[i]).slice(-2)+'"><span id="genesysSpan_'+("0" + dates[i]).slice(-2)+'">예</span><a id="genesysA_'+("0" + dates[i]).slice(-2)+'" href="javascript:detail_View(\''+currentDate+'\', \'제네시스G80\');">제네시스G80</a></p>';
		  			htmlDates += '</div>'; 
		  			htmlDates += '</div>'; 
		  		}else	{
		  			htmlDates += '<div id="date_'+("0" + dates[i]).slice(-2)+'" class="dates linkCalendar" ><p>'+dates[i]+'</p>';
		  			htmlDates += '<div class="calendar-badge__inner">';
		  			htmlDates += '<p class="calendar-badge__list calendar-badge__list--deepblue" id="sorentoP_'+("0" + dates[i]).slice(-2)+'"><span id="sorentoSpan_'+("0" + dates[i]).slice(-2)+'">예</span><a id="sorentoA_'+("0" + dates[i]).slice(-2)+'" href="javascript:fn_none();">쏘렌토</a></p>';
		  			htmlDates += '<p class="calendar-badge__list calendar-badge__list--deepblue" id="santafeP_'+("0" + dates[i]).slice(-2)+'"><span id="santafeSpan_'+("0" + dates[i]).slice(-2)+'">예</span><a id="santafeA_'+("0" + dates[i]).slice(-2)+'" href="javascript:fn_none();">싼타페</a></p>';
		  			htmlDates += '<p class="calendar-badge__list calendar-badge__list--deepblue" id="carnivalP_'+("0" + dates[i]).slice(-2)+'"><span id="carnivalSpan_'+("0" + dates[i]).slice(-2)+'">예</span><a id="carnivalA_'+("0" + dates[i]).slice(-2)+'" href="javascript:fn_none();">카니발</a></p>';
		  			htmlDates += '<p class="calendar-badge__list calendar-badge__list--deepblue" id="genesysP_'+("0" + dates[i]).slice(-2)+'"><span id="genesysSpan_'+("0" + dates[i]).slice(-2)+'">예</span><a id="genesysA_'+("0" + dates[i]).slice(-2)+'" href="javascript:fn_none();">제네시스G80</a></p>';
		  			htmlDates += '</div>'; 
		  			htmlDates += '</div>'; 
		  		}
			}
			$("#cal30").html(htmlDates);
			
			if(dayReserve.length > 0){
				for(var j=0; j<dayReserve.length; j++){
					var dateArr  = fn_dateStartToLast(dayReserve[j].rentDt, dayReserve[j].returnDt);
					 for(var dd=0; dd<dateArr.length; dd++){
			 			var redClass='calendar-badge__list calendar-badge__list--red';
			 			var greenClass='calendar-badge__list calendar-badge__list--green';
			 			var day = dateArr[dd].split('-');
						var currentDate = (year+curMonth+day[2]);
						dateArr[dd]= replaceAll(dateArr[dd], '-', '');
						if(currentDate === dateArr[dd]){
			 				if((dayReserve[j].rentCarCode == "쏘렌토") && (dayReserve[j].reservationStatus==2)){
			 					$('span#sorentoSpan_'+day[2]).text("불");		  						
								$('p#sorentoP_'+day[2]).attr('class', redClass);		  						
								$('a#sorentoA_'+day[2]).prop('href', 'javascript:detail_View("'+dayReserve[j].rentDt+'",'+dayReserve[j].reservationNumber+')');
							}else if((dayReserve[j].rentCarCode == "쏘렌토") && (dayReserve[j].reservationStatus==1)){
								$('span#sorentoSpan_'+day[2]).text("불");		  						
								$('p#sorentoP_'+day[2]).attr('class', greenClass);		  						
								$('a#sorentoA_'+day[2]).prop('href', 'javascript:detail_View("'+dayReserve[j].rentDt+'",'+dayReserve[j].reservationNumber+')');
							}
							if((dayReserve[j].rentCarCode == "싼타페") && (dayReserve[j].reservationStatus==2)){
								$('span#santafeSpan_'+day[2]).text("불");		  						
								$('p#santafeP_'+day[2]).attr('class', redClass);		  						
								$('a#santafeA_'+day[2]).prop('href', 'javascript:detail_View("'+dayReserve[j].rentDt+'",'+dayReserve[j].reservationNumber+')');
							}else if((dayReserve[j].rentCarCode == "싼타페") && (dayReserve[j].reservationStatus==1)){
								$('span#santafeSpan_'+day[2]).text("불");		  						
								$('p#santafeP_'+day[2]).attr('class', greenClass);		  						
								$('a#santafeA_'+day[2]).prop('href', 'javascript:detail_View("'+dayReserve[j].rentDt+'",'+dayReserve[j].reservationNumber+')');
							}
							if((dayReserve[j].rentCarCode == "카니발") && (dayReserve[j].reservationStatus==2)){
								$('span#carnivalSpan_'+day[2]).text("불");		  						
								$('p#carnivalP_'+day[2]).attr('class', redClass);		  						
								$('a#carnivalA_'+day[2]).prop('href', 'javascript:detail_View("'+dayReserve[j].rentDt+'",'+dayReserve[j].reservationNumber+')');
							}else if((dayReserve[j].rentCarCode == "카니발") && (dayReserve[j].reservationStatus==1)){
								$('span#carnivalSpan_'+day[2]).text("불");		  						
								$('p#carnivalP_'+day[2]).attr('class', greenClass);		  						
								$('a#carnivalA_'+day[2]).prop('href', 'javascript:detail_View("'+dayReserve[j].rentDt+'",'+dayReserve[j].reservationNumber+')');
							}
							if((dayReserve[j].rentCarCode == "제네시스G80") && (dayReserve[j].reservationStatus==2)){
								$('span#genesysSpan_'+day[2]).text("불");		  						
								$('p#genesysP_'+day[2]).attr('class', redClass);		  						
								$('a#genesysA_'+day[2]).prop('href', 'javascript:detail_View("'+dayReserve[j].rentDt+'",'+dayReserve[j].reservationNumber+')');
							}else if((dayReserve[j].rentCarCode == "제네시스G80") && (dayReserve[j].reservationStatus==1)){
								$('span#genesysSpan_'+day[2]).text("불");		  						
								$('p#genesysP_'+day[2]).attr('class', greenClass);		  						
								$('a#genesysA_'+day[2]).prop('href', 'javascript:detail_View("'+dayReserve[j].rentDt+'",'+dayReserve[j].reservationNumber+')');
							}
							
						}
						
					}
				}
			}
	
	
/*   			htmlDates += '<div id="date_'+("0" + dates[i]).slice(-2)+'" class="dates linkCalendar" ><p>'+dates[i]+'</p>';
  			htmlDates += '<div class="calendar-badge__inner">';
  			if(carCode[i] == "쏘렌토"){ 				
  				htmlDates += '<p class="calendar-badge__list calendar-badge__list--'+addClass[i]+'">'+status[i]+'<a href="javascript:detail_View('+reservationNumber[i]+');">쏘렌토</a></p>';
  			}else{
  				htmlDates += '<p class="calendar-badge__list calendar-badge__list--deepblue"><span>예</span><a href="javascript:detail_View(\''+currentDate+'\','+dates[i]+', \'쏘렌토\');">쏘렌토</a></p>';
  			}
  			if(carCode[i] == "싼타페"){
  				htmlDates += '<p class="calendar-badge__list calendar-badge__list--'+addClass[i]+'">'+status[i]+'<a href="javascript:detail_View('+reservationNumber[i]+');">싼타페</a></p>';
  			}else{
  				htmlDates += '<p class="calendar-badge__list calendar-badge__list--deepblue"><span>예</span><a href="javascript:detail_View(\''+currentDate+'\','+dates[i]+', \'싼타페\');">싼타페</a></p>';
  			}
  			if(carCode[i] == "카니발"){
  				htmlDates += '<p class="calendar-badge__list calendar-badge__list--'+addClass[i]+'">'+status[i]+'<a href="javascript:detail_View('+reservationNumber[i]+');">카니발</a></p>';
  			}else{
  				htmlDates += '<p class="calendar-badge__list calendar-badge__list--deepblue"><span>예</span><a href="javascript:detail_View(\''+currentDate+'\','+dates[i]+', \'카니발\');">카니발</a></p>';
  			}
  			if(carCode[i] == "제네시스G80"){
  				htmlDates += '<p class="calendar-badge__list calendar-badge__list--'+addClass[i]+'">'+status[i]+'<a href="javascript:detail_View('+reservationNumber[i]+');">제네시스G80</a></p>';
  			}else{
  				htmlDates += '<p class="calendar-badge__list calendar-badge__list--deepblue"><span>예</span><a href="javascript:detail_View(\''+currentDate+'\','+dates[i]+', \'제네시스G80\');">제네시스G80</a></p>';
  			}
  		 	 */
  } 

	function detail_View(rentDt, reservationNumber){
		/* if(reservationNumber == undefined){
			alert("예약신청이 존재하지 않습니다.");
			return 0;
		} */
		var c_form = document.calendarForm;
		c_form.sRentDt.value=rentDt;
		c_form.reservationNumber.value=reservationNumber;
		document.calendarForm.action = "<c:url value='/system/resv/resvAppyList.do'/>";
		document.calendarForm.submit();
	}
	
	function fn_none(){
		alert("예약신청이 존재하지 않습니다.");
		return 0;
	}
	
	function replaceAll(str, searchStr, replaceStr) {
		if(str != null && typeof str == 'string') {
			while(str.indexOf(searchStr) != -1) {
				str = str.replace(searchStr, replaceStr);
			}
		}
	    return str;
	} 
	  	
	function prevCal(){
	  	 CDate.setMonth(CDate.getMonth()-1); 
	  	fn_selectReserve(); 
	  } 
	  function nextCal(){
	  	 CDate.setMonth(CDate.getMonth()+1);
	  	fn_selectReserve(); 
	  }
	  
	  function fn_dateStartToLast(startDate, lastDate){
		  var resultDate= [];
		  var curDate = new Date(startDate);
		  while(curDate <= new Date(lastDate)){
			  resultDate.push(curDate.toISOString().split("T")[0]);
			  curDate.setDate(curDate.getDate()+1);
		  }
		  return resultDate;
	  }

</script>
<form id="calendarForm" name="calendarForm" method="post">
	<input type="hidden" name="reservationNumber" id="reservationNumber"/>
	<input type="hidden" name="sRentDt" id="sRentDt"/>
</form>