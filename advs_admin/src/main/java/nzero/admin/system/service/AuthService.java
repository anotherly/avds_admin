package nzero.admin.system.service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service("authService")
public class AuthService extends EgovAbstractServiceImpl {
  private static final Logger LOGGER = LoggerFactory.getLogger(AuthService.class);
  
  @Resource(name = "commonDAO")
  private CommonDAO commonDAO;
  
  public ModelAndView selectAuthComboBox(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AuthDAO.selectAuthComboBox", paramMap);
  }
  
  public ModelAndView selectAuthList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AuthDAO.selectAuthList", paramMap);
  }
  
  public Integer selectMaxAuthId(SimpleData paramMap) throws Exception {
    return (Integer)this.commonDAO.select("AuthDAO.selectMaxAuthId", paramMap);
  }
  
  public ModelAndView insertAuth(SimpleData paramMap) throws Exception {
    return this.commonDAO.insert("AuthDAO.insertAuth", paramMap);
  }
  
  public ModelAndView updateAuth(SimpleData paramMap) throws Exception {
    return this.commonDAO.update("AuthDAO.updateAuth", paramMap);
  }
  
  public ModelAndView deleteAuth(SimpleData paramMap) throws Exception {
    return this.commonDAO.delete("AuthDAO.deleteAuth", paramMap);
  }
}
