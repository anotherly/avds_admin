package nzero.admin.egovframework.cmmn.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Clob;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.multipart.MultipartFile;

public class Util {
  private static Log log = LogFactory.getLog(Util.class);
  
  public static String nvl(String s) {
    return (s == null) ? "" : s;
  }
  
  public static String nvl(String s, String d) {
    return (s == null) ? d : s;
  }
  
  public static int nvl(String s, int d) {
    if (s == null)
      return d; 
    try {
      return Integer.parseInt(s);
    } catch (NumberFormatException e) {
      return d;
    } 
  }
  
  public static long nvl(String s, long d) {
    if (s == null)
      return d; 
    try {
      return Long.parseLong(s);
    } catch (NumberFormatException e) {
      return d;
    } 
  }
  
  public static float nvl(String s, float d) {
    if (s == null)
      return d; 
    try {
      return Float.parseFloat(s);
    } catch (NumberFormatException e) {
      return d;
    } 
  }
  
  public static double nvl(String s, double d) {
    if (s == null)
      return d; 
    try {
      return Double.parseDouble(s);
    } catch (NumberFormatException e) {
      return d;
    } 
  }
  
  public static int nvl(Integer ii, int i) {
    return (ii == null) ? i : ii.intValue();
  }
  
  public static int isZero(Integer ii, int i) {
    return (ii.intValue() == 0) ? i : ii.intValue();
  }
  
  public static int setCurrentPage(String page) {
    int currentPage = 0;
    if (page == null || page.trim().isEmpty() || page.equals("0")) {
      currentPage = 1;
    } else {
      currentPage = Integer.parseInt(page);
    } 
    return currentPage;
  }
  
  public static String isNull(String str) {
    String chStr = "";
    if (str == null)
      return chStr; 
    if (str.equals("null") || str.equals(""))
      return chStr; 
    return str;
  }
  
  public static String isNull(String str, String chStr) {
    if (str == null)
      return chStr; 
    if (str.equals("null") || str.equals(""))
      return chStr; 
    return str;
  }
  
  public static String encodingUTF8(String str) {
    if (str != null) {
      String encodeStr = "";
      try {
        encodeStr = new String(str.getBytes("8859_1"), "utf-8");
      } catch (UnsupportedEncodingException e) {
        log.info("[encodingUTF8] : ");
      } 
      return encodeStr;
    } 
    return str;
  }
  
  public static int compareDate(String date1, String date2) {
    int result = 0;
    try {
      Date startDt1 = (new SimpleDateFormat("yyyyMMdd", Locale.KOREA)).parse(date1);
      Date startDt2 = (new SimpleDateFormat("yyyyMMdd", Locale.KOREA)).parse(date2);
      result = startDt1.compareTo(startDt2);
    } catch (ParseException e) {
      log.info("[compareDate] : ");
    } 
    return result;
  }
  
  public static String getFileExtension(String filename) {
    int idx = filename.lastIndexOf(".");
    if (idx > 0)
      return filename.substring(idx + 1); 
    return "";
  }
  
  public static String getFileFilename(String filename) {
    int idx = filename.lastIndexOf(".");
    if (idx > 0)
      return filename.substring(0, idx); 
    return "";
  }
  
  public static String setDecimalFormat(String str, String form) {
    String rtnVal = "";
    if (str == null)
      rtnVal = ""; 
    if (isStringDouble(str))
      rtnVal = (new DecimalFormat(form)).format(Double.parseDouble(str)); 
    return rtnVal;
  }
  
  public static boolean isStringDouble(String s) {
    try {
      Double.parseDouble(s);
      return true;
    } catch (NumberFormatException e) {
      return false;
    } 
  }
  
  public static String transferUploadFile(MultipartFile multipartFile, String destDir, int fileSequence) throws IOException {
    if (multipartFile != null) {
      String originFileNm = multipartFile.getOriginalFilename();
      if (originFileNm != null && !"".equals(originFileNm) && (
        originFileNm.endsWith(".doc") || originFileNm.endsWith(".hwp") || originFileNm
        .endsWith(".pdf") || originFileNm.endsWith(".xls") || originFileNm
        .endsWith(".jpg") || originFileNm.endsWith(".gif"))) {
        String changedFileNm = System.currentTimeMillis() + "_" + fileSequence + "." + getFileExtension(originFileNm);
        if (log.isDebugEnabled()) {
          log.debug("originFileNm : " + originFileNm);
          log.debug("changedFileNm : " + changedFileNm);
          log.debug("destDir : " + destDir);
        } 
        File dir = new File(destDir);
        if (!dir.exists())
          dir.mkdirs(); 
        multipartFile.transferTo(new File(destDir, changedFileNm));
        return changedFileNm;
      } 
    } 
    return null;
  }
  
  public static String arr2string(String[] src, String split) {
    StringBuffer sb = new StringBuffer();
    if (src != null && src.length > 0)
      for (int i = 0; i < src.length; i++) {
        if (sb.length() > 0)
          sb.append(split); 
        sb.append(src[i]);
      }  
    return sb.toString();
  }
  
