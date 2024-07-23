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
	{ label: '내용',	name: 'content',	width: 300,	align: "center" },
	{ label: '문의',	name: 'telNo',		width: 120,	align: "center" },
	{ label: 'FAX',		name: 'faxNo',		width: 120, align: "center" },
	{ label: 'E-mail',	name: 'email',		width: 120, align: "center" }
];

$(window).resize(function(event) {
	if (this == event.target) {
		fn_init();
	}
});

$(document).ready(function() {
	commonMakeGrid("gridList", "/system/usaInfo/selectUsaInfoList.do", colModelMast, true
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
});

function fn_searchForm(rowId) {
	var rowData = $("#gridList").jqGrid("getRowData", rowId);

	commonAjax({ "content": rowData.content }, "/system/usaInfo/selectUsaInfoList.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;

		var formData = returnData.rows[0];

		$("#content").val(formData.content);
		$("#telNo").val(formData.telNo);
		$("#faxNo").val(formData.faxNo);
		$("#email").val(formData.email);
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
}

function fn_search() {
	$("#gridList").jqGrid("clearGridData");
	document.detailForm.reset();
	
	var searchData = {
		sContent: $("#sContent").val()
	};
	$("#gridList").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
}


function fn_save() {
	if (!$("#detailForm").valid()) return;


	var data = $("#detailForm").serializeArray();

	commonAjax(data ,"/system/usaInfo/saveUsaInfo.do" , function(returnData, textStatus, jqXHR) {
		alert(returnData.message);
		fn_search();
	});
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
			<input type="hidden" id="excelFileNm" name="excelFileNm" value="">
			<input type="hidden" id="columnsNm" name="columnsNm" value="">
			<input type="hidden" id="datafield" name="datafield" value="">

			<div class="d-flex align-center posi_r">
				<fieldset class="d-flex align-center ml-20">
<!-- 					<span class="tit el-txt fw-500">신청기관</span> -->
<!-- 					<div class="el-form custom-input ml-10"> -->
<!-- 						<input type="text" class="el-form__input el-form-width--l" id="sContent" name="sContent" value="" onkeypress="if(event.keyCode==13) {fn_search(); return false;}"/> -->
<!-- 					</div> -->
				</fieldset>
				<div class="contBtn2">
<!-- 					<button type="button" onclick="fn_search()" class="btn btn-b" title="조회">조회</button> -->
					<button type="button" onclick="fn_save()" class="btn" title="저장">저장</button>
				</div>
			</div>
		</form>
	</div>
	
	<div class="lay-boxItem lay-item--full grids__col-12 m-0" style="overflow: auto;height:calc(100% - 90px);">
		<div class="boxItem__inner h-100">
			<div class="d-flex flex-7 h-100 flex-wrap">
				<div id="grid" class="float_left flex-10 w100p" style="height:50%;padding:10px;border:1px solid #e8eef1;border-radius:3px;">
					<table id="gridList" class="word_b"></table>
				</div>
				
				<div id="form" class="form_box mt-10" style="width:100%;height: calc(50% - 5px);padding:10px;border:1px solid #e8eef1;border-radius:5px;">
					<form id="detailForm" name="detailForm" method="post">
						<input type="text" style="display: none;" id="rowId" name="rowId" value=""/>
<!-- 						<input type="text" style="display: none;" id="content" name="content" value=""/> -->
<!-- 						<input type="text" style="display: none;" id="sContent" name="sContent" value=""/> -->
			
						<div class="el-table-wrap">
							<table class="el-table  el-table--row el-table--usermanage" style="table-layout:fixed">
								<caption></caption>
								<colgroup>
									<col width="10%" />
									<col width="40%" />
									<col width="10%" />
									<col width="40%" />
								</colgroup>
								<tbody>
									<tr>
										<th>내용</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--full" id="content" name="content" value="" caption="내용" required="required"/>
											</div>
										</td>
										<th>문의</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="telNo" name="telNo" value="" caption="문의" required="required"/>
											</div>
										</td>
									</tr>
									<tr>
										<th>FAX</th>
										<td>
											<div class="el-form custom-sel">
												<input type="text" class="el-form__input el-form-width--200" id="faxNo" name="faxNo" value="" caption="FAX" required="required"/>
											</div>
										</td>
										<th>E-mail</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="email" name="email" value="" caption="이메일" required="required"/>
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
