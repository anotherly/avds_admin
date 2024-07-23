package nzero.admin.system.web;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.system.service.AuthService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AuthController extends BaseController {
  private static final Logger LOGGER = LoggerFactory.getLogger(AuthController.class);
  
  @Resource(name = "authService")
  private AuthService authService;
  
  @RequestMapping({"/system/auth/selectAuthComboBox.do"})
  @ResponseBody
  public ModelAndView selectAuthComboBox(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.authService.selectAuthComboBox(paramMap);
  }
  
  @RequestMapping({"/system/auth/openAuth.do"})
  public String openAuth(HttpServletRequest request) {
    return "system/authList";
  }
  
  @RequestMapping({"/system/auth/selectAuthList.do"})
  @ResponseBody
  public ModelAndView selectAuthList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.authService.selectAuthList(paramMap);
  }
  
  @RequestMapping({"/system/auth/transactionAuth.do"})
  @ResponseBody
  public ModelAndView transactionAuth(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    ModelAndView mv = null;
    if (paramMap.getString("saveMode").equals("I")) {
      Integer authId = this.authService.selectMaxAuthId(paramMap);
      paramMap.put("authId", String.format("%05d", new Object[] { Integer.valueOf(authId.intValue() + 1) }));
      mv = this.authService.insertAuth(paramMap);
    } 
    if (paramMap.getString("saveMode").equals("U"))
      mv = this.authService.updateAuth(paramMap); 
    if (paramMap.getString("saveMode").equals("D"))
      mv = this.authService.deleteAuth(paramMap); 
    return mv;
  }
  
  @RequestMapping({"/system/auth/selectAuthExcelList.do"})
  @ResponseBody
  public ModelAndView selectAuthExcelList(HttpServletRequest request, ModelMap model) throws Exception {
    SimpleData paramData = getSimpleData(request);
    ModelAndView excelMV = this.authService.selectAuthList(paramData);
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
