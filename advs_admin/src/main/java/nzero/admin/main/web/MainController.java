package nzero.admin.main.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.main.service.MainService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class MainController extends BaseController {
  private static final Logger LOGGER = LoggerFactory.getLogger(MainController.class);
  
  @Resource(name = "mainService")
  private MainService mainService;
  
  @RequestMapping({"/main/dashboard/selectTempOperTotCnt.do"})
  @ResponseBody
  public ModelAndView selectTempOperTotCnt(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.mainService.selectTempOperTotCnt(paramMap);
  }
  
  @RequestMapping({"/main/dashboard/selectDrivingInfo.do"})
  @ResponseBody
  public ModelAndView selectDrivingInfo(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.mainService.selectDrivingInfo(paramMap);
  }
  
  @RequestMapping({"/main/dashboard/selectDataTotCnt.do"})
  @ResponseBody
  public ModelAndView selectDataTotCnt(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.mainService.selectDataTotCnt(paramMap);
  }
  
  @RequestMapping({"/main/dashboard/selectDataTotVolume.do"})
  @ResponseBody
  public ModelAndView selectDataTotVolume(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.mainService.selectDataTotVolume(paramMap);
  }
  
  @RequestMapping({"/main/dashboard/selectUpDnStatus.do"})
  @ResponseBody
  public ModelAndView selectUpDnStatus(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.mainService.selectUpDnStatus(paramMap);
  }
  
  @RequestMapping({"/main/dashboard/selectUploadCnt.do"})
  @ResponseBody
  public ModelAndView selectUploadCnt(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.mainService.selectUploadCnt(paramMap);
  }
  
  @RequestMapping({"/main/dashboard/selectAccStatus.do"})
  @ResponseBody
  public ModelAndView selectAccStatus(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.mainService.selectAccStatus(paramMap);
  }
  
  @RequestMapping({"/main/dashboard/selectAccList.do"})
  @ResponseBody
  public ModelAndView selectAccList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.mainService.selectAccList(paramMap);
  }
  
  @RequestMapping({"/main/dashboard/selectChart.do"})
  @ResponseBody
  public ModelAndView selectChart(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.mainService.selectChart(paramMap);
  }
  
  @RequestMapping({"/main/dashboard/selectDBStatus.do"})
  @ResponseBody
  public ModelAndView selectDBStatus(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.mainService.selectDBStatus(paramMap);
  }
  
  @RequestMapping(value = "/main/dashboard/SelectCarReserveList.do")
	public ModelAndView SelectCarReserveList(HttpServletRequest request) throws Exception {
	  	SimpleData paramMap = getSimpleData(request);
	    return this.mainService.selectReserveList(paramMap);
	}
  
}
