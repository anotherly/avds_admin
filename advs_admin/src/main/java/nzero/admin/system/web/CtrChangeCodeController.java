package nzero.admin.system.web;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.system.service.CtrChangeCodeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CtrChangeCodeController extends BaseController {
  private static final Logger LOGGER = LoggerFactory.getLogger(CtrChangeCodeController.class);
  
  @Resource(name = "ctrChangeCodeService")
  private CtrChangeCodeService ctrChangeCodeService;
  
  @RequestMapping({"/system/ctrChangeCode/openCtrChangeCode.do"})
  public String openCtrChangeCode(HttpServletRequest request) {
    return "system/ctrChangeCodeList";
  }
  
  @RequestMapping({"/system/ctrChangeCode/selectCtrChangeCodeList.do"})
  @ResponseBody
  public ModelAndView selectCtrChangeCodeList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.ctrChangeCodeService.selectCtrChangeCodeList(paramMap);
  }
  
  @RequestMapping({"/system/ctrChangeCode/transactionCtrChangeCode.do"})
  @ResponseBody
  public ModelAndView transactionCtrChangeCode(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    ModelAndView mv = null;
    if (paramMap.getString("saveMode").equals("I"))
      mv = this.ctrChangeCodeService.insertCtrChangeCode(paramMap); 
    if (paramMap.getString("saveMode").equals("U"))
      mv = this.ctrChangeCodeService.updateCtrChangeCode(paramMap); 
    if (paramMap.getString("saveMode").equals("D"))
      mv = this.ctrChangeCodeService.deleteCtrChangeCode(paramMap); 
    return mv;
  }
  
  @RequestMapping({"/system/ctrChangeCode/selectCtrChangeCodeExcelList.do"})
  @ResponseBody
  public ModelAndView selectCtrChangeCodeExcelList(HttpServletRequest request, ModelMap model) throws Exception {
    SimpleData paramData = getSimpleData(request);
    ModelAndView excelMV = this.ctrChangeCodeService.selectCtrChangeCodeList(paramData);
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
