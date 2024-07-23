package nzero.admin.system.service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service("ctrChangeCodeService")
public class CtrChangeCodeService extends EgovAbstractServiceImpl {
  private static final Logger LOGGER = LoggerFactory.getLogger(CtrChangeCodeService.class);
  
  @Resource(name = "commonDAO")
  private CommonDAO commonDAO;
  
  public ModelAndView selectCtrChangeCodeList(SimpleData ctrChangeCodeMap) throws Exception {
    return this.commonDAO.selectModel("CtrChangeCodeDAO.selectCtrChangeCodeList", ctrChangeCodeMap);
  }
  
  public ModelAndView insertCtrChangeCode(SimpleData ctrChangeCodeMap) throws Exception {
    return this.commonDAO.insert("CtrChangeCodeDAO.insertCtrChangeCode", ctrChangeCodeMap);
  }
  
  public ModelAndView updateCtrChangeCode(SimpleData ctrChangeCodeMap) throws Exception {
    return this.commonDAO.update("CtrChangeCodeDAO.updateCtrChangeCode", ctrChangeCodeMap);
  }
  
  public ModelAndView deleteCtrChangeCode(SimpleData ctrChangeCodeMap) throws Exception {
    return this.commonDAO.delete("CtrChangeCodeDAO.deleteCtrChangeCode", ctrChangeCodeMap);
  }
}
