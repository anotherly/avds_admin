package nzero.admin.system.service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service("webAuthService")
public class WebAuthService extends EgovAbstractServiceImpl {
  private static final Logger LOGGER = LoggerFactory.getLogger(WebAuthService.class);
  
  @Resource(name = "commonDAO")
  private CommonDAO commonDAO;
  
  public ModelAndView selectAuthComboBox(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("WebAuthDAO.selectAuthComboBox", paramMap);
  }
  
  public ModelAndView selectAuthList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("WebAuthDAO.selectAuthList", paramMap);
  }
  
  public Integer selectMaxAuthId(SimpleData paramMap) throws Exception {
    return (Integer)this.commonDAO.select("WebAuthDAO.selectMaxAuthId", paramMap);
  }
  
  public ModelAndView insertAuth(SimpleData paramMap) throws Exception {
    return this.commonDAO.insert("WebAuthDAO.insertAuth", paramMap);
  }
  
  public ModelAndView updateAuth(SimpleData paramMap) throws Exception {
    return this.commonDAO.update("WebAuthDAO.updateAuth", paramMap);
  }
  
  public ModelAndView deleteAuth(SimpleData paramMap) throws Exception {
    return this.commonDAO.delete("WebAuthDAO.deleteAuth", paramMap);
  }
}
