package nzero.admin.egovframework.cmmn.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.multipart.MultipartFile;

public class FileUtil {
  private static final int BUFFER_SIZE = 8192;
  
  private static final String CHARSET = "utf-8";
  
  private static final Log LOG = LogFactory.getLog(FileUtil.class.getName());
  
  public static Boolean fileIsLive(String isLivefile) {
    File f1 = new File(isLivefile);
    if (f1.exists())
      return Boolean.valueOf(true); 
    return Boolean.valueOf(false);
  }
  
  public static boolean fileMake(String path, String fileName) {
    File dir = new File(path);
    File fullFileName = new File(path + fileName);
    if (!dir.exists())
      dir.mkdirs(); 
    try {
      fullFileName.createNewFile();
      return true;
    } catch (IOException e) {
      LOG.info("[fileMake] : ");
      return false;
    } 
  }
  
  public static boolean fileDelete(String deleteFileName) {
    File file = new File(deleteFileName);
    return file.delete();
  }
  
  public static boolean fileCopy(String inFileName, String outFileName) {
    LOG.debug("inFileName :: " + inFileName);
    LOG.debug("outFileName :: " + outFileName);
    FileInputStream fis = null;
    FileOutputStream fos = null;
    try {
      fis = new FileInputStream(inFileName);
      fos = new FileOutputStream(outFileName);
      int data = 0;
      while ((data = fis.read()) != -1)
        fos.write(data); 
    } catch (IOException e) {
      LOG.info("[fileCopy] : ");
      return false;
    } finally {
      if (fis != null)
        try {
          fis.close();
        } catch (IOException e1) {
          LOG.info("[fileCopy] : ");
        }  
      if (fos != null)
        try {
          fos.close();
        } catch (IOException e1) {
          LOG.info("[fileCopy] : ");
        }  
    } 
    return true;
  }
  
  public static void fileMove(String inFileName, String outFileName) {
    FileInputStream fis = null;
    FileOutputStream fos = null;
    try {
      fis = new FileInputStream(inFileName);
      fos = new FileOutputStream(outFileName);
      int data = 0;
      while ((data = fis.read()) != -1)
        fos.write(data); 
      fileDelete(inFileName);
    } catch (IOException e) {
      LOG.info("[fileMove] : ");
    } finally {
      if (fis != null)
        try {
          fis.close();
        } catch (IOException e1) {
          LOG.info("[fileMove] : ");
        }  
      if (fos != null)
        try {
          fos.close();
        } catch (IOException e1) {
          LOG.info("[fileMove] : ");
        }  
    } 
  }
  
  public static List<File> getDirFileList(String dirPath) {
    List<File> dirFileList = null;
    File dir = new File(dirPath);
    if (dir.exists()) {
      File[] files = dir.listFiles();
      dirFileList = Arrays.asList(files);
    } 
    return dirFileList;
  }
  
  public static String transferUploadFile(MultipartFile multipartFile, String destDir) throws IOException {
    String originFileNm = "";
    if (multipartFile != null) {
      File dir = new File(destDir);
      if (!dir.exists())
        dir.mkdirs(); 
      originFileNm = multipartFile.getOriginalFilename();
      try {
        multipartFile.transferTo(new File(destDir, originFileNm));
      } catch (IllegalStateException e) {
        e.printStackTrace();
        LOG.info("[transferUploadFile] : ");
      } catch (IOException e) {
        e.printStackTrace();
        LOG.info("[transferUploadFile] : ");
      } 
    } 
    return originFileNm;
  }
  
  public static String transferUploadFile(MultipartFile multipartFile, String destDir, String newFileNm) throws IOException {
    String originFileNm = "";
    if (multipartFile != null) {
      File dir = new File(destDir);
      if (!dir.exists())
        dir.mkdirs(); 
      originFileNm = multipartFile.getOriginalFilename();
      try {
        multipartFile.transferTo(new File(destDir, newFileNm));
      } catch (IllegalStateException e) {
        LOG.info("[transferUploadFile] : ");
      } catch (IOException e) {
        LOG.info("[transferUploadFile] : ");
      } 
      LOG.info("Real Conf Dir-- [" + destDir + "]");
      LOG.info("Real Conf originFileNm-- [" + originFileNm + "]");
    } 
    return newFileNm;
  }
  
  public static String transferUploadFileNew(MultipartFile multipartFile, String destDir, String newFileNm) throws IOException {
    String originFileNm = "";
    if (multipartFile != null) {
      File dir = new File(destDir);
      if (!dir.exists())
        dir.mkdirs(); 
      originFileNm = multipartFile.getOriginalFilename();
      newFileNm = newFileNm + originFileNm;
      try {
        multipartFile.transferTo(new File(destDir, newFileNm));
      } catch (IllegalStateException e) {
        LOG.info("[transferUploadFileNew] : ");
      } catch (IOException e) {
        LOG.info("[transferUploadFileNew] : ");
      } 
      LOG.info("Real Conf Dir-- [" + destDir + "]");
      LOG.info("Real Conf originFileNm-- [" + newFileNm + "]");
    } 
    return newFileNm;
  }
  
  public static void download(HttpServletRequest request, HttpServletResponse response, File file) throws ServletException, IOException {
    String mimetype = request.getSession().getServletContext().getMimeType(file.getName());
    if (file == null || !file.exists() || file.length() <= 0L || file.isDirectory())
      throw new IOException(); 
    InputStream is = null;
    try {
      is = new FileInputStream(file);
      download(request, response, is, file.getName(), file.length(), mimetype);
    } finally {
      try {
        if (is != null)
          is.close(); 
      } catch (IOException e) {
        LOG.info("[download] : ");
      } 
    } 
  }
  
  public static void download(HttpServletRequest request, HttpServletResponse response, InputStream is, String filename, long filesize, String mimetype) throws ServletException, IOException {
    String mime = mimetype;
    if (mimetype == null || mimetype.length() == 0)
      mime = "application/octet-stream;"; 
    byte[] buffer = new byte[8192];
    response.setContentType(mime + "; charset=" + "utf-8");
    String userAgent = request.getHeader("User-Agent");
    if (userAgent != null && userAgent.indexOf("MSIE 5.5") > -1) {
      response.setHeader("Content-Disposition", "filename=" + URLEncoder.encode(filename, "UTF-8") + ";");
    } else if (userAgent != null && userAgent.indexOf("MSIE") > -1) {
      response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(filename, "UTF-8") + ";");
    } else if (userAgent != null && userAgent.indexOf("Trident") > -1) {
      response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(filename, "UTF-8") + ";");
    } else {
      response.setHeader("Content-Disposition", "attachment; filename=" + new String(filename.getBytes("utf-8"), "latin1") + ";");
    } 
    if (filesize > 0L)
      response.setHeader("Content-Length", "" + filesize); 
    BufferedInputStream fin = null;
    BufferedOutputStream outs = null;
    try {
      fin = new BufferedInputStream(is);
      outs = new BufferedOutputStream((OutputStream)response.getOutputStream());
      int read = 0;
      while ((read = fin.read(buffer)) != -1) {
        outs.write(buffer, 0, read);
        outs.flush();
      } 
    } catch (IOException ex) {
      LOG.info("[download] : ");
    } finally {
      try {
        if (outs != null)
          outs.close(); 
      } catch (IOException ex1) {
        LOG.info("[download] : ");
      } 
      try {
        if (fin != null)
          fin.close(); 
      } catch (IOException ex2) {
        LOG.info("[download] : ");
      } 
    } 
  }
}
