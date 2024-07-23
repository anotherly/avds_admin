package nzero.admin.statistics.web;

import java.util.Calendar;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.statistics.service.ReportStatService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ReportStatController extends BaseController {
  private static final Logger LOGGER = LoggerFactory.getLogger(ReportStatController.class);
  
  @Resource(name = "reportStatService")
  private ReportStatService reportStatService;
  
  @RequestMapping({"/statistics/stat/openReportStat.do"})
  public String openReportStat(HttpServletRequest request) {
    Calendar cal = Calendar.getInstance();
    request.setAttribute("curYear", Integer.valueOf(cal.get(1)));
    return "statistics/reportStatList";
  }
  
  @RequestMapping({"/statistics/stat/selectReportStatList.do"})
  @ResponseBody
  public ModelAndView selectReportList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.reportStatService.selectReportStatList(paramMap);
  }
}
