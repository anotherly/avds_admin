<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Program</title>

<%@ include file="/include/header.jsp" %>
<script type="text/javascript" src="/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>

</head>
<body class="default" style="min-width: 1260px; min-height: 660px;">
<div class="wrap p-20">
	<div class="float_left w100p u">
		<div class="cont_tit2 el-box-tit el-depth-2 el-weight-5">◎ <%=java.net.URLDecoder.decode(menuNm, "UTF-8")%></div>

		<div class="contBtn1">
			<a href="javascript:fn_initClear()"  class="btn_refresh" title="초기화"></a>
			<i></i>
			<a href="javascript:fn_new()" class="btn_new" title="신규"></a>
			<i></i>
			<a href="javascript:fn_save()" class="btn_save" title="저장"></a>
			<i></i>
			<a href="javascript:fn_delete()" class="btn_del" title="삭제"></a>
			<i></i>
			<a href="javascript:fn_search()" class="btn_search" title="조회"></a>
		</div>
	</div>

	<div class="box_search lay-boxItem lay-item--full grids__col-12 mt-10 form-wrap ml-0">
		<form id="searchForm" name="searchForm" method="post">
			<fieldset>
				<span class="tit">제목검색</span>
				<input type="text" style="margin-left: 2px; width: 150px; height: 19px;" id="sKeyword" name="sKeyword" value="" onkeypress="if(event.keyCode==13) {fn_search(); return false;}"/>
	    </fieldset>
		</form>
	</div>

	<div id="grid" class="float_left" style="width: calc(50% - 27px); height: calc(100% - 109px); border: 1px solid #c5c5c5;  border-radius: 3px; background: #fff; padding: 10px;">
		<table id="gridList"></table>
	</div>

	<div id="form" style="width: calc(50% - 27px); height: calc(100% - 109px); float: left; border: 1px solid #c5c5c5; border-radius: 3px; background: #fff; padding: 10px; margin-left: 10px;">
		<form id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
			<input type="text" style="display: none;" id="userId" name="userId" value="${userVo.userId}"/>
			<input type="text" style="display: none;" id="saveMode" name="saveMode" value="I"/>
			<input type="text" style="display: none;" id="rowId" name="rowId" value=""/>

			<table summary="테이블" class="table1">
				<caption></caption>
				<colgroup>
					<col width="10%" />
					<col width="*%" />
				</colgroup>
				<tbody>
					<tr>
						<th>게시물번호</th>
						<td><input type="text" style="width: 100%; height: 19px;" id="boardSeq" name="boardSeq" value="" caption="게시물번호" required="required"/></td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input type="text" style="width: 100%; height: 19px;" id="boardTitle" name="boardTitle" value="" caption="제목" required="required"/></td>
					</tr>
					<tr>
						<th>최신동향</th>
						<td class="write_editor"><textarea style="width:100%; height:342px;background-color:#fff; display:none; resize: none;" id="boardContents" name="boardContents" value="" caption="내용"></textarea></td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td>
							<div>
								<input type="file" name="file_info" id="file_info" onchange="javascript:fileMapper();" style="display: none;">
								<input type="text" name="attachFileNm" id="attachFileNm" style="width: 400px; height: 19px;" readonly placeholder="선택된 파일 없음">
								<label for="file_info">파일선택</label>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								첨부파일크기
								<input type="text" style="width: 80px; height: 19px;" id="attachFileSize" name="attachFileSize" value="" caption="첨부파일크기" readonly />
								&nbsp;byte
							</div>
						</td>
					</tr>
					<tr>
						<th>공개여부</th>
						<td><select style="width: 100px; height: 25px;" id="gpbcYn" name="gpbcYn" caption="공개여부" required="required"></select></td>
					</tr>
					<tr>
						<th>중요도</th>
						<td><select style="width: 100px; height: 25px;" id="rtngCd" name="rtngCd" caption="중요도" required="required"></select></td>
					</tr>
					<tr>
						<th>등록자</th>
						<td><input type="text" style="width: 100%; height: 19px;" id="regId" name="regId" value="" disabled="disabled"/></td>
					</tr>
					<tr>
						<th>등록일시</th>
						<td><input type="text" style="width: 100%; height: 19px;" id="regDate" name="regDate" value="" disabled="disabled"/></td>
					</tr>
					<tr>
						<th>수정자</th>
						<td><input type="text" style="width: 100%; height: 19px;" id="updateId" name="updateId" value="" disabled="disabled"/></td>
					</tr>
					<tr>
						<th>수정일시</th>
						<td><input type="text" style="width: 100%; height: 19px;" id="updateDate" name="updateDate" value="" disabled="disabled"/></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</div>
</body>
</html>
<script type="text/javascript">
var oEditors = []; //스마트에디터 오브젝트
var colModel = [
	{ label: '번호',	name: 'bdwrSeq',		width: 60,	align: "center" },
  	{ label: '제목',	name: 'bdwrTtlNm',		width: 200 },
  	{ label: '첨부파일',	name: 'attachFilename',	width: 100 },
  	{ label: '파일크기',	name: 'fileSize',	width: 60,	align: "center" },
  	{ label: '등록자ID',	name: 'regId',		width: 60,	align: "center" },
  	{ label: '등록일시',	name: 'regDate',		width: 100,	align: "center" }
];

