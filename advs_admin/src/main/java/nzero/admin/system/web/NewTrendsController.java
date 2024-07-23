package nzero.admin.system.web;

import egovframework.rte.fdl.property.EgovPropertyService;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.util.FileUtil;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.system.service.NewTrendsService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class NewTrendsController extends BaseController {
  private static final Logger LOGGER = LoggerFactory.getLogger(NewTrendsController.class);
  
  @Resource(name = "newTrendsService")
  private NewTrendsService newTrendsService;
  
  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;
  
  @RequestMapping({"/system/newTrends/openNewTrends.do"})
  public String openNewTrends(HttpServletRequest request) {
    return "system/newTrendsList";
  }
  
  @RequestMapping({"/system/newTrends/selectNewTrendsList.do"})
  @ResponseBody
  public ModelAndView selectNewTrendsList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.newTrendsService.selectNewTrendsList(paramMap);
  }
  
  @RequestMapping({"/system/newTrends/selectNewTrendsInfo.do"})
  @ResponseBody
  public ModelAndView selectNewTrendsInfo(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.newTrendsService.selectNewTrendsInfo(paramMap);
  }
  
  @RequestMapping({"/system/newTrends/insertNewTrendsInfo.do"})
  @ResponseBody
  public ModelAndView insertNewTrendsInfo(MultipartHttpServletRequest multipartRequest, HttpServletRequest request) throws Exception {
    String pathLetter = this.propertiesService.getString("pathLetter");
    String pathUpload = this.propertiesService.getString("pathUpload");
    String uploadPath = pathUpload + "trnd" + pathLetter;
    SimpleData paramMap = getSimpleData(request);
    Map<String, MultipartFile> files = multipartRequest.getFileMap();
    String newFileNM = "";
    if (!((MultipartFile)files.get("file_info")).isEmpty()) {
      paramMap.setString("attachFileNm", ((MultipartFile)files.get("file_info")).getOriginalFilename());
      paramMap.setString("attachFileSize", String.valueOf(((MultipartFile)files.get("file_info")).getSize()));
      String file_name = FileUtil.transferUploadFileNew(files.get("file_info"), uploadPath, newFileNM);
      paramMap.setString("attachFileNm", file_name);
    } 
    return this.newTrendsService.insertNewTrends(paramMap);
  }
  
  @RequestMapping({"/system/newTrends/updateNewTrendsInfo.do"})
  @ResponseBody
  public ModelAndView updateNewTrendsInfo(MultipartHttpServletRequest multipartRequest, HttpServletRequest request) throws Exception {
    String pathLetter = this.propertiesService.getString("pathLetter");
    String pathUpload = this.propertiesService.getString("pathUpload");
    String uploadPath = pathUpload + "trnd" + pathLetter;
    SimpleData paramMap = getSimpleData(request);
    Map<String, MultipartFile> files = multipartRequest.getFileMap();
    String newFileNM = "";
    if (!((MultipartFile)files.get("file_info")).isEmpty()) {
      paramMap.setString("attachFileNm", ((MultipartFile)files.get("file_info")).getOriginalFilename());
      paramMap.setString("attachFileSize", String.valueOf(((MultipartFile)files.get("file_info")).getSize()));
      String file_name = FileUtil.transferUploadFileNew(files.get("file_info"), uploadPath, newFileNM);
      paramMap.setString("attachFileNm", file_name);
    } 
    return this.newTrendsService.updateNewTrends(paramMap);
  }
  
  @RequestMapping({"/system/newTrends/deleteNewTrendsInfo.do"})
  @ResponseBody
  public ModelAndView deleteNewTrendsInfo(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.newTrendsService.deleteNewTrends(paramMap);
  }
}
