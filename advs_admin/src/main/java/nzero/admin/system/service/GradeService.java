package nzero.admin.system.service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service("gradeService")
public class GradeService extends EgovAbstractServiceImpl {
  private static final Logger LOGGER = LoggerFactory.getLogger(GradeService.class);
  
  @Resource(name = "commonDAO")
  private CommonDAO commonDAO;
  
  public ModelAndView selectGradeList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("GradeDAO.selectGradeList", paramMap);
  }
  
  public ModelAndView updateGrade(SimpleData paramMap) throws Exception {
    return this.commonDAO.update("GradeDAO.updateGrade", paramMap);
  }
}
