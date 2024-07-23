package nzero.admin.system.service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service("resvAppyService")
public class ResvAppyService extends EgovAbstractServiceImpl {
  private static final Logger LOGGER = LoggerFactory.getLogger(ResvAppyService.class);
  
  @Resource(name = "commonDAO")
  private CommonDAO commonDAO;
  
  public ModelAndView selectResvAppyList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("ResvAppyDAO.selectResvAppyList", paramMap);
  }
  
  public ModelAndView updateResvAppy(SimpleData paramMap) throws Exception {
	    return this.commonDAO.update("ResvAppyDAO.updateUser", paramMap);
	  }
}
