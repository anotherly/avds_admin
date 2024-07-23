package nzero.admin.system.service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service("menuService")
public class MenuService extends EgovAbstractServiceImpl {
  private static final Logger LOGGER = LoggerFactory.getLogger(MenuService.class);
  
  @Resource(name = "commonDAO")
  private CommonDAO commonDAO;
  
  public ModelAndView selectMenuComboBox(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("MenuDAO.selectMenuComboBox", paramMap);
  }
  
  public ModelAndView selectMenuList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("MenuDAO.selectMenuList", paramMap);
  }
  
  public ModelAndView insertMenu(SimpleData paramMap) throws Exception {
    return this.commonDAO.insert("MenuDAO.insertMenu", paramMap);
  }
  
  public ModelAndView updateMenu(SimpleData paramMap) throws Exception {
    return this.commonDAO.update("MenuDAO.updateMenu", paramMap);
  }
  
  public ModelAndView deleteMenu(SimpleData paramMap) throws Exception {
    return this.commonDAO.delete("MenuDAO.deleteMenu", paramMap);
  }
}
