package nzero.admin.statistics.web;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.statistics.service.AcidStatService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AcidStatController extends BaseController {
  private static final Logger LOGGER = LoggerFactory.getLogger(AcidStatController.class);
  
  @Resource(name = "acidStatService")
  private AcidStatService acidStatService;
  
  @RequestMapping({"/statistics/stat/openAcidStat.do"})
  public String openAuth(HttpServletRequest request) {
    return "statistics/acidStatList";
  }
  
  @RequestMapping({"/statistics/stat/selectAcidStatMonList.do"})
  @ResponseBody
  public ModelAndView selectAcidStatMonList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    ModelAndView mv = null;
    if (paramMap.getString("sType").equals("SEL_TEMP"))
      mv = this.acidStatService.selectMonTemp(paramMap); 
    if (paramMap.getString("sType").equals("SEL_USER"))
      mv = this.acidStatService.selectMonUser(paramMap); 
    if (paramMap.getString("sType").equals("SEL_ROAD"))
      mv = this.acidStatService.selectMonRoad(paramMap); 
    if (paramMap.getString("sType").equals("SEL_WTHR"))
      mv = this.acidStatService.selectMonWhtr(paramMap); 
    if (paramMap.getString("sType").equals("SEL_TEMP_DIST"))
      mv = this.acidStatService.selectMonTempDist(paramMap); 
    if (paramMap.getString("sType").equals("SEL_USER_DIST"))
      mv = this.acidStatService.selectMonUserDist(paramMap); 
    return mv;
  }
  
  @RequestMapping({"/statistics/stat/selectAcidStatMonListChart.do"})
  @ResponseBody
  public ModelAndView selectAcidStatMonListChart(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    ModelAndView mv = null;
    if (paramMap.getString("sType").equals("SEL_TEMP"))
      mv = this.acidStatService.selectMonTempChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_USER"))
      mv = this.acidStatService.selectMonUserChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_ROAD"))
      mv = this.acidStatService.selectMonRoadChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_WTHR"))
      mv = this.acidStatService.selectMonWhtrChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_TEMP_DIST"))
      mv = this.acidStatService.selectMonTempDistChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_USER_DIST"))
      mv = this.acidStatService.selectMonUserDistChart(paramMap); 
    return mv;
  }
  
  @RequestMapping({"/statistics/stat/selectAcidStatMonExcel.do"})
  @ResponseBody
  public ModelAndView selectAcidStatMonExcel(HttpServletRequest request, ModelMap model) throws Exception {
    SimpleData paramData = getSimpleData(request);
    ModelAndView excelMV = null;
    if (paramData.getString("sType").equals("SEL_TEMP"))
      excelMV = this.acidStatService.selectMonTemp(paramData); 
    if (paramData.getString("sType").equals("SEL_USER"))
      excelMV = this.acidStatService.selectMonUser(paramData); 
    if (paramData.getString("sType").equals("SEL_ROAD"))
      excelMV = this.acidStatService.selectMonRoad(paramData); 
    if (paramData.getString("sType").equals("SEL_WTHR"))
      excelMV = this.acidStatService.selectMonWhtr(paramData); 
    if (paramData.getString("sType").equals("SEL_TEMP_DIST"))
      excelMV = this.acidStatService.selectMonTempDist(paramData); 
    if (paramData.getString("sType").equals("SEL_USER_DIST"))
      excelMV = this.acidStatService.selectMonUserDist(paramData); 
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
  
  @RequestMapping({"/statistics/stat/selectAcidStatYearList.do"})
  @ResponseBody
  public ModelAndView selectAcidStatYearList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    List<String> yearList = Arrays.asList(paramMap.getString("yearArr").split("\\s*,\\s*"));
    paramMap.set("yearList", yearList);
    ModelAndView mv = null;
    if (paramMap.getString("sType").equals("SEL_TEMP"))
      mv = this.acidStatService.selectYearTemp(paramMap); 
    if (paramMap.getString("sType").equals("SEL_USER"))
      mv = this.acidStatService.selectYearUser(paramMap); 
    if (paramMap.getString("sType").equals("SEL_ROAD"))
      mv = this.acidStatService.selectYearRoad(paramMap); 
    if (paramMap.getString("sType").equals("SEL_WTHR"))
      mv = this.acidStatService.selectYearWhtr(paramMap); 
    if (paramMap.getString("sType").equals("SEL_TEMP_DIST"))
      mv = this.acidStatService.selectYearTempDist(paramMap); 
    if (paramMap.getString("sType").equals("SEL_USER_DIST"))
      mv = this.acidStatService.selectYearUserDist(paramMap); 
    return mv;
  }
  
  @RequestMapping({"/statistics/stat/selectAcidStatYearListChart.do"})
  @ResponseBody
  public ModelAndView selectAcidStatYearListChart(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    List<String> yearList = Arrays.asList(paramMap.getString("yearArr").split("\\s*,\\s*"));
    paramMap.set("yearList", yearList);
    ModelAndView mv = null;
    if (paramMap.getString("sType").equals("SEL_TEMP"))
      mv = this.acidStatService.selectYearTempChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_USER"))
      mv = this.acidStatService.selectYearUserChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_ROAD"))
      mv = this.acidStatService.selectYearRoadChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_WTHR"))
      mv = this.acidStatService.selectYearWhtrChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_TEMP_DIST"))
      mv = this.acidStatService.selectYearTempDistChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_USER_DIST"))
      mv = this.acidStatService.selectYearUserDistChart(paramMap); 
    return mv;
  }
  
  @RequestMapping({"/statistics/stat/selectAcidStatYearExcel.do"})
  @ResponseBody
  public ModelAndView selectAcidStatYearExcel(HttpServletRequest request, ModelMap model) throws Exception {
    SimpleData paramData = getSimpleData(request);
    List<String> yearList = Arrays.asList(paramData.getString("yearArr").split("\\s*,\\s*"));
    paramData.set("yearList", yearList);
    ModelAndView excelMV = null;
    if (paramData.getString("sType").equals("SEL_TEMP"))
      excelMV = this.acidStatService.selectYearTemp(paramData); 
    if (paramData.getString("sType").equals("SEL_USER"))
      excelMV = this.acidStatService.selectYearUser(paramData); 
    if (paramData.getString("sType").equals("SEL_ROAD"))
      excelMV = this.acidStatService.selectYearRoad(paramData); 
    if (paramData.getString("sType").equals("SEL_WHTR"))
      excelMV = this.acidStatService.selectYearWhtr(paramData); 
    if (paramData.getString("sType").equals("SEL_TEMP_DIST"))
      excelMV = this.acidStatService.selectYearTempDist(paramData); 
    if (paramData.getString("sType").equals("SEL_USER_DIST"))
      excelMV = this.acidStatService.selectYearUserDist(paramData); 
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
  
  @RequestMapping({"/statistics/stat/selectAcidStatSemiAnnualList.do"})
  @ResponseBody
  public ModelAndView selectAcidStatSemiAnnualList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    List<String> yearList = Arrays.asList(paramMap.getString("yearArr").split("\\s*,\\s*"));
    paramMap.set("yearList", yearList);
    ModelAndView mv = null;
    if (paramMap.getString("sType").equals("SEL_TEMP"))
      mv = this.acidStatService.selectSemiAnnualTemp(paramMap); 
    if (paramMap.getString("sType").equals("SEL_USER"))
      mv = this.acidStatService.selectSemiAnnualUser(paramMap); 
    if (paramMap.getString("sType").equals("SEL_ROAD"))
      mv = this.acidStatService.selectSemiAnnualRoad(paramMap); 
    if (paramMap.getString("sType").equals("SEL_WTHR"))
      mv = this.acidStatService.selectSemiAnnualWhtr(paramMap); 
    if (paramMap.getString("sType").equals("SEL_TEMP_DIST"))
      mv = this.acidStatService.selectSemiAnnualTempDist(paramMap); 
    if (paramMap.getString("sType").equals("SEL_USER_DIST"))
      mv = this.acidStatService.selectSemiAnnualUserDist(paramMap); 
    return mv;
  }
  
  @RequestMapping({"/statistics/stat/selectAcidStatSemiAnnualListChart.do"})
  @ResponseBody
  public ModelAndView selectAcidStatSemiAnnualListChart(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    List<String> yearList = Arrays.asList(paramMap.getString("yearArr").split("\\s*,\\s*"));
    paramMap.set("yearList", yearList);
    ModelAndView mv = null;
    if (paramMap.getString("sType").equals("SEL_TEMP"))
      mv = this.acidStatService.selectSemiAnnualTempChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_USER"))
      mv = this.acidStatService.selectSemiAnnualUserChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_ROAD"))
      mv = this.acidStatService.selectSemiAnnualRoadChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_WTHR"))
      mv = this.acidStatService.selectSemiAnnualWhtrChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_TEMP_DIST"))
      mv = this.acidStatService.selectSemiAnnualTempDistChart(paramMap); 
    if (paramMap.getString("sType").equals("SEL_USER_DIST"))
      mv = this.acidStatService.selectSemiAnnualUserDistChart(paramMap); 
    return mv;
  }
  
  @RequestMapping({"/statistics/stat/selectAcidStatSemiAnnualExcel.do"})
  @ResponseBody
  public ModelAndView selectAcidStatSemiAnnualExcel(HttpServletRequest request, ModelMap model) throws Exception {
    SimpleData paramData = getSimpleData(request);
    List<String> yearList = Arrays.asList(paramData.getString("yearArr").split("\\s*,\\s*"));
    paramData.set("yearList", yearList);
    ModelAndView excelMV = null;
    if (paramData.getString("sType").equals("SEL_TEMP"))
      excelMV = this.acidStatService.selectSemiAnnualTemp(paramData); 
    if (paramData.getString("sType").equals("SEL_USER"))
      excelMV = this.acidStatService.selectSemiAnnualUser(paramData); 
    if (paramData.getString("sType").equals("SEL_ROAD"))
      excelMV = this.acidStatService.selectSemiAnnualRoad(paramData); 
    if (paramData.getString("sType").equals("SEL_WHTR"))
      excelMV = this.acidStatService.selectSemiAnnualWhtr(paramData); 
    if (paramData.getString("sType").equals("SEL_TEMP_DIST"))
      excelMV = this.acidStatService.selectSemiAnnualTempDist(paramData); 
    if (paramData.getString("sType").equals("SEL_USER_DIST"))
      excelMV = this.acidStatService.selectSemiAnnualUserDist(paramData); 
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
