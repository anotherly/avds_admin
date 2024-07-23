package nzero.admin.egovframework.cmmn.model;

import java.io.PrintStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

public class SimpleMultiData extends SimpleDataProtocol
{
  private int field_index;
  HashMap entityKey;

  public SimpleMultiData(String name)
  {
    this.field_index = 0;
    this.entityKey = null;
    this.name = name;
  }

  public SimpleMultiData(int initialCapacity, float loadFactor)
  {
    super(initialCapacity, loadFactor);
    this.field_index = 0;
    this.entityKey = null;
  }

  public SimpleMultiData(int initialCapacity)
  {
    super(initialCapacity);
    this.field_index = 0;
    this.entityKey = null;
  }

  public SimpleMultiData()
  {
    this.field_index = 0;
    this.entityKey = null;
  }

  public SimpleMultiData(Map m)
  {
    super(m);
    this.field_index = 0;
    this.entityKey = null;
  }

  public SimpleMultiData(int initialCapacity, float loadFactor, boolean accessOrder)
  {
    super(initialCapacity, loadFactor, accessOrder);
    this.field_index = 0;
    this.entityKey = null;
  }

  public void modify(Object key, int index, Object replaceValue)
  {
    if (!super.containsKey(key))
    {
      System.out.println("Key(" + key + ") does not exist in LMultiData(" + this.name + ") ");
      throw new RuntimeException("Key(" + key + ") does not exist in LMultiData(" + this.name + ") ");
    }
    ArrayList arrayList = (ArrayList)get(key);
    int valueSize = arrayList.size();
    if (valueSize <= index)
    {
      System.out.println("Index(" + index + ") of Key(" + key + ") exceeds size(" + (valueSize - 1) + ") of LMultiData ");
      throw new RuntimeException("Index(" + index + ") of Key(" + key + ") exceeds size(" + (valueSize - 1) + ") of LMultiData");
    }

    arrayList.set(index, replaceValue);
  }

  public void modifyInt(Object key, int index, int replaceValue)
  {
    if (!super.containsKey(key))
    {
      System.out.println("Key(" + key + ") does not exist in LMultiData(" + this.name + ") ");
      throw new RuntimeException("Key(" + key + ") does not exist in LMultiData(" + this.name + ") ");
    }
    ArrayList arrayList = (ArrayList)get(key);
    int valueSize = arrayList.size();
    if (valueSize <= index)
    {
      System.out.println("Index(" + index + ") of Key(" + key + ") exceeds size(" + (valueSize - 1) + ") of LMultiData ");
      throw new RuntimeException("Index(" + index + ") of Key(" + key + ") exceeds size(" + (valueSize - 1) + ") of LMultiData");
    }

    arrayList.set(index, new Integer(replaceValue));
  }

  public void modifyString(Object key, int index, String replaceValue)
  {
    if (!super.containsKey(key))
    {
      System.out.println("Key(" + key + ") does not exist in LMultiData(" + this.name + ") ");
      throw new RuntimeException("Key(" + key + ") does not exist in LMultiData(" + this.name + ") ");
    }
    ArrayList arrayList = (ArrayList)get(key);
    int valueSize = arrayList.size();
    if (valueSize <= index)
    {
      System.out.println("Index(" + index + ") of Key(" + key + ") exceeds size(" + (valueSize - 1) + ") of LMultiData ");
      throw new RuntimeException("Index(" + index + ") of Key(" + key + ") exceeds size(" + (valueSize - 1) + ") of LMultiData");
    }

    arrayList.set(index, replaceValue);
  }

  public void modifyDouble(Object key, int index, double replaceValue)
  {
    if (!super.containsKey(key))
    {
      System.out.println("Key(" + key + ") does not exist in LMultiData(" + this.name + ") ");
      throw new RuntimeException("Key(" + key + ") does not exist in LMultiData(" + this.name + ") ");
    }
    ArrayList arrayList = (ArrayList)get(key);
    int valueSize = arrayList.size();
    if (valueSize <= index)
    {
      System.out.println("Index(" + index + ") of Key(" + key + ") exceeds size(" + (valueSize - 1) + ") of LMultiData ");
      throw new RuntimeException("Index(" + index + ") of Key(" + key + ") exceeds size(" + (valueSize - 1) + ") of LMultiData");
    }

    arrayList.set(index, new Double(replaceValue));
  }

