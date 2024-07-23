package nzero.admin.system.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.system.service.MenuService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MenuController extends BaseController {
  private static final Logger LOGGER = LoggerFactory.getLogger(MenuController.class);
  
  @Resource(name = "menuService")
  private MenuService menuService;
  
  @RequestMapping({"/system/menu/selectMenuComboBox.do"})
  @ResponseBody
  public ModelAndView selectMenuComboBox(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.menuService.selectMenuComboBox(paramMap);
  }
  
  @RequestMapping({"/system/menu/openMenu.do"})
  public String openMenu(HttpServletRequest request) {
    return "system/menuList";
  }
  
  @RequestMapping({"/system/menu/selectMenuList.do"})
  @ResponseBody
  public ModelAndView selectMenuList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.menuService.selectMenuList(paramMap);
  }
  
  @RequestMapping({"/system/menu/transactionMenu.do"})
  @ResponseBody
  public ModelAndView transactionMenu(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    ModelAndView mv = null;
    if (paramMap.getString("saveMode").equals("I"))
      mv = this.menuService.insertMenu(paramMap); 
    if (paramMap.getString("saveMode").equals("U"))
      mv = this.menuService.updateMenu(paramMap); 
    if (paramMap.getString("saveMode").equals("D"))
      mv = this.menuService.deleteMenu(paramMap); 
    return mv;
  }
}
