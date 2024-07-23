package nzero.admin.record.web;

import egovframework.rte.fdl.property.EgovPropertyService;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.record.service.DataUsedService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class DataUsedController extends BaseController {
  private static final Logger LOGGER = LoggerFactory.getLogger(DataUsedController.class);
  
  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;
  
  @Resource(name = "dataUsedService")
  private DataUsedService dataUsedService;
  
  @RequestMapping({"/record/dataused/openDataUsed.do"})
  public String openDrvgHist(HttpServletRequest request) {
    return "record/dataUsedList";
  }
  
  @RequestMapping({"/record/dataused/selectDataUsedList.do"})
  @ResponseBody
  public ModelAndView selectDataUsedList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.dataUsedService.selectDataUsedList(paramMap);
  }
  
  @RequestMapping({"/record/dataused/selectDataUsedDtlList.do"})
  @ResponseBody
  public ModelAndView selectDataUsedDtlList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.dataUsedService.selectDataUsedDtlList(paramMap);
  }
}
