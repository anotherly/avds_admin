package nzero.admin.statistics.service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service("controlStatService")
public class ControlStatService extends EgovAbstractServiceImpl {
  private static final Logger LOGGER = LoggerFactory.getLogger(ControlStatService.class);
  
  @Resource(name = "commonDAO")
  private CommonDAO commonDAO;
  
  public ModelAndView selectMonAll(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ControlStatDAO.selectMonAll", paramMap);
  }
  
  public ModelAndView selectMonAllChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ControlStatDAO.selectMonAllChart", paramMap);
  }
  
  public ModelAndView selectMonCnt(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ControlStatDAO.selectMonCnt", paramMap);
  }
  
  public ModelAndView selectMonCntChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ControlStatDAO.selectMonCntChart", paramMap);
  }
  
  public ModelAndView selectMonTemp(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ControlStatDAO.selectMonTemp", paramMap);
  }
  
  public ModelAndView selectMonTempChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ControlStatDAO.selectMonTempChart", paramMap);
  }
  
  public ModelAndView selectMonUser(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ControlStatDAO.selectMonUser", paramMap);
  }
  
  public ModelAndView selectMonUserChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ControlStatDAO.selectMonUserChart", paramMap);
  }
  
  public ModelAndView selectYearAll(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ControlStatDAO.selectYearAll", paramMap);
  }
  
  public ModelAndView selectYearAllChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ControlStatDAO.selectYearAllChart", paramMap);
  }
  
  public ModelAndView selectYearCnt(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ControlStatDAO.selectYearCnt", paramMap);
  }
  
  public ModelAndView selectYearCntChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ControlStatDAO.selectYearCntChart", paramMap);
  }
  
  public ModelAndView selectYearTemp(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ControlStatDAO.selectYearTemp", paramMap);
  }
  
  public ModelAndView selectYearTempChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ControlStatDAO.selectYearTempChart", paramMap);
  }
  
  public ModelAndView selectYearUser(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ControlStatDAO.selectYearUser", paramMap);
  }
  
  public ModelAndView selectYearUserChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ControlStatDAO.selectYearUserChart", paramMap);
  }
  
  public ModelAndView selectSemiAnnualAll(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ControlStatDAO.selectSemiAnnualAll", paramMap);
  }
  
  public ModelAndView selectSemiAnnualAllChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ControlStatDAO.selectSemiAnnualAllChart", paramMap);
  }
  
  public ModelAndView selectSemiAnnualCnt(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ControlStatDAO.selectSemiAnnualCnt", paramMap);
  }
  
  public ModelAndView selectSemiAnnualCntChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ControlStatDAO.selectSemiAnnualCntChart", paramMap);
  }
  
  public ModelAndView selectSemiAnnualTemp(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ControlStatDAO.selectSemiAnnualTemp", paramMap);
  }
  
  public ModelAndView selectSemiAnnualTempChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ControlStatDAO.selectSemiAnnualTempChart", paramMap);
  }
  
  public ModelAndView selectSemiAnnualUser(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ControlStatDAO.selectSemiAnnualUser", paramMap);
  }
  
  public ModelAndView selectSemiAnnualUserChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ControlStatDAO.selectSemiAnnualUserChart", paramMap);
  }
}