  public void modifyFloat(Object key, int index, float replaceValue)
  {
    if (!super.containsKey(key))
    {
      System.out.println("Key(" + key + ") does not exist in LMultiData(" + this.name + ") ");
      throw new RuntimeException("Key(" + key + ") does not exist in LMultiData(" + this.name + ") ");
    }
    ArrayList arrayList = (ArrayList)get(key);
    int valueSize = arrayList.size();
    if (valueSize <= index)
    {
      System.out.println("Index(" + index + ") of Key(" + key + ") exceeds size(" + (valueSize - 1) + ") of LMultiData ");
      throw new RuntimeException("Index(" + index + ") of Key(" + key + ") exceeds size(" + (valueSize - 1) + ") of LMultiData");
    }

    arrayList.set(index, new Float(replaceValue));
  }

  public void modifyLong(Object key, int index, long replaceValue)
  {
    if (!super.containsKey(key))
    {
      System.out.println("Key(" + key + ") does not exist in LMultiData(" + this.name + ") ");
      throw new RuntimeException("Key(" + key + ") does not exist in LMultiData(" + this.name + ") ");
    }
    ArrayList arrayList = (ArrayList)get(key);
    int valueSize = arrayList.size();
    if (valueSize <= index)
    {
      System.out.println("Index(" + index + ") of Key(" + key + ") exceeds size(" + (valueSize - 1) + ") of LMultiData ");
      throw new RuntimeException("Index(" + index + ") of Key(" + key + ") exceeds size(" + (valueSize - 1) + ") of LMultiData");
    }

    arrayList.set(index, new Long(replaceValue));
  }

  public void modifyShort(Object key, int index, short replaceValue)
  {
    if (!super.containsKey(key))
    {
      System.out.println("Key(" + key + ") does not exist in LMultiData(" + this.name + ") ");
      throw new RuntimeException("Key(" + key + ") does not exist in LMultiData(" + this.name + ") ");
    }
    ArrayList arrayList = (ArrayList)get(key);
    int valueSize = arrayList.size();
    if (valueSize <= index)
    {
      System.out.println("Index(" + index + ") of Key(" + key + ") exceeds size(" + (valueSize - 1) + ") of LMultiData ");
      throw new RuntimeException("Index(" + index + ") of Key(" + key + ") exceeds size(" + (valueSize - 1) + ") of LMultiData");
    }

    arrayList.set(index, new Short(replaceValue));
  }

  public void modifyBoolean(Object key, int index, boolean replaceValue)
  {
    if (!super.containsKey(key))
    {
      System.out.println("Key(" + key + ") does not exist in LMultiData(" + this.name + ") ");
      throw new RuntimeException("Key(" + key + ") does not exist in LMultiData(" + this.name + ") ");
    }
    ArrayList arrayList = (ArrayList)get(key);
    int valueSize = arrayList.size();
    if (valueSize <= index)
    {
      System.out.println("Index(" + index + ") of Key(" + key + ") exceeds size(" + (valueSize - 1) + ") of LMultiData ");
      throw new RuntimeException("Index(" + index + ") of Key(" + key + ") exceeds size(" + (valueSize - 1) + ") of LMultiData");
    }

    arrayList.set(index, new Boolean(replaceValue));
  }

