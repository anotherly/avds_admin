package nzero.admin.main.service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;
import nzero.admin.egovframework.cmmn.service.impl.UserVo;
import nzero.admin.egovframework.cmmn.util.EgovMessageSource;
import nzero.admin.egovframework.cmmn.util.SecurityException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service("loginService")
public class LoginService extends EgovAbstractServiceImpl {
  private static final Logger LOGGER = LoggerFactory.getLogger(LoginService.class);
  
  @Resource(name = "egovMessageSource")
  private EgovMessageSource egovMessageSource;
  
  @Resource(name = "commonDAO")
  private CommonDAO commonDAO;
  
  public UserVo setUserVo(HttpServletRequest request, SimpleData data) throws Exception {
    if (data == null)
      throw new SecurityException(this.egovMessageSource.getMessage("fail.common.login")); 
    if (data.size() == 0)
      throw new SecurityException(this.egovMessageSource.getMessage("fail.common.login")); 
    UserVo user = null;
    user = (UserVo)this.commonDAO.select("LoginDAO.selectUserVo", data);
    if (user == null)
      throw new SecurityException(this.egovMessageSource.getMessage("fail.common.login")); 
    data.setString("userIp", request.getRemoteAddr());
    user.setSessionId(request.getSession().getId());
    user.setUserIp(data.getString("userIp"));
    String userPwd = data.getString("userPwd");
    if (!userPwd.equals(user.getUserPwd()))
      throw new SecurityException(this.egovMessageSource.getMessage("fail.common.login")); 
    LOGGER.debug(user.toString());
    return user;
  }
  
  public ModelAndView selectMainMenuList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("LoginDAO.selectMainMenuList", paramMap);
  }
  
  public ModelAndView selectMenu(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("LoginDAO.selectMenu", paramMap);
  }
}
