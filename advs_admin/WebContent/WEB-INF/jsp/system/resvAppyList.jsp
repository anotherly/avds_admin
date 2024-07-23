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
//폼 변수
var c_form = "";

$(document).ready(function() {
	c_form = document.detailForm; //폼 셋팅
	//달력 이벤트
	$( "#sRentDt" ).datepicker();
	$( "#sReservationNumber").val('${paramMap.reservationNumber}');
	fn_selectResvAppyList();
});

function fn_selectResvAppyList(){
	$.ajax({
		url: "/system/resv/selectResvAppyList.do",
		type: "post",
		data: {"reservationNumber":$( "#sReservationNumber").val(), "rentCarCode" : $('#sRentCarCode').val(), "applyCompanyCode" : $('#sApplyCompanyCode').val(), "rentDt" : $('#sRentDt').val()},
		success: function(data) {
	    	var result = data.rows;
	    	var innerHtml = '';
	    	if(result.length > 0){
		    	$.each(result,function(idx, item){
		    		
		    		innerHtml += '<tr class="abcd" onClick="fn_selectResvAppyDtl(\''+item.reservationNumber+'\')" style="cursor:pointer;">'; 
		    		innerHtml += '<td style="text-align:center;">'+item.reservationNumber+'</td>';
		    		innerHtml += '<td style="text-align:center;">'+item.rentCarCode+'</td>';
		    		innerHtml += '<td>'+item.applyCompanyCode+'</td>';
		    		innerHtml += '<td style="text-align:center;">'+item.rentDay+'</td>';
		    		innerHtml += '<td style="text-align:center;">'+item.rentDt+'</td>';
		    		innerHtml += '<td style="text-align:center;">'+item.returnDt+'</td>';
		    		innerHtml += '<td>'+item.attachFile+'</td>';
		    		innerHtml += '<td style="text-align:center;">'+item.reservStatus+'</td>';
		    		innerHtml += '</tr>';
		    		if($( "#sReservationNumber").val() != ""){
			    		$("#reservationNumber").val(item.reservationNumber);
			    		$("#rentCarCode").val(item.rentCarCode);
			    		$("#applyCompanyCode").val(item.applyCompanyCode);
			    		$("#applyDate").val(item.applyDate);
			    		$("#rentDt").val(item.rentDt);
			    		$("#returnDt").val(item.returnDt);
			    		$("#reservationStatus").val(item.reservationStatus);
			    		$("#resvAttachFile").val(item.resvAttachFile);
			    		
			    		$("#reservationNumber").attr("readonly", true);
			    		$("#rentCarCode").attr("readonly", true);
			    		$("#applyCompanyCode").attr("readonly", true);
			    		$("#applyDate").attr("readonly", true);
			    		$("#rentDt").attr("readonly", true);
			    		$("#resvAttachFile").attr("readonly", true);
		    		}
		    	});
	    	}else{
	    		innerHtml += '<tr><td colspan="8" style="text-align:center;">검색된 결과가 없습니다.</td></tr>';
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

function fn_selectResvAppyDtl(reservationNumber){
	$.ajax({
		url: "/system/resv/selectResvAppyList.do",
		type: "post",
		data: {"reservationNumber":reservationNumber},
		success: function(data) {
	    	var result = data.rows;
	    	if(result != '' ){
    			$("#reservationNumber").val(result[0].reservationNumber);
	    		$("#rentCarCode").val(result[0].rentCarCode);
	    		$("#applyCompanyCode").val(result[0].applyCompanyCode);
	    		$("#applyDate").val(result[0].applyDate);
	    		$("#rentDt").val(result[0].rentDt);
	    		$("#returnDt").val(result[0].returnDt);
	    		$("#reservationStatus").val(result[0].reservationStatus);
	    		$("#resvAttachFile").val(result[0].resvAttachFile);
	    		
	    		$("#reservationNumber").attr("readonly", true);
	    		$("#rentCarCode").attr("readonly", true);
	    		$("#applyCompanyCode").attr("readonly", true);
	    		$("#applyDate").attr("readonly", true);
	    		$("#rentDt").attr("readonly", true);
	    		$("#resvAttachFile").attr("readonly", true);
	    	}
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



/* var colModelMast = [
	{ label: '예약번호',	name: 'reservationNumber',		width: 100,	align: "center" },
	{ label: '대여차량',	name: 'rentCarCode',		width: 150,	align: "center" },
	{ label: '신청기관',	name: 'applyCompanyCode',	width: 200, align: "center" },
	{ label: '신청일자',	name: 'applyDate',			width: 150, align: "center" },// 날짜 계산하여 일수로 계산
	{ label: '예약일자',		name: 'rentDt',		width: 150, align: "center" },
	{ label: '반납일자',		name: 'returnDt',		width: 150, align: "center" },
	{ label: '첨부파일',	name: 'resvAttachFile',	width: 150, align: "center" },
	{ label: '상태',	name: 'reservStatus',	width: 150, align: "center" },
	{ label: '상태코드',	name: 'reservationStatus',	width: 150, align: "center", hidden: true },
]; */

/* $(window).resize(function(event) {
	if (this == event.target) {
		fn_init();
	}
}); */

$(document).ready(function() {
	
	
	
	//	$( "#eddate" ).datepicker().datepicker("setDate", new Date());

	/* commonMakeGrid("gridList", "/system/resv/selectResvAppyList.do", colModelMast, true
		, function(data) {
			if ($("#rowId").val() == "") $("#rowId").val("1");
			$("#gridList").jqGrid("setSelection", $("#rowId").val());
		}
		, function(rowid, status, e) {
			fn_searchForm(rowid);
		}
	); */
	
	/* fn_init();
	fn_search();
	$("#sRservationStatus").focus();
	var ids = $("#gridList").getDataIDs();
	$.each(ids,function(idx, rowId){
		$("#"+rowId).mouseover(function(){
			console.log(rowId);
			//$("#"+rowId).setRowData(rowId, false, { "background-color":"#F7FAFC" });
			//$("#"+rowId+' tr').removeClass('.ui-state-hover');
			//$('.jqgrow').removeClass('ui-widget-content ui-state-highlight').addClass('addclass');
			//$('#'+rowId).removeClass('jqgrow ui-row-ltr ui-widget-content ui-state-highlight').addClass('jqgrow ui-state-highlight ui-state-hover');
			$('.jqgrow').css("background-color","#F7FAFC");
		});  
   	}); */
	
});

function fn_searchForm(rowId) {
	var rowData = $("#gridList").jqGrid("getRowData", rowId);
	var sReservationNumber = $("#sReservationNumber").val();	
	if( sReservationNumber == ''){
		sReservationNumber = rowData.reservationNumber;
	}
	commonAjax({ "sReservationNumber": sReservationNumber, "rentDt": rowData.rentDt, "returnDt": rowData.returnDt }, "/system/resv/selectResvAppyList.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;

		var formData = returnData.rows[0];

// 		alert(formData.reservationNumber);
		$("#reservationNumber").val(formData.reservationNumber);
		$("#rentCarCode").val(formData.rentCarCode);
		$("#applyCompanyCode").val(formData.applyCompanyCode);
		$("#applyDate").val(formData.applyDate);
		$("#rentDt").val(formData.rentDt);
		$("#returnDt").val(formData.returnDt);
		$("#reservationStatus").val(formData.reservationStatus);
		$("#resvAttachFile").val(formData.resvAttachFile);
// 		$("#resvAttachFile").html(formData.resvAttachFile);

		$("#reservationNumber").attr("readonly", true);
		$("#rentCarCode").attr("readonly", true);
		$("#applyCompanyCode").attr("readonly", true);
		$("#applyDate").attr("readonly", true);
		$("#rentDt").attr("readonly", true);
		$("#resvAttachFile").attr("readonly", true);
		
		var resStat = formData.reservationStatus;
		if(resStat == '2' || resStat == '0' ){
			$("#reservationStatus").attr("disabled", true);	
			$("#btn_save").hide();
		}else{
			$("#reservationStatus").attr("disabled", false);
			$("#btn_save").show();
		}
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
	$("#reservationNumber").attr("readonly", true);
	$("#rentCarCode").attr("readonly", true);
	$("#applyCompanyCode").attr("readonly", true);
	$("#applyDate").attr("readonly", true);
	$("#rentDt").attr("readonly", true);
	$("#resvAttachFile").attr("readonly", true);
	$("#sResNum").focus();
}

function fn_search() {
	$("#reservationNumber").attr("readonly", true);
	$("#rentCarCode").attr("readonly", true);
	$("#applyCompanyCode").attr("readonly", true);
	$("#applyDate").attr("readonly", true);
	$("#rentDt").attr("readonly", true);
	$("#resvAttachFile").attr("readonly", true);
	
	/* var searchData = {
		sReservationNumber: $("#sReservationNumber").val(),
		sRentCarCode: $("#sRentCarCode").val(),
		sApplyCompanyCode: $("#sApplyCompanyCode").val(),
		sRentDt: $("#sRentDt").val()		
	};
	$("#gridList").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid"); */
}

function fn_save() {
	if (!$("#detailForm").valid()) return;


	var data = $("#detailForm").serializeArray();

	commonAjax(data ,"/system/resv/saveResvAppy.do" , function(returnData, textStatus, jqXHR) {
		alert(returnData.message);
		//fn_search();
		location.reload();
	});
}

/* 파일 다운로드  */
function fn_Download() {
	c_form.file_nm.value = $("#resvAttachFile").val();
	c_form.dir_nm.value = "sharing";
	c_form.action = "<c:url value='/common/File_Download.do'/>";
	c_form.submit();
}

</script>
</head>

<body class="default" style="min-width: 1260px; min-height: 660px;">
<div class="wrap p-20 h-100">
	<div class="float_left w100p q posi_r">
		<div class="cont_tit2 el-box-tit el-depth-2 el-weight-5">◎ <%=java.net.URLDecoder.decode("차량 플랫폼 공유", "UTF-8")%></div>
	</div>

	<div class="box_search lay-boxItem lay-item--full grids__col-12 mt-10 form-wrap ml-0">
		<form id="searchForm" name="searchForm" method="post">
			<input type="hidden" id="excelFileNm" name="excelFileNm" value="">
			<input type="hidden" id="columnsNm" name="columnsNm" value="">
			<input type="hidden" id="datafield" name="datafield" value="">

			<div class="d-flex align-center posi_r">
				<fieldset class="d-flex align-center">
					<span class="tit el-txt fw-500">예약번호</span>
					<div class="el-form custom-input ml-10">
						<input type="text" class="el-form__input el-form-width--l" id="sReservationNumber" name="sReservationNumber" value="" onkeypress="if(event.keyCode==13) {fn_search(); return false;}"/>
					</div>
		    	</fieldset>
				<fieldset class="d-flex align-center ml-20">
					<span class="tit el-txt fw-500">대여차량</span>
					<div class="el-form custom-input ml-10">
						<input type="text" class="el-form__input el-form-width--l" id="sRentCarCode" name="sRentCarCode" value="" onkeypress="if(event.keyCode==13) {fn_search(); return false;}"/>
					</div>
		    	</fieldset>
				<fieldset class="d-flex align-center ml-20">
					<span class="tit el-txt fw-500">신청기관</span>
					<div class="el-form custom-input ml-10">
						<input type="text" class="el-form__input el-form-width--l" id="sApplyCompanyCode" name="sApplyCompanyCode" value="" onkeypress="if(event.keyCode==13) {fn_search(); return false;}"/>
					</div>
				</fieldset>
		    	<fieldset class="d-flex align-center ml-20">
					<span class="tit el-txt fw-500">예약일자</span>
					<div class="el-form custom-sel ml-10">
						<input type="text" class="el-form__input el-form-width--l" id="sRentDt" name="sRentDt" value="${paramMap.sRentDt }" />
					</div>
				</fieldset>
				<div class="contBtn2">
					<button type="button" onclick="fn_selectResvAppyList()" class="btn btn-b" title="조회">조회</button>
<!-- 					<button type="button" onclick="fn_save()" class="btn btn-b" title="저장" >저장</button> -->
<!-- 					<button type="button" onclick="fn_ref()" class="btn btn-b" title="반려">반려</button> -->
				</div>
			</div>
		</form>
	</div>
<!-- 	<div class="lay-boxItem lay-item--full grids__col-12 m-0" style="overflow: auto;height:calc(100% - 90px);"> -->
<!-- 		<div class="boxItem__inner h-100"> -->
<!-- 			<div class="d-flex h-100 flex-wrap"> -->
<!-- 				<div id="grid" class="float_left w100p ov-auto-y ov-hidden-x" style="padding:10px;border:1px solid #e8eef1;border-radius:5px;"> -->
<!-- 					<table id="gridList" class="word_b"></table> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
	
	<div class="lay-boxItem lay-item--full grids__col-12 m-0" style="overflow: auto;height:calc(100% - 90px);">
		<div class="boxItem__inner h-100">
			<div class="d-flex flex-7 h-100 flex-wrap">
				<div id="grid" class="float_left flex-10 w100p ov-auto-y ov-hidden-x" style="height:70%;padding:10px;border:1px solid #e8eef1;border-radius:3px;">
					<div class="lay-table-wrap">
                       <div class="lay-table__inner">
                           <div class="el-table-wrap">
                               <table class="el-table">
                                   <caption>차량플랫폼 공유 리스트</caption>
	                               <colgroup>
	                                   <col style="width:5%" />
	                                   <col style="width:10%" />
	                                   <col style="width:20%" />
	                                   <col style="width:5%" />
	                                   <col style="width:15%" />
	                                   <col style="width:15%" />
	                                   <col style="width:20%" />
	                                   <col style="width:10%" />
	                               </colgroup>
	                               <thead>
	                                   <tr>
	                                       <th scope="col">예약번호</th>
	                                       <th scope="col">대여차량</th>
	                                       <th scope="col">신청기관</th>
	                                       <th scope="col">대여일</th>
	                                       <th scope="col">예약일자</th>
	                                       <th scope="col">반납일자</th>
	                                       <th scope="col">첨부파일</th>
	                                       <th scope="col">상태</th>
	                                   </tr>
	                               </thead>
	                               <tbody id="gridList"> </tbody>
                           </table>
                        </div>
                    </div>
                </div>
					<!-- <table id="gridList" class="word_b"></table> -->
				</div>
				
					<form id="detailForm" name="detailForm" method="post">
						<input type="hidden" name="file_nm" id="file_nm" />
						<input type="hidden" name="dir_nm" id="dir_nm" />
						<input type="text" style="display: none;" id="rowId" name="rowId" value=""/>
						<input type="text" style="display: none;" id="sReservationNumber" name="sReservationNumber" value=""/>
			
						<div class="el-table-wrap">
							<table class="el-table  el-table--row el-table--usermanage" style="table-layout:fixed">
								<caption></caption>
								<colgroup>
									<col width="10%" />
									<col width="23.3%" />
									<col width="10%" />
									<col width="23.3%" />
									<col width="10%" />
									<col width="*%" />
								</colgroup>
								<tbody>
									<tr>
										<th>예약번호</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="reservationNumber" name="reservationNumber" value="" caption="예약번호" required="required"/>
											</div>
										</td>
										<th>대여차량</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="rentCarCode" name="rentCarCode" value="" caption="대여차량" required="required"/>
											</div>
										</td>
										<th>신청기관</th>
										<td>
											<div class="el-form custom-sel">
												<input type="text" class="el-form__input el-form-width--200" id="applyCompanyCode" name="applyCompanyCode" value="" caption="신청기관" required="required"/>
											</div>
										</td>
									</tr>
									<tr>
										<th>신청일자</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="applyDate" name="applyDate" value="" caption="신청일자" required="required"/>
											</div>
										</td>
										<th>예약일자</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="rentDt" name="rentDt" value="" caption="예약일자" required="required"/>
											</div>
										</td>
										<th>승인/반려처리</th>
										<td>
											<div class="el-form custom-sel">
												<select class="el-form__sel" id="reservationStatus" name="reservationStatus" caption="승인/반려처리" required="required">
													<option value="1">선택</option>
													<option value="2">승인</option>
													<option value="0">반려</option>
												</select>
											<div class="contBtn3" id="btn_save">
												<button type="button" onclick="fn_save()" class="btn btn-b" title="저장" >저장</button>
											</div>
											</div>
										</td>
									</tr>
									<tr>
										<th>첨부파일</th>
										<td colspan="5">
											<div class="d-flex align-center">
												<div class="el-form custom-input">
													<input type="text" class="el-form__input el-form-width--350" name="resvAttachFile" id="resvAttachFile" placeholder="선택된 파일 없음">
												</div>
												<label for="resvAttachFile" onclick="fn_Download()" style="height:34px;padding:0 10px;margin-left:5px;margin-right:20px;background-color:#555;color:#fff;line-height:34px;">파일다운</label>
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
</body>
</html>