  public void modifyBigDecimal(Object key, int index, BigDecimal replaceValue)
  {
    if (!super.containsKey(key))
    {
      System.out.println("Key(" + key + ") does not exist in LMultiData(" + this.name + ") ");
      throw new RuntimeException("Key(" + key + ") does not exist in LMultiData(" + this.name + ") ");
    }
    ArrayList arrayList = (ArrayList)get(key);
    int valueSize = arrayList.size();
    if (valueSize <= index)
    {
      System.out.println("Index(" + index + ") of Key(" + key + ") exceeds size(" + (valueSize - 1) + ") of LMultiData ");
      throw new RuntimeException("Index(" + index + ") of Key(" + key + ") exceeds size(" + (valueSize - 1) + ") of LMultiData");
    }

    arrayList.set(index, replaceValue);
  }

  public void add(Object key, Object value)
  {
    if (!super.containsKey(key))
    {
      ArrayList arrayList = new ArrayList();
      arrayList.add(value);
      super.put(key, arrayList);
    }
    else {
      ArrayList arrayList = (ArrayList)super.get(key);
      arrayList.add(value);
    }
  }

  public void addString(Object key, String value)
  {
    if (!super.containsKey(key))
    {
      ArrayList arrayList = new ArrayList();
      arrayList.add(value);
      super.put(key, arrayList);
    }
    else {
      ArrayList arrayList = (ArrayList)super.get(key);
      arrayList.add(value);
    }
  }

  public void addInt(Object key, int value)
  {
    Integer valueInt = new Integer(value);
    if (!super.containsKey(key))
    {
      ArrayList arrayList = new ArrayList();
      arrayList.add(valueInt);
      super.put(key, arrayList);
    }
    else {
      ArrayList arrayList = (ArrayList)super.get(key);
      arrayList.add(valueInt);
    }
  }

  public void addDouble(Object key, double value)
  {
    Double valueDouble = new Double(value);
    if (!super.containsKey(key))
    {
      ArrayList arrayList = new ArrayList();
      arrayList.add(valueDouble);
      super.put(key, arrayList);
    }
    else {
      ArrayList arrayList = (ArrayList)super.get(key);
      arrayList.add(valueDouble);
    }
  }

  public void addFloat(Object key, float value)
  {
    Float valueFloat = new Float(value);
    if (!super.containsKey(key))
    {
      ArrayList arrayList = new ArrayList();
      arrayList.add(valueFloat);
      super.put(key, arrayList);
    }
    else {
      ArrayList arrayList = (ArrayList)super.get(key);
      arrayList.add(valueFloat);
    }
  }

  public void addLong(Object key, long value)
  {
    Long valueLong = new Long(value);
    if (!super.containsKey(key))
    {
      ArrayList arrayList = new ArrayList();
      arrayList.add(valueLong);
      super.put(key, arrayList);
    }
    else {
      ArrayList arrayList = (ArrayList)super.get(key);
      arrayList.add(valueLong);
    }
  }

  public void addShort(Object key, short value)
  {
    Short valueShort = new Short(value);
    if (!super.containsKey(key))
    {
      ArrayList arrayList = new ArrayList();
      arrayList.add(valueShort);
      super.put(key, arrayList);
    }
    else {
      ArrayList arrayList = (ArrayList)super.get(key);
      arrayList.add(valueShort);
    }
  }

  public void addBoolean(Object key, boolean value)
  {
    Boolean valueBoolean = new Boolean(value);
    if (!super.containsKey(key))
    {
      ArrayList arrayList = new ArrayList();
      arrayList.add(valueBoolean);
      super.put(key, arrayList);
    }
    else {
      ArrayList arrayList = (ArrayList)super.get(key);
      arrayList.add(valueBoolean);
    }
  }

  public void addBigDecimal(Object key, BigDecimal value)
  {
    if (!super.containsKey(key))
    {
      ArrayList arrayList = new ArrayList();
      arrayList.add(value);
      super.put(key, arrayList);
    }
    else {
      ArrayList arrayList = (ArrayList)super.get(key);
      arrayList.add(value);
    }
  }

  public BigDecimal getBigDecimal(Object key, int index)
  {
    Object o = getObject(key, index);
    if (o == null) {
      return new BigDecimal(0.0D);
    }
    return (BigDecimal)o;
  }

