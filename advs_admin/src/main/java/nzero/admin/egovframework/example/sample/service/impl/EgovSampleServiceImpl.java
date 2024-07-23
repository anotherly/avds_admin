package nzero.admin.egovframework.example.sample.service.impl;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import nzero.admin.egovframework.example.sample.service.EgovSampleService;
import nzero.admin.egovframework.example.sample.service.SampleDefaultVO;
import nzero.admin.egovframework.example.sample.service.SampleVO;

import java.util.List;
import javax.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service("sampleService")
public class EgovSampleServiceImpl extends EgovAbstractServiceImpl
  implements EgovSampleService
{
  private static final Logger LOGGER = LoggerFactory.getLogger(EgovSampleServiceImpl.class);

  @Resource(name="sampleDAO")
  private SampleDAO sampleDAO;

  @Resource(name="egovIdGnrService")
  private EgovIdGnrService egovIdGnrService;

  public String insertSample(SampleVO vo)
    throws Exception
  {
    LOGGER.debug(vo.toString());

    String id = this.egovIdGnrService.getNextStringId();
    vo.setId(id);
    LOGGER.debug(vo.toString());

    this.sampleDAO.insertSample(vo);
    return id;
  }

  public void updateSample(SampleVO vo)
    throws Exception
  {
    this.sampleDAO.updateSample(vo);
  }

  public void deleteSample(SampleVO vo)
    throws Exception
  {
    this.sampleDAO.deleteSample(vo);
  }

  public SampleVO selectSample(SampleVO vo)
    throws Exception
  {
    SampleVO resultVO = this.sampleDAO.selectSample(vo);
    if (resultVO == null)
      throw processException("info.nodata.msg");
    return resultVO;
  }

  public List<?> selectSampleList(SampleDefaultVO searchVO)
    throws Exception
  {
    return this.sampleDAO.selectSampleList(searchVO);
  }

  public int selectSampleListTotCnt(SampleDefaultVO searchVO)
  {
    return this.sampleDAO.selectSampleListTotCnt(searchVO);
  }
}