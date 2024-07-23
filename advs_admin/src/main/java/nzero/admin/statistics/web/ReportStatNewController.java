package nzero.admin.statistics.web;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.statistics.service.ReportStatNewService;

import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ReportStatNewController extends BaseController {
	private static final Logger LOGGER = LoggerFactory.getLogger(ReportStatNewController.class);

	@Resource(name = "reportStatNewService")
	private ReportStatNewService reportStatNewService;

	// 보고서 통계 화면
	@RequestMapping({ "/statistics/stat/openReportStatNew.do" })
	public String openReportStatNew(HttpServletRequest request) {
		Calendar cal = Calendar.getInstance();
		request.setAttribute("curYear", Integer.valueOf(cal.get(1)));
		return "statistics/reportStatNewList";
	}

	// 보고서 통계 목록 조회
	@RequestMapping({ "/statistics/stat/selectReportStatNewList.do" })
	@ResponseBody
	public ModelAndView selectReportStatNewList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		return this.reportStatNewService.selectReportStatNewListByNum(paramMap);
	}

	// 보고서 통계 엑셀 다운로드
	@RequestMapping({ "/statistics/stat/selectReportStatNewExcel.do" })
	@ResponseBody
	public void selectReportStatNewExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SimpleData paramData = getSimpleData(request);

		// 상반기, 하반기
		String sTerm = "";
		if (paramData.get("sTerm").equals("01")) {
			sTerm = "상반기";
		} else if (paramData.get("sTerm").equals("07")) {
			sTerm = "하반기";
		}

		// Excel 생성
		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFDataFormat dataFormat = workbook.createDataFormat();

		/////////////////////// 임시운행 등록번호 기준으로 통계 조회 ///////////////////////
		ModelAndView excelMV = this.reportStatNewService.selectReportStatNewListByNum(paramData);

		Map<String, Object> excelModel = excelMV.getModel();
		List<Object> excelList = (List<Object>) excelModel.get("rows");

		HSSFSheet sheet = workbook.createSheet("임시운행허가 차량별 주행거리");
		Map<String, CellStyle> styles = createStyles(workbook, dataFormat);

		Row row = null;
		Cell cell = null;

		sheet.setColumnWidth(1, 2000);
		sheet.setColumnWidth(2, 8000);
		sheet.setColumnWidth(3, 5000);
		sheet.setColumnWidth(4, 3000);

		sheet.setColumnWidth(5, 3000);
		sheet.setColumnWidth(6, 3000);
		sheet.setColumnWidth(7, 3000);
		sheet.setColumnWidth(8, 3000);

		sheet.setColumnWidth(9, 3000);
		sheet.setColumnWidth(10, 3000);
		sheet.setColumnWidth(11, 3000);
		sheet.setColumnWidth(12, 3000);

		sheet.setColumnWidth(13, 3000);
		sheet.setColumnWidth(14, 3000);
		sheet.setColumnWidth(15, 3000);

		// 제목 생성
		row = sheet.createRow(0);
		row = sheet.createRow(1);
		cell = row.createCell(0);
		cell = row.createCell(1);
		cell.setCellStyle((CellStyle) styles.get("title"));
		cell.setCellValue(paramData.get("sKeyword") + "년 " + sTerm + " 자율주행 임시운행 허가차량 주행거리 ");
		cell = row.createCell(2);
		cell = row.createCell(3);
		cell = row.createCell(4);
		cell = row.createCell(5);
		cell = row.createCell(6);
		cell = row.createCell(7);
		cell = row.createCell(8);
		cell = row.createCell(9);
		sheet.addMergedRegion(new CellRangeAddress(1, 1, 1, 9));
		row = sheet.createRow(2);

		// 헤더 생성(1)
		row = sheet.createRow(3);
		cell = row.createCell(0);
		cell = row.createCell(1);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("순번");
		cell = row.createCell(2);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("임시운행기관");
		cell = row.createCell(3);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("임시운행 등록번호");
		cell = row.createCell(4);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("반납");
		cell = row.createCell(5);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("총 누적치");
		cell = row.createCell(6);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(7);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(8);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(9);
		cell.setCellStyle((CellStyle) styles.get("header"));
		if (sTerm.equals("상반기")) {
			cell.setCellValue((Integer.valueOf((String) paramData.get("sKeyword")) - 1) + "년 하반기까지" + " 누적치");
		} else if (sTerm.equals("하반기")) {
			cell.setCellValue((Integer.valueOf((String) paramData.get("sKeyword"))) + "년 상반기까지" + " 누적치");
		} else {
			cell.setCellValue("입력값 오류");
		}
		cell = row.createCell(10);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(11);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(12);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(13);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue(paramData.get("sKeyword") + "년 " + sTerm + " 주행거리");
		cell = row.createCell(14);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(15);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(16);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue(paramData.get("sKeyword") + "년 " + sTerm + " 월별 자율주행 주행거리");
		cell = row.createCell(17);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(18);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(19);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(20);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(21);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(22);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(23);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue(paramData.get("sKeyword") + "년 " + sTerm + " 제어권 전환 횟수");
		cell = row.createCell(24);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(25);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(26);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(27);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(28);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(29);
		cell.setCellStyle((CellStyle) styles.get("header"));

		// 헤더 생성(2)
		row = sheet.createRow(4);
		cell = row.createCell(0);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(1);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(2);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(3);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(4);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(5);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("총주행거리");
		cell = row.createCell(6);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("자율모드");
		cell = row.createCell(7);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("일반모드");
		cell = row.createCell(8);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("제어권 전환 횟수");
		cell = row.createCell(9);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("총주행거리");
		cell = row.createCell(10);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("자율모드");
		cell = row.createCell(11);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("일반모드");
		cell = row.createCell(12);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("제어권 전환 횟수");
		cell = row.createCell(13);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("총주행거리");
		cell = row.createCell(14);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("자율모드");
		cell = row.createCell(15);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("일반모드");
		cell = row.createCell(16);
		cell.setCellStyle((CellStyle) styles.get("header"));
		if (paramData.get("sTerm").equals("01"))
			cell.setCellValue("1월");
		else if (paramData.get("sTerm").equals("07"))
			cell.setCellValue("7월");
		cell = row.createCell(17);
		cell.setCellStyle((CellStyle) styles.get("header"));
		if (paramData.get("sTerm").equals("01"))
			cell.setCellValue("2월");
		else if (paramData.get("sTerm").equals("07"))
			cell.setCellValue("8월");
		cell = row.createCell(18);
		cell.setCellStyle((CellStyle) styles.get("header"));
		if (paramData.get("sTerm").equals("01"))
			cell.setCellValue("3월");
		else if (paramData.get("sTerm").equals("07"))
			cell.setCellValue("9월");
		cell = row.createCell(19);
		cell.setCellStyle((CellStyle) styles.get("header"));
		if (paramData.get("sTerm").equals("01"))
			cell.setCellValue("4월");
		else if (paramData.get("sTerm").equals("07"))
			cell.setCellValue("10월");
		cell = row.createCell(20);
		cell.setCellStyle((CellStyle) styles.get("header"));
		if (paramData.get("sTerm").equals("01"))
			cell.setCellValue("5월");
		else if (paramData.get("sTerm").equals("07"))
			cell.setCellValue("11월");
		cell = row.createCell(21);
		cell.setCellStyle((CellStyle) styles.get("header"));
		if (paramData.get("sTerm").equals("01"))
			cell.setCellValue("6월");
		else if (paramData.get("sTerm").equals("07"))
			cell.setCellValue("12월");
		cell = row.createCell(22);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("합계");
		cell = row.createCell(23);
		cell.setCellStyle((CellStyle) styles.get("header"));
		if (paramData.get("sTerm").equals("01"))
			cell.setCellValue("1월");
		else if (paramData.get("sTerm").equals("07"))
			cell.setCellValue("7월");
		cell = row.createCell(24);
		cell.setCellStyle((CellStyle) styles.get("header"));
		if (paramData.get("sTerm").equals("01"))
			cell.setCellValue("2월");
		else if (paramData.get("sTerm").equals("07"))
			cell.setCellValue("8월");
		cell = row.createCell(25);
		cell.setCellStyle((CellStyle) styles.get("header"));
		if (paramData.get("sTerm").equals("01"))
			cell.setCellValue("3월");
		else if (paramData.get("sTerm").equals("07"))
			cell.setCellValue("9월");
		cell = row.createCell(26);
		cell.setCellStyle((CellStyle) styles.get("header"));
		if (paramData.get("sTerm").equals("01"))
			cell.setCellValue("4월");
		else if (paramData.get("sTerm").equals("07"))
			cell.setCellValue("10월");
		cell = row.createCell(27);
		cell.setCellStyle((CellStyle) styles.get("header"));
		if (paramData.get("sTerm").equals("01"))
			cell.setCellValue("5월");
		else if (paramData.get("sTerm").equals("07"))
			cell.setCellValue("11월");
		cell = row.createCell(28);
		cell.setCellStyle((CellStyle) styles.get("header"));
		if (paramData.get("sTerm").equals("01"))
			cell.setCellValue("6월");
		else if (paramData.get("sTerm").equals("07"))
			cell.setCellValue("12월");
		cell = row.createCell(29);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("합계");

		// 헤더 셀 병합
		sheet.addMergedRegion(new CellRangeAddress(3, 4, 1, 1));
		sheet.addMergedRegion(new CellRangeAddress(3, 4, 2, 2));
		sheet.addMergedRegion(new CellRangeAddress(3, 4, 3, 3));
		sheet.addMergedRegion(new CellRangeAddress(3, 4, 4, 4));

		sheet.addMergedRegion(new CellRangeAddress(3, 3, 5, 8));

		sheet.addMergedRegion(new CellRangeAddress(3, 3, 9, 12));

		sheet.addMergedRegion(new CellRangeAddress(3, 3, 13, 15));

		sheet.addMergedRegion(new CellRangeAddress(3, 3, 16, 22));
		sheet.addMergedRegion(new CellRangeAddress(3, 3, 23, 29));

		// 데이타 생성
		cell = row.createCell(0);

		for (int i = 0; i < excelList.size(); i++) {
			Map<String, Object> excelMap = (Map<String, Object>) excelList.get(i);
			row = sheet.createRow(5 + i);

			int cellIndex = 1;

			// 순번
			cell = row.createCell(cellIndex++);
			enterValueInCell(cell, String.valueOf(i + 1), styles);

			// 임시운행기관
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("trn")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 임시운행 등록번호
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("tmpRaceNumber")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 반납
			cell = row.createCell(cellIndex++);
			cell.setCellStyle((CellStyle) styles.get("number"));

			// 총 누적치 : 총주행거리
			cell = row.createCell(cellIndex++);
			cell.setCellStyle((CellStyle) styles.get("formula"));
			cell.setCellType(CellType.FORMULA);
			String formula = String.format("SUM(J%d, N%d)", (5 + i + 1), (5 + i + 1));
			cell.setCellFormula(formula);

			// 총 누적치 : 자율모드
			cell = row.createCell(cellIndex++);
			cell.setCellStyle((CellStyle) styles.get("formula"));
			cell.setCellType(CellType.FORMULA);
			formula = String.format("SUM(K%d, O%d)", (5 + i + 1), (5 + i + 1));
			cell.setCellFormula(formula);

			// 총 누적치 : 일반모드
			cell = row.createCell(cellIndex++);
			cell.setCellStyle((CellStyle) styles.get("formula"));
			cell.setCellType(CellType.FORMULA);
			formula = String.format("SUM(L%d, P%d)", (5 + i + 1), (5 + i + 1));
			cell.setCellFormula(formula);

			// 총 누적치 : 제어권 전환 횟수
			cell = row.createCell(cellIndex++);
			cell.setCellStyle((CellStyle) styles.get("formula"));
			cell.setCellType(CellType.FORMULA);
			formula = String.format("SUM(M%d, AD%d)", (5 + i + 1), (5 + i + 1));
			cell.setCellFormula(formula);

			// 전반기까지(누적) : 총주행거리
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("lastTotalDrivingDist")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 전반기까지(누적) : 자율모드
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("lastAutoDrivingDist")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 전반기까지(누적) : 일반모드
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("lastNomalDrivingDist")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 전반기까지(누적) : 제어권 전환 횟수
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("lastTotalCtrChangeCnt")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 해당년도 반기 주행거리 : 총주행거리
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("totalDrivingDist")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 해당년도 반기 주행거리 : 자율모드
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("autoDrivingDist")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 해당년도 반기 주행거리 : 일반모드
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("nomalDrivingDist")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 해당년도 반기 월별 자율주행 주행거리 : 1월
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("autoDrivingDist1")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 해당년도 반기 월별 자율주행 주행거리 : 2월
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("autoDrivingDist2")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 해당년도 반기 월별 자율주행 주행거리 : 3월
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("autoDrivingDist3")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 해당년도 반기 월별 자율주행 주행거리 : 4월
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("autoDrivingDist4")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 해당년도 반기 월별 자율주행 주행거리 : 5월
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("autoDrivingDist5")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 해당년도 반기 월별 자율주행 주행거리 : 6월
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("autoDrivingDist6")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 해당년도 반기 월별 자율주행 주행거리 : 합계
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("autoDrivingSum")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 해당년도 반기 제어권 전환 횟수 : 1월
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("ctrChangeCnt1")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 해당년도 반기 제어권 전환 횟수 : 2월
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("ctrChangeCnt2")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 해당년도 반기 제어권 전환 횟수 : 3월
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("ctrChangeCnt3")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 해당년도 반기 제어권 전환 횟수 : 4월
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("ctrChangeCnt4")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 해당년도 반기 제어권 전환 횟수 : 5월
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("ctrChangeCnt5")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 해당년도 반기 제어권 전환 횟수 : 6월
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("ctrChangeCnt6")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 해당년도 반기 제어권 전환 횟수 : 합계
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("ctrChangeSum")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}
		}

		// 누적
		row = sheet.createRow(5 + excelList.size());
		cell = row.createCell(0);
		cell = row.createCell(1);
		cell = row.createCell(2);
		cell = row.createCell(3);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("누적");
		cell = row.createCell(4);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		String formula = String.format("SUM(E%d:E%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(5);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(F%d:F%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(6);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(G%d:G%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(7);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(H%d:H%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(8);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(I%d:I%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(9);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(J%d:J%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(10);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(K%d:K%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(11);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(L%d:L%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(12);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(M%d:M%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(13);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(N%d:N%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(14);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(O%d:O%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(15);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(P%d:P%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(16);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(Q%d:Q%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(17);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(R%d:R%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(18);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(S%d:S%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(19);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(T%d:T%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(20);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(U%d:U%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(21);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(V%d:V%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(22);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(W%d:W%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(23);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(X%d:X%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(24);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(Y%d:Y%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(25);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(Z%d:Z%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(26);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(AA%d:AA%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(27);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(AB%d:AB%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(28);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(AC%d:AC%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(29);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(AD%d:AD%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		/////////////////////// 임시운행 등록번호 기준으로 통계 조회 끝 ///////////////////////

		/////////////////////// 기관 기준으로 통계 조회 ///////////////////////
		excelMV = this.reportStatNewService.selectReportStatNewListByTrn(paramData);

		excelModel = excelMV.getModel();
		excelList = (List<Object>) excelModel.get("rows");

		sheet = workbook.createSheet("기관별 주행거리");
		styles = createStyles(workbook, dataFormat);

		row = null;
		cell = null;

		sheet.setColumnWidth(1, 3000);
		sheet.setColumnWidth(2, 5000);
		sheet.setColumnWidth(3, 3000);

		sheet.setColumnWidth(4, 3000);
		sheet.setColumnWidth(5, 3000);
		sheet.setColumnWidth(6, 3000);
		sheet.setColumnWidth(7, 3000);

		sheet.setColumnWidth(8, 3000);
		sheet.setColumnWidth(9, 3000);
		sheet.setColumnWidth(10, 3000);
		sheet.setColumnWidth(11, 3000);

		sheet.setColumnWidth(12, 3000);
		sheet.setColumnWidth(13, 3000);
		sheet.setColumnWidth(14, 3000);

		// 제목 생성
		row = sheet.createRow(0);
		row = sheet.createRow(1);
		cell = row.createCell(0);
		cell = row.createCell(1);
		cell.setCellStyle((CellStyle) styles.get("title"));
		cell.setCellValue(paramData.get("sKeyword") + "년 " + sTerm + " 기관별 주행거리 ");
		cell = row.createCell(2);
		cell = row.createCell(3);
		cell = row.createCell(4);
		cell = row.createCell(5);
		cell = row.createCell(6);
		cell = row.createCell(7);
		cell = row.createCell(8);
		cell = row.createCell(9);
		sheet.addMergedRegion(new CellRangeAddress(1, 1, 1, 9));
		row = sheet.createRow(2);

		// 헤더 생성(1)
		row = sheet.createRow(3);
		cell = row.createCell(0);
		cell = row.createCell(1);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("순번");
		cell = row.createCell(2);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("임시운행기관");
		cell = row.createCell(3);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("운행대수");
		cell = row.createCell(4);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("총 누적치");
		cell = row.createCell(5);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(6);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(7);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(8);
		cell.setCellStyle((CellStyle) styles.get("header"));
		if (sTerm.equals("상반기")) {
			cell.setCellValue((Integer.valueOf((String) paramData.get("sKeyword")) - 1) + "년 하반기까지" + " 누적치");
		} else if (sTerm.equals("하반기")) {
			cell.setCellValue((Integer.valueOf((String) paramData.get("sKeyword"))) + "년 상반기까지" + " 누적치");
		} else {
			cell.setCellValue("입력값 오류");
		}
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(9);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(10);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(11);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(12);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue(paramData.get("sKeyword") + "년 " + sTerm + " 주행거리");
		cell = row.createCell(13);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(14);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(15);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue(paramData.get("sKeyword") + "년 " + sTerm + " 제어권 전환 횟수");
		cell = row.createCell(16);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(17);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(18);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(19);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(20);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(21);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(22);
		cell.setCellStyle((CellStyle) styles.get("header"));

		// 헤더 생성(2)
		row = sheet.createRow(4);
		cell = row.createCell(0);
		cell = row.createCell(1);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(2);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(3);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(4);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("총주행거리");
		cell = row.createCell(5);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("자율모드");
		cell = row.createCell(6);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("일반모드");
		cell = row.createCell(7);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("제어권 전환 횟수");
		cell = row.createCell(8);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("총주행거리");
		cell = row.createCell(9);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("자율모드");
		cell = row.createCell(10);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("일반모드");
		cell = row.createCell(11);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("제어권 전환 횟수");
		cell = row.createCell(12);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("총주행거리");
		cell = row.createCell(13);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("자율모드");
		cell = row.createCell(14);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("일반모드");
		cell = row.createCell(15);
		cell.setCellStyle((CellStyle) styles.get("header"));
		if (paramData.get("sTerm").equals("01"))
			cell.setCellValue("1월");
		else if (paramData.get("sTerm").equals("07"))
			cell.setCellValue("7월");
		cell = row.createCell(16);
		cell.setCellStyle((CellStyle) styles.get("header"));
		if (paramData.get("sTerm").equals("01"))
			cell.setCellValue("2월");
		else if (paramData.get("sTerm").equals("07"))
			cell.setCellValue("8월");
		cell = row.createCell(17);
		cell.setCellStyle((CellStyle) styles.get("header"));
		if (paramData.get("sTerm").equals("01"))
			cell.setCellValue("3월");
		else if (paramData.get("sTerm").equals("07"))
			cell.setCellValue("9월");
		cell = row.createCell(18);
		cell.setCellStyle((CellStyle) styles.get("header"));
		if (paramData.get("sTerm").equals("01"))
			cell.setCellValue("4월");
		else if (paramData.get("sTerm").equals("07"))
			cell.setCellValue("10월");
		cell = row.createCell(19);
		cell.setCellStyle((CellStyle) styles.get("header"));
		if (paramData.get("sTerm").equals("01"))
			cell.setCellValue("5월");
		else if (paramData.get("sTerm").equals("07"))
			cell.setCellValue("11월");
		cell = row.createCell(20);
		cell.setCellStyle((CellStyle) styles.get("header"));
		if (paramData.get("sTerm").equals("01"))
			cell.setCellValue("6월");
		else if (paramData.get("sTerm").equals("07"))
			cell.setCellValue("12월");
		cell = row.createCell(21);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("합계");
		cell = row.createCell(22);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("자율모드km/건");

		// 헤더 셀 병합
		sheet.addMergedRegion(new CellRangeAddress(3, 4, 1, 1));
		sheet.addMergedRegion(new CellRangeAddress(3, 4, 2, 2));
		sheet.addMergedRegion(new CellRangeAddress(3, 4, 3, 3));

		sheet.addMergedRegion(new CellRangeAddress(3, 3, 4, 7));

		sheet.addMergedRegion(new CellRangeAddress(3, 3, 8, 11));

		sheet.addMergedRegion(new CellRangeAddress(3, 3, 12, 14));

		sheet.addMergedRegion(new CellRangeAddress(3, 3, 15, 22));

		// 데이타 생성
		cell = row.createCell(0);

		for (int i = 0; i < excelList.size(); i++) {
			Map<String, Object> excelMap = (Map<String, Object>) excelList.get(i);
			row = sheet.createRow(5 + i);

			int cellIndex = 1;

			// 순번
			cell = row.createCell(cellIndex++);
			enterValueInCell(cell, String.valueOf(i + 1), styles);

			// 임시운행기관
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("trn")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 운행대수
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("cnt")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 총 누적치 : 총주행거리
			cell = row.createCell(cellIndex++);
			cell.setCellStyle((CellStyle) styles.get("formula"));
			cell.setCellType(CellType.FORMULA);
			formula = String.format("SUM(I%d, M%d)", (5 + i + 1), (5 + i + 1));
			cell.setCellFormula(formula);

			// 총 누적치 : 자율모드
			cell = row.createCell(cellIndex++);
			cell.setCellStyle((CellStyle) styles.get("formula"));
			cell.setCellType(CellType.FORMULA);
			formula = String.format("SUM(J%d, N%d)", (5 + i + 1), (5 + i + 1));
			cell.setCellFormula(formula);

			// 총 누적치 : 일반모드
			cell = row.createCell(cellIndex++);
			cell.setCellStyle((CellStyle) styles.get("formula"));
			cell.setCellType(CellType.FORMULA);
			formula = String.format("SUM(K%d, O%d)", (5 + i + 1), (5 + i + 1));
			cell.setCellFormula(formula);

			// 총 누적치 : 제어권 전환 횟수
			cell = row.createCell(cellIndex++);
			cell.setCellStyle((CellStyle) styles.get("formula"));
			cell.setCellType(CellType.FORMULA);
			formula = String.format("SUM(L%d, V%d)", (5 + i + 1), (5 + i + 1));
			cell.setCellFormula(formula);

			// 전반기까지(누적) : 총주행거리
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("lastTotalDrivingDist")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 전반기까지(누적) : 자율모드
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("lastAutoDrivingDist")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 전반기까지(누적) : 일반모드
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("lastNomalDrivingDist")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 전반기까지(누적) : 제어권 전환 횟수
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("lastTotalCtrChangeCnt")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 해당년도 반기 주행거리 : 총주행거리
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("totalDrivingDist")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 해당년도 반기 주행거리 : 자율모드
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("autoDrivingDist")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 해당년도 반기 주행거리 : 일반모드
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("nomalDrivingDist")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 해당년도 반기 제어권 전환 횟수 : 1월
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("ctrChangeCnt1")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 해당년도 반기 제어권 전환 횟수 : 2월
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("ctrChangeCnt2")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 해당년도 반기 제어권 전환 횟수 : 3월
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("ctrChangeCnt3")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 해당년도 반기 제어권 전환 횟수 : 4월
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("ctrChangeCnt4")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 해당년도 반기 제어권 전환 횟수 : 5월
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("ctrChangeCnt5")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 해당년도 반기 제어권 전환 횟수 : 6월
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("ctrChangeCnt6")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 해당년도 반기 제어권 전환 횟수 : 합계
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("ctrChangeSum")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 자율모드 km/건
			cell = row.createCell(cellIndex++);
			cell.setCellStyle((CellStyle) styles.get("formula2DP"));
			cell.setCellType(CellType.FORMULA);
			formula = String.format("N%d / V%d", (5 + i + 1), (5 + i + 1));
			cell.setCellFormula(formula);
			
		}
		
		// 누적
		row = sheet.createRow(5 + excelList.size());
		cell = row.createCell(0);
		cell = row.createCell(1);
		cell = row.createCell(2);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("누적");
		cell = row.createCell(3);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(D%d:D%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(4);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(E%d:E%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(5);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(F%d:F%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(6);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(G%d:G%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(7);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(H%d:H%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(8);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(I%d:I%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(9);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(J%d:J%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(10);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(K%d:K%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(11);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(L%d:L%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(12);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(M%d:M%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(13);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(N%d:N%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(14);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(O%d:O%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(15);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(P%d:P%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(16);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(Q%d:Q%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(17);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(R%d:R%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(18);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(S%d:S%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(19);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(T%d:T%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(20);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(U%d:U%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(21);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(V%d:V%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(22);
		cell.setCellStyle((CellStyle) styles.get("formula2DP"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("N%d / V%d", (5 + excelList.size() + 2), (5 + excelList.size() + 2));
		cell.setCellFormula(formula);
		/////////////////////// 기관 기준으로 통계 조회 끝 ///////////////////////
		
		/////////////////////// 분야 기준으로 통계 조회(1) ///////////////////////
		excelMV = this.reportStatNewService.selectReportStatNewListByBusi(paramData);

		excelModel = excelMV.getModel();
		excelList = (List<Object>) excelModel.get("rows");

		sheet = workbook.createSheet("분야별 주행거리");
		styles = createStyles(workbook, dataFormat);

		row = null;
		cell = null;

		sheet.setColumnWidth(1, 3000);
		sheet.setColumnWidth(2, 5000);
		sheet.setColumnWidth(3, 3000);

		sheet.setColumnWidth(4, 5000);
		sheet.setColumnWidth(5, 5000);
		sheet.setColumnWidth(6, 5000);
		
		sheet.setColumnWidth(7, 5000);
		
		// 제목 생성
		row = sheet.createRow(0);
		row = sheet.createRow(1);
		cell = row.createCell(0);
		cell = row.createCell(1);
		cell.setCellStyle((CellStyle) styles.get("title"));
		cell.setCellValue(paramData.get("sKeyword") + "년 " + sTerm + " 분야별 주행거리 ");
		cell = row.createCell(2);
		cell = row.createCell(3);
		cell = row.createCell(4);
		cell = row.createCell(5);
		cell = row.createCell(6);
		cell = row.createCell(7);
		cell = row.createCell(8);
		cell = row.createCell(9);
		sheet.addMergedRegion(new CellRangeAddress(1, 1, 1, 9));
		row = sheet.createRow(2);

		// 헤더 생성(1)
		row = sheet.createRow(3);
		cell = row.createCell(0);
		cell = row.createCell(1);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("순번");
		cell = row.createCell(2);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("분야");
		cell = row.createCell(3);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("업체수");
		cell = row.createCell(4);
		cell.setCellStyle((CellStyle) styles.get("header"));
		if (sTerm.equals("상반기")) {
			cell.setCellValue((Integer.valueOf((String) paramData.get("sKeyword")) - 1) + "년 하반기까지" + " 누적치");
		} else if (sTerm.equals("하반기")) {
			cell.setCellValue((Integer.valueOf((String) paramData.get("sKeyword"))) + "년 상반기까지" + " 누적치");
		} else {
			cell.setCellValue("입력값 오류");
		}
		cell = row.createCell(5);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(6);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(7);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("운행대수");

		// 헤더 생성(2)
		row = sheet.createRow(4);
		cell = row.createCell(0);
		cell = row.createCell(1);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(2);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(3);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(4);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("총주행거리");
		cell = row.createCell(5);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("자율모드");
		cell = row.createCell(6);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("일반모드");
		cell = row.createCell(7);
		cell.setCellStyle((CellStyle) styles.get("header"));

		// 헤더 셀 병합
		sheet.addMergedRegion(new CellRangeAddress(3, 4, 1, 1));
		sheet.addMergedRegion(new CellRangeAddress(3, 4, 2, 2));
		sheet.addMergedRegion(new CellRangeAddress(3, 4, 3, 3));

		sheet.addMergedRegion(new CellRangeAddress(3, 3, 4, 6));

		sheet.addMergedRegion(new CellRangeAddress(3, 4, 7, 7));

		// 데이타 생성
		cell = row.createCell(0);

		for (int i = 0; i < excelList.size(); i++) {
			Map<String, Object> excelMap = (Map<String, Object>) excelList.get(i);
			row = sheet.createRow(5 + i);

			int cellIndex = 1;

			// 순번
			cell = row.createCell(cellIndex++);
			enterValueInCell(cell, String.valueOf(i + 1), styles);
			
			// 분야
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("busiNm")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 업체수
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("trnCnt")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}
			
			// 전반기까지(누적) : 총주행거리
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("lastTotalDrivingDist")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 전반기까지(누적) : 자율모드
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("lastAutoDrivingDist")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 전반기까지(누적) : 일반모드
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("lastNomalDrivingDist")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}
			
			// 운행대수
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("cnt")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}
		}
		
		// 누적
		row = sheet.createRow(5 + excelList.size());
		cell = row.createCell(0);
		cell = row.createCell(1);
		cell = row.createCell(2);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("누적");
		cell = row.createCell(3);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(D%d:D%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(4);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(E%d:E%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(5);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(F%d:F%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(6);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(G%d:G%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		cell = row.createCell(7);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(H%d:H%d)", 6, (5 + excelList.size()));
		cell.setCellFormula(formula);
		
		int lastRowIndex = 5 + excelList.size();
		/////////////////////// 분야 기준으로 통계 조회(1) 끝 ///////////////////////
		
		/////////////////////// 분야 기준으로 통계 조회(2) ///////////////////////
		excelMV = this.reportStatNewService.selectReportStatNewListByTrn(paramData);

		excelModel = excelMV.getModel();
		excelList = (List<Object>) excelModel.get("rows");
		
		// 헤더 생성(1)
		row = sheet.createRow(lastRowIndex + 2);
		cell = row.createCell(0);
		cell = row.createCell(1);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("순번");
		cell = row.createCell(2);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("임시운행기관");
		cell = row.createCell(3);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("운행대수");
		cell = row.createCell(4);
		cell.setCellStyle((CellStyle) styles.get("header"));
		if (sTerm.equals("상반기")) {
			cell.setCellValue((Integer.valueOf((String) paramData.get("sKeyword")) - 1) + "년 하반기까지" + " 누적치");
		} else if (sTerm.equals("하반기")) {
			cell.setCellValue((Integer.valueOf((String) paramData.get("sKeyword"))) + "년 상반기까지" + " 누적치");
		} else {
			cell.setCellValue("입력값 오류");
		}
		cell = row.createCell(5);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(6);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(7);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("분야");

		// 헤더 생성(2)
		row = sheet.createRow(lastRowIndex + 3);
		cell = row.createCell(0);
		cell = row.createCell(1);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(2);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(3);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell = row.createCell(4);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("총주행거리");
		cell = row.createCell(5);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("자율모드");
		cell = row.createCell(6);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("일반모드");
		cell = row.createCell(7);
		cell.setCellStyle((CellStyle) styles.get("header"));

		// 헤더 셀 병합
		sheet.addMergedRegion(new CellRangeAddress(lastRowIndex + 2, lastRowIndex + 3, 1, 1));
		sheet.addMergedRegion(new CellRangeAddress(lastRowIndex + 2, lastRowIndex + 3, 2, 2));
		sheet.addMergedRegion(new CellRangeAddress(lastRowIndex + 2, lastRowIndex + 3, 3, 3));

		sheet.addMergedRegion(new CellRangeAddress(lastRowIndex + 2, lastRowIndex + 2, 4, 6));

		sheet.addMergedRegion(new CellRangeAddress(lastRowIndex + 2, lastRowIndex + 3, 7, 7));

		// 데이타 생성
		cell = row.createCell(0);

		for (int i = 0; i < excelList.size(); i++) {
			Map<String, Object> excelMap = (Map<String, Object>) excelList.get(i);
			row = sheet.createRow(lastRowIndex + 4 + i);

			int cellIndex = 1;

			// 순번
			cell = row.createCell(cellIndex++);
			enterValueInCell(cell, String.valueOf(i + 1), styles);
			
			// 임시운행기관
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("trn")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 운행대수
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("cnt")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}
			
			// 전반기까지(누적) : 총주행거리
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("lastTotalDrivingDist")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 전반기까지(누적) : 자율모드
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("lastAutoDrivingDist")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}

			// 전반기까지(누적) : 일반모드
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("lastNomalDrivingDist")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}
			
			// 분야
			cell = row.createCell(cellIndex++);
			for (Object entry : excelMap.entrySet()) {
				if (((Map.Entry<String, Object>) entry).getKey().equals("busiNm")) {
					enterValueInCell(cell, String.valueOf(((Map.Entry<String, Object>) entry).getValue()), styles);
				}
			}
		}
		
		// 누적
		row = sheet.createRow(lastRowIndex + 4 + excelList.size());
		cell = row.createCell(0);
		cell = row.createCell(1);
		cell = row.createCell(2);
		cell.setCellStyle((CellStyle) styles.get("header"));
		cell.setCellValue("누적");
		cell = row.createCell(3);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(D%d:D%d)", lastRowIndex + 5, lastRowIndex + 4 + excelList.size());
		cell.setCellFormula(formula);
		cell = row.createCell(4);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(E%d:E%d)", lastRowIndex + 5, lastRowIndex + 4 + excelList.size());
		cell.setCellFormula(formula);
		cell = row.createCell(5);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(F%d:F%d)", lastRowIndex + 5, lastRowIndex + 4 + excelList.size());
		cell.setCellFormula(formula);
		cell = row.createCell(6);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(G%d:G%d)", lastRowIndex + 5, lastRowIndex + 4 + excelList.size());
		cell.setCellFormula(formula);
		cell = row.createCell(7);
		cell.setCellStyle((CellStyle) styles.get("formula"));
		cell.setCellType(CellType.FORMULA);
		formula = String.format("SUM(H%d:H%d)", lastRowIndex + 5, lastRowIndex + 4 + excelList.size());
		cell.setCellFormula(formula);
		/////////////////////// 분야 기준으로 통계 조회(2) 끝 ///////////////////////
		
		response.setContentType("ms-vnd/excel");
		response.setHeader("Content-Disposition", "attachment;filename=" + request.getParameter("excelFileNm"));

		workbook.write(response.getOutputStream());
		workbook.close();
	}

	// 엑셀 셀에 값 입력
	private void enterValueInCell(Cell cell, String val, Map<String, CellStyle> styles) {

		String[] Arr1 = val.split("/");
		String[] Arr2 = val.split(",");

		if (val == "null") {
			cell.setCellStyle((CellStyle) styles.get("cell"));
			cell.setCellValue("");
		} else if ((isNumber(Arr1[0])) || (isNumber(Arr2[0]))) {
			cell.setCellStyle((CellStyle) styles.get("number"));
			cell.setCellValue(Integer.parseInt(val));
			cell.setCellType(CellType.NUMERIC);
		} else {
			cell.setCellStyle((CellStyle) styles.get("cell"));
			cell.setCellValue(val);
		}
	}

	// 엑셀 스타일 유형 생성
	private Map<String, CellStyle> createStyles(Workbook wb, DataFormat dataFormat) {
		Map styles = new HashMap();

		Font titleFont = wb.createFont();
		titleFont.setFontHeightInPoints((short) 18);
		titleFont.setBold(true);
		titleFont.setFontName("맑은 고딕");
		CellStyle style = wb.createCellStyle();
		style.setAlignment(HorizontalAlignment.CENTER);
		style.setVerticalAlignment(VerticalAlignment.CENTER);
		style.setFont(titleFont);
		styles.put("title", style);

		Font monthFont = wb.createFont();
		monthFont.setFontHeightInPoints((short) 11);
		monthFont.setColor(IndexedColors.WHITE.getIndex());
		monthFont.setFontName("맑은 고딕");
		style = wb.createCellStyle();
		style.setAlignment(HorizontalAlignment.CENTER);
		style.setVerticalAlignment(VerticalAlignment.CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_50_PERCENT.getIndex());
		style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		style.setBorderRight(BorderStyle.THIN);
		style.setRightBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderLeft(BorderStyle.THIN);
		style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderTop(BorderStyle.THIN);
		style.setTopBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderBottom(BorderStyle.THIN);
		style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		style.setFont(monthFont);
		style.setWrapText(true);
		styles.put("header", style);

		Font cellFont = wb.createFont();
		cellFont.setFontHeightInPoints((short) 10);
		cellFont.setColor(IndexedColors.BLACK.getIndex());
		cellFont.setFontName("맑은 고딕");

		style = wb.createCellStyle();
		style.setAlignment(HorizontalAlignment.CENTER);
		style.setBorderRight(BorderStyle.THIN);
		style.setRightBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderLeft(BorderStyle.THIN);
		style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderTop(BorderStyle.THIN);
		style.setTopBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderBottom(BorderStyle.THIN);
		style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		style.setFont(cellFont);
		styles.put("cell", style);

		style = wb.createCellStyle();
		style.setAlignment(HorizontalAlignment.CENTER);
		style.setVerticalAlignment(VerticalAlignment.CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
		style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		style.setBorderRight(BorderStyle.THIN);
		style.setRightBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderLeft(BorderStyle.THIN);
		style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderTop(BorderStyle.THIN);
		style.setTopBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderBottom(BorderStyle.THIN);
		style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		styles.put("formula", style);
		
		style = wb.createCellStyle();
		style.setAlignment(HorizontalAlignment.CENTER);
		style.setVerticalAlignment(VerticalAlignment.CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
		style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		style.setBorderRight(BorderStyle.THIN);
		style.setRightBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderLeft(BorderStyle.THIN);
		style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderTop(BorderStyle.THIN);
		style.setTopBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderBottom(BorderStyle.THIN);
		style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		style.setDataFormat(dataFormat.getFormat("0.00"));
		styles.put("formula2DP", style);

		style = wb.createCellStyle();
		style.setAlignment(HorizontalAlignment.RIGHT);
		style.setBorderRight(BorderStyle.THIN);
		style.setRightBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderLeft(BorderStyle.THIN);
		style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderTop(BorderStyle.THIN);
		style.setTopBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderBottom(BorderStyle.THIN);
		style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		style.setFont(cellFont);
		styles.put("number", style);

		return styles;
	}

	private boolean isNumber(String str) {
		boolean result = false;
		try {
			Float.parseFloat(str);
			result = true;
		} catch (Exception localException) {
		}
		return result;
	}
}
