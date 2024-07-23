<%@page import="com.clipsoft.clipreport.server.service.ClipEFormExport"%>
<%@page import="com.clipsoft.clipreport.server.service.ExportInfo"%>
<%@page import="com.clipsoft.clipreport.export.option.PDFOption"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileOutputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../Property.jsp"%>
<%
out.clear(); // where out is a JspWriter
out = pageContext.pushBody();

//getEFormSaveData()함수를 통하여 나온 데이터를 서버에 파라미터로 받아서 export하는 예제입니다.
//기본적으로 데이터가 base64로 인코딩 되어 있습니다.
String eform_data = request.getParameter("eform_data");
boolean isbase64Encoding = true;
//데이터가 인코딩이 안되어있을 때
//boolean isbase64Encoding = false;


if(null != eform_data){
	//서버에 파일로 저장 할 때
	File localFileSave = new File("c:\\temp1\\test\\report.pdf");
	OutputStream fileStream = new FileOutputStream(localFileSave);
	
	//클라이언트로 파일을 내릴 때
	//String fileName = "report.pdf";
	//response.setContentType("application/octet-stream; charset=UTF-8");
	//response.setHeader("Content-Disposition", "attachment; filename=" + fileName + ";");
	//OutputStream fileStream = response.getOutputStream();
	
	//클라이언트 브라우져에서 바로 보는 방법(헤더 변경)
	//response.setContentType("application/pdf");
	//OutputStream fileStream = response.getOutputStream();
	
	PDFOption option = new PDFOption();
	option.setDoodlePen(true);
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
	//전자서식에서 서버에 저장되어 있다면 형광펜을 export 할 때 추가할지 여부
	//option.setDoodlePen(true);
	
	//아래와 같이 기존 사용방법의 함수를 사용할 경우 propertyPath의 경로가 아래의 주석위치로 지정됩니다.
	//request.getSession().getServletContext().getRealPath("/") + File.separator +  "WEB-INF" + File.separator + "clipreport4" + File.separator + "clipreport4.properties";
	//ExportInfo exportInfo = ClipEFormExport.createExportForPDF(request, eform_data, isbase64Encoding, fileStream, option);
		
	ExportInfo exportInfo = ClipEFormExport.createExportForPDF(request, eform_data, isbase64Encoding, fileStream, option, propertyPath);
	int errorCode = exportInfo.getErrorCode();
	//errorCode == 0 정상
	//errorCode == 1 세션안에 리포트정보가 없을 때 오류 
	//errorCode == 2 리포트 서버가 설치가 안되어 있을 때 오류 
	//errorCode == 3 결과물(document) 파일을 찾지 못할 때 발생하는 오류
	//errorCode == 4 PDF 파일 생성 오류
	//errorCode == 5 eform_data 데이터가 문제가 있을 경우
	//errorCode == 6 리포트의 페이지 0 일 경우 오류
}
%>