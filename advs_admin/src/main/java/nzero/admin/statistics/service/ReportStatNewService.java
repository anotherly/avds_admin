package nzero.admin.statistics.service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service("reportStatNewService")
public class ReportStatNewService extends EgovAbstractServiceImpl {
	private static final Logger LOGGER = LoggerFactory.getLogger(ReportStatNewService.class);

	@Resource(name = "commonDAO")
	private CommonDAO commonDAO;

	// 임시운행 등록번호 기준으로 통계 조회
	public ModelAndView selectReportStatNewListByNum(SimpleData paramMap) throws Exception {
		return this.commonDAO.selectModel("ReportStatNewDAO.selectReportStatNewListByNum", paramMap);
	}

	// 기관 기준으로 통계 조회
	public ModelAndView selectReportStatNewListByTrn(SimpleData paramMap) throws Exception {
		return this.commonDAO.selectModel("ReportStatNewDAO.selectReportStatNewListByTrn", paramMap);
	}

	// 분야 기준으로 통계 조회
	public ModelAndView selectReportStatNewListByBusi(SimpleData paramMap) throws Exception {
		return this.commonDAO.selectModel("ReportStatNewDAO.selectReportStatNewListByBusi", paramMap);
	}
}