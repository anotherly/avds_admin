package nzero.admin.egovframework.cmmn.util;

import java.util.Locale;
import org.springframework.context.MessageSource;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;

public class EgovMessageSource extends ReloadableResourceBundleMessageSource implements MessageSource {
  private ReloadableResourceBundleMessageSource reloadableResourceBundleMessageSource;
  
  public void setReloadableResourceBundleMessageSource(ReloadableResourceBundleMessageSource reloadableResourceBundleMessageSource) {
    this.reloadableResourceBundleMessageSource = reloadableResourceBundleMessageSource;
  }
  
  public ReloadableResourceBundleMessageSource getReloadableResourceBundleMessageSource() {
    return this.reloadableResourceBundleMessageSource;
  }
  
  public String getMessage(String code) {
    return getReloadableResourceBundleMessageSource().getMessage(code, null, Locale.getDefault());
  }
}
