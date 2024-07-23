package nzero.admin.system.service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service("usaInfoService")
public class UsaInfoService extends EgovAbstractServiceImpl {
  private static final Logger LOGGER = LoggerFactory.getLogger(UsaInfoService.class);
  
  @Resource(name = "commonDAO")
  private CommonDAO commonDAO;
  
  public ModelAndView selectUsaInfoList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("UsaInfoDAO.selectUsaInfoList", paramMap);
  }
  
  public ModelAndView updateUsaInfo(SimpleData paramMap) throws Exception {
	    return this.commonDAO.update("UsaInfoDAO.updateUsaInfo", paramMap);
	  }
}
