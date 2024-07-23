package nzero.admin.egovframework.cmmn.service.impl;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.util.EgovMessageSource;
import org.springframework.stereotype.Repository;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

@Repository("commonDAO")
public class CommonDAO extends EgovAbstractDAO {
  @Resource(name = "egovMessageSource")
  private EgovMessageSource egovMessageSource;
  
  public String getUserId() {
    if ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes() == null)
      return ""; 
    ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes)RequestContextHolder.currentRequestAttributes();
    HttpServletRequest req = servletRequestAttributes.getRequest();
    return (new User(req.getSession())).getUserId();
  }
  
  public Object insert(String queryId, Object param) {
    return getSqlMapClientTemplate().insert(queryId, param);
  }
  
  public int update(String queryId, Object param) {
    return getSqlMapClientTemplate().update(queryId, param);
  }
  
  public int delete(String queryId, Object param) {
    return getSqlMapClientTemplate().delete(queryId, param);
  }
  
  public Object select(String queryId, Object param) {
    return getSqlMapClientTemplate().queryForObject(queryId, param);
  }
  
  public List<?> selectList(String queryId, Object param) {
    return list(queryId, param);
  }
  
  public int selectListTotCnt(String queryId, Object param) {
    return ((Integer)select(queryId, param)).intValue();
  }
  
  public ModelAndView selectModel(String queryId, SimpleData paramMap) throws Exception {
    ModelAndView mav = new ModelAndView("jsonView");
    mav.addObject("rows", list(queryId, paramMap));
    return mav;
  }
  
  public ModelAndView insert(String queryId, SimpleData paramMap) {
    ModelAndView mav = new ModelAndView("jsonView");
    Integer errorCode = Integer.valueOf(0);
    String message = "";
    String userId = getUserId();
    paramMap.put("createId", userId);
    paramMap.put("updateId", userId);
    getSqlMapClientTemplate().insert(queryId, paramMap);
    message = this.egovMessageSource.getMessage("success.common.insert");
    mav.addObject("errorCode", errorCode);
    mav.addObject("message", message);
    return mav;
  }
  
  public ModelAndView update(String queryId, SimpleData paramMap) {
    ModelAndView mav = new ModelAndView("jsonView");
    Integer errorCode = Integer.valueOf(0);
    String message = "";
    String userId = getUserId();
    paramMap.put("updateId", userId);
    int updateCnt = getSqlMapClientTemplate().update(queryId, paramMap);
    if (updateCnt == 0) {
      message = this.egovMessageSource.getMessage("fail.common.update");
    } else {
      message = this.egovMessageSource.getMessage("success.common.update");
    } 
    mav.addObject("errorCode", errorCode);
    mav.addObject("message", message);
    return mav;
  }
  
  public ModelAndView delete(String queryId, SimpleData paramMap) {
    ModelAndView mav = new ModelAndView("jsonView");
    Integer errorCode = Integer.valueOf(0);
    String message = "";
    String userId = getUserId();
    paramMap.put("updateId", userId);
    int deleteCnt = getSqlMapClientTemplate().delete(queryId, paramMap);
    if (deleteCnt == 0) {
      message = this.egovMessageSource.getMessage("fail.common.delete");
    } else {
      message = this.egovMessageSource.getMessage("success.common.delete");
    } 
    mav.addObject("errorCode", errorCode);
    mav.addObject("message", message);
    return mav;
  }
}
