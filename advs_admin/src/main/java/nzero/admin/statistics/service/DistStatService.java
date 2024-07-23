package nzero.admin.statistics.service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service("distStatService")
public class DistStatService extends EgovAbstractServiceImpl {
  private static final Logger LOGGER = LoggerFactory.getLogger(DistStatService.class);
  
  @Resource(name = "commonDAO")
  private CommonDAO commonDAO;
  
  public ModelAndView selectMonAll(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("DistStatDAO.selectMonAll", paramMap);
  }
  
  public ModelAndView selectMonAllChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("DistStatDAO.selectMonAllChart", paramMap);
  }
  
  public ModelAndView selectMonTemp(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("DistStatDAO.selectMonTemp", paramMap);
  }
  
  public ModelAndView selectMonTempChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("DistStatDAO.selectMonTempChart", paramMap);
  }
  
  public ModelAndView selectMonUser(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("DistStatDAO.selectMonUser", paramMap);
  }
  
  public ModelAndView selectMonUserChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("DistStatDAO.selectMonUserChart", paramMap);
  }
  
  public ModelAndView selectYearAll(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("DistStatDAO.selectYearAll", paramMap);
  }
  
  public ModelAndView selectYearAllChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("DistStatDAO.selectYearAllChart", paramMap);
  }
  
  public ModelAndView selectYearTemp(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("DistStatDAO.selectYearTemp", paramMap);
  }
  
  public ModelAndView selectYearTempChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("DistStatDAO.selectYearTempChart", paramMap);
  }
  
  public ModelAndView selectYearUser(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("DistStatDAO.selectYearUser", paramMap);
  }
  
  public ModelAndView selectYearUserChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("DistStatDAO.selectYearUserChart", paramMap);
  }
  
  public ModelAndView selectSemiAnnualAll(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("DistStatDAO.selectSemiAnnualAll", paramMap);
  }
  
  public ModelAndView selectSemiAnnualAllChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("DistStatDAO.selectSemiAnnualAllChart", paramMap);
  }
  
  public ModelAndView selectSemiAnnualTemp(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("DistStatDAO.selectSemiAnnualTemp", paramMap);
  }
  
  public ModelAndView selectSemiAnnualTempChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("DistStatDAO.selectSemiAnnualTempChart", paramMap);
  }
  
  public ModelAndView selectSemiAnnualUser(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("DistStatDAO.selectSemiAnnualUser", paramMap);
  }
  
  public ModelAndView selectSemiAnnualUserChart(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("DistStatDAO.selectSemiAnnualUserChart", paramMap);
  }
}
