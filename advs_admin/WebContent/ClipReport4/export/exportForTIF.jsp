<%@page import="com.clipsoft.clipreport.export.option.TIFOption"%>
<%@page import="com.clipsoft.clipreport.export.option.JPGOption"%>
<%@page import="com.clipsoft.clipreport.oof.OOFFile"%>
<%@page import="com.clipsoft.clipreport.oof.OOFDocument"%>
<%@page import="com.clipsoft.clipreport.server.service.ClipReportExport"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileOutputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../Property.jsp"%>
<%

out.clear(); // where out is a JspWriter
out = pageContext.pushBody();


OOFDocument oof = OOFDocument.newOOF();
OOFFile file = oof.addFile("crf.root", "%root%/crf/CLIP.crf");


//서버에 지정 폴더 저장 할 때
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
//멀티페이지
tifOption.setMultiPage(false);
//회전
tifOption.setRotate90(false);

//회색으로 표현
tifOption.setGray(true);

//서버에 파일 저장시 report1,report2.... 파일명에 페이지 번호가 붙는 부분을 String.format 적용시켜줍니다.
//아래의 예제와 같이 사용 할 경우 report0001, report0002...... 저장 됩니다.
//tifOption.setOutputFileCountFormat("%04d");

int statusType = ClipReportExport.createExportForTIF(request, propertyPath, oof, tifOption);
//statusType == 0 정상적인 출력
//statusType == 1 인스톨 오류
//statusType == 2 oof 문서 오류
//statusType == 3 리포트 엔진 오류
//statusType == 4 img 출력 오류
//statusType == 5 리포트의 페이지 0 일 경우 오류
%>