package nzero.admin.egovframework.cmmn.service.impl;

import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

class CustomBindingListener implements HttpSessionBindingListener {
  public void valueBound(HttpSessionBindingEvent event) {
    User.sessionCreated(event);
  }
  
  public void valueUnbound(HttpSessionBindingEvent event) {
    User.sessionDestroyed(event);
  }
}
