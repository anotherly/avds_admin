<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>서명/인감</title>
</head>
<body>
	<form>
		성명 : <input type = "text" id = "nameVal">
		<!-- 서명 : <input type = "radio" name = "signIngam" id="sign" value="2">  인감 : <input type = "radio" name = "signIngam" id="ingam" value="1"> -->
        <label for="signIngamB">
		<input type="radio" name="signIngam" id="sign" value="2" checked="">
        <span>서명</span>
        </label>
		<label for="signIngamA">
		<input type="radio" name="signIngam" id="ingam" value="1">
        <span>인감</span>
        </label>
		<input type = "button" value = "확인" onClick = "sendValue();">
	</form>
	<script>
		function sendValue() {
			//window.opener.document.getElementById().value = document.getElementById("testValue").value;
			var inputValue = document.querySelector('input[name="signIngam"]:checked');
			var nameVal = document.getElementById("nameVal").value;
			if(nameVal != ""){
				window.opener.putControlValue(inputValue.value, nameVal);
				window.close();
			}else{
				alert("성명을 입력하세요");
				return;
			}
		}
	</script>
</body>
</html>