package nzero.admin.system.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.system.service.AuthMapService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AuthMapController extends BaseController {
  private static final Logger LOGGER = LoggerFactory.getLogger(AuthMapController.class);
  
  @Resource(name = "authMapService")
  private AuthMapService authMapService;
  
  @RequestMapping({"/system/authMap/openAuthMap.do"})
  public String openAuthMap(HttpServletRequest request) {
    return "system/authMapList";
  }
  
  @RequestMapping({"/system/authMap/selectAuthMapList.do"})
  @ResponseBody
  public ModelAndView selectAuthMapList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.authMapService.selectAuthMapList(paramMap);
  }
  
  @RequestMapping({"/system/authMap/transactionAuthMap.do"})
  @ResponseBody
  public ModelAndView transactionAuthMap(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    ModelAndView mv = null;
    mv = this.authMapService.deleteAuthMap(paramMap);
    if (paramMap.get("menuIds") != null) {
      String pMenuIds = paramMap.get("menuIds").toString();
      String[] menuIds = pMenuIds.split(",");
      for (int i = 0; i < menuIds.length; i++) {
        paramMap.put("menuId", menuIds[i]);
        mv = this.authMapService.insertAuthMap(paramMap);
      } 
    } 
    return mv;
  }
}