  public static String excelErrCode(String value, int s) {
    String str = "";
    try {
      if (nvl(value).equals("") && (s == 0 || s == 1 || s == 8 || s == 18)) {
        str = "1";
      } else if (isStringDouble(value) && (s == 3 || s == 10 || s == 13)) {
        str = "2";
      } 
      switch (s) {
        case 0:
          if (value.length() > 99)
            str = "3"; 
          return str;
        case 1:
          if (value.length() > 4)
            str = "3"; 
          return str;
        case 2:
          if (value.length() > 10)
            str = "3"; 
          return str;
        case 4:
          if (value.length() > 50)
            str = "3"; 
          return str;
        case 5:
          if (value.length() > 10)
            str = "3"; 
          return str;
        case 6:
          if (value.length() > 10)
            str = "3"; 
          return str;
        case 7:
          if (value.length() > 10)
            str = "3"; 
          return str;
        case 8:
          if (value.length() > 10)
            str = "3"; 
          return str;
        case 9:
          if (value.length() > 10)
            str = "3"; 
          return str;
        case 11:
          if (value.length() > 100)
            str = "3"; 
          return str;
        case 12:
          if (value.length() > 300)
            str = "3"; 
          return str;
        case 14:
          if (value.length() > 50)
            str = "3"; 
          return str;
        case 15:
          if (value.length() > 10)
            str = "3"; 
          return str;
        case 16:
          if (value.length() > 300)
            str = "3"; 
          return str;
        case 17:
          if (value.length() > 600)
            str = "3"; 
          return str;
        case 18:
          if (value.length() > 10)
            str = "3"; 
          return str;
        case 20:
          if (value.length() > 50)
            str = "3"; 
          return str;
        case 21:
          if (value.length() > 10)
            str = "3"; 
          return str;
      } 
      str = "3";
    } catch (NullPointerException e) {
      log.info("[excelErrCode] : ");
    } 
    return str;
  }
  
  public static String replaceNumericFormat(String str) {
    return replaceNumericFormat(str, true);
  }
  
  public static String replaceNumericFormat(int num) {
    return replaceNumericFormat(String.valueOf(num), true);
  }
  
  public static String replaceNumericFormat(String str, boolean isTruncated) {
    if (str == null)
      return ""; 
    if (str.trim().equals(""))
      return ""; 
    if (str.trim().equals("&nbsp;"))
      return "&nbsp;"; 
    int pos = str.indexOf(".");
    if (pos != -1) {
      if (!isTruncated) {
        DecimalFormat decimalFormat1 = new DecimalFormat("#,##0.00");
        return decimalFormat1.format(Float.parseFloat(str.trim()));
      } 
      DecimalFormat decimalFormat = new DecimalFormat("#,##0");
      return decimalFormat.format(Long.parseLong(str.trim().substring(0, pos)));
    } 
    DecimalFormat commaFormat = new DecimalFormat("#,##0");
    return commaFormat.format(Long.parseLong(str.trim()));
  }
  
  public static String clobToStr(Clob clob) throws IOException, SQLException {
    BufferedReader contentReader = new BufferedReader(clob.getCharacterStream());
    StringBuffer out = new StringBuffer();
    String aux;
    while ((aux = contentReader.readLine()) != null) {
      out.append(aux);
      out.append("<br>");
    } 
    return out.toString();
  }
  
  public static String convertMinute(Object sec) {
    int second = Integer.parseInt((String)sec);
    return "";
  }
  
  public static String getSpeed(Object length, Object time, String dft) {
    DecimalFormat df = new DecimalFormat(dft);
    int len = Integer.parseInt((String)length);
    int tm = Integer.parseInt((String)time);
    if (tm > 0)
      return (new StringBuilder(String.valueOf(df.format(len * 3.6D / tm)))).toString(); 
    return "0";
  }
  
  public static String getGrade(Object maxspd, Object minspd, Object cspd) {
    int max = Integer.parseInt((String)maxspd);
    int min = Integer.parseInt((String)minspd);
    int spd = Integer.parseInt((String)cspd);
    if (spd == 0)
      return "0"; 
    if (spd <= min)
      return "3"; 
    if (spd > max)
      return "1"; 
    return "2";
  }
  
  public static String encrypt(String str) {
    try {
      MessageDigest digest = MessageDigest.getInstance("MD5");
      digest.update(str.getBytes());
      byte[] messageDigest = digest.digest();
      StringBuffer hexString = new StringBuffer();
      for (int i = 0; i < messageDigest.length; i++) {
        String h = Integer.toHexString(messageDigest[i] & 0xFF).toUpperCase();
        hexString.append(h);
      } 
      return hexString.toString();
    } catch (NoSuchAlgorithmException e) {
      e.printStackTrace();
      return "";
    } 
  }
  
  public static String getIpAddress(HttpServletRequest request) {
    String ipAddr = request.getHeader("X-Forwarded-For");
    if (ipAddr == null || ipAddr.length() == 0 || "unknown".equalsIgnoreCase(ipAddr))
      ipAddr = request.getHeader("Proxy-Client-IP"); 
    if (ipAddr == null || ipAddr.length() == 0 || "unknown".equalsIgnoreCase(ipAddr))
      ipAddr = request.getHeader("WL-Proxy-Client-IP"); 
    if (ipAddr == null || ipAddr.length() == 0 || "unknown".equalsIgnoreCase(ipAddr))
      ipAddr = request.getHeader("HTTP_CLIENT_IP"); 
    if (ipAddr == null || ipAddr.length() == 0 || "unknown".equalsIgnoreCase(ipAddr))
      ipAddr = request.getHeader("HTTP_X_FORWARDED_FOR"); 
    if (ipAddr == null || ipAddr.length() == 0 || "unknown".equalsIgnoreCase(ipAddr))
      ipAddr = request.getRemoteAddr(); 
    return ipAddr;
  }
}
