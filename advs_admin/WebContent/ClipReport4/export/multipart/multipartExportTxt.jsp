<%@page import="com.clipsoft.clipreport.server.service.export.ExportStatusInfo"%>
<%@page import="com.clipsoft.clipreport.export.option.JPGOption"%>
<%@page import="com.clipsoft.clipreport.export.option.PDFOption"%>
<%@page import="com.clipsoft.clipreport.export.option.TextOption"%>
<%@page import="com.clipsoft.clipreport.oof.OOFFile"%>
<%@page import="com.clipsoft.clipreport.oof.OOFDocument"%>
<%@page import="com.clipsoft.clipreport.oof.connection.*"%>
<%@page import="com.clipsoft.clipreport.server.service.ClipReportExport"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileOutputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../Property.jsp"%>
<%
out.clear(); // where out is a JspWriter
out = pageContext.pushBody();

OOFDocument oof = OOFDocument.newOOF();
OOFFile file = oof.addFile("crf", "http://rexpert.clipsoft.kr/reb/post_number.reb");
OOFConnectionHTTP connectData = file.addConnectionHTTP("*","http://rexpert.clipsoft.kr/csv/post_number.csv", "post");
connectData.addContentParamCSV("*", "EUC-KR", ",", "|#|", "|@|", "");

oof.addOption("savetxtFile", "true");   //savetxtFile 텍스트 파일 저장 여부
oof.addOption("delimRow", "\r\n"); // Row구분자
oof.addOption("delimCol", ","); //Col 구분자
oof.addOption("addFieldName", "true"); //필드 이름 넣을지 여부
oof.addOption("onlyMain", "true"); //메인 데이터만 
oof.addOption("encoding", "EUC-KR"); //인코딩

//리포트 엔진을 실행시킨다. 리포트 템프 파일을 생성한다.
ExportStatusInfo exportStatus = ClipReportExport.runEngingeText(request, propertyPath, oof.toString());
//exportStatus.getErrorType()
//ErrorType == 0 정상적인 출력
//ErrorType == 1 인스톨 오류
//ErrorType == 2 oof 문서 오류
//ErrorType == 3 리포트 엔진 오류
//ErrorType == 10 해당 서버에 Temp폴더에 해당키의 Txt 파일이 존재하지 않을경우
//서버에 PDF파일로 저장 할 때

//클라이언트로 파일을 내릴 때
String docName = "report";
if(!"".equals(exportStatus.getDocument().getTitle())){
	docName = exportStatus.getDocument().getTitle();
}

String fileName = docName + ".txt";
response.setContentType("application/octet-stream; charset=UTF-8");
response.setHeader("Content-Disposition", "attachment; filename=" + fileName + ";");
OutputStream fileStream = response.getOutputStream();


TextOption option = new TextOption();
ClipReportExport.exportForTxt(exportStatus, fileStream, option);
fileStream.close();


//리포트 관련 템프 파일 삭제
ClipReportExport.deleteReportFile(exportStatus);
%>