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
<%-- var colModelMast = [
	{ label: '등록일자', name: 'regDate',     width: 120,	align: "center" },
	{ label: '로그ID',	 name: 'logId',				width: 100, align: "center" },
	{ label: '서버ID',	 name: 'serverId',    width: 100, align: "center" },
	{ label: '서버명',   name: 'serverNm',		width: 300},
	{ label: '서버IP', name: 'serverIp', width: 120, align: "center" },
	{ label: 'CPU사용', name: 'cpuUsage',		width: 100,	align: "center" },
	{ label: '메모리사용', name: 'memUsage',	width: 100,	align: "center" },
	{ label: '시스템상태코드', name: 'systemTypeCd', width: 100, align: "center" }
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

	commonMakeGrid("gridList", "/system/rsrc/selectSvrResourceList.do", colModelMast, true
		, function(data) {
			if ($("#rowId").val() == "") $("#rowId").val("1");
			$("#gridList").jqGrid("setSelection", $("#rowId").val());
		}
		, function(rowid, status, e) {
		}
	);
	fn_init();
	fn_search();
	$("#sKeyword").focus();
});

function fn_init() {
	/*$('#grid').css('height', 'calc(100% - 109px)');*/
	$('#gridList').jqGrid('setGridWidth', $('#grid').width()-2);
	$('#gridList').jqGrid('setGridHeight', $('#grid').height()-2);
}

function fn_initClear() {
	document.searchForm.reset();
	$("#gridList").jqGrid("clearGridData");

	$("#sKeyword").focus();
}

function fn_search() {
	$("#gridList").jqGrid("clearGridData");

	var searchData = {
		sKeyword: $("#sKeyword").val(),
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

	var url = "/system/rsrc/selectSvrResourceExcel.do";
	$("#searchForm").attr("action", url);
	$("#searchForm").submit();
} --%>
var c_form = "";
$(document).ready(function() {
	c_form = document.detailForm; //폼 셋팅
	//달력 이벤트
	$( "#stdate" ).datepicker().datepicker("setDate", -1);
	$( "#eddate" ).datepicker().datepicker("setDate", new Date());
	fn_selectSvrResourceList();
});

function fn_selectSvrResourceList(){
	$.ajax({
		url: "/system/rsrc/selectSvrResourceList2.do",
		type: "post",
		data: {"stdate":$( "#stdate" ).val(), "eddate":$( "#eddate" ).val(), "sKeyword":$("#sKeyword").val()},
		success: function(data) {
	    	var result = data.rows;
	    	var innerHtml = '';
	    	console.log(result);
	    	if(result.length > 0){
		    	$.each(result,function(idx, item){
		    		innerHtml += '<tr class="abcd" style="cursor:pointer;">'; 
		    		innerHtml += '<td style="text-align:center;">'+item.regDate+'</td>';
		    		innerHtml += '<td style="text-align:center;">'+item.serverId+'</td>';
		    		innerHtml += '<td style="text-align:center;">'+item.serverNm+'</td>';
		    		innerHtml += '<td style="text-align:center;">'+item.serverIp+'</td>';
		    		innerHtml += '</tr>';
		    	});
	    	}else{
	    		innerHtml += '<tr><td colspan="4" style="text-align:center;">검색된 결과가 없습니다.</td></tr>';
	    	}
	    	$('#gridList').html(innerHtml);
	    	
	    	$("#gridList tr").click(function(){
	    		$("#gridList tr").css("background","#FFFFFF");
	    		$(this).css("background","#B2CCFF");
	    	});
		},
		error: function(jqXHR, textStatus, errorThrown) {
			if (jqXHR.responseJSON == undefined) {
				alert("에러가 발생했습니다. 관리자에게 문의하세요");
			} else {
				alert(jqXHR.responseJSON.message);
			}
			if (errorCallback != undefined) {
				errorCallback(jqXHR, textStatus, errorThrown)
			}
		}
	});
	
	
}

</script>
</head>

<body class="default" style="min-width: 1260px; min-height: 660px;">
<div class="wrap p-20 h-100">
	<div class="float_left w100p dd posi_r">
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
					<span class="tit el-txt fw-500">접속자명</span>
					<div class="el-form custom-input ml-10">
						<input type="text" class="el-form__input el-form-width--l" id="sKeyword" name="sKeyword" value="" onkeypress="if(event.keyCode==13) {fn_search(); return false;}"/>
					</div>
				</fieldset>
				<fieldset class="d-flex align-center ml-20">
					<span class="tit el-txt fw-500">등록일시</span>
					<div class="el-form custom-sel ml-10">
						<input type="text" class="el-form__input el-form-width--l" id="stdate" name="stdate" value="" /> 
						<span>&nbsp;~&nbsp;</span>
						<input type="text" class="el-form__input el-form-width--l" id="eddate" name="eddate" value="" />
					</div>
				</fieldset>
				<div class="contBtn2">
					<button type="button" onclick="fn_selectSvrResourceList()" class="btn btn-b" title="조회">조회</button>
					<button type="button" onclick="fn_excel()" class="btn btn-g" title="엑셀 다운로드">엑셀 다운로드</button>
				</div>
			</div>
		</form>
	</div>
	<div class="lay-boxItem lay-item--full grids__col-12 m-0" style="overflow: auto;height:calc(100% - 90px);">
		<div class="boxItem__inner h-100">
			<div class="d-flex flex-7 h-100 flex-wrap">
				<div id="grid" class="float_left flex-10 w100p ov-auto-y ov-hidden-x" style="height:70%;padding:10px;border:1px solid #e8eef1;border-radius:3px;">
					<div class="lay-table-wrap">
                       <div class="lay-table__inner">
                           <div class="el-table-wrap">
                               <table class="el-table">
								<caption>시스템접속이력관리 리스트</caption>
		                        <colgroup>
		                            <col style="width:20%" />
		                            <col style="width:20%" />
		                            <col style="width:25%" />
		                            <col style="width:35%" />
		                        </colgroup>
		                        <thead>
		                            <tr>
		                                <th scope="col">접속일자</th>
		                                <th scope="col">접속 ID</th>
		                                <th scope="col">접속자명</th>
		                                <th scope="col">서버IP</th>
		                            </tr>
		                        </thead>
		                        <tbody id="gridList"> </tbody>
							</table>
                        </div>
                    </div>
                </div>
					<!-- <table id="gridList" class="word_b"></table> -->
				</div>	
			</div>
		</div>
	</div>
	<div class="lay-boxItem lay-item--full grids__col-12 m-0" style="overflow: auto;height:calc(100% - 90px);">
		<div class="boxItem__inner h-100">
			<div class="d-flex h-100 flex-wrap">
				<div id="grid" class="float_left w100p ov-auto-y ov-hidden-x" style="padding:10px;border:1px solid #e8eef1;border-radius:5px;">
					
				</div>
			</div>
		</div>
	</div>

</div>
</body>
</html>
