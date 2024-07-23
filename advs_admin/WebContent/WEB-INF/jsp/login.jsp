<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <%
String sid = session.getId()+session.getLastAccessedTime();
session.setAttribute("hid", sid);
%> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>자율주행 데이터 공유센터</title>
<script src="/js/placeholders.min.js"></script>
<script src="/js/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="/css/style.css" type="text/css" />

<script type="text/javascript">
$(document).ready(function() {
	// 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
	var userInputId = getCookie("userInputId");
	$("input[name='userId']").val(userInputId);

	if($("input[name='userId']").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
		$("#idsave").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
	}

	$("#idsave").change(function(){ // 체크박스에 변화가 있다면,
		if($("#idsave").is(":checked")){ // ID 저장하기 체크했을 때,
			var userInputId = $("input[name='userId']").val();
			setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
		}else{ // ID 저장하기 체크 해제 시,
			deleteCookie("userInputId");
		}
	});

	// ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
	$("input[name='userId']").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
		if($("#idsave").is(":checked")){ // ID 저장하기를 체크한 상태라면,
			var userInputId = $("input[name='userId']").val();
			setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
		}
	});
});

function setCookie(cookieName, value, exdays) {
	var exdate = new Date();
	exdate.setDate(exdate.getDate() + exdays);
	var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
	document.cookie = cookieName + "=" + cookieValue;
}

function deleteCookie(cookieName){
	var expireDate = new Date();
	expireDate.setDate(expireDate.getDate() - 1);
	document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}

function getCookie(cookieName) {
	cookieName = cookieName + '=';
	var cookieData = document.cookie;
	var start = cookieData.indexOf(cookieName);
	var cookieValue = '';
	if(start != -1){
		start += cookieName.length;
		var end = cookieData.indexOf(';', start);
		if(end == -1)end = cookieData.length;
		cookieValue = cookieData.substring(start, end);
	}
	return unescape(cookieValue);
}

function fn_login() {
	if ($("#userId").val() == "") {
		alert("Username은 필수항목입니다.");
		return;
	}

	if ($("#userPwd").val() == "") {
		alert("Password는 필수항목입니다.");
		return;
	}

	document.loginForm.action = "/actionLogin.do";
	document.loginForm.submit();
}
</script>
</head>

<body class="login">
<form method="post" id="loginForm" name="loginForm" action="javascript:fn_login();">
<%-- <input type="hidden" id="sid" name="sid" value="<%=sid %>"></i> --%>
<div class="loginWrapper">
	<div class="loginWrap">
		<dl>
			<dt></dt>
			<dd>자율주행 데이터 공유센터 LOGIN</dd>
		</dl>

		<div class="cont">
			<p>
				<input type="checkbox" id="idsave"><label for="idsave">아이디 저장</label>
			</p>
			<ul>
				<li>
					<input type="text" placeholder="아이디" id="userId" name="userId" onkeydown="javascript:if(event.keyCode==13){fn_login();}"><i class="ico_user"></i>
				</li>
				<li>
					<input type="password" placeholder="비밀번호" id="userPwd" name="userPwd" onkeydown="javascript:if(event.keyCode==13){fn_login();}"><i class="ico_pw"></i>
				</li>
			</ul>
			<a href="javascript:fn_login();" class="btn_login">로그인</a>
		</div>
	</div>
</div>
</body>
</form>
</html>
