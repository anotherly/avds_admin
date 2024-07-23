package nzero.admin.system.web;

import egovframework.rte.fdl.property.EgovPropertyService;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.User;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.system.service.ReqConfirmService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ReqConfirmController extends BaseController {
  private static final Logger LOGGER = LoggerFactory.getLogger(ReqConfirmController.class);
  
  @Resource(name = "reqConfirmService")
  private ReqConfirmService reqConfirmService;
  
  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;
  
  @RequestMapping({"/system/req/openReqConfirm.do"})
  public String openReqConfirm(HttpServletRequest request) {
    return "system/reqConfirmList";
  }
  
  @RequestMapping({"/system/req/selectReqConfirmList.do"})
  @ResponseBody
  public ModelAndView selectReqConfirmList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.reqConfirmService.selectReqConfirmList(paramMap);
  }
  
  @RequestMapping({"/system/req/selectReqConfirmInfo_T.do"})
  @ResponseBody
  public ModelAndView selectReqConfirmInfo_T(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.reqConfirmService.selectReqConfirmInfo_T(paramMap);
  }
  
  @RequestMapping({"/system/req/selectReqConfirmInfo_U.do"})
  @ResponseBody
  public ModelAndView selectReqConfirmInfo_U(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.reqConfirmService.selectReqConfirmInfo_U(paramMap);
  }
  
  @RequestMapping({"/system/req/selectReqConfirmInfo_A.do"})
  @ResponseBody
  public ModelAndView selectReqConfirmInfo_A(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.reqConfirmService.selectReqConfirmInfo_A(paramMap);
  }
  
  @RequestMapping({"/system/req/checkDuplNumber.do"})
  @ResponseBody
  public ModelAndView checkDuplNumber(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.reqConfirmService.checkDuplNumber(paramMap);
  }
  
  @RequestMapping({"/system/req/updateReqConfirmInfo_T.do"})
  @ResponseBody
  public ModelAndView updateReqConfirmInfo_T(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    HttpSession session = request.getSession();
    User user = new User(session);
    paramMap.put("user_id", user.getUserVo().getUserId());
    return this.reqConfirmService.updateReqConfirm_T(paramMap);
  }
  
  @RequestMapping({"/system/req/updateReqConfirmInfo_U.do"})
  @ResponseBody
  public ModelAndView updateReqConfirmInfo_U(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.reqConfirmService.updateReqConfirm_U(paramMap);
  }
  
  @RequestMapping({"/system/req/updateReqConfirmInfo_A.do"})
  @ResponseBody
  public ModelAndView updateReqConfirmInfo_A(HttpServletRequest request) throws Exception {
    String apporStatus = request.getParameter("apporStatus");
    SimpleData paramMap = getSimpleData(request);
    if (apporStatus.equals("102"))
      this.reqConfirmService.updateAuth(paramMap); 
    return this.reqConfirmService.updateReqConfirm_A(paramMap);
  }
  
  @RequestMapping({"/system/req/deleteReqConfirmInfo_T.do"})
  @ResponseBody
  public ModelAndView deleteReqConfirmInfo_T(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.reqConfirmService.deleteReqConfirm_T(paramMap);
  }
  
  @RequestMapping({"/system/req/deleteReqConfirmInfo_U.do"})
  @ResponseBody
  public ModelAndView deleteReqConfirmInfo_U(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.reqConfirmService.deleteReqConfirm_U(paramMap);
  }
  
  @RequestMapping({"/system/req/popupInsdateHis.do"})
  public String popupInsdateHis(HttpServletRequest request, ModelAndView mv) {
    return "system/popupInsdateHis";
  }
  
  @RequestMapping({"/system/req/selectInsdateHisList.do"})
  @ResponseBody
  public ModelAndView selectInsdateHisList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.reqConfirmService.selectTempOperInsdateHisList(paramMap);
  }
}
