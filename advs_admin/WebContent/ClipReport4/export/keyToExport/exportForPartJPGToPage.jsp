<%@page import="com.clipsoft.clipreport.export.option.JPGOption"%>
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
	File localFileSave = new File("c:\\temp1\\test\\report.jpg");
	OutputStream fileStream = new FileOutputStream(localFileSave);
	
	
	JPGOption jpgOption = new JPGOption();
	//X DPI 설정
	jpgOption.setDpiX(96);
	//Y DPI 설정
	jpgOption.setDpiY(96);
	//품질(1~100)
	jpgOption.setQuality(100);
	//회전
	jpgOption.setRotate90(false);
	
	//전자서식에서 서버에 저장되어 있다면 형광펜을 export 할 때 추가할지 여부
	//jpgOption.setDoodlePen(true);
	
	//저장할 페이지 번호
	int pageNumber = 1;
	
	ExportInfo exportInfo = ClipReportExport.createExportForPartJPGToPage(request, report_key, fileStream, jpgOption, pageNumber, propertyPath);
	int errorCode = exportInfo.getErrorCode();
	//errorCode == 0 정상
	//errorCode == 1 세션안에 리포트정보가 없을 때 오류 
	//errorCode == 2 리포트 서버가 설치가 안되어 있을 때 오류 
	//errorCode == 3 결과물(document) 파일을 찾지 못할 때 발생하는 오류
	//errorCode == 4 jpg 파일 생성 오류
	//errorCode == 5 리포트의 페이지 0 일 경우 오류
}
%>