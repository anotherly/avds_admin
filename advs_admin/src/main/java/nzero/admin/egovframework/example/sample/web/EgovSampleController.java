package nzero.admin.egovframework.example.sample.web;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import nzero.admin.egovframework.example.sample.service.EgovSampleService;
import nzero.admin.egovframework.example.sample.service.SampleDefaultVO;
import nzero.admin.egovframework.example.sample.service.SampleVO;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

@Controller
public class EgovSampleController
{

  @Resource(name="sampleService")
  private EgovSampleService sampleService;

  @Resource(name="propertiesService")
  protected EgovPropertyService propertiesService;

  @Resource(name="beanValidator")
  protected DefaultBeanValidator beanValidator;

  @RequestMapping({"/egovSampleList.do"})
  public String selectSampleList(@ModelAttribute("searchVO") SampleDefaultVO searchVO, ModelMap model)
    throws Exception
  {
    searchVO.setPageUnit(this.propertiesService.getInt("pageUnit"));
    searchVO.setPageSize(this.propertiesService.getInt("pageSize"));

    PaginationInfo paginationInfo = new PaginationInfo();
    paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
    paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
    paginationInfo.setPageSize(searchVO.getPageSize());

    searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
    searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    List sampleList = this.sampleService.selectSampleList(searchVO);
    model.addAttribute("resultList", sampleList);

    int totCnt = this.sampleService.selectSampleListTotCnt(searchVO);
    paginationInfo.setTotalRecordCount(totCnt);
    model.addAttribute("paginationInfo", paginationInfo);

    return "sample/egovSampleList";
  }

  @RequestMapping(value={"/addSample.do"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
  public String addSampleView(@ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model)
    throws Exception
  {
    model.addAttribute("sampleVO", new SampleVO());
    return "sample/egovSampleRegister";
  }

  @RequestMapping(value={"/addSample.do"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
  public String addSample(@ModelAttribute("searchVO") SampleDefaultVO searchVO, SampleVO sampleVO, BindingResult bindingResult, Model model, SessionStatus status)
    throws Exception
  {
    this.beanValidator.validate(sampleVO, bindingResult);

    if (bindingResult.hasErrors()) {
      model.addAttribute("sampleVO", sampleVO);
      return "sample/egovSampleRegister";
    }

    this.sampleService.insertSample(sampleVO);
    status.setComplete();
    return "forward:/egovSampleList.do";
  }

  @RequestMapping({"/updateSampleView.do"})
  public String updateSampleView(@RequestParam("selectedId") String id, @ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model)
    throws Exception
  {
    SampleVO sampleVO = new SampleVO();
    sampleVO.setId(id);

    model.addAttribute(selectSample(sampleVO, searchVO));
    return "sample/egovSampleRegister";
  }

  public SampleVO selectSample(SampleVO sampleVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO)
    throws Exception
  {
    return this.sampleService.selectSample(sampleVO);
  }

  @RequestMapping({"/updateSample.do"})
  public String updateSample(@ModelAttribute("searchVO") SampleDefaultVO searchVO, SampleVO sampleVO, BindingResult bindingResult, Model model, SessionStatus status)
    throws Exception
  {
    this.beanValidator.validate(sampleVO, bindingResult);

    if (bindingResult.hasErrors()) {
      model.addAttribute("sampleVO", sampleVO);
      return "sample/egovSampleRegister";
    }

    this.sampleService.updateSample(sampleVO);
    status.setComplete();
    return "forward:/egovSampleList.do";
  }

  @RequestMapping({"/deleteSample.do"})
  public String deleteSample(SampleVO sampleVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO, SessionStatus status)
    throws Exception
  {
    this.sampleService.deleteSample(sampleVO);
    status.setComplete();
    return "forward:/egovSampleList.do";
  }
}