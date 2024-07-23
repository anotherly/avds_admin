package nzero.admin.system.web;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.fdl.property.EgovPropertyService;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.util.FileUtil;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.system.service.ResvAppyService;

@Controller
public class ResvAppyController extends BaseController {
  private static final Logger LOGGER = LoggerFactory.getLogger(ResvAppyController.class);
  
  @Resource(name = "resvAppyService")
  private ResvAppyService resvAppyService;
  
  /** EgovPropertyService */
	@Resource(name = "propertiesService") //환경 설정
	protected EgovPropertyService propertiesService;
	
  private static final Log LOG = LogFactory.getLog(CodeController.class.getName());
  
  
  @RequestMapping({"/system/resv/resvAppyList.do"})
  public String openAuth(HttpServletRequest request, ModelMap model) {
	  SimpleData paramMap = getSimpleData(request);
	  model.put("paramMap", paramMap);
    return "system/resvAppyList";
  }
  
  @RequestMapping({"/system/resv/selectResvAppyList.do"})
  @ResponseBody
  public ModelAndView selectResvAppyList(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    System.out.println(paramMap);
    return this.resvAppyService.selectResvAppyList(paramMap);
  }
  
  @RequestMapping({"/system/resv/saveResvAppy.do"})
  @ResponseBody
  public ModelAndView updateResvAppy(HttpServletRequest request) throws Exception {
    SimpleData paramMap = getSimpleData(request);
    ModelAndView mv = this.resvAppyService.updateResvAppy(paramMap); 
    return mv;
  }
  
  /**
	 * 지정한 파일을 다운로드 한다.
	 * @param paramMap - 다운로드할 파일 이름(file_nm)
	 * @param model
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/common/File_Download.do")
	public String fileDownloadProcess(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String pathLetter = propertiesService.getString("pathLetter"); 	// 구분자 : "/", "\\"
		String pathUpload = propertiesService.getString("pathUpload") + paramMap.get("dir_nm") + pathLetter;
		System.out.println("pathUpload >>>> "+ pathUpload);
		LOG.debug(" ########## File_Download.do ###########");
		// when searchWord is not null then encoding utf-8 
		if(paramMap.get("file_nm") != null) {
			try {
				String checkFile = paramMap.get("file_nm"); //잘못된 파라미터를 가려내기위해 특수기호 제거
				checkFile = checkFile.replaceAll("\\\\", "");
				checkFile = checkFile.replaceAll("/", "");
				checkFile = checkFile.replaceAll(";", "");
				//보안취약점 조치('19.11.25)
//				pathUpload = pathUpload.replaceAll(".", "");
//				pathUpload = pathUpload.replaceAll("/", "");
//				pathUpload = pathUpload.replaceAll("\\", "");
//				pathUpload = pathUpload.replaceAll("%", "");
				String down_file =  pathUpload + checkFile;
				//paramMap.put("file_nm", new String(down_file.getBytes("8859_1"),"utf-8")) ; //전자정부 표준프레임워크 3.2이상에는 인코딩안해도 됨.
				paramMap.put("file_nm", down_file);
			} catch (RuntimeException e1) {
				LOG.info("[Download File] 실패0 : ");
			}
			String filename = paramMap.get("file_nm");
			
			File file = new File(filename);
			LOG.debug("################### Download File : File Name ["+filename+"], File Length ["+file.length()+"] ");
			try {
				if(file.exists()){
					FileUtil.download(request, response, file);
					return null;
				}
				else{
					//파일이 존재하지 않을경우 alert창 띄움
					return "egovframework/cmmn/File_Exist";
				}
			} catch (ServletException e) {
				LOG.info("[Download File] 실패1 : ");
			} catch (IOException e) {
				LOG.info("[Download File] 실패2 : ");
			}
		}
		return "";
	}
  
}
