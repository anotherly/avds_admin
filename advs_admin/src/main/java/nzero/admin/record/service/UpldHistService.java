package nzero.admin.record.service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service("upldHistService")
public class UpldHistService extends EgovAbstractServiceImpl {
  private static final Logger LOGGER = LoggerFactory.getLogger(UpldHistService.class);
  
  @Resource(name = "commonDAO")
  private CommonDAO commonDAO;
  
  public ModelAndView selectUpldHistList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("UpldHistDAO.selectUpldHistList", paramMap);
  }
  
  public ModelAndView selectUpldExcelList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("UpldHistDAO.selectUpldExcelList", paramMap);
  }
}
