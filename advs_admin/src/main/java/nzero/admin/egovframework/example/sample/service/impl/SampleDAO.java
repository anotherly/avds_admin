package nzero.admin.egovframework.example.sample.service.impl;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import nzero.admin.egovframework.example.sample.service.SampleDefaultVO;
import nzero.admin.egovframework.example.sample.service.SampleVO;

import java.util.List;
import org.springframework.stereotype.Repository;

@Repository("sampleDAO")
public class SampleDAO extends EgovAbstractDAO
{
  public String insertSample(SampleVO vo)
    throws Exception
  {
    return (String)insert("sampleDAO.insertSample", vo);
  }

  public void updateSample(SampleVO vo)
    throws Exception
  {
    update("sampleDAO.updateSample", vo);
  }

  public void deleteSample(SampleVO vo)
    throws Exception
  {
    delete("sampleDAO.deleteSample", vo);
  }

  public SampleVO selectSample(SampleVO vo)
    throws Exception
  {
    return (SampleVO)select("sampleDAO.selectSample", vo);
  }

  public List<?> selectSampleList(SampleDefaultVO searchVO)
    throws Exception
  {
    return list("sampleDAO.selectSampleList", searchVO);
  }

  public int selectSampleListTotCnt(SampleDefaultVO searchVO)
  {
    return ((Integer)select("sampleDAO.selectSampleListTotCnt", searchVO)).intValue();
  }
}