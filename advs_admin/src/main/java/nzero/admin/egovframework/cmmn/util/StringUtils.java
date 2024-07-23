package nzero.admin.egovframework.cmmn.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Vector;
import java.util.regex.Pattern;

public class StringUtils {
  public static String nullToStr(Object obj) {
    if (obj == null)
      return ""; 
    return obj.toString().trim();
  }
  
  public static boolean isEmpty(String str) {
    return (str == null || str.length() == 0);
  }
  
  public static boolean isEmpty2(String str) {
    boolean result = true;
    if (str != null && !"".equals(str) && !"NULL".equalsIgnoreCase(str))
      result = false; 
    return result;
  }
  
  public static String nullValue(String str, String nullStr) {
    if (str == null || str.trim().length() == 0)
      return nullStr; 
    return str;
  }
  
  public static boolean isLower(char val) {
    if (val > '`' && val < '{')
      return true; 
    return false;
  }
  
  public static boolean isUpper(char val) {
    if (val > '^' && val < '\\')
      return true; 
    return false;
  }
  
  public static boolean isNumber(char val) {
    if (val > '/' && val < ':')
      return true; 
    return false;
  }
  
  public static String fixLength(String content, int length, String suffix) {
    if (content == null)
      return ""; 
    if ((content.getBytes()).length > length) {
      int slen = 0;
      int blen = 0;
      for (int realLength = length - (suffix.getBytes()).length; blen < realLength; ) {
        blen++;
        slen++;
        if (content.charAt(slen) > 0)
          blen++; 
      } 
      return content.substring(0, slen) + suffix;
    } 
    return content;
  }
  
  public static String showStringByLength(String szInput, int nLen) {
    String szLeft = trimString(szInput);
    for (int i = 1; i <= szInput.length(); i++) {
      szLeft = szInput.substring(0, i);
      if (lengthOfString(szLeft) > nLen) {
        szLeft = szInput.substring(0, i - 1);
        szLeft = szLeft + "...";
        break;
      } 
    } 
    return szLeft;
  }
  
  public static String trimString(String str) {
    String strTmp;
    if (str == null || str == "") {
      strTmp = "";
    } else {
      strTmp = str.trim();
    } 
    return strTmp;
  }
  
  public static int lengthOfString(String szAllText) {
    int nLen = 0;
    szAllText = trimString(szAllText);
    for (int i = 0; i < szAllText.length(); i++) {
      char szEach = szAllText.charAt(i);
      if (Character.MIN_VALUE <= szEach && szEach <= 0) {
        nLen++;
      } else {
        nLen += 2;
      } 
    } 
    return nLen;
  }
  
  public static String showHtmlTag(String pInstr) {
    if (pInstr == null || pInstr.equals(""))
      return ""; 
    String result = pInstr;
    result = replace(result, "&lt;", "<");
    result = replace(result, "&gt;", ">");
    result = replace(result, "&amp;", "&");
    result = replace(result, "&quot;", "\"");
    result = replace(result, "&apos;", "'");
    return result;
  }
  
  public static String delTag(String pInstr) {
    if (pInstr == null || pInstr.equals(""))
      return ""; 
    String result = pInstr;
    result = replace(result, "<", "&lt;");
    result = replace(result, ">", "&gt;");
    result = replace(result, "&", "&amp;");
    result = replace(result, "\"", "&quot;");
    result = replace(result, "'", "&apos;");
    return result;
  }
  
  public static String replace(String str, String pattern, String replace) {
    int s = 0;
    int e = 0;
    if (str == null || str.equals(""))
      return ""; 
    StringBuffer result = new StringBuffer();
    while ((e = str.indexOf(pattern, s)) >= 0) {
      result.append(str.substring(s, e));
      result.append(replace);
      s = e + pattern.length();
    } 
    result.append(str.substring(s));
    return result.toString();
  }
  
  public static String byteToHex(byte[] bytes) {
    StringBuilder sb = new StringBuilder();
    for (byte b : bytes) {
      String testStr = String.format("%02x", new Object[] { Integer.valueOf(b & 0xFF) });
      sb.append(testStr);
    } 
    return sb.toString();
  }
  
  public static boolean isNumeric(String str) {
    return Pattern.matches("[0-9]+", str);
  }
  
  public static boolean isAlpha(String str) {
    return Pattern.matches("[a-zA-Z]+", str);
  }
  
  public static boolean isAlphaNumeric(String str) {
    return Pattern.matches("[a-zA-Z0-9]+", str);
  }
  
  public static boolean isKorean(String str) {
    return Pattern.matches("", str);
  }
  
  public static boolean isPhoneNo(String str) {
    return Pattern.matches("0[0-9]{1,2}[-)]?[0-9]{3,4}[-]?[0-9]{4}", str);
  }
  
  public static int[] getRandomArray(int limitedMaxLength, int count) {
    int[] returnCnt = new int[count];
    Vector<Integer> tmp = new Vector();
    for (int i = 0; i < count; i++) {
      int randomNum = (int)Math.floor(Math.random() * limitedMaxLength) + 1;
      while (tmp.contains(Integer.valueOf(randomNum)))
        randomNum = (int)Math.floor(Math.random() * limitedMaxLength) + 1; 
      tmp.add(Integer.valueOf(randomNum));
      returnCnt[i] = randomNum;
    } 
    return returnCnt;
  }
  
  public static String getCarmelType(String str) {
    String strRet = "";
    boolean isDeli = false;
    for (int i = 0; i < str.length(); i++) {
      if (str.charAt(i) == '_') {
        isDeli = true;
      } else if (isDeli) {
        strRet = strRet + String.valueOf(str.charAt(i)).toUpperCase();
        isDeli = false;
      } else {
        strRet = strRet + String.valueOf(str.charAt(i)).toLowerCase();
      } 
    } 
    return strRet;
  }
  
  public static String getRevCarmelType(String str) {
    StringBuffer buffer = new StringBuffer();
    for (String token : str.split("(?=\\p{Upper})"))
      buffer.append(token.toUpperCase()).append('_'); 
    buffer.deleteCharAt(buffer.length() - 1);
    return buffer.toString();
  }
  
  public static String fnCalDateString(String sDFormat, String DateCd, int num) {
    Calendar calendar2 = Calendar.getInstance();
    if (DateCd.equals("D")) {
      calendar2.add(5, num);
    } else if (DateCd.equals("M")) {
      calendar2.add(12, num);
    } 
    Date date2 = calendar2.getTime();
    String procDate2 = (new SimpleDateFormat(sDFormat)).format(date2);
    return procDate2;
  }
}
