import java.text.SimpleDateFormat;

/**
 * @author arronshentu
 */
public class DebugLog {

  public static void log(String tag, String log) {
    System.out.println(log);
  }

  public static void log(String log) {
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String date = dateFormat.format(new java.util.Date());
    if (true) {
      System.out.println("<" + date + ">" + log);
    }
  }

  public static boolean isEmpty(String string) {
    if (string == null) {
      return true;
    }
    return string.isEmpty();
  }
}
