<%@page import="com.clipsoft.clipreport.export.option.JPGOption"%>
<%@page import="com.clipsoft.clipreport.oof.OOFFile"%>
<%@page import="com.clipsoft.clipreport.oof.OOFDocument"%>
<%@page import="com.clipsoft.clipreport.oof.reader.OOFReader"%>
<%@page import="com.clipsoft.org.apache.commons.codec.binary.Base64"%>
<%@page import="com.clipsoft.clipreport.server.service.ClipReportExport"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileOutputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../Property.jsp"%>
<%

String is_svg = request.getParameter("is_svg");
if(null != is_svg && !"true".equals(is_svg)){
    is_svg = "jpg";
}

out.clear(); // where out is a JspWriter
out = pageContext.pushBody();

byte[] decoded = Base64.decodeBase64(request.getParameter("oof"));
String oofString = new String(decoded, "UTF-8");
System.out.println(oofString);
OOFDocument oof = OOFReader.open(oofString, false);
OOFFile file = oof.addFile("crf.root", "%root%/crf/CLIP.crf");

// 크로스도메인 허용
//response.setHeader("Access-Control-Allow-Origin", "*");

//클라이언트 브라우져에서 바로 보는 방법(헤더 변경)
if(is_svg.equals("jpg")){
    response.setContentType("image/jpeg");
}
else{
    response.setContentType("image/svg+xml");
}

OutputStream fileStream = response.getOutputStream();
JPGOption jpgOption = new JPGOption();
//X DPI 설정
jpgOption.setDpiX(96);
//Y DPI 설정
jpgOption.setDpiY(96);
//품질(1~100)
jpgOption.setQuality(100);
//회전
jpgOption.setRotate90(false);

int pageNumber = 1;
int statusType = ClipReportExport.createExportForPageImage(request, fileStream, propertyPath, oof, jpgOption, pageNumber, is_svg);
//statusType == 0 정상적인 출력
//statusType == 1 인스톨 오류
//statusType == 2 oof 문서 오류
//statusType == 3 리포트 엔진 오류
//statusType == 4 img 출력 오류
%>