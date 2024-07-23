package nzero.admin.system.service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service("newTrendsService")
public class NewTrendsService extends EgovAbstractServiceImpl {
  private static final Logger LOGGER = LoggerFactory.getLogger(NewTrendsService.class);
  
  @Resource(name = "commonDAO")
  private CommonDAO commonDAO;
  
  public ModelAndView selectNewTrendsList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("NewTrendsDAO.selectNewTrendsList", paramMap);
  }
  
  public ModelAndView selectNewTrendsInfo(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("NewTrendsDAO.selectNewTrendsInfo", paramMap);
  }
  
  public ModelAndView insertNewTrends(SimpleData paramMap) throws Exception {
    return this.commonDAO.insert("NewTrendsDAO.insertNewTrends", paramMap);
  }
  
  public ModelAndView updateNewTrends(SimpleData paramMap) throws Exception {
    return this.commonDAO.update("NewTrendsDAO.updateNewTrends", paramMap);
  }
  
  public ModelAndView deleteNewTrends(SimpleData paramMap) throws Exception {
    return this.commonDAO.delete("NewTrendsDAO.deleteNewTrends", paramMap);
  }
}
