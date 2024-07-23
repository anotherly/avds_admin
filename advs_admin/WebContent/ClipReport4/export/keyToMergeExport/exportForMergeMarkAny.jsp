<%@page import="com.clipsoft.clipreport.server.service.ClipReportForMarkVoice"%>
<%@page import="com.clipsoft.clipreport.server.service.ClipReportMergeExport"%>
<%@page import="com.clipsoft.clipreport.server.service.ReportKeyInfoList"%>
<%@page import="com.clipsoft.clipreport.server.service.ResultValue"%>
<%@page import="com.clipsoft.clipreport.export.option.PDFOption"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileOutputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../Property.jsp"%>
<%
out.clear(); // where out is a JspWriter
out = pageContext.pushBody();

//리포트 키 리스트를 받아서 처리 합니다. (report_key 파라미터 이름은 변경하여도 상관 없습니다)
String[] report_key = request.getParameterValues("report_key");

if(null != report_key){
	ReportKeyInfoList keyInfo = new ReportKeyInfoList();
	for(int index = 0; index<report_key.length; index++){
		//리포트 키를 입력
		//리포트에 바코드가 있는지를 설정
		keyInfo.setReportKeyInfo(report_key[index], true);
	}
	
	//pdf 생성할 때 옵션
	PDFOption option = new PDFOption();
	//텍스트를 이미지로 표현할지 여부
	//option.setTextToImage(true);
	//option.setNotAllowCopy(true); //text복사 방지 (1.0.0.84 version 부터 적용)
	
	//아래와 같이 기존 사용방법의 함수를 사용할 경우 propertyPath의 경로가 아래의 주석위치로 지정됩니다.
	//request.getSession().getServletContext().getRealPath("/") + File.separator +  "WEB-INF" + File.separator + "clipreport4" + File.separator + "clipreport4.properties";
	//ResultValue result = ClipReportMergeExport.createMarkAny(request, keyInfo, option);
	
	//리포트안에 2D바코드 컨트롤이 페이지에 없어도 모든 페이지의 바코드 데이터를 생성합니다.
	//ResultValue result = ClipReportMergeExport.createMarkAnyAllPage(request, keyInfo, option, propertyPath);
	
	//리포트안에 페이지에 2D바코드가 있을 경우에만 바코드 데이터를 생성합니다.
	ResultValue result = ClipReportMergeExport.createMarkAny(request, keyInfo, option, propertyPath);
	int errorCode = result.getErrorCode();
	//errorCode == 0 정상
	//errorCode == 1 리포트 서버  오류
	//errorCode == 2 oof 문서 오류
	//errorCode == 3 리포트 엔진 오류
	//errorCode == 4 결과물(document) 파일을 찾을 수 없을 때 오류
	//errorCode == 5 pdf, dat 생성시 오류
	
	//바코드로 만든 데이터 파일 위치
	//result.getDataFilePath();
	
	
	//생성된 pdf 파일 위치
	//result.getPdfFilePath();
	
	//바코드가 들어갈 좌표
	//result.getLeft();
	//result.getTop();

	//문서의 세로, 가로
	//세로 0
	//가로 1
	//int paperOrientation = result.getPaperOrientation();
	
	/*
	//음성 바코드 예제
	//음성바코드에 들어갈 회사 이름
	result.setVoiceComName("클립소프트");
	//음성바코드의 x좌표
	result.setVoiceX(160);
	//음성바코드의 y좌표
	result.setVoiceY(10);
	//음성바코드의 넓이
	result.setVoiceWidth(18);
	//음성바코드의 높이
	result.setVoiceHeight(18);
	//음성바코드의 DPI
	result.setVoiceDPI(600);

	//음성바코드 문자열 xml 반환한다.
	String voiceXmlString = ClipReportForMarkVoice.makeToXmlString(result);
	//음성바코드 파일 경로를 반환
	//String voiceXmlFilePath = ClipReportForMarkVoice.makeToXmlFile(result);

	//System.out.println(voiceXmlString);
	//System.out.println(voiceXmlFilePath);
	*/
}
%>