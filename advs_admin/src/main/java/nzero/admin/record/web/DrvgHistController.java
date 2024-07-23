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
import nzero.admin.record.excel.DrvgExcel;
import nzero.admin.record.service.DrvgHistService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class DrvgHistController extends BaseController {
  private static final Logger LOGGER = LoggerFactory.getLogger(DrvgHistController.class);
  
  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;
  
  @Resource(name = "drvgHistService")
  private DrvgHistService drvgHistService;
  
  @RequestMapping({"/record/driving/openDrvgHist.do"})
  public String openDrvgHist(HttpServletRequest request) {
    return "record/drvgHistList";
  }
  
  @RequestMapping({"/record/driving/selectDrvgHistList.do"})
  @ResponseBody
  public ModelAndView selectDrvgHistList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.drvgHistService.selectDrvgHistList(paramMap);
  }
  
  @RequestMapping({"/record/driving/selectAutoDrivingList.do"})
  @ResponseBody
  public ModelAndView selectAutoDrivingList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.drvgHistService.selectAutoDrivingList(paramMap);
  }
  
  @RequestMapping({"/record/driving/selectCtrChangeList.do"})
  @ResponseBody
  public ModelAndView selectCtrChangeList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.drvgHistService.selectCtrChangeList(paramMap);
  }
  
  @RequestMapping({"/record/driving/selectCtrChangeDtlList.do"})
  @ResponseBody
  public ModelAndView selectCtrChangeDtlList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.drvgHistService.selectCtrChangeDtlList(paramMap);
  }
  
  @RequestMapping({"/record/driving/selectDrvgHistExcelList.do"})
  @ResponseBody
  public ModelAndView selectDrvgHistExcelList(HttpServletRequest request, ModelMap model) throws Exception {
    SimpleData paramData = getSimpleData(request);
    ModelAndView excelMV = this.drvgHistService.selectDrvgHistExcelList(paramData);
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
  
  @RequestMapping({"/record/driving/selectDrvgHistReport.do"})
  @ResponseBody
  public ModelAndView selectIncdHistReport(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
    String pathLetter = this.propertiesService.getString("pathLetter");
    String pathUpload = this.propertiesService.getString("pathUpload") + "excel" + pathLetter;
    SimpleData paramMap = getSimpleData(request);
    paramMap.put("sTmpNo", paramMap.get("sDrvNo"));
    ModelAndView drvgMV = this.drvgHistService.selectDrvgHistList(paramMap);
    Map<String, Object> drvgModel = drvgMV.getModel();
    List<Object> drvgList = (List<Object>)drvgModel.get("rows");
    Map<String, String> drvgInfo = (Map<String, String>)drvgList.get(0);
    ModelAndView drvMV = this.drvgHistService.selectAutoDrivingList(paramMap);
    Map<String, Object> drvModel = drvMV.getModel();
    List<Object> drvList = (List<Object>)drvModel.get("rows");
    ModelAndView chgMV = this.drvgHistService.selectCtrChangeList(paramMap);
    Map<String, Object> chgModel = chgMV.getModel();
    List<Object> chgList = (List<Object>)chgModel.get("rows");
    ModelAndView chgDtlMV = this.drvgHistService.selectCtrChangeDtlList(paramMap);
    Map<String, Object> chgDtlModel = chgDtlMV.getModel();
    List<Object> chgDtlList = (List<Object>)chgDtlModel.get("rows");
    LOGGER.info(" ########## selectDrvgHistReport.do ###########");
    LOGGER.info(" ########## drvgList : " + drvgList);
    LOGGER.info(" ##########  drvList : " + drvList);
    String filenm_org = "excel_drvg.xlsx";
    String filenm_new = "excel_drvg_" + paramMap.get("sTmpNo") + ".xlsx";
    String filePath_org = pathUpload + filenm_org;
    String filePath_new = pathUpload + filenm_new;
    filePath_new = ExcelUtil.getReplace(filePath_new, "\\\\", "/");
    LOGGER.info(" filePath_new[" + filePath_new + "]");
    String result = DrvgExcel.drvgExcelMake(filePath_new, filenm_new, drvgInfo, drvList, chgList, chgDtlList);
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
    return this.drvgHistService.selectDrvgHistList(paramMap);
  }
}
