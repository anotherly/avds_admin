package nzero.admin.record.web;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.record.service.IncdVideoService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class IncdVideoController extends BaseController {
  private static final Logger LOGGER = LoggerFactory.getLogger(IncdVideoController.class);
  
  @Resource(name = "incdVideoService")
  private IncdVideoService incdVideoService;
  
  @RequestMapping({"/record/video/openIncdVideo.do"})
  public String openIncdVideo(HttpServletRequest request) {
    return "record/incdVideoList";
  }
  
  @RequestMapping({"/record/video/selectIncdVideoList.do"})
  @ResponseBody
  public ModelAndView selectIncdList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.incdVideoService.selectIncdList(paramMap);
  }
  
  @RequestMapping({"/record/video/selectAccVideoList.do"})
  @ResponseBody
  public ModelAndView selectAccVideoList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.incdVideoService.selectVideoList(paramMap);
  }
  
  @RequestMapping({"/record/video/selectIncdVideoExcelList.do"})
  @ResponseBody
  public ModelAndView selectIncdExcelList(HttpServletRequest request, ModelMap model) throws Exception {
    SimpleData paramData = getSimpleData(request);
    ModelAndView excelMV = this.incdVideoService.selectIncdExcelList(paramData);
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
