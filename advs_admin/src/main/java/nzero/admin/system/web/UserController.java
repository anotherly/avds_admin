package nzero.admin.system.web;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.system.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class UserController extends BaseController {
  private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);
  
  @Resource(name = "userService")
  private UserService userService;
  
  @RequestMapping({"/system/user/openUser.do"})
  public String openUser(HttpServletRequest request) {
    return "system/userList";
  }
  
  @RequestMapping({"/system/user/selectUserList.do"})
  @ResponseBody
  public ModelAndView selectUserList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.userService.selectUserList(paramMap);
  }
  
  @RequestMapping({"/system/user/transactionUser.do"})
  @ResponseBody
  public ModelAndView transactionUser(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    ModelAndView mv = null;
    if (paramMap.getString("saveMode").equals("I"))
      mv = this.userService.insertUser(paramMap); 
    if (paramMap.getString("saveMode").equals("U"))
      mv = this.userService.updateUser(paramMap); 
    if (paramMap.getString("saveMode").equals("D"))
      mv = this.userService.deleteUser(paramMap); 
    return mv;
  }
  
  @RequestMapping({"/system/user/selectUserExcelList.do"})
  @ResponseBody
  public ModelAndView selectUserExcelList(HttpServletRequest request, ModelMap model) throws Exception {
    SimpleData paramData = getSimpleData(request);
    ModelAndView excelMV = this.userService.selectUserList(paramData);
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
