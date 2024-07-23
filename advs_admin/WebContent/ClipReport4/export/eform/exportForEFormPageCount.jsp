<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="com.clipsoft.clipreport.server.service.eform.ClipEFormData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../Property.jsp"%><%
//리포트 키를 받아서 처리 합니다. (eform_key 파라미터 이름은 변경하여도 상관 없습니다)
String eform_key = request.getParameter("eform_key");
if(null != eform_key){
	//리포트 파일 별 페이지 수를 배열로 반환합니다.
	int[] pageCountList = ClipEFormData.getEFormPageCount(request, eform_key, propertyPath);
	for(int i=0; i<pageCountList.length; i++){
		System.out.println(pageCountList[i]);
	}
}
%>