$(window).resize(function(event) {
	if (this == event.target) {
		fn_init();
	}
});

$(document).ready(function() {

	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "boardContents",
		sSkinURI: "/se2/SmartEditor2Skin.html",
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : false,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : false,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
			//에디터 로딩 후 그리드 로딩 -> 그리드에서 상세정보 -> 에디터 데이터 표출 가능
			fn_mkeGrid();
		},
		fCreator: "createSEditor2"
	});
});

function fn_mkeGrid() {
	commonMakeGrid("gridList", "/system/newTrends/selectNewTrendsList.do", colModel, true
		, function(data) {
			if ($("#rowId").val() == "") $("#rowId").val("1");
			$("#gridList").jqGrid("setSelection", $("#rowId").val());
			}
		, function(rowid, status, e) {
			fn_searchForm(rowid);
		}
	);
	commonMakeCodeComboBox("gpbcYn", "YN_CODE1");
	commonMakeCodeComboBox("rtngCd", "bdwr_rtng_cd");

	fn_init();
	fn_search();
	$("#sKeyword").focus();
}

function fn_init() {
	// $("#grid").css("height", "calc(100% - "+($("#form").height()+119)+"px)");
	$("#gridList").jqGrid("setGridWidth", $("#grid").width()-2);
	$("#gridList").jqGrid("setGridHeight", $("#grid").height()-30);
}

function fn_initClear() {
	document.searchForm.reset();
	$("#gridList").jqGrid("clearGridData");
	$("#boardContents").val("");
	oEditors.getById["boardContents"].exec("SET_IR", [""]);
	document.detailForm.reset();

	$("#sKeyword").focus();
}

function fn_search(selectNode) {
	$("#gridList").jqGrid("clearGridData");
	document.detailForm.reset();

	var searchData = {
		sKeyword: $("#sKeyword").val()
	};
	$("#gridList").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
}

function fn_searchForm(rowId) {
	var rowData = $("#gridList").jqGrid("getRowData", rowId);

	commonAjax({ "boardSeq": rowData.bdwrSeq }, "/system/newTrends/selectNewTrendsInfo.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;

		var formData = returnData.rows[0];
		$("#saveMode").val("U");

		$("#boardSeq").val(formData.bSeq);
		$("#boardTitle").val(formData.bTitle);
		if(formData.bContent != null) {
			$("#boardContents").val(formData.bContent);
			oEditors.getById["boardContents"].exec("LOAD_CONTENTS_FIELD");
		}
		$("#attachFileNm").val(formData.attachFileNm);
		$("#attachFileSize").val(formData.attachFileSize);
		$("#gpbcYn").val(formData.gpbcYn);
		$("#rtngCd").val(formData.bRtng);
		$("#regId").val(formData.regId);
		$("#regDate").val(formData.regDate);
		$("#updateId").val(formData.updateId);
		$("#updateDate").val(formData.updateDate);

		$("#boardSeq").attr("readonly", true);
		$("#attachFileSize").attr("readonly", true);
		$("#regId").attr("readonly", true);
		$("#regDate").attr("readonly", true);
		$("#updateId").attr("readonly", true);
		$("#updateDate").attr("readonly", true);

		$("#boardSeq").css("background-color", "rgb(235, 235, 228)");
		$("#attachFileSize").css("background-color", "rgb(235, 235, 228)");
		$("#regId").css("background-color", "rgb(235, 235, 228)");
		$("#regDate").css("background-color", "rgb(235, 235, 228)");
		$("#updateId").css("background-color", "rgb(235, 235, 228)");
		$("#updateDate").css("background-color", "rgb(235, 235, 228)");
	});
}

function fn_new() {
	$("#boardContents").val("");
	oEditors.getById["boardContents"].exec("SET_IR", [""]);
	document.detailForm.reset();
	$("#saveMode").val("I");
	$("#boardSeq").val("신규");

	$("#boardTitle").focus();
}

function fn_save() {
	oEditors.getById["boardContents"].exec("UPDATE_CONTENTS_FIELD", []);

	if (!$("#detailForm").valid()) return;

	var data = new FormData($("#detailForm")[0]);
	var requestUrl = "";

	if($("#saveMode").val() == "I") requestUrl = "/system/newTrends/insertNewTrendsInfo.do";
	else if($("#saveMode").val() == "U") requestUrl = "/system/newTrends/updateNewTrendsInfo.do";

	if(requestUrl != "") {
		commonFormAjax(data, requestUrl, function(returnData, textStatus, jqXHR) {
			alert(returnData.message);
			fn_search();
		});
	}
}

function fn_delete() {
	if ($("#boardSeq").val() == "신규" || $("#boardSeq").val() == "") return;

	if (!confirm("<spring:message code='common.delete.msg'/>")) return;

	$("#saveMode").val("D");

	var data = $("#detailForm").serializeArray();

	commonAjax(data ,"/system/newTrends/deleteNewTrendsInfo.do" , function(returnData, textStatus, jqXHR) {
		alert(returnData.message);
		fn_search();
	});
}

function fileMapper() {
	$('#attachFileNm').val($('#file_info').val());
}

</script>
