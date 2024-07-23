package nzero.admin.system.web;

import egovframework.rte.fdl.property.EgovPropertyService;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.util.FileUtil;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.system.service.NoticeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class NoticeController extends BaseController {
  private static final Logger LOGGER = LoggerFactory.getLogger(NoticeController.class);
  
  @Resource(name = "noticeService")
  private NoticeService noticeService;
  
  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;
  
  @RequestMapping({"/system/notice/openNotice.do"})
  public String openNotice(HttpServletRequest request) {
    return "system/noticeList";
  }
  
  @RequestMapping({"/system/notice/selectNoticeList.do"})
  @ResponseBody
  public ModelAndView selectNoticeList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.noticeService.selectNoticeList(paramMap);
  }
  
  @RequestMapping({"/system/notice/selectNoticeInfo.do"})
  @ResponseBody
  public ModelAndView selectNoticeInfo(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.noticeService.selectNoticeInfo(paramMap);
  }
  
  @RequestMapping({"/system/notice/insertNoticeInfo.do"})
  @ResponseBody
  public ModelAndView insertNoticeInfo(MultipartHttpServletRequest multipartRequest, HttpServletRequest request) throws Exception {
    String pathLetter = this.propertiesService.getString("pathLetter");
    String pathUpload = this.propertiesService.getString("pathUpload");
    String uploadPath = pathUpload + "notc" + pathLetter;
    SimpleData paramMap = getSimpleData(request);
    Map<String, MultipartFile> files = multipartRequest.getFileMap();
    String newFileNM = "";
    if (!((MultipartFile)files.get("file_info")).isEmpty()) {
      paramMap.setString("attachFileNm", ((MultipartFile)files.get("file_info")).getOriginalFilename());
      paramMap.setString("attachFileSize", String.valueOf(((MultipartFile)files.get("file_info")).getSize()));
      String file_name = FileUtil.transferUploadFileNew(files.get("file_info"), uploadPath, newFileNM);
      paramMap.setString("attachFileNm", file_name);
    } 
    return this.noticeService.insertNotice(paramMap);
  }
  
  @RequestMapping({"/system/notice/updateNoticeInfo.do"})
  @ResponseBody
  public ModelAndView updateNoticeInfo(MultipartHttpServletRequest multipartRequest, HttpServletRequest request) throws Exception {
    String pathLetter = this.propertiesService.getString("pathLetter");
    String pathUpload = this.propertiesService.getString("pathUpload");
    String uploadPath = pathUpload + "notc" + pathLetter;
    SimpleData paramMap = getSimpleData(request);
    Map<String, MultipartFile> files = multipartRequest.getFileMap();
    String newFileNM = "";
    if (!((MultipartFile)files.get("file_info")).isEmpty()) {
      paramMap.setString("attachFileNm", ((MultipartFile)files.get("file_info")).getOriginalFilename());
      paramMap.setString("attachFileSize", String.valueOf(((MultipartFile)files.get("file_info")).getSize()));
      String file_name = FileUtil.transferUploadFileNew(files.get("file_info"), uploadPath, newFileNM);
      paramMap.setString("attachFileNm", file_name);
    } 
    return this.noticeService.updateNotice(paramMap);
  }
  
  @RequestMapping({"/system/notice/deleteNoticeInfo.do"})
  @ResponseBody
  public ModelAndView deleteNoticeInfo(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    return this.noticeService.deleteNotice(paramMap);
  }
}
