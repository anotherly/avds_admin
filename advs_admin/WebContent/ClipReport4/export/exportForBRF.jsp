<%@page import="com.clipsoft.clipreport.oof.connection.OOFConnectionFile"%>
<%@page import="com.clipsoft.clipreport.server.service.ClipReportExportBRF"%>
<%@page import="com.clipsoft.clipreport.oof.OOFFile"%>
<%@page import="com.clipsoft.clipreport.oof.OOFDocument"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileOutputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../Property.jsp"%>
<%
out.clear(); // where out is a JspWriter
out = pageContext.pushBody();

OOFDocument oof = OOFDocument.newOOF();
//샘플 crf실행
OOFFile file = oof.addFile("crf.root", "%root%/crf/brf_test.crf");

//예제 crf에 데이터 추가
//OOFFile reportFile = oof.addFile("crf", "C:\\Users\\pc\\Desktop\\samples\\test\\1011.crf");
//OOFConnectionFile connectData = reportFile.addConnectionFile("*","C:\\Users\\pc\\Desktop\\samples\\test\\1011.xml");
//connectData.addContentParamXML("", "UTF-8", "{%dataset.xml.root%}");


//서버에 파일로 저장 할 때
//File localFileSave = new File("c:\\test.pdf");
//OutputStream fileStream = new FileOutputStream(localFileSave);

//클라이언트로 파일을 내릴 때
//String fileName = "report.pdf";
//response.setContentType("application/octet-stream; charset=UTF-8");
//response.setHeader("Content-Disposition", "attachment; filename=" + fileName + ";");
//OutputStream fileStream = response.getOutputStream();

//클라이언트 브라우져에서 바로 보는 방법(헤더 변경)
response.setContentType("application/brf");
OutputStream fileStream = response.getOutputStream();

int statusType = ClipReportExportBRF.createExportForBRF(request, fileStream, propertyPath, oof);
//statusType == 0 정상적인 출력
//statusType == 1 인스톨 오류
//statusType == 2 oof 문서 오류
//statusType == 3 리포트 엔진 오류
//statusType == 4 PDF 출력 오류
//statusType == 5 리포트의 페이지 0 일 경우 오류
%>
