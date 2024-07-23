package nzero.admin.record.web;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.record.service.DownHistService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class DownHistController extends BaseController {
  private static final Logger LOGGER = LoggerFactory.getLogger(DownHistController.class);
  
  @Resource(name = "downHistService")
  private DownHistService downHistService;
  
  @RequestMapping({"/record/downloadhitory/openDownHist.do"})
  public String openDownHist(HttpServletRequest request) {
    return "record/downHistList";
  }
  
  @RequestMapping({"/record/downloadhitory/selectDownHistList.do"})
  @ResponseBody
  public ModelAndView selectDownList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.downHistService.selectDownHistList(paramMap);
  }
  
  @RequestMapping({"/record/downloadhitory/selectDownHistExcelList.do"})
  @ResponseBody
  public ModelAndView selectDownExcelList(HttpServletRequest request, ModelMap model) throws Exception {
    SimpleData paramData = getSimpleData(request);
    ModelAndView excelMV = this.downHistService.selectDownExcelList(paramData);
    Map<String, Object> excelModel = excelMV.getModel();
    List<Object> excelList = (List<Object>)excelModel.get("rows");
    String[] columsNm = paramData.getString("columnsNm").split(",");
    String[] datafield = paramData.getString("datafield").split(",");
    model.put("columnsNm", columsNm);
    model.put("datafield", datafield);
    model.put("excelList", excelList);
    model.put("excelFileNm", request.getParameter("excelFileNm"));
    return new ModelAndView("ExcelDownload", "excel", model);
  }
}
