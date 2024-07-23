package nzero.admin.main.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.User;
import nzero.admin.egovframework.cmmn.service.impl.UserVo;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.main.service.LoginService;
import nzero.admin.system.service.SvrResourceService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

@Controller
@SessionAttributes(types = {UserVo.class})
public class LoginController extends BaseController {
  private static final Logger LOGGER = LoggerFactory.getLogger(LoginController.class);
  
  @Resource(name = "loginService")
  private LoginService loginService;
  
  @Resource(name = "svrResourceService")
  private SvrResourceService svrResourceService;
  
  @RequestMapping({"/openLogin.do"})
  public String openLogin(HttpServletRequest request, HttpServletResponse response) {
    User user = new User(request.getSession());
    user.logout();
    return "login";
  }
  
  @RequestMapping({"/actionLogin.do"})
  public String actionLogin(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    
    UserVo userVo = this.loginService.setUserVo(request, paramMap);
    
    User user = new User(request.getSession());
    user.setSessionId(userVo.getSessionId());
    user.setUserId(userVo.getUserId());
    user.setUserNm(userVo.getUserNm());
    user.setUserPwd(userVo.getUserPwd());
    user.setAuthId(userVo.getAuthId());
    user.setUserIp(userVo.getUserIp());

    String url = "/openMain.do";
    /*String csrfToken = UUID.randomUUID().toString();
    session.setAttribute("CSRF_TOKEN", csrfToken);
    
    String sid = request.getParameter("sid");
    String hid = (String) request.getSession().getAttribute("hid");
    
    if(sid.equals(hid)) {
    	String clientIp = request.getHeader("X-FORWARDED-FOR");
    	if(clientIp == null) {
    		clientIp = request.getRemoteAddr();
    	}*/
    	
    	String result = svrResourceService.insertResourceHist(user);
    	
    	/*if(result == null) {
    		request.setAttribute("hid", "");
    		//response.sendRedirect("/openMain.do");
    		
    	}else{
    		PrintWriter writer = response.getWriter();
    		response.setContentType("text/html; charset=UTF-8;");
    		request.setCharacterEncoding("utf-8");
    		writer.println("<script type='text/javascript'>");
    		writer.println("alert('비정상적인 접근입니다.');");
    		writer.println("history.back();");
    		writer.println("</script>");
    		writer.flush();
    	}
    }else {
    	PrintWriter writer = response.getWriter();
    	response.setContentType("text/html; charset=UTF-8;");
    	request.setCharacterEncoding("utf-8");
    	writer.println("<script type='text/javascript'>");
    	writer.println("alert('비정상적인 접근입니다.');");
    	writer.println("history.back();");
    	writer.println("</script>");
    	writer.flush();
    }*/
    
    
    /* 관리자 시스템접속이력 등록
     시스템접속이력을 관리자가 시스템에 접속한 이력을 관리하는 페이지로 변경
     기존 사용하는 TB_CM_HT_SERVERRESOURCE 테이블을 이용하여 만들어서
     컬럼을 맘대로 사용함.
      LOG_ID = AUTHID(권한ID와 로그ID가 0003으로 같아서 맵핑함)
      REG_DATE = 접속한 시간
      SERVER_ID = USERID
      SERVER_NM = USERNM
      SERVER_IP = USERIP
      나머지 컬럼은 의미없어서 NULL
    */
    
    user.login();
    
    return "redirect:"+url;
  }
  
  @RequestMapping({"/openMain.do"})
  public String openMain() {
    return "main";
  }
  
  @RequestMapping({"/selectMainMenuList.do"})
  @ResponseBody
  public ModelAndView selectMainMenuList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    paramMap.put("authId", (new User(request.getSession())).getAuthId());
    return this.loginService.selectMainMenuList(paramMap);
  }
  
  @RequestMapping({"/selectMenu.do"})
  @ResponseBody
  public ModelAndView selectMenu(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.loginService.selectMenu(paramMap);
  }
  
  @RequestMapping({"/actionLogout.do"})
  public String actionLogout(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
    User user = new User(request.getSession());
    user.logout();
    return "redirect:/";
  }
  
  @RequestMapping({"/openInit.do"})
  public String openInit(HttpServletRequest request) {
    return "init";
  }
}
