
var timerNTLM;
var browserName = getBrowserName();

function setTimeoutNTLM() {
    if (browserName === "IE") {
        timerNTLM = window.setTimeout(timeoutNTLM, 60000);
    }
}
function timeoutNTLM(){
    clearTimeout(timerNTLM);
    alert("HTTP keep-alive was expired.\nRe-checking Windows-Authentication.");
    checkWA();
}

function checkWindowsAuth(ssoUrl, tagNameSite, ssosite, tagNameRet, returnUrl){
    window.location.href = ssoUrl + '?' + tagNameSite + '=' + ssosite + '&' + tagNameRet + '=' + encodeURIComponent(encodeURIComponent(returnUrl));
}


function getBrowserName() {
    var browserName;

    // Opera 8.0+
    if ((window.opr && opr.addons) || window.opera || (navigator.userAgent.indexOf(' OPR/') >= 0))
        browserName = "Opera";

    // Firefox 1.0+
    if (typeof InstallTrigger !== 'undefined')
        browserName = "Firefox";

    // At least Safari 3+: "[object HTMLElementConstructor]"
    if (Object.prototype.toString.call(window.HTMLElement).indexOf('Constructor') > 0)
        browserName = "Safari";

    // Internet Explorer 6-11
    if ((/*@cc_on!@*/false) || (document.documentMode))
        browserName = "IE";

    // Edge 20+
    if (!(document.documentMode) && window.StyleMedia)
        browserName = "IE";   //Edge

    // Chrome 1+
    if (window.chrome && window.chrome.webstore)
        browserName = "Chrome";

    return browserName;
}