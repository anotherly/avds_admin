package nzero.admin.system.service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service("webMenuService")
public class WebMenuService extends EgovAbstractServiceImpl {
  private static final Logger LOGGER = LoggerFactory.getLogger(WebMenuService.class);
  
  @Resource(name = "commonDAO")
  private CommonDAO commonDAO;
  
  public ModelAndView selectMenuComboBox(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("WebMenuDAO.selectMenuComboBox", paramMap);
  }
  
  public ModelAndView selectMenuList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("WebMenuDAO.selectMenuList", paramMap);
  }
  
  public ModelAndView insertMenu(SimpleData paramMap) throws Exception {
    return this.commonDAO.insert("WebMenuDAO.insertMenu", paramMap);
  }
  
  public ModelAndView updateMenu(SimpleData paramMap) throws Exception {
    return this.commonDAO.update("WebMenuDAO.updateMenu", paramMap);
  }
  
  public ModelAndView deleteMenu(SimpleData paramMap) throws Exception {
    return this.commonDAO.delete("WebMenuDAO.deleteMenu", paramMap);
  }
}
