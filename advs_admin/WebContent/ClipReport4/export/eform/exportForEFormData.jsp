<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="com.clipsoft.clipreport.server.service.ClipEFormExport"%>
<%@page import="com.clipsoft.clipreport.server.service.ExportInfo"%>
<%@page import="com.clipsoft.org.json.simple.parser.JSONParser"%>
<%@page import="com.clipsoft.org.json.simple.JSONObject"%>
<%@page import="com.clipsoft.clipreport.server.service.eform.ClipEFormData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@include file="../../Property.jsp"%><%
    
//리포트 키를 받아서 처리 합니다. (eform_key 파라미터 이름은 변경하여도 상관 없습니다)
String eform_key = request.getParameter("eform_key");
String eform_data = "";
if(null != eform_key){
	//입력 컨트롤의 설정까지 모두 포함한 데이터
	eform_data = ClipEFormData.getEFormSaveData(request, eform_key, propertyPath);
	System.out.println(eform_data);
	
	//uid를 포함한 json 데이터
	//eform_data = ClipEFormData.getEFormSaveDataInculdeKey(request, eform_key, propertyPath);
	
	//입력 컨트롤의 키 -데이터 형태의 데이터
	eform_data = ClipEFormData.getEFormData(request, eform_key, propertyPath);
	System.out.println(eform_data);
}
%>