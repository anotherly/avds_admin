package nzero.admin.system.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.fdl.property.EgovPropertyService;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.system.service.UsaInfoService;

@Controller
public class UsaInfoController extends BaseController {
  private static final Logger LOGGER = LoggerFactory.getLogger(UsaInfoController.class);
  
  @Resource(name = "usaInfoService")
  private UsaInfoService usaInfoService;
  
  /** EgovPropertyService */
	@Resource(name = "propertiesService") //환경 설정
	protected EgovPropertyService propertiesService;
	
  private static final Log LOG = LogFactory.getLog(CodeController.class.getName());
  
  
  @RequestMapping({"/system/usaInfo/usaInfoList.do"})
  public String openAuth(HttpServletRequest request, ModelMap model) {
	  SimpleData paramMap = getSimpleData(request);
	  model.put("paramMap", paramMap);
    return "system/usaInfoList";
  }
  
  @RequestMapping({"/system/usaInfo/selectUsaInfoList.do"})
  @ResponseBody
  public ModelAndView selectUsaInfoList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.usaInfoService.selectUsaInfoList(paramMap);
  }
  
  @RequestMapping({"/system/usaInfo/saveUsaInfo.do"})
  @ResponseBody
  public ModelAndView updateUsaInfo(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    ModelAndView mv = null;    
      mv = this.usaInfoService.updateUsaInfo(paramMap); 
    return mv;
  }
}