  private Object getObject(Object key, int index)
  {
    Object o = null;
    ArrayList arrayList = (ArrayList)super.get(key);
    if (arrayList == null) {
      if (this.nullToInitialize)
      {
        return null;
      }

      System.out.println("Key(" + key + ") does not exist in LMultiData(" + this.name + ") ");
      throw new RuntimeException("Key(" + key + ") does not exist in LMultiData(" + this.name + ") ");
    }
    try
    {
      if (index >= arrayList.size())
        return null;
      o = arrayList.get(index);
    }
    catch (IndexOutOfBoundsException ioe)
    {
      System.out.println("Index(" + index + ") in LMultiData(" + this.name + ") is out of Bounds.");
      throw new RuntimeException("Index(" + index + ") in LMultiData(" + this.name + ") is out of Bounds.");
    }
    return o;
  }

  public Object get(Object key, int index)
  {
    return getObject(key, index);
  }

  public int getInt(Object key, int index)
  {
    Object o = getObject(key, index);
    if (o == null) {
      if (isNullToInitialize()) {
        return 0;
      }
      throw new RuntimeException("Value of the Key(" + key + ") is null");
    }Class classType = o.getClass();
    if (classType == Integer.class)
      return ((Integer)o).intValue();
    if (classType == Short.class)
      return ((Short)o).shortValue();
    if (classType == String.class)
    {
      try
      {
        return Integer.parseInt(o.toString());
      }
      catch (Exception e)
      {
        System.out.println("Value of the Key(" + key + ") Type(int) does not match : It's type is not int");

        throw new RuntimeException("Value of the Key(" + key + ") Type(int) does not match : It's type is not int");
      }
    }
    System.out.println("Value of the Key(" + key + ") Type(int) does not match : It's type is not int");
    throw new RuntimeException("Value of the Key(" + key + ") Type(int) does not match : It's type is not int");
  }

  public double getDouble(Object key, int index)
  {
    Object o = getObject(key, index);
    if (o == null) {
      if (isNullToInitialize()) {
        return 0.0D;
      }
      throw new RuntimeException("Value of the Key(" + key + ") is null");
    }Class classType = o.getClass();
    if (classType == Double.class)
      return ((Double)o).doubleValue();
    if (classType == Float.class)
      return ((Float)o).floatValue();
    if ((classType == String.class) || (classType == BigDecimal.class))
    {
      try
      {
        return Double.parseDouble(o.toString());
      }
      catch (Exception e)
      {
        System.out.println("Value of the Key(" + key + ") Type(double) does not match : It's type is not double");

        throw new RuntimeException("Value of the Key(" + key + ") Type(double) does not match : It's type is not double");
      }
    }
    System.out.println("Value of the Key(" + key + ")  Type(double) does not match : It's type is not double");
    throw new RuntimeException("Value of the Key(" + key + ")  Type(double) does not match : It's type is not double");
  }

  public float getFloat(Object key, int index)
  {
    Object o = getObject(key, index);
    if (o == null) {
      if (isNullToInitialize()) {
        return 0.0F;
      }
      throw new RuntimeException("Value of the Key(" + key + ") is null");
    }Class classType = o.getClass();
    if (classType == Float.class)
      return ((Float)o).floatValue();
    if ((classType == String.class) || (classType == BigDecimal.class))
    {
      try
      {
        return Float.parseFloat(o.toString());
      }
      catch (Exception e)
      {
        System.out.println("Value of the Key(" + key + ") Type(float) does not match : It's type is not float");

        throw new RuntimeException("Value of the Key(" + key + ") Type(float) does not match : It's type is not float");
      }
    }
    System.out.println("Value of the Key(" + key + ") Type(float) does not match : It's type is not float");
    throw new RuntimeException("Value of the Key(" + key + ") Type(float) does not match : It's type is not float");
  }

