package nzero.admin.egovframework.cmmn.service.impl;

public class UserVo {
  protected String sessionId;
  
  protected String userId;
  
  protected String userNm;
  
  protected String userPwd;
  
  protected String authId;
  
  protected String userIp;
  
  public String getSessionId() {
    return this.sessionId;
  }
  
  public void setSessionId(String sessionId) {
    this.sessionId = sessionId;
  }
  
  public String getUserId() {
    return this.userId;
  }
  
  public void setUserId(String userId) {
    this.userId = userId;
  }
  
  public String getUserNm() {
    return this.userNm;
  }
  
  public void setUserNm(String userNm) {
    this.userNm = userNm;
  }
  
  public String getUserPwd() {
    return this.userPwd;
  }
  
  public void setUserPwd(String userPwd) {
    this.userPwd = userPwd;
  }
  
  public String getAuthId() {
    return this.authId;
  }
  
  public void setAuthId(String authId) {
    this.authId = authId;
  }
  
  public String getUserIp() {
    return this.userIp;
  }
  
  public void setUserIp(String userIp) {
    this.userIp = userIp;
  }
}
