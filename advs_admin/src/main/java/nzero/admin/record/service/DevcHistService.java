package nzero.admin.record.service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service("devcHistService")
public class DevcHistService extends EgovAbstractServiceImpl {
  private static final Logger LOGGER = LoggerFactory.getLogger(DevcHistService.class);
  
  @Resource(name = "commonDAO")
  private CommonDAO commonDAO;
  
  public ModelAndView selectDevcHistList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("DevcHistDAO.selectDevcHistList", paramMap);
  }
  
  public ModelAndView selectDevcExcelList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("DevcHistDAO.selectDevcExcelList", paramMap);
  }
}