  public long getLong(Object key, int index)
  {
    Object o = getObject(key, index);
    if (o == null) {
      if (isNullToInitialize()) {
        return 0L;
      }
      throw new RuntimeException("Value of the Key(" + key + ") is null");
    }Class classType = o.getClass();
    if (classType == Long.class)
      return ((Long)o).longValue();
    if (classType == Integer.class)
      return ((Integer)o).intValue();
    if (classType == Short.class)
      return ((Short)o).shortValue();
    if (classType == String.class)
    {
      try
      {
        return Long.parseLong(o.toString());
      }
      catch (Exception e)
      {
        System.out.println("Value of the Key(" + key + ") Type(long) does not match : It's type is not long");

        throw new RuntimeException("Value of the Key(" + key + ") Type(long) does not match : It's type is not long");
      }
    }
    System.out.println("Value of the Key(" + key + ") Type(long) does not match : It's type is not long");
    throw new RuntimeException("Value of the Key(" + key + ") Type(long) does not match : It's type is not long");
  }

  public short getShort(Object key, int index)
  {
    Object o = getObject(key, index);
    if (o == null) {
      if (isNullToInitialize()) {
        return 0;
      }
      throw new RuntimeException("Value of the Key(" + key + ")  is null");
    }Class classType = o.getClass();
    if (classType == Short.class)
      return ((Short)o).shortValue();
    if (classType == String.class)
    {
      try
      {
        return Short.parseShort(o.toString());
      }
      catch (Exception e)
      {
        System.out.println("Key(" + key + ") Type(short) does not match : It's type is not short");

        throw new RuntimeException("Value of the Key(" + key + ") Type(short) does not match : It's type is not short");
      }
    }
    System.out.println("Key(" + key + ") Type(short) does not match : It's type is not short");
    throw new RuntimeException("Value of the Key(" + key + ") Type(short) does not match : It's type is not short");
  }

  public boolean getBoolean(Object key, int index)
  {
    Object o = getObject(key, index);
    if (o == null) {
      if (isNullToInitialize()) {
        return false;
      }
      throw new RuntimeException("Value of the Key(" + key + ") is null");
    }Class classType = o.getClass();
    if (classType == Boolean.class)
      return ((Boolean)o).booleanValue();
    if (classType == String.class)
    {
      try
      {
        return Boolean.getBoolean(o.toString());
      }
      catch (Exception e)
      {
        System.out.println("Value of the Key(" + key + ") Type(short) does not match : It's type is not short");

        throw new RuntimeException("Value of the Key(" + key + ") Type(short) does not match : It's type is not short");
      }
    }
    System.out.println("Value of the Key(" + key + ") Type(short) does not match : It's type is not short");
    throw new RuntimeException("Value of the Key(" + key + ") Type(short) does not match : It's type is not short");
  }

  public String getString(Object key, int index)
  {
    Object o = getObject(key, index);
    if (o == null)
    {
      if (isNullToInitialize()) {
        return "";
      }
      return null;
    }

    return o.toString();
  }

  public Object remove(Object key, int index)
  {
    if (super.containsKey(key)) {
      return ((ArrayList)super.get(key)).remove(index);
    }
    return null;
  }

  public int keySize(Object key)
  {
    if (super.containsKey(key)) {
      return ((ArrayList)super.get(key)).size();
    }
    return 0;
  }

  public int keySize()
  {
    Set tempSet = super.keySet();
    Iterator iterator = tempSet.iterator();
    if (iterator.hasNext())
    {
      String key = iterator.next().toString();
      return ((ArrayList)super.get(key)).size();
    }

    return 0;
  }

  public SimpleData getSimpleData(int index)
  {
    SimpleData singleData = new SimpleData("");
    Set tempSet = super.keySet();
    String key;
    Object o;
    for (Iterator iterator = tempSet.iterator(); iterator.hasNext(); singleData.put(key, o))
    {
      key = iterator.next().toString();
      o = getObject(key, index);
    }

    return singleData;
  }

