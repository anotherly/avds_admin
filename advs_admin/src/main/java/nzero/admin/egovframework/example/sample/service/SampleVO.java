package nzero.admin.egovframework.example.sample.service;

public class SampleVO extends SampleDefaultVO
{
  private static final long serialVersionUID = 1L;
  private String id;
  private String name;
  private String description;
  private String useYn;
  private String regUser;

  public String getId()
  {
    return this.id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public String getName() {
    return this.name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getDescription() {
    return this.description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public String getUseYn() {
    return this.useYn;
  }

  public void setUseYn(String useYn) {
    this.useYn = useYn;
  }

  public String getRegUser() {
    return this.regUser;
  }

  public void setRegUser(String regUser) {
    this.regUser = regUser;
  }
}