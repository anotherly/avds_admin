<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Program</title>
<link rel="stylesheet" href="<c:url value='/css/layout.css' />" type="text/css">
<%@ include file="/include/header.jsp" %>
<% String tmpRaceNumber = (String) request.getParameter("tmpRaceNumber"); %>
</head>
<body class="default" style="min-width: 598px; min-height: 628px;">
<div class="wrap p-20">

	<div id="grid" class="float_left" style="width: calc(90% - 27px); height: calc(100% - 29px); b````order: 1px solid #c5c5c5;  border-radius: 3px; background: #fff; padding: 10px;">
		<table id="gridList"></table>
	</div>

</div>
</body>
</html>
<script type="text/javascript">
var colModel = [
	{ name: 'reqTp', hidden: true },
	{ name: 'reqId', hidden: true },
	{ label: '번호',	name: 'seq', align: "center" },
	{ label: '보험가입일자',	name: 'insInitDateView', align: "center" },
	{ label: '등록ID',	name: 'regId', align: "center" },
	{ label: '등록일시',	name: 'regDateView', align: "center" },
];

$(window).resize(function(event) {
	if (this == event.target) {
		fn_init();
	}
});

$(document).ready(function() {
	commonMakeGrid("gridList", "/system/req/selectInsdateHisList.do?tmpRaceNumber=<%=tmpRaceNumber%>" , colModel, true
		, function(data) {
			if ($("#rowId").val() == "") $("#rowId").val("1");
			$("#gridList").jqGrid("setSelection", $("#rowId").val());
		}
	);

	fn_init();
	fn_search();
});


function fn_init() {
	// $("#grid").css("height", "calc(100% - "+($("#form").height()+119)+"px)");
	$("#gridList").jqGrid("setGridWidth", $("#grid").width()-2);
	$("#gridList").jqGrid("setGridHeight", $("#grid").height()-30);
}

function fn_initClear() {
	document.searchForm.reset();
	$("#gridList").jqGrid("clearGridData");
	document.detailForm.reset();

	$("#sReqType").focus();
}

function fn_search(selectNode) {
	$("#gridList").jqGrid("clearGridData");

	var searchData = {
		sReqType: $("#sReqType").val()
	};
	$("#gridList").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
}




</script>
