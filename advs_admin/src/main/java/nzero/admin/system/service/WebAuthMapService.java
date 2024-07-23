package nzero.admin.system.service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service("webAuthMapService")
public class WebAuthMapService extends EgovAbstractServiceImpl {
  private static final Logger LOGGER = LoggerFactory.getLogger(WebAuthMapService.class);
  
  @Resource(name = "commonDAO")
  private CommonDAO commonDAO;
  
  public ModelAndView selectAuthMapList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("WebAuthMapDAO.selectAuthMapList", paramMap);
  }
  
  public ModelAndView deleteAuthMap(SimpleData paramMap) throws Exception {
    return this.commonDAO.delete("WebAuthMapDAO.deleteAuthMap", paramMap);
  }
  
  public ModelAndView insertAuthMap(SimpleData paramMap) throws Exception {
    return this.commonDAO.insert("WebAuthMapDAO.insertAuthMap", paramMap);
  }
}
