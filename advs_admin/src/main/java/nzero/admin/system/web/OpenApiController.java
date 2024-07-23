package nzero.admin.system.web;

import java.util.UUID;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.system.service.OpenApiService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class OpenApiController extends BaseController {
  private static final Logger LOGGER = LoggerFactory.getLogger(OpenApiController.class);
  
  @Resource(name = "openApiService")
  private OpenApiService openApiService;
  
  @RequestMapping({"/system/openApi/openOpenApi.do"})
  public String openOpenApi(HttpServletRequest request) {
    return "system/openApiList";
  }
  
  @RequestMapping({"/system/openApi/selectOpenApiList.do"})
  @ResponseBody
  public ModelAndView selectOpenApiList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.openApiService.selectOpenApiList(paramMap);
  }
  
  @RequestMapping({"/system/openApi/transactionOpenApi.do"})
  @ResponseBody
  public ModelAndView transactionOpenApi(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    ModelAndView mv = null;
    if (paramMap.getString("saveMode").equals("U")) {
      String apprCode = paramMap.getString("apiApprCode");
      mv = this.openApiService.updateOpenApi(paramMap);
    } 
    if (paramMap.getString("saveMode").equals("D"))
      mv = this.openApiService.deleteOpenApi(paramMap); 
    return mv;
  }
  
  @RequestMapping({"/system/openApi/generationApiKey.do"})
  @ResponseBody
  public ModelAndView generationApiKey(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    ModelAndView mv = new ModelAndView("jsonView");
    String apiKey = UUID.randomUUID().toString().replaceAll("-", "");
    mv.addObject("apiKey", apiKey);
    return mv;
  }
}
