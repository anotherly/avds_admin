package nzero.admin.statistics.web;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.statistics.service.ControlStatService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ControlStatController extends BaseController {
  private static final Logger LOGGER = LoggerFactory.getLogger(ControlStatController.class);
  
  @Resource(name = "controlStatService")
  private ControlStatService controlStatService;
  
  @RequestMapping({"/statistics/stat/openControlStat.do"})
  public String openAuth(HttpServletRequest request) {
    return "statistics/controlStatList";
  }
  
  @RequestMapping({"/statistics/stat/selectControlStatMonList.do"})
  @ResponseBody
  public ModelAndView selectControlStatMonList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    ModelAndView mv = null;
    if (paramMap.getString("sType").equals("SEL_ALL"))
      mv = this.controlStatService.selectMonAll(paramMap); 
    if (paramMap.getString("sType").equals("SEL_CNT"))
      mv = this.controlStatService.selectMonCnt(paramMap); 
    if (paramMap.getString("sType").equals("SEL_TEMP"))
      mv = this.controlStatService.selectMonTemp(paramMap); 
    if (paramMap.getString("sType").equals("SEL_USER"))
      mv = this.controlStatService.selectMonUser(paramMap); 
    return mv;
  }
  
  @RequestMapping({"/statistics/stat/selectControlStatMonListChart.do"})
  @ResponseBody
  public ModelAndView selectControlStatMonListChart(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    ModelAndView mv = null;
    if (paramMap.getString("sType").equals("SEL_ALL"))
      mv = this.controlStatService.selectMonAllChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_CNT"))
      mv = this.controlStatService.selectMonCntChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_TEMP"))
      mv = this.controlStatService.selectMonTempChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_USER"))
      mv = this.controlStatService.selectMonUserChart(paramMap); 
    return mv;
  }
  
  @RequestMapping({"/statistics/stat/selectControlStatMonExcel.do"})
  @ResponseBody
  public ModelAndView selectControlStatMonExcel(HttpServletRequest request, ModelMap model) throws Exception {
    SimpleData paramData = getSimpleData(request);
    ModelAndView excelMV = null;
    if (paramData.getString("sType").equals("SEL_ALL"))
      excelMV = this.controlStatService.selectMonAll(paramData); 
    if (paramData.getString("sType").equals("SEL_CNT"))
      excelMV = this.controlStatService.selectMonCnt(paramData); 
    if (paramData.getString("sType").equals("SEL_TEMP"))
      excelMV = this.controlStatService.selectMonTemp(paramData); 
    if (paramData.getString("sType").equals("SEL_USER"))
      excelMV = this.controlStatService.selectMonUser(paramData); 
    Map<String, Object> excelModel = excelMV.getModel();
    List<Object> excelList = (List<Object>)excelModel.get("rows");
    String[] columsNm = paramData.getString("columnsNm").split(",");
    String[] datafield = paramData.getString("datafield").split(",");
    model.put("columnsNm", columsNm);
    model.put("datafield", datafield);
    model.put("excelList", excelList);
    model.put("excelFileNm", request.getParameter("excelFileNm"));
    return new ModelAndView("ExcelDownload", "excel", model);
  }
  
  @RequestMapping({"/statistics/stat/selectControlStatYearList.do"})
  @ResponseBody
  public ModelAndView selectControlStatYearList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    List<String> yearList = Arrays.asList(paramMap.getString("yearArr").split("\\s*,\\s*"));
    paramMap.set("yearList", yearList);
    ModelAndView mv = null;
    if (paramMap.getString("sType").equals("SEL_ALL"))
      mv = this.controlStatService.selectYearAll(paramMap); 
    if (paramMap.getString("sType").equals("SEL_CNT"))
      mv = this.controlStatService.selectYearCnt(paramMap); 
    if (paramMap.getString("sType").equals("SEL_TEMP"))
      mv = this.controlStatService.selectYearTemp(paramMap); 
    if (paramMap.getString("sType").equals("SEL_USER"))
      mv = this.controlStatService.selectYearUser(paramMap); 
    return mv;
  }
  
  @RequestMapping({"/statistics/stat/selectControlStatYearListChart.do"})
  @ResponseBody
  public ModelAndView selectControlStatYearListChart(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    List<String> yearList = Arrays.asList(paramMap.getString("yearArr").split("\\s*,\\s*"));
    paramMap.set("yearList", yearList);
    ModelAndView mv = null;
    if (paramMap.getString("sType").equals("SEL_ALL"))
      mv = this.controlStatService.selectYearAllChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_CNT"))
      mv = this.controlStatService.selectYearCntChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_TEMP"))
      mv = this.controlStatService.selectYearTempChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_USER"))
      mv = this.controlStatService.selectYearUserChart(paramMap); 
    return mv;
  }
  
  @RequestMapping({"/statistics/stat/selectControlStatYearExcel.do"})
  @ResponseBody
  public ModelAndView selectControlStatYearExcel(HttpServletRequest request, ModelMap model) throws Exception {
    SimpleData paramData = getSimpleData(request);
    List<String> yearList = Arrays.asList(paramData.getString("yearArr").split("\\s*,\\s*"));
    paramData.set("yearList", yearList);
    ModelAndView excelMV = null;
    if (paramData.getString("sType").equals("SEL_ALL"))
      excelMV = this.controlStatService.selectYearAll(paramData); 
    if (paramData.getString("sType").equals("SEL_CNT"))
      excelMV = this.controlStatService.selectYearCnt(paramData); 
    if (paramData.getString("sType").equals("SEL_TEMP"))
      excelMV = this.controlStatService.selectYearTemp(paramData); 
    if (paramData.getString("sType").equals("SEL_USER"))
      excelMV = this.controlStatService.selectYearUser(paramData); 
    Map<String, Object> excelModel = excelMV.getModel();
    List<Object> excelList = (List<Object>)excelModel.get("rows");
    String[] columsNm = paramData.getString("columnsNm").split(",");
    String[] datafield = paramData.getString("datafield").split(",");
    model.put("columnsNm", columsNm);
    model.put("datafield", datafield);
    model.put("excelList", excelList);
    model.put("excelFileNm", request.getParameter("excelFileNm"));
    return new ModelAndView("ExcelDownload", "excel", model);
  }
  
  @RequestMapping({"/statistics/stat/selectControlStatSemiAnnualList.do"})
  @ResponseBody
  public ModelAndView selectControlStatSemiAnnualList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    List<String> yearList = Arrays.asList(paramMap.getString("yearArr").split("\\s*,\\s*"));
    paramMap.set("yearList", yearList);
    ModelAndView mv = null;
    if (paramMap.getString("sType").equals("SEL_ALL"))
      mv = this.controlStatService.selectSemiAnnualAll(paramMap); 
    if (paramMap.getString("sType").equals("SEL_CNT"))
      mv = this.controlStatService.selectSemiAnnualCnt(paramMap); 
    if (paramMap.getString("sType").equals("SEL_TEMP"))
      mv = this.controlStatService.selectSemiAnnualTemp(paramMap); 
    if (paramMap.getString("sType").equals("SEL_USER"))
      mv = this.controlStatService.selectSemiAnnualUser(paramMap); 
    return mv;
  }
  
  @RequestMapping({"/statistics/stat/selectControlStatSemiAnnualListChart.do"})
  @ResponseBody
  public ModelAndView selectControlStatSemiAnnualListChart(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    List<String> yearList = Arrays.asList(paramMap.getString("yearArr").split("\\s*,\\s*"));
    paramMap.set("yearList", yearList);
    ModelAndView mv = null;
    if (paramMap.getString("sType").equals("SEL_ALL"))
      mv = this.controlStatService.selectSemiAnnualAllChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_CNT"))
      mv = this.controlStatService.selectSemiAnnualCntChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_TEMP"))
      mv = this.controlStatService.selectSemiAnnualTempChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_USER"))
      mv = this.controlStatService.selectSemiAnnualUserChart(paramMap); 
    return mv;
  }
  
  @RequestMapping({"/statistics/stat/selectControlStatSemiAnnualExcel.do"})
  @ResponseBody
  public ModelAndView selectControlStatSemiAnnualExcel(HttpServletRequest request, ModelMap model) throws Exception {
    SimpleData paramData = getSimpleData(request);
    List<String> yearList = Arrays.asList(paramData.getString("yearArr").split("\\s*,\\s*"));
    paramData.set("yearList", yearList);
    ModelAndView excelMV = null;
    if (paramData.getString("sType").equals("SEL_ALL"))
      excelMV = this.controlStatService.selectSemiAnnualAll(paramData); 
    if (paramData.getString("sType").equals("SEL_CNT"))
      excelMV = this.controlStatService.selectSemiAnnualCnt(paramData); 
    if (paramData.getString("sType").equals("SEL_TEMP"))
      excelMV = this.controlStatService.selectSemiAnnualTemp(paramData); 
    if (paramData.getString("sType").equals("SEL_USER"))
      excelMV = this.controlStatService.selectSemiAnnualUser(paramData); 
    Map<String, Object> excelModel = excelMV.getModel();
    List<Object> excelList = (List<Object>)excelModel.get("rows");
    String[] columsNm = paramData.getString("columnsNm").split(",");
    String[] datafield = paramData.getString("datafield").split(",");
    model.put("columnsNm", columsNm);
    model.put("datafield", datafield);
    model.put("excelList", excelList);
    model.put("excelFileNm", request.getParameter("excelFileNm"));
    return new ModelAndView("ExcelDownload", "excel", model);
  }
}
