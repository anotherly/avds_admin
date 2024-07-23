<%@page import="com.clipsoft.clipreport.export.option.PDFOption"%>
<%@page import="com.clipsoft.clipreport.oof.OOFFile"%>
<%@page import="com.clipsoft.clipreport.oof.OOFDocument"%>
<%@page
	import="com.clipsoft.clipreport.server.service.ClipReportPDFForRedBC"%>
<%@ page import="java.util.*,java.io.*,  java.lang.Integer, java.net.*"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="com.clipsoft.clipreport.server.service.ResultValue"%>
<%@page import="com.clipsoft.clipreport.server.service.ClipReportExport"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileOutputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../../Property.jsp"%>
<%
	//리포트 키를 받아서 처리 합니다. (report_key 파라미터 이름은 변경하여도 상관 없습니다)
	String report_key = request.getParameter("report_key");

	ResultValue result = new ResultValue();
	if (null != report_key) {
		PDFOption option = new PDFOption();
		/*
		option = new PDFOption();
		option.setUserPassword("사용자(읽기) 암호");
		option.setOwnerPassword("저자(쓰기) 암호");
		option.setTextToImage(true); // 글자를 이미지로 처리 - unicode 처리시 사용
		option.setImportOriginImage(true); // 원본 이미지 삽입
		option.setNotAllowCopy(true); //text복사 방지 (1.0.0.84 version 부터 적용)
		option.setEditable(false); // 편집 허용 여부 (1.0.0.173 version 부터 적용)
		*/

		//전자서식에서 서버에 저장되어 있다면 형광펜을 export 할 때 추가할지 여부
		//option.setDoodlePen(true);

		//pdf 생성 및 바코드 데이터 생성 호출 메소드입니다.
		result = ClipReportPDFForRedBC.createPartRedBC(request, report_key, propertyPath, option);
		int errorCode = result.getErrorCode();
		//errorCode == 0 정상
		//errorCode == 1 세션안에 리포트정보가 없을 때 오류 
		//errorCode == 2 리포트 서버가 설치가 안되어 있을 때 오류 
		//errorCode == 3 결과물(document) 파일을 찾지 못할 때 발생하는 오류
		//errorCode == 4 결과물(document) 파일을 찾을 수 없을 때 오류
		//errorCode == 5 pdf, dat 생성시 오류

		//ResultValue 객체를 이용하여 연동하시면 될 것 같습니다. 

		//window 예제
		//result.getPdfFilePath().replaceAll("\\/\\\\", "\\\\").replaceAll("\\/", "\\\\");

		//페이지 수
		//int pageCount = result.getPageCount();

		//저장된 파일 삭제 (파일을 사용하시고 아래의 메소드를 호출하시면 파일이 삭제됩니다.)
		//ClipReportPDFForRedBC.delete(result);
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>연동 TEST</title>
</head>
<body>
	<h2>쉽게 보실 수 있게 html에 출력하였습니다.</h2>
	<br> 서버에 생성된 pdf 위치 :
	<%=result.getPdfFilePath()%>
	<br> 서버에 생성된 바코드 데이터 위치 :
	<%=result.getDataFilePath()%>
	<br> 바코드 좌표 left :
	<%=result.getLeft()%>
	<br> 바코드 좌표 top :
	<%=result.getTop()%>
	<br> 바코드 좌표 right :
	<%=result.getRight()%>
	<br> 바코드 좌표 bottom :
	<%=result.getBottom()%>
	<br> 리포트 Key:
	<%=result.getKey()%>
	<br>
</body>
</html>