package nzero.admin.system.service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service("openApiService")
public class OpenApiService extends EgovAbstractServiceImpl {
  private static final Logger LOGGER = LoggerFactory.getLogger(OpenApiService.class);
  
  @Resource(name = "commonDAO")
  private CommonDAO commonDAO;
  
  public ModelAndView selectOpenApiList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("OpenApiDAO.selectOpenApiList", paramMap);
  }
  
  public ModelAndView deleteOpenApi(SimpleData paramMap) throws Exception {
    return this.commonDAO.delete("OpenApiDAO.deleteOpenApi", paramMap);
  }
  
  public ModelAndView updateOpenApi(SimpleData paramMap) throws Exception {
    return this.commonDAO.update("OpenApiDAO.updateOpenApi", paramMap);
  }
}
