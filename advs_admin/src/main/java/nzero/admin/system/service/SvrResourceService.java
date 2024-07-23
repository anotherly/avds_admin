package nzero.admin.system.service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;
import nzero.admin.egovframework.cmmn.service.impl.User;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service("svrResourceService")
public class SvrResourceService extends EgovAbstractServiceImpl {
  private static final Logger LOGGER = LoggerFactory.getLogger(SvrResourceService.class);
  
  @Resource(name = "commonDAO")
  private CommonDAO commonDAO;
  
  public ModelAndView selectSvrResourceList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("SvrResourceDAO.selectSvrResourceList", paramMap);
  }

  public String insertResourceHist(User user) {	 
	return  (String) commonDAO.insert("SvrResourceDAO.insertResourceHist", user);
  }
}
