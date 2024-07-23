package nzero.admin.system.web;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.system.service.WebAuthService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class WebAuthController extends BaseController {
  private static final Logger LOGGER = LoggerFactory.getLogger(WebAuthController.class);
  
  @Resource(name = "webAuthService")
  private WebAuthService webAuthService;
  
  @RequestMapping({"/system/webAuth/selectAuthComboBox.do"})
  @ResponseBody
  public ModelAndView selectAuthComboBox(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.webAuthService.selectAuthComboBox(paramMap);
  }
  
  @RequestMapping({"/system/webAuth/openAuth.do"})
  public String openAuth(HttpServletRequest request) {
    return "system/webAuthList";
  }
  
  @RequestMapping({"/system/webAuth/selectAuthList.do"})
  @ResponseBody
  public ModelAndView selectAuthList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.webAuthService.selectAuthList(paramMap);
  }
  
  @RequestMapping({"/system/webAuth/transactionAuth.do"})
  @ResponseBody
  public ModelAndView transactionAuth(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    ModelAndView mv = null;
    if (paramMap.getString("saveMode").equals("I")) {
      Integer authId = this.webAuthService.selectMaxAuthId(paramMap);
      paramMap.put("authId", String.format("%03d", new Object[] { Integer.valueOf(authId.intValue() + 1) }));
      mv = this.webAuthService.insertAuth(paramMap);
    } 
    if (paramMap.getString("saveMode").equals("U"))
      mv = this.webAuthService.updateAuth(paramMap); 
    if (paramMap.getString("saveMode").equals("D"))
      mv = this.webAuthService.deleteAuth(paramMap); 
    return mv;
  }
  
  @RequestMapping({"/system/webAuth/selectAuthExcelList.do"})
  @ResponseBody
  public ModelAndView selectAuthExcelList(HttpServletRequest request, ModelMap model) throws Exception {
    SimpleData paramData = getSimpleData(request);
    ModelAndView excelMV = this.webAuthService.selectAuthList(paramData);
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
