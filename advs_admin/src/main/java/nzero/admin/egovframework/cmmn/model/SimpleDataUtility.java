package nzero.admin.egovframework.cmmn.model;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Enumeration;
import javax.servlet.http.HttpServletRequest;

public class SimpleDataUtility
{
  public static SimpleData getData(HttpServletRequest req)
  {
    SimpleData data = new SimpleData("REQUEST_DATA");
    String key;
    for (Enumeration e = req.getParameterNames(); e.hasMoreElements(); data.put(key, req.getParameter(key))) {
      key = (String)e.nextElement();
    }
    return data;
  }

  public static SimpleMultiData getMultiData(HttpServletRequest req)
  {
    SimpleMultiData multiData = new SimpleMultiData("requestbox");
    String key;
    ArrayList list;
    for (Enumeration e = req.getParameterNames(); e.hasMoreElements(); multiData.put(key, list))
    {
      key = (String)e.nextElement();
      String[] values = req.getParameterValues(key);

      list = new ArrayList();
      for (int i = 0; i < values.length; i++) {
        list.add(values[i]);
      }
    }

    return multiData;
  }

  public static Object SimpleDataToValueObject(SimpleData data, Class src)
    throws Exception
  {
    Object returnValue = src.newInstance();
    Class superClass = src;
    Field[] field = superClass.getDeclaredFields();

    for (int i = 0; i < field.length; i++) {
      if (data.containsKey(field[i].getName())) {
        String methodName = "set" + field[i].getName().substring(0, 1).toUpperCase() + field[i].getName().substring(1);
        Method method = superClass.getMethod(methodName, new Class[] { field[i].getType() });

        Object[] argument = { 
          getObjectValueByType(field[i]
          .getType(), data.getString(field[i].getName())) };

        method.invoke(returnValue, argument);
      }
    }

    return returnValue;
  }

  private static Object getObjectValueByType(Class type, String value)
  {
    Object returnValue = null;
    if ((Byte.TYPE == type) || (Byte.class == type)) {
      returnValue = new Byte(Byte.parseByte(value));
    } else if ((Integer.TYPE == type) || (Integer.class == type)) {
      if (value.equals("")) value = "0";
      returnValue = new Integer(Integer.parseInt(value.replaceAll(",", "")));
    } else if ((Long.TYPE == type) || (Long.class == type)) {
      if (value.equals("")) value = "0";
      returnValue = new Long(Long.parseLong(value.replaceAll(",", "")));
    } else if ((Double.TYPE == type) || (Double.class == type)) {
      if (value.equals("")) value = "0";
      returnValue = new Double(Double.parseDouble(value.replaceAll(",", "")));
    } else if ((Float.TYPE == type) || (Float.class == type)) {
      if (value.equals("")) value = "0";
      returnValue = new Float(Float.parseFloat(value.replaceAll(",", "")));
    } else if ((Character.TYPE == type) || (Character.class == type)) {
      char[] charArr = value.toCharArray();
      returnValue = new Character(charArr[0]);
    } else if ((Boolean.TYPE == type) || (Boolean.class == type)) {
      returnValue = new Boolean(value);
    }
    else if (String.class == type) {
      returnValue = value;
    }

    return returnValue;
  }
}