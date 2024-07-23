<%@page import="com.clipsoft.clipreport.export.option.PDFOption"%>
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
oof.addFile("crf.root", "%root%/crf/CLIP.crf");
oof.addFile("crf.root", "%root%/crf/CLIP.crf");
oof.addFile("crf.root", "%root%/crf/CLIP.crf");
oof.addFile("crf.root", "%root%/crf/CLIP.crf");
oof.addFile("crf.root", "%root%/crf/CLIP.crf");
oof.addFile("crf.root", "%root%/crf/CLIP.crf");
oof.addFile("crf.root", "%root%/crf/CLIP.crf");
oof.addFile("crf.root", "%root%/crf/CLIP.crf");
oof.addFile("crf.root", "%root%/crf/CLIP.crf");

//서버에 파일로 저장 할 때
//File localFileSave = new File("c:\\test.zip");
//OutputStream fileStream = new FileOutputStream(localFileSave);

//클라이언트로 파일을 내릴 때
String fileName = "report.zip";
response.setContentType("application/octet-stream; charset=UTF-8");
response.setHeader("Content-Disposition", "attachment; filename=" + fileName + ";");
OutputStream fileStream = response.getOutputStream();



PDFOption option = null;
/*
option = new PDFOption();
option.setUserPassword("사용자(읽기) 암호");
option.setOwnerPassword("저자(쓰기) 암호");
option.setTextToImage(true); // 글자를 이미지로 처리 - unicode 처리시 사용
option.setNumCopies(1); // 프린팅 매수 미리 설정
option.setImportOriginImage(true); // 원본 이미지 삽입
option.setNotAllowCopy(true); //text복사 방지 (1.0.0.84 version 부터 적용)
option.setEditable(false); // 편집 허용 여부 (1.0.0.173 version 부터 적용)
*/

//분할 페이지 수
int splitPage = 3;
String[] fileNames = new String[3];
fileNames[0] = "aaa";
fileNames[1] = "bbb";
fileNames[2] = "ccc";

int statusType = ClipReportExport.createExportForPDF(request, fileStream, propertyPath, oof, splitPage, fileNames, option);
//statusType == 0 정상적인 출력
//statusType == 1 인스톨 오류
//statusType == 2 oof 문서 오류
//statusType == 3 리포트 엔진 오류
//statusType == 4 PDF 출력 오류
//statusType == 5 리포트의 페이지 0 일 경우 오류
%>
