package nzero.admin.egovframework.cmmn.web;

import java.beans.PropertyEditor;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.support.WebBindingInitializer;
import org.springframework.web.context.request.WebRequest;

public class EgovBindingInitializer implements WebBindingInitializer {
  public void initBinder(WebDataBinder binder, WebRequest request) {
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.getDefault());
    dateFormat.setLenient(false);
    binder.registerCustomEditor(Date.class, (PropertyEditor)new CustomDateEditor(dateFormat, false));
    binder.registerCustomEditor(String.class, (PropertyEditor)new StringTrimmerEditor(false));
  }
}
