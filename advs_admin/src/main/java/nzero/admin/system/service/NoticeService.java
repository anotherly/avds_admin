package nzero.admin.system.service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service("noticeService")
public class NoticeService extends EgovAbstractServiceImpl {
  private static final Logger LOGGER = LoggerFactory.getLogger(NoticeService.class);
  
  @Resource(name = "commonDAO")
  private CommonDAO commonDAO;
  
  public ModelAndView selectNoticeList(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("NoticeDAO.selectNoticeList", paramMap);
  }
  
  public ModelAndView selectNoticeInfo(SimpleData paramMap) throws Exception {
    return this.commonDAO.selectModel("NoticeDAO.selectNoticeInfo", paramMap);
  }
  
  public ModelAndView insertNotice(SimpleData paramMap) throws Exception {
    return this.commonDAO.insert("NoticeDAO.insertNotice", paramMap);
  }
  
  public ModelAndView updateNotice(SimpleData paramMap) throws Exception {
    return this.commonDAO.update("NoticeDAO.updateNotice", paramMap);
  }
  
  public ModelAndView deleteNotice(SimpleData paramMap) throws Exception {
    return this.commonDAO.delete("NoticeDAO.deleteNotice", paramMap);
  }
}
