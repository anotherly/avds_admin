package nzero.admin.system.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.system.service.WebAuthMapService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class WebAuthMapController extends BaseController {
  private static final Logger LOGGER = LoggerFactory.getLogger(WebAuthMapController.class);
  
  @Resource(name = "webAuthMapService")
  private WebAuthMapService webAuthMapService;
  
  @RequestMapping({"/system/webAuthMap/openAuthMap.do"})
  public String openAuthMap(HttpServletRequest request) {
    return "system/webAuthMapList";
  }
  
  @RequestMapping({"/system/webAuthMap/selectAuthMapList.do"})
  @ResponseBody
  public ModelAndView selectAuthMapList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.webAuthMapService.selectAuthMapList(paramMap);
  }
  
  @RequestMapping({"/system/webAuthMap/transactionAuthMap.do"})
  @ResponseBody
  public ModelAndView transactionAuthMap(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    ModelAndView mv = null;
    mv = this.webAuthMapService.deleteAuthMap(paramMap);
    if (paramMap.get("menuIds") != null) {
      String pMenuIds = paramMap.get("menuIds").toString();
      String[] menuIds = pMenuIds.split(",");
      for (int i = 0; i < menuIds.length; i++) {
        paramMap.put("menuId", menuIds[i]);
        mv = this.webAuthMapService.insertAuthMap(paramMap);
      } 
    } 
    return mv;
  }
}