  public SimpleData getSimpleData(String dataName, int index)
  {
    SimpleData singleData = new SimpleData(dataName);
    String prefix = dataName + ".";
    Set tempSet = super.keySet();
    for (Iterator iterator = tempSet.iterator(); iterator.hasNext(); )
    {
      String key = iterator.next().toString();
      int key_index = key.indexOf(".");
      String realKey = key.substring(key_index + 1);
      if (key.startsWith(prefix))
      {
        Object o = getObject(key, index);
        singleData.put(realKey, o);
      }
    }

    return singleData;
  }

  public void addSimpleData(SimpleData data)
  {
    Set tempSet = data.keySet();
    for (Iterator iterator = tempSet.iterator(); iterator.hasNext(); )
    {
      Object key = iterator.next();
      if (containsKey(key))
      {
        int field_size = ((ArrayList)get(key)).size();
        if (field_size != this.field_index)
        {
          for (int inx = field_size; inx < this.field_index; inx++) {
            add(key, null);
          }
        }
        add(key, data.get(key));
      }
      else {
        for (int inx = 0; inx < this.field_index; inx++) {
          add(key, null);
        }
        add(key, data.get(key));
      }
    }

    this.field_index += 1;
  }

  public void addSimpleData(String dataName, SimpleData data)
  {
    int entitySize = 0;
    if (this.entityKey == null) {
      this.entityKey = new HashMap(5);
    }
    else if (this.entityKey.containsKey(dataName))
      entitySize = ((Integer)this.entityKey.get(dataName)).intValue();
    Set tempSet = data.keySet();
    for (Iterator iterator = tempSet.iterator(); iterator.hasNext(); )
    {
      Object key = iterator.next();
      String dataKey = dataName + "." + key;
      if (containsKey(dataKey))
      {
        int fieldSize = ((ArrayList)get(dataKey)).size();
        if (fieldSize != entitySize)
        {
          for (int inx = fieldSize; inx < entitySize; inx++) {
            add(dataKey, null);
          }
        }
        add(dataKey, data.get(key));
      }
      else {
        for (int inx = 0; inx < entitySize; inx++) {
          add(dataKey, null);
        }
        add(dataKey, data.get(key));
      }
    }

    this.entityKey.put(dataName, new Integer(entitySize + 1));
  }

