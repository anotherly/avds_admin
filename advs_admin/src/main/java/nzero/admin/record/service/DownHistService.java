package nzero.admin.record.service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service("downHistService")
public class DownHistService extends EgovAbstractServiceImpl {
  private static final Logger LOGGER = LoggerFactory.getLogger(DownHistService.class);
  
  @Resource(name = "commonDAO")
  private CommonDAO commonDAO;
  
  public ModelAndView selectDownHistList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("DownHistDAO.selectDownHistList", paramMap);
  }
  
  public ModelAndView selectDownExcelList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("DownHistDAO.selectDownExcelList", paramMap);
  }
}
