package nzero.admin.egovframework.cmmn.util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.xssf.usermodel.XSSFCell;

public class ExcelUtil {
  private static Log log = LogFactory.getLog(ExcelUtil.class);
  
  public static String getType(XSSFCell cell) {
    String value = "";
    if (cell != null) {
      switch (cell.getCellType()) {
        case 2:
          value = Util.nvl(cell.getNumericCellValue() + "");
          log.debug("cell_value : " + value);
          return value;
        case 0:
          value = String.valueOf((new Double(cell.getNumericCellValue())).intValue());
          log.debug("cell_value : " + value);
          return value;
        case 1:
          value = Util.nvl(cell.getStringCellValue());
          log.debug("cell_value : " + value);
          return value;
        case 3:
          value = Util.nvl(cell.getBooleanCellValue() + "");
          log.debug("cell_value : " + value);
          return value;
        case 5:
          value = Util.nvl(cell.getErrorCellValue() + "");
          log.debug("cell_value : " + value);
          return value;
      } 
      value = Util.nvl(cell.getStringCellValue());
    } 
    log.debug("cell_value : " + value);
    return value;
  }
  
  public static String getReplace(String str, String rep, String tok) {
    String retStr = "";
    if (str == null)
      return ""; 
    if (str.equals(""))
      return ""; 
    int i, j;
    for (i = 0, j = 0; (j = str.indexOf(rep, i)) > -1; i = j + rep.length())
      retStr = retStr + str.substring(i, j) + tok; 
    return (str.indexOf(rep) == -1) ? str : (retStr + str.substring(str.lastIndexOf(rep) + rep.length(), str.length()));
  }
}
