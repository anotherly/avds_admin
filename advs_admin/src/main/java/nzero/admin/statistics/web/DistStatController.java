package nzero.admin.statistics.web;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.statistics.service.DistStatService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class DistStatController extends BaseController {
  private static final Logger LOGGER = LoggerFactory.getLogger(DistStatController.class);
  
  @Resource(name = "distStatService")
  private DistStatService distStatService;
  
  @RequestMapping({"/statistics/stat/openDistStat.do"})
  public String openAuth(HttpServletRequest request) {
    return "statistics/distStatList";
  }
  
  @RequestMapping({"/statistics/stat/selectDistStatMonList.do"})
  @ResponseBody
  public ModelAndView selectDistStatMonList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    ModelAndView mv = null;
    if (paramMap.getString("sType").equals("SEL_ALL"))
      mv = this.distStatService.selectMonAll(paramMap); 
    if (paramMap.getString("sType").equals("SEL_TEMP"))
      mv = this.distStatService.selectMonTemp(paramMap); 
    if (paramMap.getString("sType").equals("SEL_USER"))
      mv = this.distStatService.selectMonUser(paramMap); 
    return mv;
  }
  
  @RequestMapping({"/statistics/stat/selectDistStatMonListChart.do"})
  @ResponseBody
  public ModelAndView selectDistStatMonListChart(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    ModelAndView mv = null;
    if (paramMap.getString("sType").equals("SEL_ALL"))
      mv = this.distStatService.selectMonAllChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_TEMP"))
      mv = this.distStatService.selectMonTempChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_USER"))
      mv = this.distStatService.selectMonUserChart(paramMap); 
    return mv;
  }
  
  @RequestMapping({"/statistics/stat/selectDistStatMonExcel.do"})
  @ResponseBody
  public ModelAndView selectDistStatMonExcel(HttpServletRequest request, ModelMap model) throws Exception {
    SimpleData paramData = getSimpleData(request);
    ModelAndView excelMV = null;
    if (paramData.getString("sType").equals("SEL_ALL"))
      excelMV = this.distStatService.selectMonAll(paramData); 
    if (paramData.getString("sType").equals("SEL_TEMP"))
      excelMV = this.distStatService.selectMonTemp(paramData); 
    if (paramData.getString("sType").equals("SEL_USER"))
      excelMV = this.distStatService.selectMonUser(paramData); 
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
  
  @RequestMapping({"/statistics/stat/selectDistStatYearList.do"})
  @ResponseBody
  public ModelAndView selectDistStatYearList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    List<String> yearList = Arrays.asList(paramMap.getString("yearArr").split("\\s*,\\s*"));
    paramMap.set("yearList", yearList);
    ModelAndView mv = null;
    if (paramMap.getString("sType").equals("SEL_ALL"))
      mv = this.distStatService.selectYearAll(paramMap); 
    if (paramMap.getString("sType").equals("SEL_TEMP"))
      mv = this.distStatService.selectYearTemp(paramMap); 
    if (paramMap.getString("sType").equals("SEL_USER"))
      mv = this.distStatService.selectYearUser(paramMap); 
    return mv;
  }
  
  @RequestMapping({"/statistics/stat/selectDistStatYearListChart.do"})
  @ResponseBody
  public ModelAndView selectDistStatYearListChart(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    List<String> yearList = Arrays.asList(paramMap.getString("yearArr").split("\\s*,\\s*"));
    paramMap.set("yearList", yearList);
    ModelAndView mv = null;
    if (paramMap.getString("sType").equals("SEL_ALL"))
      mv = this.distStatService.selectYearAllChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_TEMP"))
      mv = this.distStatService.selectYearTempChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_USER"))
      mv = this.distStatService.selectYearUserChart(paramMap); 
    return mv;
  }
  
  @RequestMapping({"/statistics/stat/selectDistStatYearExcel.do"})
  @ResponseBody
  public ModelAndView selectDistStatYearExcel(HttpServletRequest request, ModelMap model) throws Exception {
    SimpleData paramData = getSimpleData(request);
    List<String> yearList = Arrays.asList(paramData.getString("yearArr").split("\\s*,\\s*"));
    paramData.set("yearList", yearList);
    ModelAndView excelMV = null;
    if (paramData.getString("sType").equals("SEL_ALL"))
      excelMV = this.distStatService.selectYearAll(paramData); 
    if (paramData.getString("sType").equals("SEL_TEMP"))
      excelMV = this.distStatService.selectYearTemp(paramData); 
    if (paramData.getString("sType").equals("SEL_USER"))
      excelMV = this.distStatService.selectYearUser(paramData); 
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
  
  @RequestMapping({"/statistics/stat/selectDistStatSemiAnnualList.do"})
  @ResponseBody
  public ModelAndView selectDistStatSemiAnnualList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    List<String> yearList = Arrays.asList(paramMap.getString("yearArr").split("\\s*,\\s*"));
    paramMap.set("yearList", yearList);
    ModelAndView mv = null;
    if (paramMap.getString("sType").equals("SEL_ALL"))
      mv = this.distStatService.selectSemiAnnualAll(paramMap); 
    if (paramMap.getString("sType").equals("SEL_TEMP"))
      mv = this.distStatService.selectSemiAnnualTemp(paramMap); 
    if (paramMap.getString("sType").equals("SEL_USER"))
      mv = this.distStatService.selectSemiAnnualUser(paramMap); 
    return mv;
  }
  
  @RequestMapping({"/statistics/stat/selectDistStatSemiAnnualListChart.do"})
  @ResponseBody
  public ModelAndView selectDistStatSemiAnnualListChart(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    List<String> yearList = Arrays.asList(paramMap.getString("yearArr").split("\\s*,\\s*"));
    paramMap.set("yearList", yearList);
    ModelAndView mv = null;
    if (paramMap.getString("sType").equals("SEL_ALL"))
      mv = this.distStatService.selectSemiAnnualAllChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_TEMP"))
      mv = this.distStatService.selectSemiAnnualTempChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_USER"))
      mv = this.distStatService.selectSemiAnnualUserChart(paramMap); 
    return mv;
  }
  
  @RequestMapping({"/statistics/stat/selectDistStatSemiAnnualExcel.do"})
  @ResponseBody
  public ModelAndView selectDistStatSemiAnnualExcel(HttpServletRequest request, ModelMap model) throws Exception {
    SimpleData paramData = getSimpleData(request);
    List<String> yearList = Arrays.asList(paramData.getString("yearArr").split("\\s*,\\s*"));
    paramData.set("yearList", yearList);
    ModelAndView excelMV = null;
    if (paramData.getString("sType").equals("SEL_ALL"))
      excelMV = this.distStatService.selectSemiAnnualAll(paramData); 
    if (paramData.getString("sType").equals("SEL_TEMP"))
      excelMV = this.distStatService.selectSemiAnnualTemp(paramData); 
    if (paramData.getString("sType").equals("SEL_USER"))
      excelMV = this.distStatService.selectSemiAnnualUser(paramData); 
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
