package nzero.admin.egovframework.cmmn.service.impl;

import java.util.HashMap;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import nzero.admin.egovframework.cmmn.util.EgovMessageSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class User extends UserVo {
  private static final Logger LOGGER = LoggerFactory.getLogger(User.class);
  
  @Resource(name = "egovMessageSource")
  private EgovMessageSource egovMessageSource;
  
  private static final String USER_VO = "userVo";
  
  private static final String LISTENER = "listener";
  
  private HttpSession sess = null;
  
  private static Map<String, HttpSession> sessions = new HashMap<>();
  
  private static int nowUser = 0;
  
  public User(HttpSession sess) {
    this.sess = sess;
    checkSession();
  }
  
  private void checkSession() {
    if (this.sess == null)
      return; 
    UserVo userVo = (UserVo)this.sess.getAttribute("userVo");
    if (userVo == null || userVo.getUserId() == null || "".equals(userVo.getUserId())) {
      this.sessionId = "";
      this.userId = "";
      this.userNm = "";
      this.userPwd = "";
      this.authId = "";
      this.userIp = "";
    } else {
      this.sessionId = userVo.getSessionId();
      this.userId = userVo.getUserId();
      this.userNm = userVo.getUserNm();
      this.userPwd = userVo.getUserPwd();
      this.authId = userVo.getAuthId();
      this.userIp = userVo.getUserIp();
    } 
  }
  
  public UserVo getUserVo() {
    UserVo userVo = new UserVo();
    userVo.setSessionId(this.sessionId);
    userVo.setUserId(this.userId);
    userVo.setUserNm(this.userNm);
    userVo.setUserPwd(this.userPwd);
    userVo.setAuthId(this.authId);
    userVo.setUserIp(this.userIp);
    return userVo;
  }
  
  public void login(UserVo userVo) {
    try {
      if (userVo == null || userVo.getUserId() == null || "".equals(userVo.getUserId()))
        throw new SecurityException(this.egovMessageSource.getMessage("fail.common.login")); 
      this.sess.setAttribute("userVo", userVo);
      this.sess.setAttribute("listener", new CustomBindingListener());
    } catch (Exception e) {
      LOGGER.debug(" =>" + e.getMessage());
    } 
  }
  
  public void login() {
    UserVo userVo = getUserVo();
    login(userVo);
  }
  
  public void logout() {
    this.sess.removeAttribute("userVo");
    this.sess.removeAttribute("listener");
  }
  
  public static void sessionCreated(HttpSessionBindingEvent event) {
    LOGGER.debug("----------- sessionCreated:" + event.getSession().getId());
    setNowUser(1);
    sessions.put(event.getSession().getId(), event.getSession());
  }
  
  public static void sessionDestroyed(HttpSessionBindingEvent event) {
    LOGGER.debug("---------- sessionDestroyed:" + event.getSession().getId());
    setNowUser(-1);
    sessions.remove(event.getSession().getId());
  }
  
  public static Map getAllSession() {
    return sessions;
  }
  
  protected static void setNowUser(int x) {
    nowUser += x;
  }
  
  public static int getNowUser() {
    return nowUser;
  }
}
