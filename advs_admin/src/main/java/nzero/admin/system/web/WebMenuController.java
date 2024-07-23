package nzero.admin.system.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.system.service.WebMenuService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class WebMenuController extends BaseController {
  private static final Logger LOGGER = LoggerFactory.getLogger(WebMenuController.class);
  
  @Resource(name = "webMenuService")
  private WebMenuService webMenuService;
  
  @RequestMapping({"/system/webMenu/selectMenuComboBox.do"})
  @ResponseBody
  public ModelAndView selectMenuComboBox(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.webMenuService.selectMenuComboBox(paramMap);
  }
  
  @RequestMapping({"/system/webMenu/openMenu.do"})
  public String openMenu(HttpServletRequest request) {
    return "system/webMenuList";
  }
  
  @RequestMapping({"/system/webMenu/selectMenuList.do"})
  @ResponseBody
  public ModelAndView selectMenuList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.webMenuService.selectMenuList(paramMap);
  }
  
  @RequestMapping({"/system/webMenu/transactionMenu.do"})
  @ResponseBody
  public ModelAndView transactionMenu(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    ModelAndView mv = null;
    if (paramMap.getString("saveMode").equals("I"))
      mv = this.webMenuService.insertMenu(paramMap); 
    if (paramMap.getString("saveMode").equals("U"))
      mv = this.webMenuService.updateMenu(paramMap); 
    if (paramMap.getString("saveMode").equals("D"))
      mv = this.webMenuService.deleteMenu(paramMap); 
    return mv;
  }
}
