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

oof.addOption("savetxtFile", "true");   //savetxtFile 텍스트 파일 저장 여부
oof.addOption("delimRow", "{%enter%}"); // Row구분자
oof.addOption("delimCol", ","); //Col 구분자
//oof.addOption("delimCol", "{%tab%}"); //Col 구분자
oof.addOption("addFieldName", "true"); //필드 이름 넣을지 여부
oof.addOption("onlyMain", "true"); //메인 데이터만 
oof.addOption("encoding", "EUC-KR"); //인코딩

//서버에 파일로 저장 할 때
File localFileSave = new File("c:\\temp1\\test.txt");
OutputStream fileStream = new FileOutputStream(localFileSave);

//클라이언트로 파일을 내릴 때
//String fileName = "report.txt";
//response.setContentType("application/octet-stream; charset=UTF-8");
//response.setHeader("Content-Disposition", "attachment; filename=" + fileName + ";");
//OutputStream fileStream = response.getOutputStream();

//클라이언트 브라우져에서 바로 보는 방법(헤더 변경)
//response.setContentType("text/html");
//OutputStream fileStream = response.getOutputStream();";


int statusType = ClipReportExport.createExportForTXT(request, fileStream, propertyPath, oof);
//statusType == 0 정상적인 출력
//statusType == 1 인스톨 오류
//statusType == 2 oof 문서 오류
//statusType == 3 리포트 엔진 오류
//statusType == 4 생성된 txt 가 없음(oof 옵션 확인 필요)
//statusType == 5 리포트의 페이지 0 일 경우 오류
%>