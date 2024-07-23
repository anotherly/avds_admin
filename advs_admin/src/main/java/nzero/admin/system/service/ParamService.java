package nzero.admin.system.service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service("paramService")
public class ParamService extends EgovAbstractServiceImpl {
  private static final Logger LOGGER = LoggerFactory.getLogger(ParamService.class);
  
  @Resource(name = "commonDAO")
  private CommonDAO commonDAO;
  
  public ModelAndView selectParamList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ParamDAO.selectParamList", paramMap);
  }
  
  public ModelAndView insertParam(SimpleData paramMap) throws Exception {
    return this.commonDAO.insert("ParamDAO.insertParam", paramMap);
  }
  
  public ModelAndView updateParam(SimpleData paramMap) throws Exception {
    return this.commonDAO.update("ParamDAO.updateParam", paramMap);
  }
  
  public ModelAndView deleteParam(SimpleData paramMap) throws Exception {
    return this.commonDAO.delete("ParamDAO.deleteParam", paramMap);
  }
}
