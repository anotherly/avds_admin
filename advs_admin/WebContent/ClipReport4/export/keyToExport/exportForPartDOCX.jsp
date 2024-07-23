<%@page import="com.clipsoft.clipreport.export.option.WordXOption"%>
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
	//서버에 파일로 저장 할 때
	File localFileSave = new File("c:\\temp1\\test\\test1.docx");
	OutputStream fileStream = new FileOutputStream(localFileSave);
	
	//클라이언트로 파일을 내릴 때
	//String fileName = "report.hwp";
	//response.setContentType("application/octet-stream; charset=UTF-8");
	//response.setHeader("Content-Disposition", "attachment; filename=" + fileName + ";");
	//OutputStream fileStream = response.getOutputStream();
	
	//클라이언트 브라우져에서 바로 보는 방법(헤더 변경)
	//response.setContentType("application/hwp");
	//OutputStream fileStream = response.getOutputStream();
	
	       
	//DOCX 저장에 대한 옵션을 설정합니다.
	WordXOption docxOption = new WordXOption();
	
	//기본 자간
	docxOption.setDefaultCharSpace(-0.5f);
	//균등 분할 처리 방법
	//0=왼쪽 정렬
	//1=오른쪽 정렬
	//2=가운데 정렬
	//3=양쪽 정렬
	docxOption.setProcessEqualAlign(3);
	//리포트에 출력된 것 처럼 문자열을 여러줄로 잘라서 표현할지 여부
	docxOption.setSplitTextByLine(true);
	//이웃한 테이블과 병합할 것인지 여부
	docxOption.setMergeTable(false);
	//테이블을 감싸는 객체를 삽입할 것인지 여부
	docxOption.setInsertTableWrapper(true);
	//테이블을 감싸는 레이아웃와 테이블의 아래쪽 간격
	docxOption.setTableWrapperBottomGap(0);
	//간편 편집용
	//0=일반
	//1= 간편 편집용
	docxOption.setExportMethod(0);
	
	//아래와 같이 기존 사용방법의 함수를 사용할 경우 propertyPath의 경로가 아래의 주석위치로 지정됩니다.
	//request.getSession().getServletContext().getRealPath("/") + File.separator +  "WEB-INF" + File.separator + "clipreport4" + File.separator + "clipreport4.properties";
	//ExportInfo exportInfo = ClipReportExport.createExportForPartDOCX(request, report_key, fileStream, docxOption);
		
	ExportInfo exportInfo = ClipReportExport.createExportForPartDOCX(request, report_key, fileStream, docxOption, propertyPath);
	int errorCode = exportInfo.getErrorCode();
	//errorCode == 0 정상
	//errorCode == 1 세션안에 리포트정보가 없을 때 오류 
	//errorCode == 2 리포트 서버가 설치가 안되어 있을 때 오류 
	//errorCode == 3 결과물(document) 파일을 찾지 못할 때 발생하는 오류
	//errorCode == 4 DOCX 파일 생성 오류
	//errorCode == 5 리포트의 페이지 0 일 경우 오류
}
%>