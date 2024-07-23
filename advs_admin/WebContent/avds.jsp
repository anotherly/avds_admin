<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
Connection conn=null;
String driver = "com.tmax.tibero.jdbc.TbDriver";
//String url = "jdbc:tibero:thin:@192.168.1.42:8629:tsasc";
String url = "jdbc:tibero:thin:@220.89.252.68:8629:tsasc";

	
Boolean connect = false;
String sql = "";
ResultSet res;

try{
    Class.forName(driver);
    conn=DriverManager.getConnection(url,"avds","avds"); //자신의 아이디와 비밀번호
    connect = true;
   
    sql = "select * from TB_CM_HT_TEMPOPER ";
    res = conn.prepareStatement(sql).executeQuery();
    
    
     while (res.next()) {
		out.print(res.getString("tmp_race_number") + "	" + res.getString("tmp_race_agency") + "	" + res.getString("ins_init_date") + "	" + res.getString("permit_date") + "<br/>");
    }     
    
    conn.close();
}catch(Exception e){
    connect = false;
    e.printStackTrace();
}
%>
<%
if(connect==true){%>
    연결되었습니다.
<%}else{ %>
    연결에 실패하였습니다.
<%}%> 
