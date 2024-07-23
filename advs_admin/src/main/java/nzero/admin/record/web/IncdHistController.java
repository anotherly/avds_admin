package nzero.admin.record.web;

import egovframework.rte.fdl.property.EgovPropertyService;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.util.ExcelUtil;
import nzero.admin.egovframework.cmmn.util.FileUtil;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.record.excel.IncdExcel;
import nzero.admin.record.service.IncdHistService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class IncdHistController extends BaseController {
  private static final Logger LOGGER = LoggerFactory.getLogger(IncdHistController.class);
  
  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;
  
  @Resource(name = "incdHistService")
  private IncdHistService incdHistService;
  
  @RequestMapping({"/record/incident/openIncdHist.do"})
  public String openIncdHist(HttpServletRequest request) {
    return "record/incdHistList";
  }
  
  @RequestMapping({"/record/incident/selectIncdHistList.do"})
  @ResponseBody
  public ModelAndView selectIncdList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.incdHistService.selectIncdList(paramMap);
  }
  
  @RequestMapping({"/record/incident/selectAccCarList.do"})
  @ResponseBody
  public ModelAndView selectAccCarList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.incdHistService.selectAccCarList(paramMap);
  }
  
  @RequestMapping({"/record/incident/selectIncdHistExcelList.do"})
  @ResponseBody
  public ModelAndView selectIncdExcelList(HttpServletRequest request, ModelMap model) throws Exception {
    SimpleData paramData = getSimpleData(request);
    ModelAndView excelMV = this.incdHistService.selectIncdExcelList(paramData);
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
  
  @RequestMapping({"/record/incident/selectIncdHistReport.do"})
  @ResponseBody
  public ModelAndView selectIncdHistReport(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
    String pathLetter = this.propertiesService.getString("pathLetter");
    String pathUpload = this.propertiesService.getString("pathUpload") + "excel" + pathLetter;
    SimpleData paramMap = getSimpleData(request);
    ModelAndView incdMV = this.incdHistService.selectIncdList(paramMap);
    Map<String, Object> incdModel = incdMV.getModel();
    List<Object> incdList = (List<Object>)incdModel.get("rows");
    Map<String, String> incdInfo = (Map<String, String>)incdList.get(0);
    ModelAndView accCarMV = this.incdHistService.selectAccCarList(paramMap);
    Map<String, Object> accCarModel = accCarMV.getModel();
    List<Object> carList = (List<Object>)accCarModel.get("rows");
    LOGGER.info(" ########## selectIncdHistReport.do ###########");
    LOGGER.info(" ########## incdList : " + incdList);
    LOGGER.info(" ##########  carList : " + carList);
    String filenm_org = "excel_incd.xlsx";
    String filenm_new = "excel_incd_" + paramMap.get("sAccId") + ".xlsx";
    String filePath_org = pathUpload + filenm_org;
    String filePath_new = pathUpload + filenm_new;
    filePath_new = ExcelUtil.getReplace(filePath_new, "\\\\", "/");
    LOGGER.info(" filePath_new[" + filePath_new + "]");
    String result = IncdExcel.incdExcelMake(filePath_new, filenm_new, incdInfo, carList);
    LOGGER.debug("     result[" + result + "]");
    if (result.equals("1")) {
      LOGGER.debug(" ########## File_Download ###########");
      try {
        String checkFile = filePath_new;
        checkFile = checkFile.replaceAll("\\\\", "");
        checkFile = checkFile.replaceAll("/", "");
        checkFile = checkFile.replaceAll(";", "");
      } catch (RuntimeException e1) {
        LOGGER.info("[Download File] : ");
      } 
      String filename = filePath_new;
      File file = new File(filename);
      LOGGER.debug("################### Download File : File Name [" + filename + "], File Length [" + file.length() + "] ");
      try {
        if (file.exists())
          FileUtil.download(request, response, file); 
      } catch (ServletException e) {
        LOGGER.info("[Download File] : ");
      } catch (IOException e) {
        LOGGER.info("[Download File] : ");
      } 
    } 
    model.addAttribute("result", result);
    return this.incdHistService.selectIncdList(paramMap);
  }
}
