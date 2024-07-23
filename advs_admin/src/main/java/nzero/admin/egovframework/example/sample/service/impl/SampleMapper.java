package nzero.admin.egovframework.example.sample.service.impl;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import nzero.admin.egovframework.example.sample.service.SampleDefaultVO;
import nzero.admin.egovframework.example.sample.service.SampleVO;

import java.util.List;

@Mapper("sampleMapper")
public abstract interface SampleMapper
{
  public abstract void insertSample(SampleVO paramSampleVO)
    throws Exception;

  public abstract void updateSample(SampleVO paramSampleVO)
    throws Exception;

  public abstract void deleteSample(SampleVO paramSampleVO)
    throws Exception;

  public abstract SampleVO selectSample(SampleVO paramSampleVO)
    throws Exception;

  public abstract List<?> selectSampleList(SampleDefaultVO paramSampleDefaultVO)
    throws Exception;

  public abstract int selectSampleListTotCnt(SampleDefaultVO paramSampleDefaultVO);
}