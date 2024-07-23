package nzero.admin.statistics.service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service("reportStatService")
public class ReportStatService extends EgovAbstractServiceImpl {
  private static final Logger LOGGER = LoggerFactory.getLogger(ReportStatService.class);
  
  @Resource(name = "commonDAO")
  private CommonDAO commonDAO;
  
  public ModelAndView selectReportStatList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ReportStatDAO.selectReportStatList", paramMap);
  }
}
