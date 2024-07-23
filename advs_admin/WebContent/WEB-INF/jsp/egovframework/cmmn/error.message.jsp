<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=utf-8"%>

<script type="text/javascript">
var info_message = '${exception.message}';

if (info_message != '') {
    alert(info_message);
    top.location.href = "/";
}


</script>