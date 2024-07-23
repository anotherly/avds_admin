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
	
	//클라이언트로 파일을 내릴 때
	response.setContentType("text/html");
	OutputStream fileStream = response.getOutputStream();

	//리포트의 특정 사용자 ID가 부여됐을 때
	//clipreport4.properties 의 useuserid 옵션이 true 일 때만 적용됩니다. 
	//clipreport4.properties 의 useuserid 옵션이 true 이고 기본 예제[ClipReportExport.createExportForPartDIVSVG(request, report_key, fileStream, "UTF-8", propertyPath)] 사용 했을 때 세션ID가 userID로 사용 됩니다.
	//ExportInfo exportInfo = ClipReportExport.createExportForPartDIVSVG(request, report_key, fileStream, "UTF-8", propertyPath, "userID");
	
	ExportInfo exportInfo = ClipReportExport.createExportForPartDIVSVG(request, report_key, fileStream, "UTF-8", propertyPath);
	int errorCode = exportInfo.getErrorCode();
	//errorCode == 0 정상
	//errorCode == 1 세션안에 리포트정보가 없을 때 오류 
	//errorCode == 2 리포트 서버가 설치가 안되어 있을 때 오류 
	//errorCode == 3 결과물(document) 파일을 찾지 못할 때 발생하는 오류
	//errorCode == 4 HTML5 파일 생성 오류
	//errorCode == 5 리포트의 페이지 0 일 경우 오류
	//errorCode == 6 리포트 생성시 userID 다를 때 오류 
	
	
	//outputStream이 아닌 문자열로 가져올 경우
	//outputStream 대신 StringBuffer 사용합니다.
	/*
	StringBuffer exportTxt = new StringBuffer();
	ExportInfo exportInfo = ClipReportExport.createExportForPartDIVSVG(request, report_key, exportTxt, "UTF-8", propertyPath);
	int errorCode = exportInfo.getErrorCode();
	System.out.println(exportTxt.toString());
	*/
}


%>