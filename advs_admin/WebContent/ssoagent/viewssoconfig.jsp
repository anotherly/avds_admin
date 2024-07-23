<%@ page import="com.nets.sso.agent.AuthUtil" %>
<%@ page import="com.nets.sso.agent.configuration.SSOConfig" %>
<%@ page import="com.nets.sso.agent.configuration.SSOProvider" %>
<%@ page import="com.nets.sso.agent.configuration.SSOSite" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    SSOProvider provider = SSOConfig.getInstance().getCurrentSSOProvider(request.getServerName());
    SSOSite site = SSOConfig.getInstance().getCurrentSSOSite(request.getServerName());
    if (null == provider || site == null) {
%>Can not find configuration for '<%=request.getServerName()%>'.<%
} else {
%>
<html>
<head><title>SSO 환경설정</title></head>
<body>
<table align="center" border="0" cellpadding="=0" cellspacing="0" width="100%">
    <tr>
        <td valign="top">
            <table border="0" cellpadding="0" cellspacing="0" width="120">
                <tr class="text-blackgul">
                    <td align="center" height="24" width="120">SSO 환경설정</td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td valign="top">
            <table bgcolor="#074C91" border="0" cellpadding="01" cellspacing="1" style="width:900px;">
                <tr>
                    <td bgcolor="#FFFFFF" valign="top" width="100%">
                        <table border="0" cellspacing="6" width="100%">
                            <tr>
                                <td valign="top">
                                    <table align="left" bgcolor="#FFFFFF" border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td valign="top">
                                                <table align="left" bgcolor="#FFFFFF" border="0" cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td>빌드번호</td>
                                                        <td><%=provider.getPolicyVer()%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>사용자 ID 입력 태그명</td>
                                                        <td><%=provider.getParamName(AuthUtil.ParamInfo.USER_ID)%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>비빌번호 입력 태그명</td>
                                                        <td><%=provider.getParamName(AuthUtil.ParamInfo.USER_PW)%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>자격증명 종류 태그명</td>
                                                        <td><%=provider.getParamName(AuthUtil.ParamInfo.CRED_TYPE)%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>리턴 URL 태그명</td>
                                                        <td><%=provider.getParamName(AuthUtil.ParamInfo.RETURN_URL)%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>로그온 요청 URL</td>
                                                        <td><%=provider.getLogonUrl(request, site.getSiteDNS())%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>로그오프 요청 URL</td>
                                                        <td><%=provider.getLogoffUrl(request, site.getSiteDNS())%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>인증 검사 요청 URL</td>
                                                        <td><%=provider.getAuthCheckUrl(request, site.getSiteDNS())%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>중앙인증 도메인</td>
                                                        <td><%=provider.getProviderDomain()%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>인증요청 IP 검사 여부</td>
                                                        <td><%=provider.getClientIPCheck()%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>인증 유효 기간(idle-timeout)</td>
                                                        <td><%=provider.getIdleTimeout()%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>체크 주기(idle-timeout)</td>
                                                        <td><%=provider.getIdleTimeoutInterval()%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>인증 만료 시간 사용 여부</td>
                                                        <td><%=provider.getTokenExpiredYN()%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>인증 만료 시간</td>
                                                        <td><%=provider.getTokenExpiredTimeout()%> (Hour)</td>
                                                    </tr>
                                                    <tr>
                                                        <td>중복 로그온 방지 정책 사용여부</td>
                                                        <td><%=provider.getDuplicationYN()%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>세션 재설정 시간</td>
                                                        <td><%=provider.getDuplicationCheckIntervalMinutes()%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>SSO 도메인</td>
                                                        <td><%=site.getSsoDomain()%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>SSO 참여 여부</td>
                                                        <td><%=site.getSsoYN()%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>SSO 도메인 인증 쿠키</td>
                                                        <td><%=site.getTokenConfig().getName()%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>SSO 참여 여부</td>
                                                        <td><%=site.getSsoYN()%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>SSO 사용자정보 쿠키</td>
                                                        <td><%=site.getAttributeConfig().getName()%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>SSO 도메인 쿠키목록</td>
                                                        <td>
                                                            <table width="500px">
                                                                <tr>
                                                                    <td>
                                                                        <table bgcolor="#E0E0E0" border="0" cellpadding="0" cellspacing="1" width="50%">
                                                                            <tr bgcolor="#C7DDF3" class="text-black">
                                                                                <td align="center" height="20" width="40%">쿠키명</td>
                                                                            </tr>
                                                                            <%
                                                                                if (site.getAttributeConfig().getAttributeNames() != null && site.getAttributeConfig().getAttributeNames().length > 0) {
                                                                                    for (int i = 0; i < site.getAttributeConfig().getAttributeNames().length; i++) {
                                                                            %>
                                                                            <tr>
                                                                                <td><%=site.getAttributeConfig().getAttributeNames()[i]%>
                                                                                </td>
                                                                            </tr>
                                                                            <%
                                                                                    }
                                                                                }
                                                                            %>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>SSO 사이트명</td>
                                                        <td><%=site.getSiteDomain()%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>HttpOnly</td>
                                                        <td><%=site.getTokenConfig().getHttpOnly()%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Secure</td>
                                                        <td><%=site.getTokenConfig().getSecure()%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>
</html>
<%
    }
%>