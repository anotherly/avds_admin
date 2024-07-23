package nzero.admin.system.service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service("codeService")
public class CodeService extends EgovAbstractServiceImpl {
  private static final Logger LOGGER = LoggerFactory.getLogger(CodeService.class);
  
  @Resource(name = "commonDAO")
  private CommonDAO commonDAO;
  
  public ModelAndView selectCodeComboBox(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("CodeDAO.selectCodeComboBox", paramMap);
  }
  
  public ModelAndView selectCodeMastList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("CodeDAO.selectCodeMastList", paramMap);
  }
  
  public ModelAndView insertCodeMast(SimpleData paramMap) throws Exception {
    return this.commonDAO.insert("CodeDAO.insertCodeMast", paramMap);
  }
  
  public ModelAndView updateCodeMast(SimpleData paramMap) throws Exception {
    return this.commonDAO.update("CodeDAO.updateCodeMast", paramMap);
  }
  
  public ModelAndView deleteCodeMast(SimpleData paramMap) throws Exception {
    return this.commonDAO.delete("CodeDAO.deleteCodeMast", paramMap);
  }
  
  public ModelAndView selectCodeDetlList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("CodeDAO.selectCodeDetlList", paramMap);
  }
  
  public ModelAndView insertCodeDetl(SimpleData paramMap) throws Exception {
    return this.commonDAO.insert("CodeDAO.insertCodeDetl", paramMap);
  }
  
  public ModelAndView updateCodeDetl(SimpleData paramMap) throws Exception {
    return this.commonDAO.update("CodeDAO.updateCodeDetl", paramMap);
  }
  
  public ModelAndView deleteCodeDetl(SimpleData paramMap) throws Exception {
    return this.commonDAO.delete("CodeDAO.deleteCodeDetl", paramMap);
  }
  
  public ModelAndView selectCodeExcelList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("CodeDAO.selectCodeExcelList", paramMap);
  }
}
