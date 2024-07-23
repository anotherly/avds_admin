package nzero.admin.statistics.service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service("acidStatService")
public class AcidStatService extends EgovAbstractServiceImpl {
  private static final Logger LOGGER = LoggerFactory.getLogger(AcidStatService.class);
  
  @Resource(name = "commonDAO")
  private CommonDAO commonDAO;
  
  public ModelAndView selectMonTemp(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectMonTemp", paramMap);
  }
  
  public ModelAndView selectMonTempChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectMonTempChart", paramMap);
  }
  
  public ModelAndView selectMonTempDist(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectMonTempDist", paramMap);
  }
  
  public ModelAndView selectMonTempDistChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectMonTempDistChart", paramMap);
  }
  
  public ModelAndView selectMonUser(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectMonUser", paramMap);
  }
  
  public ModelAndView selectMonUserChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectMonUserChart", paramMap);
  }
  
  public ModelAndView selectMonUserDist(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectMonUserDist", paramMap);
  }
  
  public ModelAndView selectMonUserDistChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectMonUserDistChart", paramMap);
  }
  
  public ModelAndView selectMonRoad(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectMonRoad", paramMap);
  }
  
  public ModelAndView selectMonRoadChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectMonRoadChart", paramMap);
  }
  
  public ModelAndView selectMonWhtr(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectMonWhtr", paramMap);
  }
  
  public ModelAndView selectMonWhtrChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectMonWhtrChart", paramMap);
  }
  
  public ModelAndView selectYearTemp(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectYearTemp", paramMap);
  }
  
  public ModelAndView selectYearTempChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectYearTempChart", paramMap);
  }
  
  public ModelAndView selectYearTempDist(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectYearTempDist", paramMap);
  }
  
  public ModelAndView selectYearTempDistChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectYearTempDistChart", paramMap);
  }
  
  public ModelAndView selectYearUser(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectYearUser", paramMap);
  }
  
  public ModelAndView selectYearUserChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectYearUserChart", paramMap);
  }
  
  public ModelAndView selectYearUserDist(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectYearUserDist", paramMap);
  }
  
  public ModelAndView selectYearUserDistChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectYearUserDistChart", paramMap);
  }
  
  public ModelAndView selectYearRoad(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectYearRoad", paramMap);
  }
  
  public ModelAndView selectYearRoadChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectYearRoadChart", paramMap);
  }
  
  public ModelAndView selectYearWhtr(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectYearWhtr", paramMap);
  }
  
  public ModelAndView selectYearWhtrChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectYearWhtrChart", paramMap);
  }
  
  public ModelAndView selectSemiAnnualTemp(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectSemiAnnualTemp", paramMap);
  }
  
  public ModelAndView selectSemiAnnualTempChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectSemiAnnualTempChart", paramMap);
  }
  
  public ModelAndView selectSemiAnnualTempDist(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectSemiAnnualTempDist", paramMap);
  }
  
  public ModelAndView selectSemiAnnualTempDistChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectSemiAnnualTempDistChart", paramMap);
  }
  
  public ModelAndView selectSemiAnnualUser(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectSemiAnnualUser", paramMap);
  }
  
  public ModelAndView selectSemiAnnualUserChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectSemiAnnualUserChart", paramMap);
  }
  
  public ModelAndView selectSemiAnnualUserDist(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectSemiAnnualUserDist", paramMap);
  }
  
  public ModelAndView selectSemiAnnualUserDistChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectSemiAnnualUserDistChart", paramMap);
  }
  
  public ModelAndView selectSemiAnnualRoad(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectSemiAnnualRoad", paramMap);
  }
  
  public ModelAndView selectSemiAnnualRoadChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectSemiAnnualRoadChart", paramMap);
  }
  
  public ModelAndView selectSemiAnnualWhtr(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectSemiAnnualWhtr", paramMap);
  }
  
  public ModelAndView selectSemiAnnualWhtrChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("AcidStatDAO.selectSemiAnnualWhtrChart", paramMap);
  }
}
