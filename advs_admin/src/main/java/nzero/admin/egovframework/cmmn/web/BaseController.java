package nzero.admin.egovframework.cmmn.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;
import javax.servlet.http.HttpServletRequest;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.model.SimpleDataUtility;
import nzero.admin.egovframework.cmmn.model.SimpleMultiData;
import org.springframework.stereotype.Controller;

@Controller
public class BaseController
{
  protected SimpleData getSimpleData(HttpServletRequest request)
  {
    SimpleData data = SimpleDataUtility.getData(request);
    if (request.getAttribute("gv_aop_tokenKey") != null) {
      data.setString("gv_aop_tokenKey", request.getAttribute("gv_aop_tokenKey").toString());
    }

    if (data.get("sortdatafield") != null) {
      data.setString("sortdatafield", nzero.admin.egovframework.cmmn.util.StringUtils.getRevCarmelType(data.get("sortdatafield").toString()));
    }
    return data;
  }

  protected SimpleMultiData getSimpleMultiData(HttpServletRequest request)
  {
    return SimpleDataUtility.getMultiData(request);
  }

  protected SimpleData getSimpleDecodeData(HttpServletRequest request)
  {
    return (SimpleData)request.getAttribute("decodeData");
  }

  protected SimpleMultiData getSimpleMultiDecodeData(HttpServletRequest request)
  {
    return (SimpleMultiData)request.getAttribute("decodeMulitData");
  }

  protected SimpleData getStringToSimpleData(String paramVal, String del1, String del2)
  {
    SimpleData result = new SimpleData();

    if ((paramVal == null) || (paramVal.equals(""))) {
      return result;
    }

    StringTokenizer tokenizer = new StringTokenizer(paramVal, del1);

    while (tokenizer.hasMoreTokens())
    {
      String str = tokenizer.nextToken();

      int keyIndex = str.indexOf(del2);
      if (keyIndex != -1) {
        String key = str.substring(0, keyIndex);
        if (key != null) {
          key = key.trim();
          if (!result.containsKey(key)) {
            String strVal = str.substring(keyIndex + 1, str.length());
            result.put(key, strVal);
          }
        }
      }
    }

    return result;
  }

  protected SimpleMultiData getStringToSimpleMultiData(HttpServletRequest request, String paramVal, String del1, String del2)
  {
    Map m = null;
    List list = new ArrayList();
    Map mkey = null;

    Set keylist = new HashSet();
    StringTokenizer tokenizer = new StringTokenizer(paramVal, del1);

    while (tokenizer.hasMoreTokens())
    {
      String str = tokenizer.nextToken();

      int keyIndex = str.indexOf(del2);
      if (keyIndex != -1) {
        String key = str.substring(0, keyIndex);
        if (key != null) {
          key = key.trim();
          String strVal = str.substring(keyIndex + 1, str.length());

          m = new HashMap();
          m.put(key, strVal);
          list.add(m);

          mkey = new HashMap();
          keylist.add(key);
        }

      }

    }

    String value = "";
    Iterator iter = keylist.iterator();
    int keyCount = 0;
    int keyCountDummy = 0;
    Map oneMap = null;

    while (iter.hasNext()) {
      value = (String)iter.next();
      keyCount = org.apache.commons.lang3.StringUtils.countMatches(paramVal, value);
      if (keyCount >= keyCountDummy) {
        keyCountDummy = keyCount;
      }
    }

    SimpleMultiData mdata = new SimpleMultiData();
    SimpleData sdata = null;
    for (int i = 0; i < keyCountDummy; i++) {
      sdata = makeSimpleData(keylist, list, paramVal);
      mdata.addSimpleData(sdata);
    }

    return mdata;
  }

  public SimpleData makeSimpleData(Set keylist, List list, String paramVal)
  {
    String value = "";

    Iterator iter = keylist.iterator();
    int keyCount = 0;
    Map oneMap = null;

    SimpleData sdata = new SimpleData();

    while (iter.hasNext()) {
      value = (String)iter.next();

      keyCount = org.apache.commons.lang3.StringUtils.countMatches(paramVal, value);

      for (int k = 0; k < list.size(); k++) {
        oneMap = (Map)list.get(k);
        if (oneMap.get(value) != null) {
          sdata.setString(value, oneMap.get(value).toString());
          list.remove(k);
          break;
        }
      }
    }
    return sdata;
  }
}