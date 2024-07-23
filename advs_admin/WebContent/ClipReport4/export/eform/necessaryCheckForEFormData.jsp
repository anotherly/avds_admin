<%@page import="com.clipsoft.clipreport.server.service.eform.EFormNecessaryStatus"%>
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
if(null != eform_key){
	//서버에 저장된 리포트의 입력 데이터를 체크합니다.
	EFormNecessaryStatus checkStatus = ClipEFormData.getEFormNecessaryCheck(request, eform_key, propertyPath);
	if(checkStatus.isNecessaryCheck()){
		//필수 항목 체크가 모두 정상 일 경우
		System.out.println("message : " + checkStatus.getMessage());
	}
	else{
		//들어오는 경우
		//1. 서버에 리포트 엔진이 정상적으로 설치되지 않았을 때 	
		//2. 서버에서 리포트 키로 저장된 데이터를 못 찾을 때
		//3. 필수항목을 체크해야 하는 컨트롤에  입력값이 없을 때 
		
		//필수항목 체크가 걸린 컨트롤의 key명
		System.out.println("control key : " + checkStatus.getControlKey());
		//필수항목 체크가 걸린 컨트롤의 페이지 번호
		System.out.println("pageNmuber : " + checkStatus.getPageNumber());
		//필수항목 체크가 걸린 컨트롤의 메시지
		System.out.println(checkStatus.getMessage());
	}
}
%>