  public String toString()
  {
    boolean checkLongString = true;
    StringBuffer buf = new StringBuffer();
    Set keySet = keySet();
    int keySize = keySet.size();
    String[] keyStr = new String[keySize];
    keySet.toArray(keyStr);
    buf.append(" [SimpleMultiData]-------------");
    buf.append(ModelStringUtil.makeRepeatString("-", (keySize - 1) * 23 - 1));
    buf.append("|");
    buf.append("\n |{index}| ");
    for (int keyLoopNumber = 0; checkLongString; keyLoopNumber++)
    {
      checkLongString = false;
      for (int inx = 0; inx < keySize; inx++)
      {
        int keyLength = keyStr[inx].length();
        int printKeyLength = 0;
        if (keyLength > (keyLoopNumber + 1) * 20)
        {
          printKeyLength = (keyLoopNumber + 1) * 20;
          checkLongString = true;
        }
        else if ((keyLoopNumber == 0) || (keyLength > keyLoopNumber * 20)) {
          printKeyLength = keyLength;
        } else {
          printKeyLength = 0;
        }if (printKeyLength != 0)
          buf.append(keyStr[inx].substring(keyLoopNumber * 20, printKeyLength));
        if ((printKeyLength != 0) && (printKeyLength % 20 == 0))
          printKeyLength = 20;
        else
          buf.append(ModelStringUtil.makeRepeatString(" ", 20 - printKeyLength % 20));
        buf.append(" | ");
      }

      if (!checkLongString)
        break;
      buf.append("\n |       | ");
    }

    buf.append("\n |-------------------------------");
    buf.append(ModelStringUtil.makeRepeatString("-", (keySize - 1) * 23 - 1));
    buf.append("|");
    int rowSize = 0;
    for (int inx = 0; inx < keySize; inx++)
    {
      int rowSizeOfKey = keySize(keyStr[inx]);
      if (rowSizeOfKey > rowSize) {
        rowSize = rowSizeOfKey;
      }
    }
    for (int inx = 0; inx < rowSize; inx++)
    {
      buf.append("\n |  ");
      String indexStr = inx + "";
      buf.append(indexStr);
      buf.append(ModelStringUtil.makeRepeatString(" ", 5 - indexStr.length()));
      buf.append("| ");
      checkLongString = true;
      for (int lineLoopNumber = 0; checkLongString; lineLoopNumber++)
      {
        checkLongString = false;
        for (int jnx = 0; jnx < keySize; jnx++)
        {
          String tmpValue = getString(keyStr[jnx], inx);
          if (tmpValue == null)
            tmpValue = "null";
          int[] uniCode = ModelUnicodeUtil.getUnicodeLineArray(tmpValue, 20);
          int valueLength = tmpValue.getBytes().length;
          int printValueLength = 0;
          int lastUnicodeNumber = 0;
          int beforeLastUnicodeNumber = 0;
          String printString = "";
          for (int knx = 0; knx < uniCode.length; knx++) {
            if (uniCode[knx] <= lineLoopNumber + 1)
              lastUnicodeNumber++;
          }
          for (int knx = 0; knx < uniCode.length; knx++) {
            if (uniCode[knx] <= lineLoopNumber)
              beforeLastUnicodeNumber++;
          }
          if (valueLength + lastUnicodeNumber > (lineLoopNumber + 1) * 20)
          {
            printValueLength = (lineLoopNumber + 1) * 20 - lastUnicodeNumber;
            checkLongString = true;
            if (lineLoopNumber == 0)
            {
              printString = new String(tmpValue.getBytes(), lineLoopNumber * 20, printValueLength - lineLoopNumber * 20);
              buf.append(printString);
            }
            else {
              printValueLength += beforeLastUnicodeNumber;
              printString = new String(tmpValue.getBytes(), lineLoopNumber * 20 - beforeLastUnicodeNumber, printValueLength - lineLoopNumber * 20);
              buf.append(printString);
            }
          }
          else if ((lineLoopNumber == 0) || (valueLength + lastUnicodeNumber > lineLoopNumber * 20))
          {
            printValueLength = valueLength;
            if (lineLoopNumber == 0)
            {
              printString = new String(tmpValue.getBytes(), lineLoopNumber * 20, printValueLength - lineLoopNumber * 20 + lastUnicodeNumber);
              buf.append(printString);
            }
            else {
              printValueLength += lastUnicodeNumber;
              printString = new String(tmpValue.getBytes(), lineLoopNumber * 20 - lastUnicodeNumber, printValueLength - lineLoopNumber * 20);
              buf.append(printString);
            }
          }
          else {
            printValueLength = 0;
          }
          if ((printValueLength != 0) && (printValueLength % 20 == 0))
          {
            printValueLength = 20;
            int unicodeNumber = ModelUnicodeUtil.countUnicode(printString);
            buf.append(ModelStringUtil.makeRepeatString(" ", unicodeNumber));
          }
          else {
            int unicodeNumber = ModelUnicodeUtil.countUnicode(printString);
            buf.append(ModelStringUtil.makeRepeatString(" ", unicodeNumber));
            if ((printString.length() != 0) && (ModelUnicodeUtil.isUnicode(printString.charAt(printString.length() - 1))))
              buf.append(ModelStringUtil.makeRepeatString(" ", 20 - printValueLength % 20));
            buf.append(ModelStringUtil.makeRepeatString(" ", 20 - printValueLength % 20));
          }
          buf.append(" | ");
        }

        if (!checkLongString)
          break;
        buf.append("\n |       | ");
      }

      buf.append("\n |-------------------------------");
      buf.append(ModelStringUtil.makeRepeatString("-", (keySize - 1) * 23 - 1));
      buf.append("|");
    }

    buf.append("\n [Total Row Size] = ");
    buf.append(rowSize);
    return buf.toString();
  }
}