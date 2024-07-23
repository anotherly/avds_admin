<%@page import="com.clipsoft.clipreport.export.option.TIFOption"%>
<%@page import="com.clipsoft.clipreport.server.service.ExportInfo"%>
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

	String fileName = "c:\\temp1\\report.tif";

	TIFOption tifOption = new TIFOption();
	//저장파일 
	tifOption.setOutputFilename(fileName);
	//X DPI 설정
	tifOption.setDpiX(96);
	//Y DPI 설정
	tifOption.setDpiY(96);
	//흑백 여부
	tifOption.setBlackWhite(false);
	//멀티페이지 설정
	//멀티페이지가 false 일경우 지정한 폴더에 (파일명 + 페이지번호) 저장합니다.
	//지정한 폴더에 report1.jpg 로 저장됩니다.
	//리포트가 1~3페이지 (여러 페이지)일 경우 report1.jpg, report2.jpg, report3.jpg 저장 됩니다.
	tifOption.setMultiPage(true);
	//회전
	tifOption.setRotate90(false);
	//회색으로 표현
	tifOption.setGray(false);
	//전자서식에서 서버에 저장되어 있다면 형광펜을 export 할 때 추가할지 여부
	//tifOption.setDoodlePen(true);
	
	//서버에 파일 저장시 report1,report2.... 파일명에 페이지 번호가 붙는 부분을 String.format 적용시켜줍니다.
	//아래의 예제와 같이 사용 할 경우 report0001, report0002...... 저장 됩니다.
	//tifOption.setOutputFileCountFormat("%04d");
	
	//아래와 같이 기존 사용방법의 함수를 사용할 경우 propertyPath의 경로가 아래의 주석위치로 지정됩니다.
	//request.getSession().getServletContext().getRealPath("/") + File.separator +  "WEB-INF" + File.separator + "clipreport4" + File.separator + "clipreport4.properties";
	//ExportInfo exportInfo = ClipReportExport.createExportForPartTIF(request, report_key, tifOption);	
	
	ExportInfo exportInfo = ClipReportExport.createExportForPartTIF(request, report_key, tifOption, propertyPath);
	int errorCode = exportInfo.getErrorCode();
	//errorCode == 0 정상
	//errorCode == 1 세션안에 리포트정보가 없을 때 오류 
	//errorCode == 2 리포트 서버가 설치가 안되어 있을 때 오류 
	//errorCode == 3 결과물(document) 파일을 찾지 못할 때 발생하는 오류
	//errorCode == 4 jpg 파일 생성 오류
	//errorCode == 5 리포트의 페이지 0 일 경우 오류
	
	//리포트 총 페이지 수
	//System.out.println(exportInfo.getPageCount());
}
%>