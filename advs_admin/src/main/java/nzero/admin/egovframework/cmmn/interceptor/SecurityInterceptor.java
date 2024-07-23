package nzero.admin.egovframework.cmmn.interceptor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONObject;
import nzero.admin.egovframework.cmmn.service.impl.UserVo;
import nzero.admin.egovframework.cmmn.util.SecurityException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

@Service("securityInterceptor")
public class SecurityInterceptor extends HandlerInterceptorAdapter {
  private static final Logger LOGGER = LoggerFactory.getLogger(SecurityInterceptor.class);
  
  List<String> urls;
  
  public void setUrls(List<String> urls) {
    this.urls = urls;
  }
  
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    for (int i = 0; i < this.urls.size(); i++) {
      if (request.getRequestURI().matches(this.urls.get(i)))
        return true; 
    } 
    boolean ajaxFlag = false;
    if ("XMLHttpRequest".equals(request.getHeader("x-requested-with")))
      ajaxFlag = true; 
    UserVo userVo = (UserVo)request.getSession().getAttribute("userVo");
    if (userVo == null) {
      if (ajaxFlag) {
        showAjaxMessage("", response);
        return false;
      } 
      throw new SecurityException("");
    } 
    return true;
  }
  
  public void showAjaxMessage(String msg, HttpServletResponse response) throws Exception {
    Map<String, Object> data = new HashMap<>();
    data.put("interceptorMsg", msg);
    JSONObject json = new JSONObject();
    json.putAll(data);
    response.setContentType("text/html; charset=UTF-8");
    response.getWriter().print(json.toString());
  }
  
  public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {}
}
