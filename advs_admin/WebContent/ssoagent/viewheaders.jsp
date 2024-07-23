<%@ page import="java.util.Enumeration" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<html>
<head><title>SSO 통합인증 테스트 사이트</title></head>
<body>
<%
    //JDK 1.4
//    Enumeration eHeader = request.getHeaderNames();
    //JDK1.5
    Enumeration<String> eHeader = request.getHeaderNames();
    while (eHeader.hasMoreElements()) {
        String hName = (String) eHeader.nextElement();
        String hValue = request.getHeader(hName);
%>
<%=hName + ":" + hValue%><br/>
<%
    }
%>
<br/>
requeset.getServerName():<%=request.getServerName()%><br/>
</body>
</html>
