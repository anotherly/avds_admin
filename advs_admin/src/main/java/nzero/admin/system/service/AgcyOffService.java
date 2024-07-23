package nzero.admin.system.service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service("agcyOffService")
public class AgcyOffService extends EgovAbstractServiceImpl {
  private static final Logger LOGGER = LoggerFactory.getLogger(AgcyOffService.class);
  
  @Resource(name = "commonDAO")
  private CommonDAO commonDAO;
  
  public ModelAndView selectAgcyOffList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AgcyOffDAO.selectAgcyOffList", paramMap);
  }
}
