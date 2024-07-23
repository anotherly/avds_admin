package nzero.admin.system.service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service("reqConfirmService")
public class ReqConfirmService extends EgovAbstractServiceImpl {
  private static final Logger LOGGER = LoggerFactory.getLogger(ReqConfirmService.class);
  
  @Resource(name = "commonDAO")
  private CommonDAO commonDAO;
  
  public ModelAndView selectReqConfirmList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ReqConfirmDAO.selectReqConfirmList", paramMap);
  }
  
  public ModelAndView selectReqConfirmInfo_T(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ReqConfirmDAO.selectReqConfirmInfo_T", paramMap);
  }
  
  public ModelAndView selectReqConfirmInfo_U(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ReqConfirmDAO.selectReqConfirmInfo_U", paramMap);
  }
  
  public ModelAndView selectReqConfirmInfo_A(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ReqConfirmDAO.selectReqConfirmInfo_A", paramMap);
  }
  
  public ModelAndView checkDuplNumber(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ReqConfirmDAO.checkDuplNumber", paramMap);
  }
  
  public ModelAndView updateReqConfirm_T(SimpleData paramMap) throws Exception {
    String insDate = (String)paramMap.get("insInitDateU");
    if (insDate != null && insDate.length() > 0) {
      this.commonDAO.update("ReqConfirmDAO.updateTempOperInsdate", paramMap);
      this.commonDAO.insert("ReqConfirmDAO.insertTempOperInsdateHis", paramMap);
    } 
    return this.commonDAO.update("ReqConfirmDAO.updateReqConfirm_T", paramMap);
  }
  
  public ModelAndView updateReqConfirm_U(SimpleData paramMap) throws Exception {
    return this.commonDAO.update("ReqConfirmDAO.updateReqConfirm_U", paramMap);
  }
  
  public ModelAndView updateReqConfirm_A(SimpleData paramMap) throws Exception {
    return this.commonDAO.update("ReqConfirmDAO.updateReqConfirm_A", paramMap);
  }
  
  public ModelAndView updateAuth(SimpleData paramMap) throws Exception {
    return this.commonDAO.update("ReqConfirmDAO.updateAuth_A", paramMap);
  }
  
  public ModelAndView deleteReqConfirm_T(SimpleData paramMap) throws Exception {
    return this.commonDAO.delete("ReqConfirmDAO.deleteReqConfirm_T", paramMap);
  }
  
  public ModelAndView deleteReqConfirm_U(SimpleData paramMap) throws Exception {
    return this.commonDAO.delete("ReqConfirmDAO.deleteReqConfirm_U", paramMap);
  }
  
  public ModelAndView deleteTempOperInsdateHis(SimpleData paramMap) throws Exception {
    return this.commonDAO.delete("ReqConfirmDAO.deleteTempOperInsdateHis", paramMap);
  }
  
  public ModelAndView insertTempOperInsdateHis(SimpleData paramMap) throws Exception {
    return this.commonDAO.insert("ReqConfirmDAO.insertTempOperInsdateHis", paramMap);
  }
  
  public ModelAndView selectTempOperInsdateHisList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ReqConfirmDAO.selectTempOperInsdateHisList", paramMap);
  }
  
  public ModelAndView updateTempOperInsdate(SimpleData paramMap) throws Exception {
    return this.commonDAO.update("ReqConfirmDAO.updateTempOperInsdate", paramMap);
  }
}
