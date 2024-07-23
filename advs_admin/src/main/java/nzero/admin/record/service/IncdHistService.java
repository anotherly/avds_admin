package nzero.admin.record.service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service("incdHistService")
public class IncdHistService extends EgovAbstractServiceImpl {
  private static final Logger LOGGER = LoggerFactory.getLogger(IncdHistService.class);
  
  @Resource(name = "commonDAO")
  private CommonDAO commonDAO;
  
  public ModelAndView selectIncdList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("IncdHistDAO.selectIncdList", paramMap);
  }
  
  public ModelAndView selectAccCarList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("IncdHistDAO.selectAccCarList", paramMap);
  }
  
  public ModelAndView selectIncdExcelList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("IncdHistDAO.selectIncdExcelList", paramMap);
  }
}
