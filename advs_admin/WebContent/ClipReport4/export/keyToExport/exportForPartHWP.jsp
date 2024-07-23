<%@page import="com.clipsoft.clipreport.server.service.ExportInfo"%>
<%@page import="com.clipsoft.clipreport.export.option.HWPOption"%>
<%@page import="com.clipsoft.clipreport.export.option.ExcelOption"%>
<%@page import="com.clipsoft.clipreport.server.service.ClipReportExport"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileOutputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../Property.jsp"%>
<%
out.clear(); // where out is a JspWriter
out = pageContext.pushBody();

//리포트 키를 받아서 처리 합니다. (report_key 파라미터 이름은 변경하여도 상관 없습니다)
String report_key = request.getParameter("report_key");

if(null != report_key){
	//서버에 파일로 저장 할 때
	File localFileSave = new File("c:\\test.hwp");
	OutputStream fileStream = new FileOutputStream(localFileSave);
	
	//클라이언트로 파일을 내릴 때
	//String fileName = "report.hwp";
	//response.setContentType("application/octet-stream; charset=UTF-8");
	//response.setHeader("Content-Disposition", "attachment; filename=" + fileName + ";");
	//OutputStream fileStream = response.getOutputStream();
	
	//클라이언트 브라우져에서 바로 보는 방법(헤더 변경)
	//response.setContentType("application/hwp");
	//OutputStream fileStream = response.getOutputStream();
	
	
	//한글저장에 대한 옵션을 설정합니다.
	HWPOption hwpOption = new HWPOption();
	/* fixSize {Boolean} 크기 고정*/
	hwpOption.setFixSize(true);
	/* allowOverlay {Boolean} 겹침 허용*/
	hwpOption.setAllowOverlay(true);
	/* setPageBottomMarginToZero {Boolean} 페이지 바닥 여백을 0으로 설정*/
	hwpOption.setSetPageBottomMarginToZero(true);
	/* setPageBottomMarginToZero 옵션이 false 일 떄 페이지 아래쪽 여백 적용비율이 적용됩니다.*/
	hwpOption.setPageBottomMarginApplicationRate(100);
	/* outputLikeWord {Boolean} 글자처럼 출력*/
	hwpOption.setOutputLikeWord(false);
	/* tableSplitMethod {Integer}
	 0 = 나눔 
	 1 = 셀 단위로 나눔 
	 2 = 나누지 않음 */
	hwpOption.setTableSplitMethod(1);
	/* defaultCharGap {Integer} 기본 자간*/
	hwpOption.setDefaultCharGap(-8);
	/* charRatio {Integer} 자평*/
	hwpOption.setCharRatio(100);
	/* putCheckboxIntoCell (Boolean) 셀 안에 체크박스 넣기 */
	hwpOption.setPutCheckboxIntoCell(false);
	//이웃한 테이블과 병합할 것인지 여부
	hwpOption.setMergeTable(false);
	//줄간격 비율(%)
	hwpOption.setLineSpaceRate(100);
	/*저장 방식
	0 = 일반
	1 = 표만 나열하기 (선택시 [크기고정(false), 겸침 허용(false), 표 합치기(false), 페이지 바닥 여백 0로 설정(false), 
	* 글자처럼(true), 테이블셀에 표 넣기(true), 페이지영역에서 표 나눔(셀 단위로 나눔) , 위치 기준(문단) 으로 고정])
	*/
	hwpOption.setExportMethod(0);
	
	/*저장 방식이 표만 나열하기 일 때 페이지 나눔 여부*/
	hwpOption.setSplitPageOnListTableOnly(true);
	/*페이지 넘버 삽입 여부*/
	hwpOption.setInsertPageNumber(false);

	
	//아래와 같이 기존 사용방법의 함수를 사용할 경우 propertyPath의 경로가 아래의 주석위치로 지정됩니다.
	//request.getSession().getServletContext().getRealPath("/") + File.separator +  "WEB-INF" + File.separator + "clipreport4" + File.separator + "clipreport4.properties";
	//ExportInfo exportInfo = ClipReportExport.createExportForPartHWP(request, report_key, fileStream, hwpOption);
		
	ExportInfo exportInfo = ClipReportExport.createExportForPartHWP(request, report_key, fileStream, hwpOption, propertyPath);
	int errorCode = exportInfo.getErrorCode();
	//errorCode == 0 정상
	//errorCode == 1 세션안에 리포트정보가 없을 때 오류 
	//errorCode == 2 리포트 서버가 설치가 안되어 있을 때 오류 
	//errorCode == 3 결과물(document) 파일을 찾지 못할 때 발생하는 오류
	//errorCode == 4 HWP 파일 생성 오류
	//errorCode == 5 리포트의 페이지 0 일 경우 오류
}
%>