package nzero.admin.egovframework.cmmn.model;

import java.util.LinkedHashMap;
import java.util.Map;

public class SimpleDataProtocol extends LinkedHashMap
{
  protected String name;
  protected boolean nullToInitialize;

  public SimpleDataProtocol(int arg0, float arg1)
  {
    super(arg0, arg1);
    this.name = null;
    this.nullToInitialize = false;
  }

  public SimpleDataProtocol(int arg0)
  {
    super(arg0);
    this.name = null;
    this.nullToInitialize = false;
  }

  public SimpleDataProtocol()
  {
    this.name = null;
    this.nullToInitialize = false;
  }

  public SimpleDataProtocol(Map arg0)
  {
    super(arg0);
    this.name = null;
    this.nullToInitialize = false;
  }

  public SimpleDataProtocol(int arg0, float arg1, boolean arg2)
  {
    super(arg0, arg1, arg2);
    this.name = null;
    this.nullToInitialize = false;
  }

  public String getName()
  {
    return this.name;
  }

  public void setName(String name)
  {
    this.name = name;
  }

  public boolean isNullToInitialize()
  {
    return this.nullToInitialize;
  }

  public void setNullToInitialize(boolean nullToInitialize)
  {
    this.nullToInitialize = nullToInitialize;
  }
}